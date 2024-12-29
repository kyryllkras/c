#!/bin/bash
set -e

# Узгодження GPT через gdisk
disk="/dev/sda"
echo "Узгодження GPT-таблиці на $disk..."
echo -e "r\ng\np\nw\nY\n" | gdisk "$disk"

echo "GPT-таблиця узгоджена."