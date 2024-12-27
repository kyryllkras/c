#!/bin/bash

mount /dev/sda1 /mnt
grub-install --root-directory=/mnt /dev/sda

cd /mnt/boot/grub
cat <<EOF > grub.cfg
menuentry "windows installer" {
	insmod ntfs
	search --set=root --file=/bootmgr
	ntldr /bootmgr
	boot
}
EOF

echo "GRUB встановлено та налаштовано."