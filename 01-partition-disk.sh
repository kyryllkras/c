#!/bin/bash
set -e

export PATH=$PATH:/usr/sbin:/sbin

disk="/dev/sda"

# Перевірка, чи існує диск
if ! lsblk | grep -q "${disk##*/}"; then
    echo "Помилка: Диск $disk не знайдено!"
    exit 1
fi

# Створення нової мітки розділу (GPT)
echo "Створення GPT-таблиці на $disk..."
parted "$disk" --script mklabel gpt || { echo "Не вдалося створити мітку розділу на $disk"; exit 1; }

# Визначення розміру диска
disk_size_gb=$(parted "$disk" --script print | awk '/^Disk/ {print int($3)}')
if [ -z "$disk_size_gb" ] || [ "$disk_size_gb" -le 0 ]; then
    echo "Помилка: Неможливо визначити розмір диска!"
    exit 1
fi

disk_size_mb=$((disk_size_gb * 1024))
part_size_mb=$((disk_size_mb / 4))

# Створення NTFS-розділів
echo "Створення NTFS-розділів..."
parted "$disk" --script mkpart primary ntfs 1MB "${part_size_mb}MB"
parted "$disk" --script mkpart primary ntfs "${part_size_mb}MB" "$((2 * part_size_mb))MB"

# Інформування ядра про зміни
echo "Оновлення інформації ядра про зміни в розділах..."
partprobe "$disk"

echo "Розділи успішно створено!"