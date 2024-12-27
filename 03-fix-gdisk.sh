#!/bin/bash

# Узгодження GPT через gdisk
echo -e "r\ng\np\nw\nY\n" | gdisk /dev/sda