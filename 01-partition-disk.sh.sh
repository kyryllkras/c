#!/bin/bash

# Визначення розміру диска
disk_size_gb=$(parted /dev/sda --script print | awk '/^Disk \/dev\/sda:/ {print int($3)}')
disk_size_mb=$((disk_size_gb * 1024))
part_size_mb=$((disk_size_mb / 4))

# Створення GPT-таблиці
parted /dev/sda --script -- mklabel gpt

# Створення двох NTFS-розділів
parted /dev/sda --script -- mkpart primary ntfs 1MB ${part_size_mb}MB
parted /dev/sda --script -- mkpart primary ntfs ${part_size_mb}MB $((2 * part_size_mb))MB

# Інформування ядра про зміни
partprobe /dev/sda
sleep 30
partprobe /dev/sda
sleep 30
partprobe /dev/sda
sleep 30