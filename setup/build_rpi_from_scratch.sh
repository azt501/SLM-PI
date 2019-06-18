# Install the Raspbian Minimal Image
sudo apt-get update --fix-missing
sudo apt-get install tmux vim git
sudo apt-get install i2c-tools build-essential


# python2 libraries
sudo apt-get install \
python-dev \
python-pyaudio \
python-numpy \
python-scipy \
python-smbus \
python-pip

# python3 libraries
sudo apt-get install \
python3-dev \
python3-pyaudio \
python3-numpy \
python3-scipy \
python3-smbus \
python3-pip

cd ~
git clone https://github.com/adafruit/Adafruit_Python_SSD1306.git
cd Adafruit_Python_SSD1306
sudo python setup.py install


read -p "Enable i2c. Press enter to continue"
sudo raspi-config # enable i2c
read -p "Looking for '3c' in i2c"
sudo i2cdetect -y 1
