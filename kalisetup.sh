#!/bin/bash

sudo apt update
sudo apt install gcc build-essential libc6-dev libcrypt-dev gcc-multilib -y
sudo apt install kali-tools-web kali-tools-top10 kali-tools-wireless kali-tools-everything -y
sudo apt install impacket-scripts ffuf wget -y
sudo apt install ruby ruby-dev -y
sudo gem install evil-winrm


cd ~

mkdir kali
cd kali

git clone https://github.com/HamTheHacker/MyKaliBox.git
mkdir transfer

cd transfer
mkdir powerup

cd powerup
mv ../../MyKaliBox/tools/powersploit/common_scripts/* .
rm -rf common_scripts
cd ..

mv ../MyKaliBox/tools/* .
rm -rf ../MyKaliBox/tools/others

mkdir dirtycow
cd dirtycow
git clone https://gist.github.com/KrE80r/42f8629577db95782d5e4f609f437a54
mv 42f8629577db95782d5e4f609f437a54/* .
rm -rf 42f8629577db95782d5e4f609f437a54
gcc -pthread c0w.c -o cow-compiled -lcrypt
cd ..



mkdir windows_suggester
cd windows_suggester
git clone https://github.com/AonCyberLabs/Windows-Exploit-Suggester.git
mv Windows-Exploit-Suggester/windows-exploit-suggester.py .
./windows-exploit-suggester.py --update
rm -rf Windows-Exploit-Suggester
cd ..

mkdir print_nightmare
cd print_nightmare
git clone https://github.com/nemo-wq/PrintNightmare-CVE-2021-34527
mv PrintNightmare-CVE-2021-34527/CVE-2021-34527.py .
rm -rf PrintNightmare-CVE-2021-34527
cd ..

cd ld_preload_privesc
gcc -m32 -fPIC -shared -o compiled_32bit_ld_preload.so ld_preload.c -nostartfiles
gcc -fPIC -shared -o compiled_64bit_ld_preload.so ld_preload.c -nostartfiles
cd ..

mkdir drupal7
cd Drupal7
git clone https://github.com/pimps/CVE-2018-7600
mv CVE-2018-7600/drupa7-CVE-2018-7600.py .
mv drupa7-CVE-2018-7600.py drupal7.py
rm -rf CVE-2018-7600
pip3 install requests
pip3 install bs4
cd ..

cd ..

mkdir workspace
cd workspace
mkdir findings 

mv ../MyKaliBox/script/* .
chmod +x *
cd ..

mv MyKaliBox/krakin .
rm -rf MyKaliBox

rm -rf transfer/others
rm -rf transfer/powersploit

