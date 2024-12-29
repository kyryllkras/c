#!/bin/bash
set -e

# Встановлення GRUB
echo "Встановлення GRUB на /mnt..."
grub-install --root-directory=/mnt /dev/sda

echo "GRUB успішно встановлено."

# Налаштування grub.cfg
grub_cfg="/mnt/boot/grub/grub.cfg"
mkdir -p /mnt/boot/grub
echo "Створення файлу конфігурації GRUB..."
cat <<EOF > "$grub_cfg"
menuentry "Windows Installer" {
    insmod ntfs
    search --set=root --file=/bootmgr
    ntldr /bootmgr
    boot
}
EOF

echo "Файл конфігурації GRUB створено."