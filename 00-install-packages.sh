#!/bin/bash

# Оновлення системи та встановлення необхідних пакетів
apt update -y && apt upgrade -y
apt install grub2 wimtools ntfs-3g -y