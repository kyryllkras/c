#!/bin/bash

# Завантаження VirtIO ISO
wget -O virtio.iso https://bit.ly/4d1g7Ht

# Монтування VirtIO
mount -o loop virtio.iso winfile

# Створення теки для драйверів на sda1
mkdir -p /mnt/sources/virtio

# Копіювання драйверів
rsync -avz --progress winfile/* /mnt/sources/virtio

cd /mnt/sources

# Оновлення boot.wim
touch cmd.txt
echo 'add virtio /virtio_drivers' >> cmd.txt
wimlib-imagex update boot.wim 2 < cmd.txt

# Відмонтовуємо VirtIO
umount winfile