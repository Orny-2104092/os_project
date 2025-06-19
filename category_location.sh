#!/bin/bash
DATA="data/inventory.csv"

echo "=== Categories and Locations ==="
awk -F',' '{ print $2, "->", $3, "/", $4 }' $DATA | column -t
read -p "Press enter to return..."
