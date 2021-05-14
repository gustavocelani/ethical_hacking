# DigiSpark Rubber Ducky Payloads

This repository contains rubber ducky payloads for **Digispark** platform.  
They are separated by target operational system: Windows OS or Linux OS.

## Specification

* Suports Arduino IDE (Linux / OSX / WIN)
* USB Power Supply
* OnBoard Voltage Regulator 5V 500mA
* Embedded USB and Serial Debugging
* 6x I/O Pins
* Total Flash Memory 8K (2K for Bootloader, 6K Free)
* I2C Interface
* SPI Interface
* LED Activity Indicator
* 1x LED for General Use
* Dimensions: 1,8cm x 2,6cm

![Alt text](digispark.png?raw=true "Digispark")

## Installation

Use the URL below in Boards Manager to get DigiKeyboard library with multi layout support:
* [Custom Board Package with Keyboard Layout Support](https://raw.githubusercontent.com/rsrdesarrollo/DigistumpArduino/master/package_digistump_index.json)

Follow the steps below using the previous URL:
* [Installation Guide](https://gbalestrin.com.br/?p=64)

Install the Digistump drivers if needed
* [Digistump Drviers](https://github.com/digistump/DigistumpArduino/releases/download/1.6.7/Digistump.Drivers.zip)

Replace the `keylayouts.h` file of downloaded DigiKeyboard library for the `./install/keylayouts.h` to get PT-BR layout support
```
Orig: ./install/keylayouts.h
Dest: C:\Users\<USERNAME>\Documents\ArduinoData\packages\digistump\hardware\avr\1.6.7\libraries\DigisparkKeyboard
```

## Uploading Code

OBS.: Digispark will **NOT** be recognized in **Port** section of IDE Tools.

* Write the code
* Select **Digispark (Default - 16.5mhz)** board
* Click in **Upload**
* **Plug** Digispark on PC
* The code will be uploaded by bootloader and will run automatically

## References

* [CedArctic/DigiSpark-Scripts](https://github.com/CedArctic/DigiSpark-Scripts)
* [MTK911/Attiny85](https://github.com/MTK911/Attiny85)
* [rsrdesarrollo/DigistumpArduino](https://github.com/rsrdesarrollo/DigistumpArduino)
