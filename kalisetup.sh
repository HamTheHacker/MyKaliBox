#!/bin/bash

sudo apt update
sudo apt install kali-tools-web kali-tools-top10 kali-tools-wireless kali-tools-everything -y
sudo apt install impacket-scripts ffuf wget -y
sudo apt install ruby ruby-dev -y
sudo gem install evil-winrm


cd ~

mkdir kali
cd kali

git clone https://github.com/HamTheHacker/MyKaliBox/tree/main/krakin
mkdir transfer

cd transfer

mkdir powerup
cd powerup
git clone https://github.com/HamTheHacker/MyKaliBox/tree/main/tools/powersploit/common_scripts
mv common_scripts/* .
rm -rf common_scripts
cd ..

git clone https://github.com/HamTheHacker/MyKaliBox/tree/main/tools
rm -rf powersploit 
rm -rf others

mkdir dirtycow
cd dirtycow
git clone https://gist.github.com/KrE80r/42f8629577db95782d5e4f609f437a54
mv 42f8629577db95782d5e4f609f437a54/* .
rm -rf 42f8629577db95782d5e4f609f437a54
gcc -pthread c0w.c -o cow-compiled -lcrypt
cd ..

git clone https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS10-059

mkdir windows_suggester
cd windows_suggester
git clone https://github.com/AonCyberLabs/Windows-Exploit-Suggester/blob/master/windows-exploit-suggester.py
cd ..

cd linpeas
git clone https://github.com/peass-ng/PEASS-ng/blob/master/winPEAS/winPEASps1/winPEAS.ps1
cd ..

mkdir print_nightmare
cd print_nightmare
git clone https://github.com/nemo-wq/PrintNightmare-CVE-2021-34527
mv PrintNightmare-CVE-2021-34527/CVE-2021-34527.py .
rm -rf PrintNightmare-CVE-2021-34527
cd ..

mkdir drupal7
cd Drupal7
git clone https://github.com/pimps/CVE-2018-7600
mv CVE-2018-7600/drupa7-CVE-2018-7600.py .
mv drupa7-CVE-2018-7600.py drupal7.py
rm -rf CVE-2018-7600
pip install requests
pip install bs4
cd ..

cd ..

mkdir workspace
cd workspace
mkdir findings 
https://github.com/HamTheHacker/MyKaliBox.git
rm -rf krakin notes tools workspace # to only keep script
mv script/* .
rm -rf script
cd ..


