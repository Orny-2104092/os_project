#!/bin/bash

# Create data folder if not exists
mkdir -p data

# Create required CSV files if they don't exist
touch data/inventory.csv
touch data/transactions.csv

# Optional: Add headers for CSVs (if needed for readability)
if ! grep -q "ID,Name" data/inventory.csv; then
  echo "ID,Name,Category,Location,Quantity,Expiry" > data/inventory.csv
fi

if ! grep -q "Timestamp" data/transactions.csv; then
  echo "Timestamp,ItemID,ItemName,Change" > data/transactions.csv
fi

echo "Setup complete. Inventory system is ready."
