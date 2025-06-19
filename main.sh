#!/bin/bash

while true; do
  clear
  echo "=== Lab Inventory Management ==="
  echo "1. Inventory Management"
  echo "2. Stock Level Monitoring"
  echo "3. Transaction Logs"
  echo "4. Category & Location Management"
  echo "5. Expiry Date Management"
  echo "6. Reports & Analytics"
  echo "7. Import/Export CSV"
  echo "0. Exit"
  read -p "Select an option: " choice

  case $choice in
    1) bash inventory.sh ;;
    2) bash stock.sh ;;
    3) bash transactions.sh ;;
    4) bash category_location.sh ;;
    5) bash expiry.sh ;;
    6) bash reports.sh ;;
    7) bash import_export.sh ;;
    0) exit ;;
    *) echo "Invalid choice"; read ;;
  esac
done
