#!/bin/bash

# Remove any previous role file
rm -f /tmp/user_role

# Authenticate and get role
bash user.sh
status=$?

if [[ $status -ne 0 ]]; then
  echo "Authentication failed or exited. Goodbye."
  exit 1
fi

if [[ ! -f /tmp/user_role ]]; then
  echo "No role information received. Goodbye."
  exit 1
fi

role=$(cat /tmp/user_role)
rm -f /tmp/user_role

if [[ "$role" != "admin" && "$role" != "user" ]]; then
  echo "Invalid role received: '$role'. Goodbye."
  exit 1
fi

# Now continue with your main menu logic
while true; do
  clear
  echo -e "\e[1;34m=========================================="
  echo -e "\e[1;32m   Lab Management System"
  echo -e "\e[1;33m   Department of Chemistry"
  echo -e "\e[1;35m   Chittagong University of Engineering and Technology"
  echo -e "\e[1;34m==========================================\e[0m"
  echo ""

  echo "=== Main Menu ==="
  if [[ "$role" == "admin" ]]; then
    echo "1. Inventory Management"
    echo "2. Stock Level Monitoring"
    echo "3. Transaction Logs"
    echo "4. Explore Inventory"
    echo "5. Expiry Date Management"
    echo "6. Reports & Analytics"
    echo "7. Import/Export CSV"
    echo "8. User Role Management" 
  else
    echo "1. Explore Inventory"
    echo "2. Import/Export CSV"
  fi
  echo "0. Exit"

  read -p "Select an option: " choice

  if [[ "$role" == "admin" ]]; then
    case $choice in
      1) bash inventory.sh ;;
      2) bash stock.sh ;;
      3) bash transactions.sh ;;
      4) bash search.sh ;;
      5) bash expiry.sh ;;
      6) bash reports.sh ;;
      7) bash import_export.sh ;;
      8) bash manage_roles.sh ;; 
      0) exit ;;
      *) echo "Invalid choice"; read -p "Press Enter to continue..." ;;
    esac
  else
    case $choice in
      1) bash search.sh ;;
      2) bash import_export.sh ;;
      0) exit ;;
      *) echo "Invalid choice"; read -p "Press Enter to continue..." ;;
    esac
  fi
done
