#!/bin/bash

read -p "Are you sure you want to clean up the workspace? (y/n): " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    echo "Cleaning up workspace! Preparing for a new pentest..."
    rm -rf findings/*
    rm -rf payload*
    echo "You're all clean! Happy Pentesting!"
else
    echo "Cleanup canceled."
fi
