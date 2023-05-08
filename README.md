# mac-ntfs-write
Mac NTFS Write is a script that enables writing to an NTFS-formatted drive on macOS.

To use this script, open a text editor (such as TextEdit) and copy and paste the above code into a new file. Save the file with a .sh extension (such as ntfs-write.sh) in a convenient location (such as your home folder).

Make the script executable by opening Terminal and navigating to the folder where you saved the script. Then, enter the following command:

```bash
chmod +x ntfs-write.sh
```

Now, you can run the script by opening Terminal and entering the following command:

```bash
./ntfs-write.sh
```

The script will prompt you for your administrator password to make the necessary changes to /etc/fstab and mount the drive. Once the script finishes running, the drive will be available for writing in the /Volumes/DRIVENAME directory and will open in Finder.
