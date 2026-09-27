#!/bin/bash
# post-installation.sh - Automated provisioning for Parrot OS (AMD CPU/NVIDIA GPU)

# Ensure the Script is run as root 
if [ "$EUID" -ne 0]; then echo "Please run this script with sudo."
	exit
fi

echo "[*] Installing AMD microcode and NVIDIA proprietary drivers..."
# This resolves the Wayland screen flickering and login loops
apt install -y nvidia-driver nvidia-smi amd64-microcode

echo "[*] Installing Snap daemon..."
apt install -y snapd
# Give the snapd socket a few seconds to initialize
sleep 5
snap install core

echo "[*] Installing Discord And Spotify..."
snap install discord
snap install spotify

echo "[*] Cleaning up unused packages..."
apt autoremove -y

echo "================================================================="
echo "provisioning complete! Please REBOOT your system now."
echo "Note: Ensure 'Secure Boot' is disabled in your BIOS so the NVIDIA"
echo "drivers can load properly without causing a black screen"
echo "================================================================="

sudo reboot
