
#####################################################################################
#               Copyright (C) Gustavo Celani - All Rights Reserved
#          Written by Gustavo Celani <gustavo_celani@hotmail.com>, 2021
#####################################################################################
#
#  Author:   Gustavo Pasqua de Oliveira Celani
#  Social:   Gustavo Celani (@gustavo_celani)
#  Email:    gustavo_celani@hotmail.com
#  Linkedin: https://br.linkedin.com/in/gustavocelani
#  GitHub:   https://github.com/gustavocelani
#
#####################################################################################

#!/bin/bash

TERMINAL_GEOMETRY="100x35"

ANONYMIZATION="off"
SKIP_SSL_CHECK="off"
SCAN_NIKTO="off"
SCAN_DIRB="on"
SCAN_GOBUSTER="on"

GB_WORDLIST="/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"
GB_EXTENSIONS=".php,.txt,.js,/,.html"

PROTOCOL=$1
TARGET_IP=$2
PORT=$3
OUTPUT_DIR=$4

_title_() {
    echo -e "\n#################################################################"
    figlet $1
    echo -e "#################################################################\n"
}

_press_any_key_to_continue_() {
    echo ""
    read -n 1 -s -r -p "Press any key to continue..."
}

_data_loss_warning_() {
    echo -e "!!! WARNING !!!\n"
    echo "Scan result for this target already exists [ $1 ]"
    echo "Backuping to avoid data loss."
    cp -v $1 $1.bkp
    echo ""
}

_update_outputs_() {
    NIKTO_OUT="${OUTPUT_DIR}/nikto_${TARGET_IP}.txt"
    DIRB_OUT="${OUTPUT_DIR}/dirb_${TARGET_IP}.txt"
    GOBUSTER_OUT="${OUTPUT_DIR}/gobuster_${TARGET_IP}.txt"
}

_update_url_() {
    TARGET_URL=${PROTOCOL}://${TARGET_IP}:${PORT}
}

_nikto_() {

    _title_ "Nikto"

    if [[ -f $NIKTO_OUT ]]
    then
        _data_loss_warning_ $NIKTO_OUT
    fi

    CMD=""
    if [[ "${ANONYMIZATION}" == "on" ]]; then CMD="proxychains "; fi
    CMD="${CMD}nikto -h ${TARGET_URL}"
    if [[ "${SKIP_SSL_CHECK}" == "on" ]]; then CMD="$CMD -nossl"; fi
    CMD="$CMD | tee $NIKTO_OUT"

    echo -e "\n > RUNNING [ ${CMD} ]\n\n"
    gnome-terminal --window --hide-menubar --geometry=${TERMINAL_GEOMETRY} -t "Nikto_${TARGET_URL}" -- bash -c "$CMD"
    echo ""
}

_dirb_() {

    _title_ "Dirb"

    if [[ -f $DIRB_OUT ]]
    then
        _data_loss_warning_ $DIRB_OUT
    fi

    CMD=""
    if [[ "${ANONYMIZATION}" == "on" ]]; then CMD="proxychains "; fi
    CMD="${CMD}dirb ${TARGET_URL} | tee $DIRB_OUT"

    echo -e "\n > RUNNING [ ${CMD} ]\n\n"
    gnome-terminal --window --hide-menubar --geometry=${TERMINAL_GEOMETRY} -t "Dirb_${TARGET_URL}" -- bash -c "$CMD"
    echo ""
}

_gobuster_() {

    _title_ "GoBuster"

    if [[ -f $GOBUSTER_OUT ]]
    then
        _data_loss_warning_ $GOBUSTER_OUT
    fi

    CMD=""
    if [[ "${ANONYMIZATION}" == "on" ]]; then CMD="proxychains "; fi
    CMD="${CMD}gobuster dir -t 50 -u ${TARGET_URL} -w ${GB_WORDLIST}"
    if [[ "${SKIP_SSL_CHECK}" == "on" ]]; then CMD="$CMD -k"; fi
    if [[ "${GB_EXTENSIONS}" != "" ]]; then CMD="$CMD -x ${GB_EXTENSIONS}"; fi
    CMD="$CMD | tee $GOBUSTER_OUT"

    echo -e "\n > RUNNING [ ${CMD} ]\n\n"
    gnome-terminal --window --hide-menubar --geometry=${TERMINAL_GEOMETRY} -t "GoBuster_${TARGET_URL}" -- bash -c "$CMD"
    echo ""
}

_Protocol_() {

    clear
    PROTOCOL=$( dialog \
                --stdout \
                --backtitle "Powered by Gustavo Celani ( github.com/gustavocelani )" \
                --title "WEB Scanning" \
                --clear \
                --ok-label "OK" \
                --nocancel \
                --inputbox "WEB Protocol (http/https):" \
                0 0 \
                ${PROTOCOL} )
    clear

    if [[ "${PROTOCOL}" != "http" ]] && [[ "${PROTOCOL}" != "https" ]]
    then
        PROTOCOL="http"
    fi

    _update_url_
}

_Target_IP_() {

    clear
    TARGET_IP=$( dialog \
                --stdout \
                --backtitle "Powered by Gustavo Celani ( github.com/gustavocelani )" \
                --title "WEB Scanning" \
                --clear \
                --ok-label "OK" \
                --nocancel \
                --inputbox "Target IP Address or DNS:" \
                0 0 \
                ${TARGET_IP} )
    clear

    if [[ "${TARGET_IP}" == "" ]]
    then
        TARGET_IP="127.0.0.1"
    fi

    _update_url_
}

_Port_() {

    clear
    PORT=$( dialog \
                --stdout \
                --backtitle "Powered by Gustavo Celani ( github.com/gustavocelani )" \
                --title "WEB Scanning" \
                --clear \
                --ok-label "OK" \
                --nocancel \
                --inputbox "Port:" \
                0 0 \
                ${PORT} )
    clear

    if [[ "${PORT}" == "" ]]
    then
        PORT="80"
    fi

    _update_url_
}

_Output_() {

    clear
    OUTPUT_DIR=$( dialog \
                --stdout \
                --backtitle "Powered by Gustavo Celani ( github.com/gustavocelani )" \
                --title "WEB Scanning" \
                --clear \
                --ok-label "OK" \
                --nocancel \
                --inputbox "Output Directory:" \
                0 0 \
                ${OUTPUT_DIR} )
    clear

    if [[ "${OUTPUT_DIR}" == "" ]]
    then
        OUTPUT_DIR="/tmp"
        return
    fi

    _update_outputs_
}

_GoBuster_() {
    clear
    ACTION=$( dialog \
            --stdout \
            --backtitle "Powered by Gustavo Celani ( github.com/gustavocelani )" \
            --title "WEB Scanning" \
            --clear \
            --ok-label "OK" \
            --nocancel \
            --menu "GoBuster Parameters" \
            0 0 0 \
            _GB_Wordlist_    "${GB_WORDLIST}" \
            _GB_Extensions_  "${GB_EXTENSIONS}" \
            _Return_         "" )
    clear

    if [ "${ACTION}" == ""] || ["${ACTION}" == "_Return_"]
    then
        return
    fi

    ${ACTION}
}

_GB_Wordlist_() {

    clear
    GB_WORDLIST=$( dialog \
                --stdout \
                --backtitle "Powered by Gustavo Celani ( github.com/gustavocelani )" \
                --title "WEB Scanning" \
                --clear \
                --ok-label "OK" \
                --nocancel \
                --inputbox "GoBuster Wordlist Directory:" \
                0 0 \
                ${GB_WORDLIST} )
    clear

    if [[ "${GB_WORDLIST}" == "" ]]
    then
        GB_WORDLIST="/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"
    fi
}

_GB_Extensions_() {

    clear
    GB_EXTENSIONS=$( dialog \
                --stdout \
                --backtitle "Powered by Gustavo Celani ( github.com/gustavocelani )" \
                --title "WEB Scanning" \
                --clear \
                --ok-label "OK" \
                --nocancel \
                --inputbox "GoBuster Extensions:" \
                0 0 \
                ${GB_EXTENSIONS} )
    clear

    if [[ "${GB_EXTENSIONS}" == "" ]]
    then
        GB_EXTENSIONS=".php,.txt,.js,/,.html"
    fi
}

_Setup_() {

    clear
    SETUP=$( dialog \
            --stdout \
            --backtitle "Powered by Gustavo Celani ( github.com/gustavocelani )" \
            --no-items \
            --title "WEB Scanning" \
            --clear \
            --ok-label "OK" \
            --nocancel \
            --checklist "Scan Setup" \
            0 0 0 \
            "Anonymization" "$ANONYMIZATION" \
            "Skip_SSL_Check" "$SKIP_SSL_CHECK" \
            "Run_Nikto" "$SCAN_NIKTO" \
            "Run_Dirb" "$SCAN_DIRB" \
            "Run_GoBuster" "$SCAN_GOBUSTER" )
    clear
    
    echo "Setup = $SETUP"
    if [[ "${SETUP}" == "" ]]
    then
        return
    fi

    if [[ ${SETUP} == *"Anonymization"* ]]; then ANONYMIZATION="on"; else ANONYMIZATION="off"; fi
    if [[ ${SETUP} == *"Skip_SSL_Check"* ]]; then SKIP_SSL_CHECK="on"; else SKIP_SSL_CHECK="off"; fi
    if [[ ${SETUP} == *"Run_Nikto"* ]]; then SCAN_NIKTO="on"; else SCAN_NIKTO="off"; fi
    if [[ ${SETUP} == *"Run_Dirb"* ]]; then SCAN_DIRB="on"; else SCAN_DIRB="off"; fi
    if [[ ${SETUP} == *"Run_GoBuster"* ]]; then SCAN_GOBUSTER="on"; else SCAN_GOBUSTER="off"; fi
}

_Start_() {

    mkdir -p ${OUTPUT_DIR}

    if [[ ! -d ${OUTPUT_DIR} ]]
    then
        echo -e "!!! FAIL !!!\n"
        echo "Fail to create output directory [ $SCAN_DEFAULT_OUT ]"
        echo -e "Check the setup and try again...\n"
        return
    fi

    if [[ "${SCAN_NIKTO}" == "on" ]]; then _nikto_; fi
    if [[ "${SCAN_DIRB}" == "on" ]]; then _dirb_; fi
    if [[ "${SCAN_GOBUSTER}" == "on" ]]; then _gobuster_; fi
}

_Results_() {

    if [[ -f "${NIKTO_OUT}" ]]
    then
        _title_ "Nikto"
        cat ${NIKTO_OUT}
    fi

    if [[ -f "${DIRB_OUT}" ]]
    then
        _title_ "Dirb"
        cat ${DIRB_OUT}
    fi

    if [[ -f "${GOBUSTER_OUT}" ]]
    then
        _title_ "GoBuster"
        cat ${GOBUSTER_OUT}
    fi

    _press_any_key_to_continue_
}

_Clear_() {

    _title_ "Clear"

    if [[ -f "${NIKTO_OUT}" ]]
    then
        rm -v ${NIKTO_OUT}
    fi

    if [[ -f "${DIRB_OUT}" ]]
    then
        rm -v ${DIRB_OUT}
    fi

    if [[ -f "${GOBUSTER_OUT}" ]]
    then
        rm -v ${GOBUSTER_OUT}
    fi

    _press_any_key_to_continue_
}

_Exit_() {

    echo ""
    exit 0
}

#
# Main Loop
#

if [[ "${PROTOCOL}" == "" ]]
then
    PROTOCOL="http"
fi

if [[ "${TARGET_IP}" == "" ]]
then
    TARGET_IP="127.0.0.1"
fi

if [[ "${PORT}" == "" ]]
then
    PORT="8000"
fi

if [[ "${OUTPUT_DIR}" == "" ]]
then
    OUTPUT_DIR="/tmp"
fi

_update_outputs_
_update_url_

while true
do
    clear
    ACTION=$( dialog \
            --stdout \
            --backtitle "Powered by Gustavo Celani ( github.com/gustavocelani )" \
            --title "WEB Scanning" \
            --clear \
            --ok-label "OK" \
            --nocancel \
            --menu "" \
            0 0 0 \
            _Protocol_  "${PROTOCOL}" \
            _Target_IP_ "${TARGET_IP}" \
            _Port_      "${PORT}" \
            _Output_    "${OUTPUT_DIR}" \
            _GoBuster_  "" \
            _Setup_     "" \
            _Start_     "" \
            _Results_   "" \
            _Clear_     "" \
            _Exit_      "" )
    clear

    if [[ "${ACTION}" == "" ]]
    then
        _Exit_
    fi

    ${ACTION}
done
