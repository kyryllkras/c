#!/bin/bash
set -e

# Оновлення системи та встановлення необхідних пакетів
echo "Оновлення системи та встановлення необхідних пакетів..."
apt update -y && apt upgrade -y
apt install -y grub2 wimtools ntfs-3g

echo "Успішно встановлені пакети: grub2, wimtools, ntfs-3g."