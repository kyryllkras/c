#!/bin/bash
set -e

# Перехід у /root/windisk
cd /root/windisk

# Завантаження Windows 10 ISO
iso_path="win10.iso"
echo "Завантаження Windows 10 ISO..."
wget -O "$iso_path" https://example.com/win10.iso || { echo "Не вдалося завантажити ISO!"; exit 1; }

# Монтування ISO
mkdir -p winfile
mount -o loop "$iso_path" winfile

# Копіювання файлів
echo "Копіювання файлів Windows 10 на /mnt..."
rsync -avz --progress winfile/* /mnt

# Відмонтовування ISO
umount winfile
echo "Файли Windows 10 успішно скопійовано."