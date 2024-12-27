#!/bin/bash

# Монтування розділів
mount /dev/sda1 /mnt

# Переходимо до домашнього каталогу root і створюємо теку для sda2
cd ~
mkdir -p windisk

mount /dev/sda2 windisk