#!/bin/bash
set -e

# Форматування розділів у NTFS
echo "Форматування розділів /dev/sda1 і /dev/sda2 у NTFS..."
mkfs.ntfs -f /dev/sda1
mkfs.ntfs -f /dev/sda2

echo "Розділи відформатовано."