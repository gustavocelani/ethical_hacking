# Third Party Tools

* [Payloads All The Things](#PayloadsAllTheThings)
* [PEASS - Privilege Escalation Awesome Scripts Suite](#PEASS)
* [LES - Linux Privilege Escalation Auditing Tool](#LES)
* [OpenBoleto](#OpenBoleto)
* [OpenVAS](#OpenVAS)


<a name="PayloadsAllTheThings"></a>
# Payloads All The Things

**Repository**: [swisskyrepo/PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings)

A list of useful payloads and bypasses for Web Application Security.  
Feel free to improve with your payloads and techniques!


<a name="PEASS"></a>
# PEASS - Privilege Escalation Awesome Scripts Suite

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
$ $ wget https://raw.githubusercontent.com/carlospolop/privilege-escalation-awesome-scripts-suite/master/linPEAS/linpeas.sh -O linpeas.sh
$ chmod +x linpeas.sh
$ ./linpeas.sh -a > linpeas_output.txt
$ less -r linpeas_output.txt
```


<a name="LES"></a>
# LES - Linux Privilege Escalation Auditing Tool

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
$ wget https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh -O les.sh
$ chmod +x les.sh
$ ./les.sh
```


<a name="OpenBoleto"></a>
# OpenBoleto

**Repository**: [openboleto/openboleto](https://github.com/openboleto/openboleto)

O OpenBoleto é uma biblioteca de código aberto para geração de boletos bancários.  
Boletos bancários são considerados um meio de pagamento muito comum no Brasil.  
O foco é ser simples e ter uma arquitetura compatível com os recursos mais modernos do PHP.

### Basic Usage

```
$ git clone https://github.com/openboleto/openboleto.git
$ cd ./openboleto/samples/

# Edit fields of your chosen emitter (Banco do Brasil in this example)
$ vi banco_do_brasil.php

$ php banco_do_brasil.php > /tmp/boleto.html
$ firefox /tmp/boleto.html &
```



<a name="OpenVAS"></a>
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

Web Page: https://127.0.0.1:9392
Username: administrator
Password: 5aae84fa-f1ec-409d-bf2b-24e3bbc38595

# Stop Daemon
$ sudo gvm-stop
```

________________________
