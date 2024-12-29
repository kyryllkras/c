#!/bin/bash
set -e

export PATH=$PATH:/usr/sbin:/sbin

disk="/dev/sda"

# Перевірка наявності диска
if ! lsblk | grep -q "${disk##*/}"; then
    echo "Помилка: Диск $disk не знайдено!"
    exit 1
fi

# Створення таблиці GPT
echo "Створення GPT-таблиці на $disk..."
parted "$disk" --script mklabel gpt || { echo "Не вдалося створити мітку розділу."; exit 1; }

# Перевірка, чи створено GPT
table_type=$(parted "$disk" --script print | awk '/Partition Table:/ {print $3}')
if [ "$table_type" != "gpt" ]; then
    echo "Помилка: таблиця GPT не створена!"
    exit 1
fi
echo "Таблиця GPT успішно створена."

# Визначення розміру диска
disk_size_bytes=$(blockdev --getsize64 "$disk")
if [ -z "$disk_size_bytes" ] || [ "$disk_size_bytes" -le 0 ]; then
    echo "Помилка: Неможливо визначити розмір диска!"
    exit 1
fi

disk_size_mb=$((disk_size_bytes / 1024 / 1024))
part_size_mb=$((disk_size_mb / 4))

echo "Розмір диска: ${disk_size_mb} MB"
echo "Розмір кожного розділу: ${part_size_mb} MB"

# Створення розділів
echo "Створення NTFS-розділів..."
parted "$disk" --script mkpart primary ntfs 1MiB "$part_size_mb"MiB
parted "$disk" --script mkpart primary ntfs "$part_size_mb"MiB "$((4 * part_size_mb))"MiB

# Оновлення інформації ядра
echo "Оновлення інформації ядра..."
partprobe "$disk"

# Виведення інформації про диск
echo "Таблиця розділів після створення:"
parted "$disk" --script print

echo "Розділи успішно створено!"

# Форматування розділів у NTFS
echo "Форматування розділів /dev/sda1 і /dev/sda2 у NTFS..."
mkfs.ntfs -f /dev/sda1
mkfs.ntfs -f /dev/sda2

echo "Розділи відформатовано."