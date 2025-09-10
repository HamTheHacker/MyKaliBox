#!/bin/bash

sudo apt update
sudo apt install gcc build-essential libc6-dev libcrypt-dev gcc-multilib -y
sudo apt install subfinder -y
sudo apt install kali-tools-web kali-tools-top10 kali-tools-wireless kali-tools-everything -y
sudo apt install impacket-scripts ffuf wget -y
sudo apt install ruby ruby-dev -y
sudo gem install evil-winrm

######## pimp my kali ##### commented to not execute
# cd /
# git clone https://github.com/Dewalt-arch/pimpmykali
# cd pimpmykali
# sudo ./pimpmykali.sh --auto


################## cloning main repo
cd ~
git clone https://github.com/HamTheHacker/MyKaliBox.git

################## setting up transfer
mkdir transfer
mkdir transfer/powerup
mv MyKaliBox/tools/* transfer/
mv transfer/powersploit/common_scripts/* transfer/powerup
rm -rf transfer/powersploit
rm -rf transfer/others

mkdir transfer/dirtycow
cd transfer/dirtycow
git clone https://gist.github.com/KrE80r/42f8629577db95782d5e4f609f437a54
mv 42f8629577db95782d5e4f609f437a54/* .
rm -rf 42f8629577db95782d5e4f609f437a54
gcc -pthread c0w.c -o compiled_cow -lcrypt
cd ~

mkdir transfer/windows_suggester
cd transfer/windows_suggester
git clone https://github.com/AonCyberLabs/Windows-Exploit-Suggester.git
mv Windows-Exploit-Suggester/windows-exploit-suggester.py .
./windows-exploit-suggester.py --update
rm -rf Windows-Exploit-Suggester
cd ~

mkdir transfer/print_nightmare
cd transfer/print_nightmare
git clone https://github.com/nemo-wq/PrintNightmare-CVE-2021-34527
mv PrintNightmare-CVE-2021-34527/CVE-2021-34527.py .
rm -rf PrintNightmare-CVE-2021-34527
cd ~

cd transfer/ld_preload_privesc
gcc -m32 -fPIC -shared -o compiled_32bit_ld_preload.so ld_preload.c -nostartfiles
gcc -fPIC -shared -o compiled_64bit_ld_preload.so ld_preload.c -nostartfiles
cd ~

cd transfer
git clone https://github.com/saleemrashid/sudo-cve-2019-18634.git
mv sudo-cve-2019-18634 PrivEsc-cve-2019-18634-sudoersExploit
cd sudoPrivEsc-cve-2019-18634
gcc -o exploit.c compiled_exploit
cd ~

mkdir transfer/drupal7
cd transfer/Drupal7
git clone https://github.com/pimps/CVE-2018-7600
mv CVE-2018-7600/drupa7-CVE-2018-7600.py .
mv drupa7-CVE-2018-7600.py drupal7.py
rm -rf CVE-2018-7600
pip3 install requests
pip3 install bs4
cd ~


################## workspace setup

mkdir workspace
mkdir workspace/findings
mkdir workspace/findings/web-osint

mv MyKaliBox/script/* workspace
cd workspace
sudo chmod +x *
cd ~

############## krakin setup
mv MyKaliBox/krakin .

############ remove kali box github repo
rm -rf MyKaliBox
# check wut tf this is first: rm -rf transfer/sudo-cve2019-18634

############# copy transfer.sh
cp workspace/transfer.sh transfer/powerup
cp workspace/transfer.sh transfer/dirtycow
cp workspace/transfer.sh transfer/print_nightmare
cp workspace/transfer.sh transfer/ld_preload_privesc
cp workspace/transfer.sh transfer/sudoPrivEsc-cve-2019-18634
cp workspace/transfer.sh transfer/drupal7
cp workspace/transfer.sh transfer/akagi
cp workspace/transfer.sh transfer/linpeas
cp workspace/transfer.sh transfer/spip_exploit/reverse_shell
cp workspace/transfer.sh transfer/spip_exploit/injection
cp workspace/transfer.sh transfer/php-reverseshell
cp workspace/transfer.sh transfer/
