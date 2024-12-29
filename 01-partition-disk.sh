#!/bin/bash
set -e

export PATH=$PATH:/usr/sbin:/sbin

disk="/dev/sda"

# Перевірка наявності диска
if ! lsblk | grep -q "${disk##*/}"; then
    echo "Помилка: Диск $disk не знайдено!"
    exit 1
fi

# Ініціалізація диска (якщо необхідно)
echo "Створення GPT-таблиці на $disk..."
parted "$disk" --script mklabel gpt || { echo "Не вдалося створити мітку розділу."; exit 1; }

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

# Створення NTFS-розділів
echo "Створення NTFS-розділів..."
parted "$disk" --script mkpart primary ntfs 1MiB "$part_size_mb"MiB
parted "$disk" --script mkpart primary ntfs "$part_size_mb"MiB "$((2 * part_size_mb))"MiB

# Інформування ядра про зміни
echo "Оновлення інформації ядра..."
partprobe "$disk"

echo "Розділи успішно створено!"