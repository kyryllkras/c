#!/bin/bash
set -e

# Перехід у /root/windisk
cd /root/windisk

# Завантаження Windows 10 ISO
iso_path="win10.iso"
echo "Завантаження Windows 10 ISO..."
wget -O "$iso_path" https://download851.mediafire.com/bn3mqht8fpggiO7oXcvvZoq_YtQ3_HfHb_9oWZWVhrcHwoNlX2wnDSbcWRDeBjSf-PSoMCS28-8d3b2b0qWzyw7YCa3QPI6tDPOcwPtJZGjaVIUtrONcLI5H90rNcclpTmsa6dajJPOpSQlnh71UNWzccxVlv38l6o6WLg0SSAnOpw/bh54h0pgw5gz4sh/win10.iso || { echo "Не вдалося завантажити ISO!"; exit 1; }

# Монтування ISO
mkdir -p winfile
mount -o loop "$iso_path" winfile

# Копіювання файлів
echo "Копіювання файлів Windows 10 на /mnt..."
rsync -avz --progress winfile/* /mnt

# Відмонтовування ISO
umount winfile
echo "Файли Windows 10 успішно скопійовано."