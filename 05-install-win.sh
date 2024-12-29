#!/bin/bash
set -e

# Перехід у /root/windisk
cd /root/windisk

# Завантаження Windows 10 ISO
iso_path="win10.iso"
echo "Завантаження Windows 10 ISO..."
wget -O "$iso_path" https://download1503.mediafire.com/ebizmk0uscpgYnLF63kxn5cCrFHnM7a5TfeRdLzUk-7gzvIr1iSSsdZB0lqlW5ere-FmiSynRoF-SJJEtodr3KRFqDSro0zalgVZcnK43U8TGVn3McqRmnLu5J60KMbXXiPK7fYvilVsDagjJcA_cOp7dvx-Hyz6ou4qewYxZ54UjA/6lbfcm1bp3omglg/en_windows_server_2019_updated_march_2020_x64_dvd_337baef4.iso || { echo "Не вдалося завантажити ISO!"; exit 1; }

# Монтування ISO
mkdir -p winfile
mount -o loop "$iso_path" winfile

# Копіювання файлів
echo "Копіювання файлів Windows 10 на /mnt..."
rsync -avz --progress winfile/* /mnt

# Відмонтовування ISO
umount winfile
echo "Файли Windows 10 успішно скопійовано."