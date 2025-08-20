
#!/bin/bash

TARGET=$1
OUTPUT_DIR=~/kali/workspace/findings
OUTPUT_FILE="$OUTPUT_DIR/scan-results.txt"

mkdir -p "$OUTPUT_DIR"

# Header
{
    echo "=== Nmap Scan Report for $TARGET ==="
    echo "Date: $(date)"
    echo "-----------------------------------"
    echo
} | tee "$OUTPUT_FILE"

# Run Nmap with version + scripts, parse into neat blocks
nmap -sV -sC "$TARGET" -oG - | awk -v outfile="$OUTPUT_FILE" '
/^Host:/ {
    ip=$2
    state=$4
    if (state=="Up") {
        print "=== Host: " ip " ===" >> outfile
        print "-----------------------------------" >> outfile
        print "=== Host: " ip " ==="
        print "-----------------------------------"
    }
}

/Ports:/ {
    split($0, arr, "Ports: ")
    ports=arr[2]
    n=split(ports, plist, ", ")
    for (i=1; i<=n; i++) {
        gsub("/open/", " open    ", plist[i])
        gsub("/filtered/", " filtered ", plist[i])
        gsub("/closed/", " closed   ", plist[i])
        gsub("tcp", "tcp   ", plist[i])
        print plist[i] >> outfile
        print plist[i]
    }
    print "" >> outfile
    print ""
}

/Service Info:/ {
    print "  " $0 >> outfile
    print "  " $0
}
END {
    print "[*] Scan complete. Results saved in: " outfile >> outfile
    print "[*] Scan complete. Results saved in: " outfile
}'
