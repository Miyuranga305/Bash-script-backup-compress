#!/bin/bash

# Function to print usage instructions
usage() {
    echo "Usage: $0 <directory_to_backup> <backup_directory>"
    exit 1
}

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Error: Invalid number of arguments."
    usage
fi

# Assigning arguments to variables
DIR_TO_BACKUP=$1
BACKUP_DIR=$2

# Check if the directory to back up exists
if [ ! -d "$DIR_TO_BACKUP" ]; then
    echo "Error: The directory to back up does not exist: $DIR_TO_BACKUP"
    exit 1
fi

# Check if the backup directory exists
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Error: The backup directory does not exist: $BACKUP_DIR"
    exit 1
fi

# Get the current date in YYYY-MM-DD format
CURRENT_DATE=$(date +"%Y-%m-%d")

# Create the backup file name with the current date
BACKUP_FILE_NAME="backup_$(basename "$DIR_TO_BACKUP")_$CURRENT_DATE.tar.gz"

# Create the backup
tar -czf "$BACKUP_FILE_NAME" -C "$(dirname "$DIR_TO_BACKUP")" "$(basename "$DIR_TO_BACKUP")"
if [ $? -ne 0 ]; then
    echo "Error: Failed to create the backup."
    exit 1
fi

# Move the backup file to the backup directory
mv "$BACKUP_FILE_NAME" "$BACKUP_DIR"
if [ $? -ne 0 ]; then
    echo "Error: Failed to move the backup file to the backup directory."
    exit 1
fi

echo "Backup created and moved to $BACKUP_DIR/$BACKUP_FILE_NAME successfully."

exit 0

