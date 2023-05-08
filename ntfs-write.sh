#!/bin/bash

# Find the identifier of the NTFS-formatted drive
DRIVE_ID=$(diskutil list | grep "Microsoft Basic Data" | awk '{print $NF}')

# Check if a valid drive was found
if [ -z "$DRIVE_ID" ]; then
    echo "No NTFS-formatted drive found"
    exit 1
fi

# Get the name of the drive
DRIVE_NAME=$(diskutil info "$DRIVE_ID" | grep "Volume Name" | awk -F': +' '{print $2}')

# Check if the drive is already mounted
if mount | grep "/Volumes/$DRIVE_NAME" > /dev/null; then
    echo "Drive is already mounted"
    
    # Unmount the drive before mounting it with the new options
    sudo umount "/Volumes/$DRIVE_NAME"
else
    # Create a mount point for the drive
    sudo mkdir "/Volumes/$DRIVE_NAME"
fi

# Add the drive to /etc/fstab to enable writing
echo "LABEL=$DRIVE_NAME none ntfs rw,auto,nobrowse" | sudo tee -a /etc/fstab

# Mount the drive
sudo mount -t ntfs -o rw,auto,nobrowse "/dev/$DRIVE_ID" "/Volumes/$DRIVE_NAME"

echo "Drive mounted at /Volumes/$DRIVE_NAME"

# Open the drive in Finder
open "/Volumes/$DRIVE_NAME"

# Wait for the user to finish using the drive
echo "Press any key to unmount the drive"
read -n 1 -s

# Unmount the drive
sudo umount "/Volumes/$DRIVE_NAME"

# Remove the mount point
sudo rmdir "/Volumes/$DRIVE_NAME"

# Remove the /etc/fstab entry
sudo sed -i '' "/$DRIVE_NAME/d" /etc/fstab

echo "Drive unmounted"
