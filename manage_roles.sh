#!/bin/bash

USER_FILE="users.txt"

change_role() {
  echo "User List:"
  nl -w2 -s". " "$USER_FILE"
  
  read -p "Select user number: " num
  username=$(sed -n "${num}p" "$USER_FILE" | cut -d: -f1)
  
  if [ -z "$username" ]; then
    echo "Invalid selection"
    return
  fi
  
  current_role=$(grep "^$username:" "$USER_FILE" | cut -d: -f3)
  echo "Current role for $username: $current_role"
  
  read -p "New role (admin/user): " new_role
  if [[ "$new_role" != "admin" && "$new_role" != "user" ]]; then
    echo "Invalid role"
    return
  fi
  
  # Update role
  tmpfile=$(mktemp)
  while IFS=: read -r u p r; do
    if [ "$u" == "$username" ]; then
      echo "$u:$p:$new_role"
    else
      echo "$u:$p:$r"
    fi
  done < "$USER_FILE" > "$tmpfile"
  
  mv "$tmpfile" "$USER_FILE"
  echo "Role updated successfully!"
}

while true; do
  clear
  echo "=== Role Management ==="
  echo "1. Change User Role"
  echo "0. Back"
  
  read -p "Choose: " opt
  case $opt in
    1) change_role ;;
    0) break ;;
    *) echo "Invalid option" ;;
  esac
  read -p "Press Enter to continue..."
done
