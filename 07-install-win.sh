#!/bin/bash

# Перехід у /root/windisk (де змонтовано sda2)
cd /root/windisk

# Папка для монтування ISO
mkdir -p winfile

# Завантаження Windows 10 ISO
wget -O win10.iso --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" https://download851.mediafire.com/bn3mqht8fpggiO7oXcvvZoq_YtQ3_HfHb_9oWZWVhrcHwoNlX2wnDSbcWRDeBjSf-PSoMCS28-8d3b2b0qWzyw7YCa3QPI6tDPOcwPtJZGjaVIUtrONcLI5H90rNcclpTmsa6dajJPOpSQlnh71UNWzccxVlv38l6o6WLg0SSAnOpw/bh54h0pgw5gz4sh/win10.iso

# Монтування ISO
mount -o loop win10.iso winfile

# Копіювання файлів Windows 10 на sda1 (/mnt)
rsync -avz --progress winfile/* /mnt

# Відмонтовування ISO
umount winfile
