#!/bin/bash
set -e

# Перевірка джерел репозиторіїв
echo "Перевірка та оновлення джерел репозиторіїв..."
cat <<EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian buster main contrib non-free
deb http://security.debian.org/debian-security buster/updates main contrib non-free
deb http://deb.debian.org/debian buster-updates main contrib non-free
EOF

# Оновлення списку пакетів
echo "Оновлення списку пакетів..."
apt update -y

# Встановлення ядра (якщо його немає)
if ! ls /boot/vmlinuz-* &>/dev/null; then
    echo "Ядро не знайдено. Встановлюємо ядро..."
    apt install -y linux-image-amd64 || { echo "Помилка: не вдалося встановити ядро."; exit 1; }
fi

# Встановлення необхідних пакетів
echo "Встановлення необхідних пакетів..."
apt install -y grub2 wimtools ntfs-3g || { echo "Помилка: не вдалося встановити пакети."; exit 1; }

echo "Успішне встановлення всіх необхідних компонентів."
