# minecraft-backup-script
A simple script to backup my minecraft world

This script will create a backup of the indicated folder by archiving it in a tarball, appending the current date and time to the filename. It will place said tarball in a folder in the same path as the location of the script file.

After that, it will check for the number of backups in the folder and delete the oldest one if there are more than the max number set on line 25.

Finally, it will sync the backup folder with a cloud folder using Filen.io (follow instructions from https://github.com/FilenCloudDienste/filen-cli to install and setup). The destination folder in the cloud needs to exist already. If not interested in this sync, delete or comment out lines 41 to 49.

If you'd like to use this, remember to modify line 13, indicating the correct path for your Minecraft world.
