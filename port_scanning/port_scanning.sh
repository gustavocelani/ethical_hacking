
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

ANONYMIZATION="off"
SKIP_HOST_DISCOVERY="off"
SCAN_DEFAULT="on"
SCAN_AGGRESSIVE="on"
SCAN_VULN="on"

TARGET=$1
OUTPUT_DIR=$2

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
    SCAN_DEFAULT_OUT="${OUTPUT_DIR}/nmap_default_${TARGET}.txt"
    SCAN_AGGRESSIVE_OUT="${OUTPUT_DIR}/nmap_aggressive_${TARGET}.txt"
    SCAN_VULN_OUT="${OUTPUT_DIR}/nmap_vuln_${TARGET}.txt"
}

_default_scan_() {

    _title_ "Default"

    if [[ -f $SCAN_DEFAULT_OUT ]]
    then
        _data_loss_warning_ $SCAN_DEFAULT_OUT
    fi

    CMD=""
    if [[ "${ANONYMIZATION}" == "on" ]]; then CMD="proxychains "; fi
    CMD="${CMD}nmap ${TARGET}"
    if [[ "${SKIP_HOST_DISCOVERY}" == "on" ]]; then CMD="$CMD -Pn"; fi
    CMD="$CMD -oN $SCAN_DEFAULT_OUT"

    echo -e "\n > RUNNING [ ${CMD} ]\n\n"
    ${CMD}
    echo ""
}

_aggressive_scan_() {

    _title_ "Aggressive"

    if [[ ! -f "$SCAN_DEFAULT_OUT" ]]
    then
        echo -e "!!! WARNING !!!\n"
        echo "Default Scan result not found [ $SCAN_DEFAULT_OUT ]"
        echo -e "Attempting to run Default Scan...\n"
        _default_scan_
    fi

    if [[ ! -f "$SCAN_DEFAULT_OUT" ]]
    then
        echo -e "!!! FAIL !!!\n"
        echo "Default Scan result doen't exists [ $SCAN_DEFAULT_OUT ]"
        echo -e "Check the setup and try again...\n"
        return
    fi

    if [[ -f $SCAN_AGGRESSIVE_OUT ]]
    then
        _data_loss_warning_ $SCAN_AGGRESSIVE_OUT
    fi

    PORTS="-p$(cat $SCAN_DEFAULT_OUT | grep -E "\/.*open" | cut -d '/' -f1 | tr '\n' ',' | rev | cut -c 2- | rev)"

    CMD=""
    if [[ "${ANONYMIZATION}" == "on" ]]; then CMD="proxychains "; fi
    CMD="${CMD}nmap ${TARGET}"
    if [[ "${SKIP_HOST_DISCOVERY}" == "on" ]]; then CMD="$CMD -Pn"; fi
    CMD="$CMD ${PORTS} -A -oN $SCAN_AGGRESSIVE_OUT"

    echo -e "\n > RUNNING [ ${CMD} ]\n\n"
    ${CMD}
    echo ""
}

_vuln_scan_() {

    _title_ "Vuln"

    if [[ ! -f "$SCAN_DEFAULT_OUT" ]]
    then
        echo -e "!!! WARNING !!!\n"
        echo "Default Scan result not found [ $SCAN_DEFAULT_OUT ]"
        echo -e "Attempting to run Default Scan...\n"
        _default_scan_
    fi

    if [[ ! -f "$SCAN_DEFAULT_OUT" ]]
    then
        echo -e "!!! FAIL !!!\n"
        echo "Default Scan result doen't exists [ $SCAN_DEFAULT_OUT ]"
        echo -e "Check the setup and try again...\n"
        return
    fi

    if [[ -f $SCAN_VULN_OUT ]]
    then
        _data_loss_warning_ $SCAN_VULN_OUT
    fi

    PORTS="-p$(cat $SCAN_DEFAULT_OUT | grep -E "\/.*open" | cut -d '/' -f1 | tr '\n' ',' | rev | cut -c 2- | rev)"

    CMD=""
    if [[ "${ANONYMIZATION}" == "on" ]]; then CMD="proxychains "; fi
    CMD="${CMD}nmap ${TARGET}"
    if [[ "${SKIP_HOST_DISCOVERY}" == "on" ]]; then CMD="$CMD -Pn"; fi
    CMD="$CMD ${PORTS} --script=vuln -oN $SCAN_VULN_OUT"

    echo -e "\n > RUNNING [ ${CMD} ]\n\n"
    ${CMD}
    echo ""
}

_Target_() {

    clear
    TARGET=$( dialog \
                --stdout \
                --backtitle "Powered by Gustavo Celani ( github.com/gustavocelani )" \
                --title "Port Scanning" \
                --clear \
                --ok-label "OK" \
                --nocancel \
                --inputbox "Target IP Address or DNS:" \
                0 0 \
                ${TARGET} )
    clear

    if [[ "${TARGET}" == "" ]]
    then
        TARGET="127.0.0.1"
    fi

    _update_outputs_
}

_Output_() {

    clear
    OUTPUT_DIR=$( dialog \
                --stdout \
                --backtitle "Powered by Gustavo Celani ( github.com/gustavocelani )" \
                --title "Port Scanning" \
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

    mkdir -p ${OUTPUT_DIR}
    _update_outputs_
}

_Setup_() {

    clear
    SETUP=$( dialog \
            --stdout \
            --backtitle "Powered by Gustavo Celani ( github.com/gustavocelani )" \
            --no-items \
            --title "Port Scanning" \
            --clear \
            --ok-label "OK" \
            --nocancel \
            --checklist "Scan Setup" \
            0 0 0 \
            "Anonymization" "$ANONYMIZATION" \
            "Skip_host_discovery" "$SKIP_HOST_DISCOVERY" \
            "Default_Scan" "$SCAN_DEFAULT" \
            "Aggressive_Scan" "$SCAN_AGGRESSIVE" \
            "Vulnerabilities_Script_Scan" "$SCAN_VULN" )
    clear
    
    echo "Setup = $SETUP"
    if [[ "${SETUP}" == "" ]]
    then
        return
    fi

    if [[ ${SETUP} == *"Anonymization"* ]]; then ANONYMIZATION="on"; else ANONYMIZATION="off"; fi
    if [[ ${SETUP} == *"Skip_host_discovery"* ]]; then SKIP_HOST_DISCOVERY="on"; else SKIP_HOST_DISCOVERY="off"; fi
    if [[ ${SETUP} == *"Default_Scan"* ]]; then SCAN_DEFAULT="on"; else SCAN_DEFAULT="off"; fi
    if [[ ${SETUP} == *"Aggressive_Scan"* ]]; then SCAN_AGGRESSIVE="on"; else SCAN_AGGRESSIVE="off"; fi
    if [[ ${SETUP} == *"Vulnerabilities_Script_Scan"* ]]; then SCAN_VULN="on"; else SCAN_VULN="off"; fi
}

_Start_() {

    if [[ "${SCAN_DEFAULT}" == "on" ]]; then _default_scan_; fi
    if [[ "${SCAN_AGGRESSIVE}" == "on" ]]; then _aggressive_scan_; fi
    if [[ "${SCAN_VULN}" == "on" ]]; then _vuln_scan_; fi

    _press_any_key_to_continue_
}

_Results_() {

    if [[ -f "${SCAN_DEFAULT_OUT}" ]]
    then
        _title_ "Default"
        cat ${SCAN_DEFAULT_OUT}
    fi

    if [[ -f "${SCAN_AGGRESSIVE_OUT}" ]]
    then
        _title_ "Aggressive"
        cat ${SCAN_AGGRESSIVE_OUT}
    fi

    if [[ -f "${SCAN_VULN_OUT}" ]]
    then
        _title_ "Vuln"
        cat ${SCAN_VULN_OUT}
    fi

    _press_any_key_to_continue_
}

_Clear_() {

    _title_ "Clear"

    if [[ -f "${SCAN_DEFAULT_OUT}" ]]
    then
        rm -v $SCAN_DEFAULT_OUT
    fi

    if [[ -f "${SCAN_AGGRESSIVE_OUT}" ]]
    then
        rm -v $SCAN_AGGRESSIVE_OUT
    fi

    if [[ -f "${SCAN_VULN_OUT}" ]]
    then
        rm -v $SCAN_VULN_OUT
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

if [[ "${TARGET}" == "" ]]
then
    TARGET="127.0.0.1"
fi

if [[ "${OUTPUT_DIR}" == "" ]]
then
    OUTPUT_DIR="/tmp"
fi

_update_outputs_

while true
do
    clear
    ACTION=$( dialog \
            --stdout \
            --backtitle "Powered by Gustavo Celani ( github.com/gustavocelani )" \
            --title "Port Scanning" \
            --clear \
            --ok-label "OK" \
            --nocancel \
            --menu "" \
            0 0 0 \
            _Target_   "${TARGET}" \
            _Output_   "${OUTPUT_DIR}" \
            _Setup_    "" \
            _Start_    "" \
            _Results_  "" \
            _Clear_    "" \
            _Exit_     "" )
    clear

    if [[ "${ACTION}" == "" ]]
    then
        _Exit_
    fi

    ${ACTION}
done
