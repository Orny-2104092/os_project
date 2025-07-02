#!/bin/bash

DATA="data/inventory.csv"
EXPORT_DIR="downloads"
EXPORT_FILE="$EXPORT_DIR/inventory.csv"

# Optionally, create the directory if it doesn't exist
mkdir -p "$EXPORT_DIR"

echo "1. Import (View) Inventory CSV"
echo "2. Export (Download) Inventory CSV"
read -p "Select: " ch

case $ch in
  1)
    read -p "Path to local CSV to view: " path
    if [[ -f "$path" ]]; then
      echo "Contents of $path:"
      echo "--------------------------------------------"
      column -t -s, "$path"
      echo "--------------------------------------------"
    else
      echo "File not found: $path"
    fi
    ;;
  2)
    if cp "$DATA" "$EXPORT_FILE"; then
      echo "Exported to $EXPORT_FILE!"
    else
      echo "Export failed!"
    fi
    ;;
  *)
    echo "Invalid"
    ;;
esac
read -p "Press enter to return..."
