#!/bin/bash
DATA="data/inventory.csv"

add_item() {
  read -p "Item Name: " name
  read -p "Category: " category
  read -p "Location: " location
  read -p "Quantity: " qty
  read -p "Expiry Date (YYYY-MM-DD): " expiry
  id=$(date +%s)
  echo "$id,$name,$category,$location,$qty,$expiry" >> $DATA
  echo "Item added!"
}

edit_item() {
  read -p "Enter Item ID to Edit: " id
  grep -v "^$id," $DATA > temp.csv
  read -p "New Name: " name
  read -p "New Category: " category
  read -p "New Location: " location
  read -p "New Quantity: " qty
  read -p "New Expiry Date: " expiry
  echo "$id,$name,$category,$location,$qty,$expiry" >> temp.csv
  mv temp.csv $DATA
  echo "Item updated!"
}

delete_item() {
  read -p "Enter Item ID to Delete: " id
  grep -v "^$id," $DATA > temp.csv
  mv temp.csv $DATA
  echo "Item deleted!"
}

view_items() {
  echo "ID,Name,Category,Location,Quantity,Expiry"
  cat $DATA
}

search_item() {
  read -p "Enter name to search: " query
  grep -i "$query" $DATA
}

while true; do
  echo "--- Inventory Management ---"
  echo "1. Add Item"
  echo "2. Edit Item"
  echo "3. Delete Item"
  echo "4. View All Items"
  echo "5. Search by Name"
  echo "0. Back"
  read -p "Choose: " opt
  case $opt in
    1) add_item ;;
    2) edit_item ;;
    3) delete_item ;;
    4) view_items ;;
    5) search_item ;;
    0) break ;;
    *) echo "Invalid";;
  esac
done
