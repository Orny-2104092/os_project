

DATA="data/inventory.csv"
LOG="data/transactions.csv"

log_transaction() {
  
  timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  echo "$timestamp,$1,$2,$3,$4" >> $LOG
}


add_stock() {
  read -p "Enter Item ID: " id
  item_line=$(grep "^$id," $DATA)
  if [ -z "$item_line" ]; then
    echo "Item not found"
    return
  fi

  read -p "Enter quantity to add: " qty_to_add
  name=$(echo $item_line | cut -d',' -f2)
  current_qty=$(echo $item_line | cut -d',' -f5)
  new_qty=$((current_qty + qty_to_add))


  sed -i "/^$id,/d" $DATA
  new_line=$(echo $item_line | awk -F',' -v q=$new_qty 'BEGIN{OFS=","} {$5=q; print}')
  echo $new_line >> $DATA

 
  log_transaction $id $name $qty_to_add "add"
  echo "Stock added successfully!"
}


remove_stock() {
  read -p "Enter Item ID: " id
  item_line=$(grep "^$id," $DATA)
  if [ -z "$item_line" ]; then
    echo "Item not found"
    return
  fi

  read -p "Enter quantity to remove: " qty_to_remove
  name=$(echo $item_line | cut -d',' -f2)
  current_qty=$(echo $item_line | cut -d',' -f5)
  

  if [ $current_qty -lt $qty_to_remove ]; then
    echo "Not enough stock available to remove"
    return
  fi

  new_qty=$((current_qty - qty_to_remove))


  sed -i "/^$id,/d" $DATA
  new_line=$(echo $item_line | awk -F',' -v q=$new_qty 'BEGIN{OFS=","} {$5=q; print}')
  echo $new_line >> $DATA


  log_transaction $id $name $qty_to_remove "remove"
  echo "Stock removed successfully!"
}

while true; do
  echo "--- Transaction Logging ---"
  echo "1. Add Stock"
  echo "2. Remove Stock"
  echo "0. Back"
  read -p "Choose an option: " opt

  case $opt in
    1) add_stock ;;
    2) remove_stock ;;
    0) break ;;
    *) echo "Invalid option";;
  esac
done
