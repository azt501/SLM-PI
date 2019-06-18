# Setup

## Overview

This is the setup guide for the RaspberryPi Dosimeter

# Setup the RaspberryPi

1. Flashed 8gb card with [Raspbian Stretch Lite](https://www.raspberrypi.org/downloads/raspbian/) using [Etcher](https://www.balena.io/etcher/)
2. Create ```SSH``` and ```wpa_supplicant.conf``` files to ```/boot``` partition on the SD card
3. Boot raspberry pi
4. SSH into pi over the network, ```ssh pi@raspberrypi``` with the password ```raspberry```
	- Copy your local ssh key to the rpi: ```ssh-copy-id pi@raspberrypi```
5. Run ```sudo apt-get update --fix-missing && sudo apt-get install git```
6. ```git clone [this repo url]```
7. run ```bash ./scripts/build_rpi_from_scratch.sh```
8. Reboot with ```sudo shutdown -r 0```

# Setup the Raspberry Pi


- Connected 128x64 oled display
- Setup upload code to raspberrypi
- Setup Crontab to run code on startup


## Initial Setup

```sh
sudo apt-get update --fix-missing
sudo apt-get install -y tmux vim git
```

## Connect to Wifi

Goto the ```boot``` partition on the SD card

```sh
touch SSH wpa_supplicant.conf
```

In ```wpa_supplicant.conf``` add:

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev

network={
	ssid="Your network SSID"
	psk="Your WPA/WPA2 security key"
}
```

## Setup SSD1306 display

Sources:
- [Adafruit ssd1306](https://learn.adafruit.com/ssd1306-oled-displays-with-raspberry-pi-and-beaglebone-black/wiring)
- [Adafruit i2c](https://learn.adafruit.com/adafruits-raspberry-pi-lesson-4-gpio-setup/configuring-i2c)
- [Adafruit ssd1306 on rpi](https://learn.adafruit.com/ssd1306-oled-displays-with-raspberry-pi-and-beaglebone-black/usage)


|#|disp|pi|
|-|-|-|
|1|vcc|2 - 5v|
|2|gnd|6 - gnd|
|3|scl|5 - sda1 - i2c|
|4|sda|3 - scl1 - i2c|


```

sudo apt-get install -y python-smbus i2c-tools
sudo raspi-config
# Advanced -> enable I2C

sudo i2cdetect -y 1

```

```

sudo apt-get install build-essential python-dev python-pip python3-pip
sudo apt-get install -y python-imaging python-smbus git

sudo pip install RPi.GPIO

sudo apt-get install git
git clone https://github.com/adafruit/Adafruit_Python_SSD1306.git
cd Adafruit_Python_SSD1306
sudo python setup.py install


```


## Crontab

run

```
crontab -e
```

and add

```
@reboot bash /home/pi/spl/src/run.sh
```

## Create RamDisk at /var/tmp

You don't need to do this, but it will prolong the SD cards lifespan as it will be writing to RAM not the card.

```sh
sudo vim /etc/fstab
```
and add

```
tmpfs    /var/tmp    tmpfs    defaults,noatime,nosuid,size=30m    0 0
```


## SPL

```
sudo apt-get install python-pyaudio python-numpy python-scipy
```


# OSX Setup

With homebrew installed:

```sh
brew install portaudio
pip3 -i requirements.txt
```

and run
```sh
cd src
python3 ./spl_meter_text.py
```
