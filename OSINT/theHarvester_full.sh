
#####################################################################################
#               Copyright (C) Gustavo Celani - All Rights Reserved
#          Written by Gustavo Celani <gustavo_celani@hotmail.com>, 2021
#####################################################################################
#  Creation Date: 27/02/2021
#  Creation Time: 23:41:19
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

if [ ! "$#" -eq 1 ]
then
	echo -e "\nUsage: ./theHarvester_multiple_sources.sh <target>"
	gustavo-copyright
	exit 1
fi

TARGET=${1}
INDEX=0

TH_SOURCES=(baidu bing bingapi bufferoverun censys certspotter crtsh dnsdumpster duckduckgo exalead github-code google hackertarget hunter intelx linkedin linkedin_links netcraft omnisint otx pentesttools projectdiscovery qwant rapiddns securityTrails spyse sublist3r threatcrowd threatminer trello twitter urlscan virustotal yahoo)

for TH_SOURCE in "${TH_SOURCES[@]}"
do
	INDEX=$(expr ${INDEX} + 1)

	echo ""
	echo "==========================================================================================================="
	echo "[ ${INDEX}/${#TH_SOURCES[@]} ] - ${TH_SOURCE}"
	echo "==========================================================================================================="
	echo ""

	theHarvester -d ${TARGET} -b ${TH_SOURCE} -f theHarvester_${TH_SOURCE}.html
done

mkdir -p ./output_xml
mv ./*.xml ./output_xml

mkdir -p ./output_html
mv ./*.html ./output_html

cd ./output_xml

for XML_FILE in ./*.xml
do
	sed -i 's/<hostname>/\n<hostname>/g' ${XML_FILE}
	sed -i 's/<\/hostname>/<\/hostname>\n/g' ${XML_FILE}

	sed -i 's/<email>/\n<email>/g' ${XML_FILE}
	sed -i 's/<\/email>/<\/email>\n/g' ${XML_FILE}
done

clear

figlet "The Harvester"
echo "            Formatted Result for: ${TARGET}"

echo ""
echo "+--------+"
echo "| Emails |"
echo "+--------+"
grep -rnw -E "<email>(.*)</email>" | cut -d ">" -f 2 | cut -d "<" -f 1 | sort | uniq

echo ""
echo "+-------+"
echo "| Hosts |"
echo "+-------+"
grep -rnw -E "<hostname>(.*)</hostname>" | cut -d ">" -f 2 | cut -d "<" -f 1 | sort | uniq
