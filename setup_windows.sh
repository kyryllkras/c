#!/bin/bash

cd /root/windisk
mkdir -p winfile

# Завантаження Windows ISO
wget -O win10.iso --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" https://download851.mediafire.com/bn3mqht8fpggiO7oXcvvZoq_YtQ3_HfHb_9oWZWVhrcHwoNlX2wnDSbcWRDeBjSf-PSoMCS28-8d3b2b0qWzyw7YCa3QPI6tDPOcwPtJZGjaVIUtrONcLI5H90rNcclpTmsa6dajJPOpSQlnh71UNWzccxVlv38l6o6WLg0SSAnOpw/bh54h0pgw5gz4sh/win10.iso
mount -o loop win10.iso winfile
rsync -avz --progress winfile/* /mnt
umount winfile

# Завантаження VirtIO драйверів
wget -O virtio.iso https://bit.ly/4d1g7Ht
mount -o loop virtio.iso winfile
mkdir -p /mnt/sources/virtio
rsync -avz --progress winfile/* /mnt/sources/virtio
umount winfile

# Інтеграція драйверів
cd /mnt/sources
touch cmd.txt
echo 'add virtio /virtio_drivers' >> cmd.txt
wimlib-imagex update boot.wim 2 < cmd.txt

echo "Windows файли та VirtIO драйвери готові."