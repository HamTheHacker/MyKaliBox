#!/bin/bash

# Check args
if [ $# -ne 2 ]; then
    echo "Usage: $0 <IP> <PORT>"
    exit 1
fi

IP=$1
PORT=$2
PROTO="http"

# If port is 443, default to https
if [ "$PORT" -eq 443 ]; then
    PROTO="https"
fi

URL="$PROTO://$IP:$PORT/"

# Findings directory in ~/kali/workspace/
FINDINGS_DIR=~/kali/workspace/findings
mkdir -p "$FINDINGS_DIR"

OUTPUT_FILE="$FINDINGS_DIR/web-$IP.txt"

echo "=== Scan Report for $URL ===" | tee "$OUTPUT_FILE"
echo "Date: $(date)" | tee -a "$OUTPUT_FILE"
echo "-----------------------------------" | tee -a "$OUTPUT_FILE"

# --- Nikto scan FIRST ---
echo -e "\n=== Nikto Scan Results ($URL) ===" | tee -a "$OUTPUT_FILE"
nikto -h "$URL" | tee -a "$OUTPUT_FILE"

# --- FFUF scan SECOND ---
echo -e "\n=== FFUF Directory Scan Results ($URL) ===" | tee -a "$OUTPUT_FILE"
ffuf -u "$URL/FUZZ" -w ~/kali/krakin/directory-list-2.3-medium.txt -mc 200,301,302,403 \
     -of csv -o /tmp/ffuf_$IP.csv > /dev/null 2>&1

if [ -s /tmp/ffuf_$IP.csv ]; then
    awk -F',' 'NR>1 {printf "%-7s | %-6s | %s\n",$2,$5,$1}' /tmp/ffuf_$IP.csv \
        | tee -a "$OUTPUT_FILE"
else
    echo "No results found." | tee -a "$OUTPUT_FILE"
fi

echo -e "\n[*] Scan complete. Results saved in: $OUTPUT_FILE"
