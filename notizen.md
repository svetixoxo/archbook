# Arch Linux Installation und Konfiguration

## Inhaltsverzeichnis

1. [Erste Schritte](#1-erste-schritte)
   - [1.1 Vorbereitungen](#11-vorbereitungen)
   - [1.2 Tastaturlayout laden](#12-tastaturlayout-laden)
2. [Festplatte einrichten](#2-festplatte-einrichten)
   - [2.1 Festplatten anzeigen](#21-festplatten-anzeigen)
   - [2.2 Festplatte partitionieren](#22-festplatte-partitionieren)
   - [2.3 Dateisysteme erstellen](#23-dateisysteme-erstellen)
   - [2.4 Partitionen mounten](#24-partitionen-mounten)
3. [System-Installation](#3-system-installation)
   - [3.1 Basis-Pakete installieren](#31-basis-pakete-installieren)
   - [3.2 fstab erstellen](#32-fstab-erstellen)
   - [3.3 In das neue System wechseln](#33-in-das-neue-system-wechseln)
4. [System konfigurieren](#4-system-konfigurieren)
   - [4.1 Zeitzone setzen](#41-zeitzone-setzen)
   - [4.2 Locale konfigurieren](#42-locale-konfigurieren)
   - [4.3 Hostname setzen](#43-hostname-setzen)
5. [GRUB-Bootloader installieren](#5-grub-bootloader-installieren)
   - [5.1 GRUB für UEFI installieren](#51-grub-für-uefi-installieren)
   - [5.2 GRUB-Konfiguration erstellen](#52-grub-konfiguration-erstellen)
   - [5.3 GRUB für WLAN-Treiber konfigurieren](#53-grub-für-wlan-treiber-konfigurieren-falls-benötigt)
6. [Benutzer und Passwörter](#6-benutzer-und-passwörter)
   - [6.1 Root-Passwort setzen](#61-root-passwort-setzen)
   - [6.2 Neuen Benutzer erstellen](#62-neuen-benutzer-erstellen)
   - [6.3 Sudo-Rechte aktivieren](#63-sudo-rechte-aktivieren)
7. [NetworkManager aktivieren](#7-networkmanager-aktivieren)
8. [System neu starten](#8-system-neu-starten)
9. [WLAN-Treiber installieren](#9-wlan-treiber-installieren-falls-benötigt)
   - [9.1 Notwendige Pakete](#91-notwendige-pakete)
   - [9.2 WLAN verbinden](#92-wlan-verbinden)
10. [Hyprland-Setup](#10-hyprland-setup)
    - [10.1 Als normaler Benutzer anmelden](#101-als-normaler-benutzer-anmelden)
    - [10.2 System aktualisieren](#102-system-aktualisieren)
    - [10.3 AUR Helper (yay) installieren](#103-aur-helper-yay-installieren)
    - [10.4 Hyprland und wichtige Pakete installieren](#104-hyprland-und-wichtige-pakete-installieren)
    - [10.5 Hyprland konfigurieren](#105-hyprland-konfigurieren)
11. [Login-Manager (SDDM) installieren](#11-login-manager-sddm-installieren)
    - [11.1 SDDM installieren und aktivieren](#111-sddm-installieren-und-aktivieren)
    - [11.2 SDDM-Theme installieren](#112-sddm-theme-installieren-optional)
    - [11.3 System neustarten](#113-system-neustarten)
12. [Schriftarten für Waybar](#12-schriftarten-für-waybar)
    - [12.1 Icon-Fonts installieren](#121-icon-fonts-installieren)
    - [12.2 Font-Cache aktualisieren](#122-font-cache-aktualisieren)
    - [12.3 Waybar und Hyprland neustarten](#123-waybar-und-hyprland-neustarten)
13. [Nouveau-Treiber für NVIDIA-Grafikkarte](#13-nouveau-treiber-für-nvidia-grafikkarte)
    - [13.1 Mesa und Nouveau installieren](#131-mesa-und-nouveau-installieren)
    - [13.2 Kernel-Module zur Initramfs hinzufügen](#132-kernel-module-zur-initramfs-hinzufügen)
    - [13.3 Apple-spezifische Module laden](#133-apple-spezifische-module-laden)
    - [13.4 Hyprland für Nouveau konfigurieren](#134-hyprland-für-nouveau-konfigurieren)
    - [13.5 Installation überprüfen](#135-installation-überprüfen)
14. [Tastaturbeleuchtung](#14-tastaturbeleuchtung)
15. [Ruhezustand einrichten](#15-ruhezustand-einrichten)
    - [15.1 GRUB-Konfiguration anpassen](#151-grub-konfiguration-anpassen)
    - [15.2 Initramfs-Hooks anpassen](#152-initramfs-hooks-anpassen)
16. [Nützliche Tipps](#16-nützliche-tipps)
    - [16.1 VIM-Befehle](#161-vim-befehle)
    - [16.2 Allgemeine Befehle](#162-allgemeine-befehle)
    - [16.3 Workspace-Navigation](#163-workspace-navigation)
17. [Hilfreiche Links](#17-hilfreiche-links)
18. [Bekannte Probleme](#18-bekannte-probleme)
    - [18.1 Discord Performance](#181-discord-performance)

---

## 1. Erste Schritte

### 1.1 Vorbereitungen
- **Zeit einplanen:** Die komplette Installation dauert 5-7 Stunden
- **Geduld mitbringen:** Arch Linux erfordert manuelle Konfiguration
- **Backup erstellen:** Alle wichtigen Daten vorher sichern
- **USB-Stick vorbereiten:** Mit WLAN-Treibern und Image für Arch Linux

### 1.2 Tastaturlayout laden
```bash
loadkeys de
# oder falls Probleme auftreten:
loadkeys de-latin1  # (-) liegt auf (ß)
```

## 2. Festplatte einrichten

### 2.1 Festplatten anzeigen
```bash
lsblk
# oder
fdisk -l
```

### 2.2 Festplatte partitionieren
```bash
gdisk /dev/sda
o                    # GPT-Partitionstabelle erstellen
y                    # bestätigen

# EFI-Partition
n                    # neue Partition erstellen
1                    # Partitionsnummer
[Enter]              # erster Sektor (Standard)
+512M                # Größe der EFI-Partition
ef00                 # EFI System Partition

# Swap-Partition
n                    # neue Partition
2                    # Partitionsnummer
[Enter]              # erster Sektor (Standard)
+8G                  # Größe der Swap-Partition
8200                 # Linux swap

# Root-Partition
n                    # neue Partition
3                    # Partitionsnummer
[Enter]              # erster Sektor (Standard)
[Enter]              # letzter Sektor (Rest der Festplatte)
8300                 # Linux filesystem

w                    # Änderungen schreiben
y                    # bestätigen
```

### 2.3 Dateisysteme erstellen
```bash
# EFI-Partition formatieren
mkfs.fat -F32 /dev/sda1

# Swap einrichten und aktivieren
mkswap /dev/sda2
swapon /dev/sda2

# Root-Partition formatieren
mkfs.ext4 /dev/sda3
```

### 2.4 Partitionen mounten
```bash
# Root mounten
mount /dev/sda3 /mnt

# EFI-Verzeichnis erstellen und mounten
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
```

## 3. System-Installation

### 3.1 Basis-Pakete installieren
```bash
pacstrap /mnt base base-devel linux linux-firmware vim nano networkmanager grub efibootmgr
```

### 3.2 fstab erstellen
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

### 3.3 In das neue System wechseln
```bash
arch-chroot /mnt
```

## 4. System konfigurieren

### 4.1 Zeitzone setzen
```bash
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc
```

### 4.2 Locale konfigurieren
```bash
# Locale-Datei bearbeiten
vim /etc/locale.gen
# Auskommentieren: de_DE.UTF-8 UTF-8 und en_US.UTF-8 UTF-8

# Locales generieren
locale-gen

# System-Sprache festlegen
echo "LANG=de_DE.UTF-8" > /etc/locale.conf
echo "KEYMAP=de-latin1" > /etc/vconsole.conf
```

### 4.3 Hostname setzen
```bash
echo "archbook" > /etc/hostname

# /etc/hosts bearbeiten
vim /etc/hosts
# Folgende Zeilen hinzufügen:
# 127.0.0.1    localhost
# ::1          localhost
# 127.0.1.1    archbook.local archbook
```

## 5. GRUB-Bootloader installieren

### 5.1 GRUB für UEFI installieren
```bash
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --recheck
```

### 5.2 GRUB-Konfiguration erstellen
```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

### 5.3 GRUB für WLAN-Treiber konfigurieren (falls benötigt)
```bash
nano /etc/default/grub
# Folgende Zeile anpassen:
# GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet brcmfmac.feature_disable=0x82000"

# GRUB-Konfiguration neu erstellen
grub-mkconfig -o /boot/grub/grub.cfg
```

## 6. Benutzer und Passwörter

### 6.1 Root-Passwort setzen
```bash
passwd
```

### 6.2 Neuen Benutzer erstellen
```bash
useradd -m -G wheel -s /bin/bash BENUTZERNAME
passwd BENUTZERNAME
```

### 6.3 Sudo-Rechte aktivieren
```bash
EDITOR=vim visudo
# Folgende Zeile auskommentieren:
# %wheel ALL=(ALL:ALL) ALL
```

## 7. NetworkManager aktivieren

```bash
systemctl enable NetworkManager
```

## 8. System neu starten

```bash
exit            # chroot verlassen
umount -R /mnt  # Partitionen unmounten
reboot          # Neustart
```

## 9. WLAN-Treiber installieren (falls benötigt)

### 9.1 Notwendige Pakete
```bash
# Falls USB-Stick mit Paketen vorhanden:
mount /dev/sdb2 /mnt
pacman -U /mnt/*.pkg.tar.zst

# Oder spezifische Pakete:
pacman -U /mnt/linux-firmware-*.pkg.tar.zst
pacman -U /mnt/broadcom-wl-*.pkg.tar.zst
```

### 9.2 WLAN verbinden
```bash
# WLAN-Modul laden
modprobe wl

# Falls Kernel-Parameter gesetzt ist:
modprobe -r wl
modprobe brcmfmac

# NetworkManager starten
sudo systemctl start NetworkManager
sudo systemctl enable NetworkManager

# WLAN-Netzwerke anzeigen und verbinden
nmcli device wifi list
nmcli device wifi connect "SSID" --ask

# Alternative mit iwctl:
iwctl
station wlan0 scan
station wlan0 get-networks
station wlan0 connect "SSID"
exit

# Verbindung testen
ping archlinux.de
```

## 10. Hyprland-Setup

### 10.1 Als normaler Benutzer anmelden
```bash
su - chanelxoxo
```

### 10.2 System aktualisieren
```bash
sudo pacman -Syu
```

### 10.3 AUR Helper (yay) installieren
```bash
sudo pacman -S --needed base-devel git

cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

### 10.4 Hyprland und wichtige Pakete installieren
```bash
# Hyprland und Wayland-Komponenten
sudo pacman -S hyprland waybar wofi xdg-desktop-portal-hyprland polkit-kde-agent qt5-wayland qt6-wayland xwayland

# Weitere nützliche Pakete
sudo pacman -S kitty firefox thunar grim slurp wl-clipboard pipewire pipewire-pulse wireplumber
```

### 10.5 Hyprland konfigurieren
```bash
vim ~/.config/hypr/hyprland.conf

# Wichtige Einstellungen:
# kb_layout = de
# $mainMod = ALT  # statt SUPER
# exec-once = waybar
```

## 11. Login-Manager (SDDM) installieren

### 11.1 SDDM installieren und aktivieren
```bash
sudo pacman -S sddm qt5-graphicaleffects qt5-quickcontrols2 qt5-svg
sudo systemctl enable sddm
```

### 11.2 SDDM-Theme installieren (optional)
```bash
sudo git clone https://github.com/m-wynn/sddm_wynn-theme.git /usr/share/sddm/themes/sddm_wynn-theme
sudo chmod -R 755 /usr/share/sddm/themes/sddm_wynn-theme

# Konfiguration erstellen
sudo sddm --example-config > /etc/sddm.conf

# Theme aktivieren
sudo vim /etc/sddm.conf
# [Theme]
# Current=sddm_wynn-theme
```

### 11.3 System neustarten
```bash
sudo reboot
```

## 12. Schriftarten für Waybar

### 12.1 Icon-Fonts installieren
```bash
sudo pacman -S ttf-font-awesome ttf-jetbrains-mono-nerd otf-font-awesome
```

### 12.2 Font-Cache aktualisieren
```bash
fc-cache -fv
```

### 12.3 Waybar und Hyprland neustarten
```bash
pkill waybar
pkill Hyprland
```

## 13. Nouveau-Treiber für NVIDIA-Grafikkarte

### 13.1 Mesa und Nouveau installieren
```bash
sudo pacman -S mesa xf86-video-nouveau
```

### 13.2 Kernel-Module zur Initramfs hinzufügen
```bash
sudo vim /etc/mkinitcpio.conf
# MODULES=(nouveau)

# Initramfs neu erstellen
sudo mkinitcpio -P
```

### 13.3 Apple-spezifische Module laden
```bash
sudo vim /etc/modules-load.d/macbook.conf

# Inhalt der Datei:
applesmc
coretemp
```

### 13.4 Hyprland für Nouveau konfigurieren
```bash
vim ~/.config/hypr/hyprland.conf

# Folgende Umgebungsvariablen hinzufügen:
env = LIBVA_DRIVER_NAME,nouveau
env = WLR_NO_HARDWARE_CURSORS,1
env = WLR_RENDERER_ALLOW_SOFTWARE,1

misc {
    vfr = true
    vrr = 0
}
```

### 13.5 Installation überprüfen
```bash
# Nach Neustart:
lsmod | grep nouveau
lspci -k | grep -A 2 -E "(VGA|3D)"

# OpenGL-Info anzeigen
sudo pacman -S mesa-utils
glxinfo | grep "OpenGL renderer"
```

## 14. Tastaturbeleuchtung

```bash
sudo su
echo 255 > /sys/class/leds/smc::kbd_backlight/brightness
```

## 15. Ruhezustand einrichten

### 15.1 GRUB-Konfiguration anpassen
```bash
sudo vim /etc/default/grub
# GRUB_CMDLINE_LINUX_DEFAULT ergänzen um: resume=LABEL=swap

sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### 15.2 Initramfs-Hooks anpassen
```bash
sudo vim /etc/mkinitcpio.conf
# Im Abschnitt HOOKS ergänzen: resume

sudo mkinitcpio -p linux
```

## 16. Nützliche Tipps

### 16.1 VIM-Befehle
```
/text     # Text suchen
n         # Nächstes Suchergebnis
i         # Insert-Modus (schreiben)
:wq       # Speichern und beenden
```

### 16.2 Allgemeine Befehle
```bash
# System aktualisieren
sudo pacman -Syu

# Mehrere Pakete installieren
sudo pacman -S paket1 paket2 paket3

# Benutzergruppen anzeigen
groups

# Programme im Hintergrund starten
programm &

# Letzten Befehl als sudo ausführen
sudo !!

# Tab-Vervollständigung für Befehle und Pfade verwenden
befehl[TAB]
```

### 16.3 Workspace-Navigation
```
ALT + 1, ALT + 2, etc.  # Zwischen Workspaces wechseln
```

## 17. Hilfreiche Links

- Hyprland-Wiki: https://wiki.hyprland.org/Useful-Utilities/
- Arch Linux Packages: https://archlinux.org/packages/
- Readline-Shortcuts: https://readline.kablamo.org/emacs.html

## 18. Bekannte Probleme

### 18.1 Discord Performance
- **Problem**: Discord über Firefox verbraucht 100% CPU auf einem Kern und 16 GB RAM
- **Lösung**: Discord-App verwenden (Multi-Core-Unterstützung, nur 2 GB RAM-Verbrauch)
