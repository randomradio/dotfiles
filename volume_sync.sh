#!/bin/bash

# A script to import/export folders to/from a volume.
#
# This script simplifies copying folders to and from a specified volume.
# It uses `rsync` to efficiently transfer files.

# --- Configuration ---
# The target volume mount point.
# IMPORTANT: Change this to your specific volume name.
VOLUME_BASE_PATH="/Volumes/soloman/"

if [ -z "$VOLUME_BASE_PATH" ]; then
  echo "Error: VOLUME_BASE_PATH is not set. Please configure it before running the script."
  exit 1
fi

if [ ! -d "$VOLUME_BASE_PATH" ]; then
  echo "Error: VOLUME_BASE_PATH directory '$VOLUME_BASE_PATH' does not exist."
  exit 1
fi

# --- Functions ---

# Function to print usage instructions
usage() {
  echo "A script to sync folders with an external volume."
  echo
  echo "Usage: $0 <action> <source> [destination]"
  echo
  echo "Actions:"
  echo "  export <local_path> [volume_path] - Copies a local folder to a path on the volume."
  echo "                                      If 'volume_path' is omitted, it copies to the volume root."
  echo "  import <volume_path> [local_path]  - Copies a folder from the volume to a local path."
  echo "                                      If 'local_path' is omitted, it copies to the current directory."
  echo
  echo "Examples:"
  echo "  # Export './my-project' to '/Volumes/soloman/my-project'"
  echo "  $0 export ./my-project"
  echo
  echo "  # Export './my-project' to '/Volumes/soloman/backups/'"
  echo "  $0 export ./my-project backups"
  echo
  echo "  # Import 'my-backup' from the volume to the current directory"
  echo "  $0 import my-backup"
  echo
  echo "  # Import 'my-backup' from the volume to './restored-backups/'"
  echo "  $0 import my-backup ./restored-backups"
  exit 1
}

# --- Pre-flight Checks ---

# 1. Check if rsync is installed
if ! command -v rsync &>/dev/null; then
  echo "Error: 'rsync' is not installed or not in your PATH."
  echo "Please install rsync to use this script."
  exit 1
fi

# 2. Check for a valid number of arguments
if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
  usage
fi

# 3. Check if the volume is mounted and accessible
if ! df "${VOLUME_BASE_PATH}" &>/dev/null; then
  echo "Error: Volume at '${VOLUME_BASE_PATH}' is not mounted or accessible."
  echo "Please ensure the volume is connected and the path is correct in the script."
  exit 1
fi

# --- Main Script ---

ACTION=$1
SOURCE=$2
DESTINATION=$3

case "$ACTION" in
export)
  echo "--- Exporting to Volume ---"
  SOURCE_PATH=$SOURCE
  # If a destination path on the volume is given, use it. Otherwise, use the root.
  DESTINATION_PATH="${VOLUME_BASE_PATH}/${DESTINATION:-}"

  # Check if the source directory exists
  if [ ! -e "$SOURCE_PATH" ]; then
    echo "Error: Source '$SOURCE_PATH' not found."
    exit 1
  fi

  # Create the destination directory on the volume if it doesn't exist
  mkdir -p "$DESTINATION_PATH"

  echo "Source:      $(realpath "$SOURCE_PATH")"
  echo "Destination: $DESTINATION_PATH"
  echo

  rsync -avh --progress "$SOURCE_PATH" "$DESTINATION_PATH"
  ;;

import)
  echo "--- Importing from Volume ---"
  # The source is relative to the volume's base path
  SOURCE_PATH="${VOLUME_BASE_PATH}/${SOURCE}"
  # If a local destination is given, use it. Otherwise, use the current directory.
  DESTINATION_PATH="${DESTINATION:-.}"

  # Check if the source on the volume exists
  if [ ! -e "$SOURCE_PATH" ]; then
    echo "Error: Source '$SOURCE_PATH' not found on the volume."
    exit 1
  fi

  # Create the local destination directory if it doesn't exist
  mkdir -p "$DESTINATION_PATH"

  echo "Source:      $SOURCE_PATH"
  echo "Destination: $(realpath "$DESTINATION_PATH")"
  echo

  rsync -avh --progress "$SOURCE_PATH" "$DESTINATION_PATH"
  ;;

*)
  echo "Error: Invalid action '$ACTION'."
  usage
  ;;
esac

echo
echo "Operation completed successfully."
