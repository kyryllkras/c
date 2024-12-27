#!/bin/bash

apt update -y && apt upgrade -y
apt install grub2 wimtools ntfs-3g -y
echo "Система оновлена та необхідне ПЗ встановлено."