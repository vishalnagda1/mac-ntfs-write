#!/bin/bash

# Change the values below to match your drive's name and identifier
DRIVE_NAME="DRIVENAME"  # replace "DRIVENAME" with the name of the NTFS-formatted drive.
DRIVE_IDENTIFIER="/dev/disk2s1"  # replace "disk2s1" with the disk identifier of the NTFS-formatted drive.

# Create a mount point for the drive
sudo mkdir "/Volumes/$DRIVE_NAME"

# Add the drive to /etc/fstab to enable writing
echo "LABEL=$DRIVE_NAME none ntfs rw,auto,nobrowse" | sudo tee -a /etc/fstab

# Mount the drive
sudo mount -t ntfs -o rw,auto,nobrowse "$DRIVE_IDENTIFIER" "/Volumes/$DRIVE_NAME"

# Open the drive in Finder
open "/Volumes/$DRIVE_NAME"
