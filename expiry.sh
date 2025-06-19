#!/bin/bash
DATA="data/inventory.csv"

echo "=== Expired or Near Expiry Items ==="
today=$(date +%F)
awk -F',' -v now="$today" '
{
  diff = (mktime(gensub(/-/, " ", "g", $6) " 00 00 00") - mktime(gensub(/-/, " ", "g", now) " 00 00 00")) / 86400;
  if (diff <= 30) print $2 " expires on " $6;
}' $DATA
read -p "Press enter to return..."
