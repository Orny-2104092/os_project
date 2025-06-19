#!/bin/bash
echo "=== Inventory Report ==="
cat data/inventory.csv

echo ""
echo "=== Transaction Log ==="
cat data/transactions.csv

read -p "Press enter to return..."
