#!/bin/bash
ip -o -4 addr show | awk '{print $2, $4}' | column -t
python3 -m http.server 80
