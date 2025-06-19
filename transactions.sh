#!/bin/bash
DATA="data/inventory.csv"
LOG="data/transactions.csv"

log_transaction() {
  timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  echo "$timestamp,$1,$2,$3" >> $LOG
}

read -p "Enter Item ID: " id
item_line=$(grep "^$id," $DATA)
if [ -z "$item_line" ]; then echo "Item not found"; exit; fi

read -p "Enter + or - quantity: " delta
name=$(echo $item_line | cut -d',' -f2)
qty=$(echo $item_line | cut -d',' -f5)
new_qty=$((qty + delta))

sed -i "/^$id,/d" $DATA
new_line=$(echo $item_line | awk -F',' -v q=$new_qty 'BEGIN{OFS=","} {$5=q; print}')
echo $new_line >> $DATA

log_transaction $id $name $delta
echo "Transaction logged."
