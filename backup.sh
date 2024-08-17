#!/bin/bash

# Enable the directory completion
shopt -s direxpand

# Ask directory or directories to be compressed
echo "What directory or directories do you want to compress? (Specify the full path. If more than one, please separate with a space)"
read -e -p ">" DIRECTORIES

# Ask the destination folder
echo "Please specify the destination folder"
read -e -p ">" BACKUP_DIR

# Check if the directory exists
if [ ! -d "$BACKUP_DIR" ]; then
        echo "Creating directory..."
        mkdir -p "$BACKUP_DIR"
fi

# Timestamp format
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Loop
for DIR in $DIRECTORIES; do
        # Check if the directory exists
        if [ -d "$DIR" ]; then
                # Get the directory name
                DIR_NAME=$(basename "$DIR")

                # Filename
                BACKUP_FILE="${BACKUP_DIR}/${DIR_NAME}_${TIMESTAMP}.tar.gz"

                # Compress directory
                tar -czf "$BACKUP_FILE" -C "$DIR" .

                # Show results
                echo "Directory $DIR compressed: $BACKUP_FILE"
        else
                echo "Directory $DIR does not exist. Skipping..."
        fi
done

echo "Backup completed"
