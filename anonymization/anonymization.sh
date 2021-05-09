
#####################################################################################
#               Copyright (C) Gustavo Celani - All Rights Reserved
#          Written by Gustavo Celani <gustavo_celani@hotmail.com>, 2021
#####################################################################################
#  Creation Date: 19/02/2021
#  Creation Time: 21:10:43
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

_title_() {
    echo -e "\n#################################################################"
    figlet $1
    echo -e "#################################################################\n"
}

_press_any_key_to_continue_() {
    echo ""
    read -n 1 -s -r -p "Press any key to continue..."
}

_validate_path_() {
    if [[ "$(pwd)" != *anonymization ]]
    then
        echo -e "Please, call this script from anonymization directory..."
        echo -e "                              -------------\n"
        exit 1
    fi
}

_Setup_() {

    _title_ "Setup"

    _validate_path_

    sudo apt-get install -y torbrowser-launcher tor privoxy proxychains

    echo -e "\nBackuping current privoxy config"
    sudo cp -v /etc/privoxy/config /etc/privoxy/config.bpk
    echo -e "\nAttempt to replace privoxy config"
    sudo cp -v ./privoxy/config /etc/privoxy/config

    echo -e "\nBackuping current proxychains config"
    sudo cp -v /etc/proxychains4.conf /etc/proxychains4.conf.bpk
    sudo cp -v /etc/proxychains.conf /etc/proxychains.conf.bkp
    echo -e "\nAttempt to replace proxychains config"
    sudo cp -v ./proxychains/proxychains.conf /etc/proxychains4.conf
    sudo cp -v ./proxychains/proxychains.conf /etc/proxychains.conf
}

_Start_() {

    _title_ "Start"

    echo -e "\nAttempt to start tor service"
    sudo /etc/init.d/tor start

    echo -e "\nAttempt to start privoxy service"
    sudo /etc/init.d/privoxy start
}

_Stop_() {

    _title_ "Stop"

    echo -e "\nAttempt to stop tor service"
    sudo /etc/init.d/tor stop

    echo -e "\nAttempt to stop privoxy service"
    sudo /etc/init.d/privoxy stop
}

_Status_() {

    _title_ "Status"

    echo -e "\nTor service status"
    sudo /etc/init.d/tor status

    echo -e "\nPrivoxy service status"
    sudo /etc/init.d/privoxy status
}

_IP_Test_() {

    _title_ "IP Test"

    echo -e "\nReal Public IP Address:"
    curl ifconfig.me

    echo -e "\n\nAnonymized Public IP Address:"
    torify curl ifconfig.me

    echo ""
}

_IP_Info_() {

    _title_ "IP Info"

    proxychains firefox --new-instance https://ipleak.net/
}

_Launch_Tor_Browser_() {

    _title_ "Launch Tor Browser"
    torbrowser-launcher
}

_Exit_() {

    _Stop_
    echo ""
    exit 0
}

#
# Main Loop
#

while true
do
    clear
    ACTION=$( dialog \
            --stdout \
            --backtitle "Powered by Gustavo Celani ( github.com/gustavocelani )" \
            --title "Anonymization" \
            --clear \
            --ok-label "OK" \
            --nocancel \
            --menu "" \
        0 0 0 \
        _Setup_                "Initial Setup for Anonymization" \
        _Start_                "Start Anonymization" \
        _Stop_                 "Stop Anonymization" \
        _Status_               "Anonymization Services Status" \
        _IP_Test_              "Torify ifconfig.me" \
        _IP_Info_              "Proxychains Firefox IP Leak" \
        _Launch_Tor_Browser_   "Launch Tor Browser" \
        _Exit_                 "Exit" )

    clear
    ${ACTION}
    _press_any_key_to_continue_
done
