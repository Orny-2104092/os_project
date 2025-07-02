#!/bin/bash

DATA="data/inventory.csv"

search_by_name() {
  read -p "Enter item name: " name
  if [ -z "$name" ]; then
    echo "No name entered."
    return
  fi
  echo "Search results for '$name':"
  awk -F, -v name="$name" 'BEGIN {IGNORECASE=1; OFS=","; print "ID,Name,Category,Location,Quantity,Expiry"}
                           $2 ~ name {print $1,$2,$3,$4,$5,$6}' "$DATA" | column -t -s,
}

search_by_category() {
  echo "Available categories:"
  awk -F, '{print $3}' "$DATA" | sort | uniq | column
  read -p "Enter category: " category
  if [ -z "$category" ]; then
    echo "No category entered."
    return
  fi
  echo "Items in category '$category':"
  awk -F, -v cat="$category" 'BEGIN {IGNORECASE=1; OFS=","; print "ID,Name,Category,Location,Quantity,Expiry"}
                              $3 ~ cat {print $1,$2,$3,$4,$5,$6}' "$DATA" | column -t -s,
}

search_by_location() {
  echo "Available locations:"
  awk -F, '{print $4}' "$DATA" | sort | uniq | column
  read -p "Enter location: " location
  if [ -z "$location" ]; then
    echo "No location entered."
    return
  fi
  echo "Items in location '$location':"
  awk -F, -v loc="$location" 'BEGIN {IGNORECASE=1; OFS=","; print "ID,Name,Category,Location,Quantity,Expiry"}
                              $4 ~ loc {print $1,$2,$3,$4,$5,$6}' "$DATA" | column -t -s,
}

while true; do
  clear
  echo "=== Search Inventory =="
  echo "1. Search by Name"
  echo "2. Search by Category"
  echo "3. Search by Location"
  echo "0. Back"
  
  read -p "Choose option: " opt
  case $opt in
    1) search_by_name
       read -p "Press Enter to continue..." ;;
    2) search_by_category
       read -p "Press Enter to continue..." ;;
    3) search_by_location
       read -p "Press Enter to continue..." ;;
    0) break ;;
    *) echo "Invalid option";;
  esac
done
