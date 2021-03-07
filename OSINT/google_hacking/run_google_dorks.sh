
#####################################################################################
#               Copyright (C) Gustavo Celani - All Rights Reserved
#          Written by Gustavo Celani <gustavo_celani@hotmail.com>, 2021
#####################################################################################
#  Creation Date: 07/03/2021
#  Creation Time: 17:12:31
#
#  Version:  1.0
#  Revision: 1
#
#  Author:   Gustavo Pasqua de Oliveira Celani
#  Social:   Gustavo Celani (@gustavo_celani)
#  Email:    gustavo_celani@hotmail.com
#  Linkedin: https://br.linkedin.com/in/gustavocelani
#  GitHub:   https://github.com/gustavocelani
#
#####################################################################################

#!/bin/bash

_press_any_key_to_continue_() {
    read -n 1 -s -r -p "Press any key to continue..."
    echo ""
}

_validate_path_() {
    if [[ "$(pwd)" != *google_hacking ]]
    then
        echo -e "Please, call this script from google_hacking directory..."
        echo -e "                              --------------\n"
        exit 1
    fi
}

_RUN_() {

    readarray -t DORKS_ARRAY < ${DORKS_FILE}

    for DORK in "${DORKS_ARRAY[@]}"
    do
        INDEX=$(expr ${INDEX} + 1)
        INDEX_CTL=$(expr ${INDEX_CTL} + 1)

        echo ""
    	echo "==========================================================================================================="
    	echo "[ ${INDEX}/${#DORKS_ARRAY[@]} ] - ${DORK}"
    	echo "==========================================================================================================="

        firefox "site:\"${TARGET}\" ${DORK}"

        if [[ ${INDEX_CTL} -eq ${RESULTS_PER_ITERATION} ]]
        then
            echo -e "\nNumber of results per iteration reached [ ${RESULTS_PER_ITERATION} ]"
            _press_any_key_to_continue_
            INDEX_CTL=0
        fi
    done
}

_Username_() {
    DORKS_FILE=./dorks/dorks_files_containing_usernames.txt
    _RUN_
}

_Password_() {
    DORKS_FILE=./dorks/dorks_files_containing_passwords.txt
    _RUN_
}

_Juicy_() {
    DORKS_FILE=./dorks/dorks_files_containing_juicy_info.txt
    _RUN_
}

_Sensitive_Directories_() {
    DORKS_FILE=dorks_sensitive_directories.txt
    _RUN_
}

_Exit_() {
    exit 0
}

#
# Main Loop
#

_validate_path_

if [ ! "$#" -eq 2 ]
then
	echo -e "\nUsage:   ./run_google_dorks.sh <target> <results_per_iteration>"
    echo -e "\nExample: ./run_google_dorks.sh mytaregt.com 10"
    echo ""
	exit 1
fi

TARGET=${1}
RESULTS_PER_ITERATION=${2}

while true
do
    INDEX=0
    INDEX_CTL=0
    clear

    ACTION=$( dialog \
            --stdout \
            --backtitle "Powered by Gustavo Celani ( github.com/gustavocelani )" \
            --title "Google Hacking - Target: [ ${TARGET} ]" \
            --clear \
            --ok-label "OK" \
            --nocancel \
            --menu "" \
        0 0 0 \
        _Username_               "Files Containing Usernames" \
        _Password_               "Files Containing Passwords" \
        _Juicy_                  "Files Containing Juicy Info" \
        _Sensitive_Directories_  "Sensitive Directories" \
        _Exit_                   "Exit" )

    clear
    ${ACTION}
done
