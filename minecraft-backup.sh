#!/bin/bash

# get current date and create the string to append
now="$(date)"
echo "Current date and time: $now"
now="$(date +'%Y-%m-%d--%H-%M')"
echo "The following string will be appended to the backup: $now"

# create the backup folder if it does not exist
mkdir -p minecraft-backups

# create a new backup
sudo tar -cvf minecraft-backups/bedrock-level-backup-$now.tar -C /opt/bedrock-server/worlds/ 'Bedrock level'
echo "Backup completed. Checking for older backups to delete..."

# define backup directory
backup_dir="minecraft-backups"

# check the number of backups
echo "Checking files in $backup_dir..."
backup_count=$(find "$backup_dir" -type f -name "*.tar" | wc -l)
echo "There are $backup_count backups."

# set max number of backups to keep
max_backups=14

if [ "$backup_count" -gt "$max_backups" ]; then
    echo "Too many backups. Deleting the oldest one..."
    # find and delete the oldest file
    oldest_backup=$(find "$backup_dir" -type f -name "*.tar" -printf "%T+ %p\n" | sort | head -n 1 | awk '{print $2}')
    if [ -n "$oldest_backup" ]; then
        echo "Deleting $oldest_backup..."
        rm -f "$oldest_backup"
        echo "Oldest backup deleted."
    else
        echo "No backup found to delete"
    fi
else
    echo "Backup count is within the limit of $max_backups"
fi

# wait one minute
echo "Waiting 10 seconds..."
sleep 1m

# one-time folder sync using Filen
echo "Starting cloud sync using Filen."
filen sync ~/minecraft-backups:twoWay:/minecraft-backups
echo "Cloud sync completed."

echo "Backup script completed."
