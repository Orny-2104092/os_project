#!/bin/bash
DATA="data/inventory.csv"

echo "=== Stock Levels ==="
awk -F',' '{ print $1, $2, "->", $5 " units" }' $DATA
read -p "Press enter to return..."
