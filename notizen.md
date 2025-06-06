# Erste Schritte
- `loadkeys de` bzw. `loadkeys de-latin1` (`-` liegt auf `ß`)

## Festplatte einrichten
- Festplatten anzeigen: `lsblk` oder `fdisk -l`
- Festplatten formatieren und partitionieren:
```
gdisk /dev/sda # partitionieren
o # GPT-Partitionstabelle erstellen
y # bestätigen

# EFI-Partition
n # neue Partition erstellen
1 # Partitionsnummer
[Enter] # erster Sektor
+512M # letzter Sektor (Größe)
ef00 # EFI System Partition

# Swap-Partition
n
2
[Enter]
+8G
8200 # Linux swap

# Root-Partition
n
3
[Enter]
[Enter] # Rest der Festplatte
8300 # Linux filesystem

w # Änderungen schreiben
y # bestätigen
```

## Dateisystem erstellen
- EFI-Partition formatieren: `mkfs.fat F32 /dev/sda1`
- Swap einrichten und aktivieren:
```
mkswap /dev/sda2
swapon /dev/sda2
```
- Root-Partition formatieren: `mkfs.ext4 /dev/sda3`


## Installieren und Einrichten
### Arch Linux installieren
1. Merlin nochmal nach den ersten Schritten fragen (Vorkonfiguration)
2. `GRUB/UEFI` statt `EFI`
3. `SYSTEMD` auswählen
4. `VIM` als Editor

### WLAN-Treiber
- notwendige Pakete: `broadcom-wl`, `linux-headers`, `linux-firmware`, `pahole`, `grub`
- `lsblk` zeigt Laufwerke an
- USB-Stick mounten mit `mount /dev/sd… /mnt`
- Pakete installieren: `pacman -U /mnt/*.pkg.tar.zst` oder bspw. `pacman -U /mnt/linux-firmware-*.pkg.tar.zst` (`*` ist Platzhalter)

#### WLAN verbinden
- `modprobe wl`; falls Kernel-Parameter `brcmfmac.feature_disable=0x82000` gesetzt ist:
```
modprobe -r wl
modprobe brcmfmac
```
- `nmcli device wifi list`
- `nmcli device wifi connect "SSID" --ask` bzw. `nmcli device wifi connect "SSID" bssid B:S:S:I:D --ask`

```
iwctl
station wlan0 scan
station wlan0 get-networks
station wlan0 connect "SSID"
exit
ping archlinux.de
```


### GRUB einrichten
- `pacman -S grub efibootmgr`
- `grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB`
- `nano /etc/default/grub`
- `GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet brcmfmac.feature_disable=0x82000"`
- `grub-mkconfig -o /boot/grub/grub.cfg`
- `reboot`

## Hyprland 
### Hyprland vorbereiten und installieren
- `git` & `base-devel` für `AUR`: `sudo pacman -S --needed base-devel git`
- `yay` für `AUR`:
```
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```
- `yay -S hyprland xdg-desktop-portal-hyprland kitty waybar wofi xwayland`

### Hyprland konfigurieren
- `vim .config/hypr/hyprland.conf`
- `kb_layout = de`
- `$mainMod = SUPER` ändern zu `ALT`
- bei `exec-once` nur `waybar`

## Nützliches
### VIM
- mit `/` und `N` kann man bei `VIM` suchen
- `i` für Insert-Modus (schreiben)
- Schließen und Speichern mit `:wq` (write, quit)

### Sonstiges
- beim `root` deutsches Tastaturlayout: `loadkeys de-latin1` (`-` ist auf `ß`)
- Sytem aktualisieren: `pacman -Syu`
- Pakete installieren mit `sudo pacman -S`
- mehrere Pakete lassen sich bspw. so auf einmal installieren: `sudo pacman -S kitty asciiquarium sl wofi waybar nwg-displays`
- Benutzer in `wheels`-Gruppe, testen mit `groups` (`root` mit `su` aufrufen)
- Progamme automatisch im Hintergrund starten, bspw.: `kitty &`
- mit `OPT 1`, `OPT 2` usw. kann man zwischen verschiedenen Workspaces wechseln
- beim Installieren etc. muss nicht `J/n` getippt werden, sondern mit `Enter` wird großgeschriebene Option automatisch ausgewählt
- mit `TAB` kann man Befehle, Pfade usw. vervollständigen
- mit `sudo !!` kann man den vorigen Befehl als `sudo` ausführen, ohne den Befehl nochmal neu zu tippen
- sudo-Benutzer anlegen:
```
useradd -m -G wheel -s /bin/bash benutzername
passwd benutzername
EDITOR=nano visudo oder EDITOR=vim visudo
suchen und "#" entfernen: # %wheel ALL=(ALL:ALL) ALL
```

### Links
- weitere Kurzbefehle: https://readline.kablamo.org/emacs.html
- Hyprland-Wiki: https://wiki.hyprland.org/Useful-Utilities/
- Packages: https://archlinux.org/packages/?sort=&q=&maintainer=&flagged=
