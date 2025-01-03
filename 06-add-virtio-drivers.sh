#!/bin/bash
set -e

# Завантаження VirtIO ISO
iso_path="virtio.iso"
echo "Завантаження VirtIO ISO..."
wget -O "$iso_path" https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.266-1/virtio-win-0.1.266.iso || { echo "Не вдалося завантажити VirtIO ISO!"; exit 1; }

# Монтування VirtIO
mkdir -p winfile
mount -o loop "$iso_path" winfile

# Копіювання драйверів
mkdir -p /mnt/sources/virtio
echo "Копіювання VirtIO драйверів..."
rsync -avz --progress winfile/* /mnt/sources/virtio

# Оновлення boot.wim
cd /mnt/sources
cmd_file="cmd.txt"
echo "add virtio /virtio_drivers" > "$cmd_file"
wimlib-imagex update boot.wim 2 < "$cmd_file"

# Відмонтовування VirtIO
umount winfile
echo "VirtIO драйвери успішно додано."