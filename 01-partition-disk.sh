#!/bin/bash
set -e

export PATH=$PATH:/usr/sbin:/sbin

# Перевірка існування диска
disk="/dev/sda"
if ! lsblk | grep -q "${disk##*/}"; then
    echo "Диск ${disk} не знайдено!"
    exit 1
fi

# Визначення розміру диска
disk_size_gb=$(parted "$disk" --script print | awk '/^Disk/ {print int($3)}')
disk_size_mb=$((disk_size_gb * 1024))
part_size_mb=$((disk_size_mb / 4))

# Створення GPT-таблиці
echo "Створення GPT-таблиці на $disk..."
parted "$disk" --script -- mklabel gpt

# Створення двох NTFS-розділів
echo "Створення NTFS-розділів..."
parted "$disk" --script -- mkpart primary ntfs 1MB "${part_size_mb}MB"
parted "$disk" --script -- mkpart primary ntfs "${part_size_mb}MB" "$((2 * part_size_mb))MB"

# Інформування ядра про зміни
partprobe "$disk"
echo "Розділи створено."