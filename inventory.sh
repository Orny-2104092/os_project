#!/bin/bash
DATA="data/inventory.csv"

# Define location codes and sequential counters for each location
declare -A location_codes
location_codes=(
  ["Shelf A"]="A"
  ["Shelf B"]="B"
  ["Drawer 1"]="D1"
  ["Drawer 2"]="D2"
  ["Fume Hood"]="FH"
  ["Fridge"]="F"
)

declare -A location_counters
location_counters=(
  ["Shelf A"]=1
  ["Shelf B"]=1
  ["Drawer 1"]=1
  ["Drawer 2"]=1
  ["Fume Hood"]=1
  ["Fridge"]=1
)

add_item() {
  read -p "Item Name: " name
  read -p "Category: " category
  
  # Predefined locations for efficiency
  echo "Select location:"
  echo "1. Shelf A"
  echo "2. Shelf B"
  echo "3. Drawer 1"
  echo "4. Drawer 2"
  echo "5. Fume Hood"
  echo "6. Fridge"
  echo "7. Other"
  read -p "Choose a location (1-7): " location_choice

  # Handle location input based on user's choice
  case $location_choice in
    1) location="Shelf A" ;;
    2) location="Shelf B" ;;
    3) location="Drawer 1" ;;
    4) location="Drawer 2" ;;
    5) location="Fume Hood" ;;
    6) location="Fridge" ;;
    7) 
      read -p "Enter custom location: " location
      location_code="O"
      ;;
    *)
      echo "Invalid choice, setting location as 'Other'."
      location="Other"
      location_code="O"
      ;;
  esac

  # Generate the ID based on location and sequential number
  location_code="${location_codes[$location]:-${location_code}}"
  id="${location_code}$(printf "%04d" ${location_counters[$location]})"
  
  # Increment the location counter for the next item
  location_counters[$location]=$((location_counters[$location] + 1))

  read -p "Quantity: " qty
  read -p "Expiry Date (YYYY-MM-DD): " expiry

  # Save the item to the inventory
  echo "$id,$name,$category,$location,$qty,$expiry" >> $DATA
  echo "Item added with ID: $id"
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
