# WEB Scanning Tool

### Automated Tools

* Nikto
* Dirb
* GoBuster

## Basic Usage

```
$ git clone https://github.com/gustavocelani/ethical_hacking.git
$ cd ./web_scanning
$ chmod +x web_scanning.sh
$ ./web_scanning.sh

# Optional Arguments
$ ./web_scanning.sh <PROTOCOL> <TARGET_IP> <OUTPUT_DIR>
```

### Without Arguments

```
$ ./web_scanning.sh
```

![Alt text](usage1.png?raw=true "Usage without Arguments")

### With Arguments

```
$ ./web_scanning.sh http 127.0.0.1 8080 /home/burton/Downloads/ctf
```

![Alt text](usage2.png?raw=true "Usage with Arguments")
