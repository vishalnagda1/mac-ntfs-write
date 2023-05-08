#!/bin/bash

# Find the first NTFS-formatted drive
DRIVE_NAME=$(diskutil list | grep "Microsoft Basic Data" | head -n 1 | awk '{print $NF}')
# you might need to change the "Microsoft Basic Data" if it doesn't detect the drive

# Check if a valid drive was found
if [ -z "$DRIVE_NAME" ]; then
    echo "No NTFS-formatted drive found"
    exit 1
fi

# Get the drive identifier
DRIVE_IDENTIFIER=$(diskutil list | grep "$DRIVE_NAME" | awk '{print $NF}')

# Create a mount point for the drive
sudo mkdir "/Volumes/$DRIVE_NAME"

# Add the drive to /etc/fstab to enable writing
echo "LABEL=$DRIVE_NAME none ntfs rw,auto,nobrowse" | sudo tee -a /etc/fstab

# Mount the drive
sudo mount -t ntfs -o rw,auto,nobrowse "$DRIVE_IDENTIFIER" "/Volumes/$DRIVE_NAME"

# Open the drive in Finder
open "/Volumes/$DRIVE_NAME"
