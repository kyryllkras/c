#!/bin/bash
set -e

# Встановлення GRUB
echo "Встановлення GRUB на /mnt..."
grub-install --root-directory=/mnt /dev/sda

echo "GRUB успішно встановлено."