#!/bin/bash

USER_FILE="users.txt"
touch "$USER_FILE"

login() {
  read -p "Username: " username
  read -sp "Password: " password
  echo

  if grep -q "^$username:$password:admin$" "$USER_FILE"; then
    echo "admin" > /tmp/user_role
    exit 0
  elif grep -q "^$username:$password:user$" "$USER_FILE"; then
    echo "user" > /tmp/user_role
    exit 0
  else
    echo "Invalid credentials."
    return 1
  fi
}

register() {
  read -p "Choose username: " username
  read -sp "Choose password: " password
  echo

  if grep -q "^$username:" "$USER_FILE"; then
    echo "Username already exists."
    return 1
  else
    # Check if admin already exists
    if grep -q ":admin$" "$USER_FILE"; then
      echo "Admin account already exists. Creating user account instead."
      role="user"
    else
      read -p "Is this an admin account? (y/n): " is_admin
      role="user"
      [[ "$is_admin" == "y" || "$is_admin" == "Y" ]] && role="admin"
    fi
    
    echo "$username:$password:$role" >> "$USER_FILE"
    echo "Account created. Role: $role"
  fi
}

  clear
  echo "=========================================="
  echo "     Welcome to the Lab Management System"
  echo "      Department of Chemistry, CUET"
  echo "=========================================="
  echo ""
  echo "Please login to your account or register as a new user to continue."
  echo ""
  echo "1. Login"
  echo "2. Register"
  echo "0. Exit"
  read -p "Choose an option: " opt
  case $opt in
    1)
      login
      ;;
    2)
      register
      ;;
    0)
      exit 1
      ;;
    *)
      echo "Invalid option"
      ;;
  esac 
done
