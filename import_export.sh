#!/bin/bash

echo "1. Import Inventory CSV"
echo "2. Export Inventory CSV"
read -p "Select: " ch

case $ch in
  1)
    read -p "Path to CSV: " path
    cp $path data/inventory.csv
    echo "Imported!"
    ;;
  2)
    read -p "Export path: " path
    cp data/inventory.csv $path
    echo "Exported!"
    ;;
  *)
    echo "Invalid"
    ;;
esac
read -p "Press enter to return..."
