#!/bin/bash

# Форматування розділів у NTFS
mkfs.ntfs -f /dev/sda1
mkfs.ntfs -f /dev/sda2

echo "NTFS partitions created"