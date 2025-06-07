# ArchBook
```bash
sudo hostnamectl set-hostname ArchBook && echo "🍎 → 🐧 MacBook transformed into ArchBook!"`
```

Dieses Repository enthält meine persönlichen Schritte zur Installation und Konfiguration von Arch Linux mit Hyprland auf meinem MacBook. Die Dokumentation dient zur Nachvollziehbarkeit meiner Installationsschritte und ist spezifisch auf meine Hardware-Konfiguration zugeschnitten. `#ItWorksOnMyMachine`

## Systemübersicht
### Software
- **System:** `base`, `linux`, `grub`, `networkmanager`
- **Desktop:** `hyprland`, `waybar`, `wofi`, `sddm`, `kitty`  
- **Treiber:** `mesa`, `xf86-video-nouveau`, `broadcom-wl`, `brightnessctl`
- **Audio:** `pipewire`, `pipewire-pulse`

### Hardware
**MacBookPro10,1** (Retina, 15″, Anfang 2013)
- **CPU:** Intel Core i7-3740QM @ 2.70 GHz (4C/8T)
- **RAM:** 16 GB 1600 MHz DDR3L
- **iGPU:** Intel HD Graphics 4000
- **GPU:** NVIDIA GeForce GT 650M 1 GB GDDR5 (GK107M)
- **SSD:** 1 TB OWC Aura Pro S MB258
- **Ethernet:** Broadcom NetXtreme BCM57786 Gigabit
- **WLAN:** Broadcom BCM43602 802.11ac


## Guide
**Kompletter Guide:** [archbook-guide.md](archbook-guide.md)

1. [Erste Schritte](archbook-guide.md#1-erste-schritte)
2. [Festplatte einrichten](archbook-guide.md#2-festplatte-einrichten)
3. [System-Installation](archbook-guide.md#3-system-installation)
4. [System konfigurieren](archbook-guide.md#4-system-konfigurieren)
5. [GRUB-Bootloader installieren](archbook-guide.md#5-grub-bootloader-installieren)
6. [Benutzer und Passwörter](archbook-guide.md#6-benutzer-und-passwörter)
7. [NetworkManager aktivieren](archbook-guide.md#7-networkmanager-aktivieren)
8. [System neu starten](archbook-guide.md#8-system-neu-starten)
9. [WLAN-Treiber installieren](archbook-guide.md#9-wlan-treiber-installieren-falls-benötigt)
10. [Hyprland-Setup](archbook-guide.md#10-hyprland-setup)
11. [Login-Manager (SDDM) installieren](archbook-guide.md#11-login-manager-sddm-installieren)
12. [Schriftarten für Waybar](archbook-guide.md#12-schriftarten-für-waybar)
13. [Nouveau-Treiber für NVIDIA-Grafikkarte](archbook-guide.md#13-nouveau-treiber-für-nvidia-grafikkarte)
14. [Tastaturbeleuchtung](archbook-guide.md#14-tastaturbeleuchtung)
15. [Ruhezustand einrichten](archbook-guide.md#15-ruhezustand-einrichten)
16. [Nützliche Tipps](archbook-guide.md#16-nützliche-tipps)
17. [Hilfreiche Links](archbook-guide.md#17-hilfreiche-links)
18. [Bekannte Probleme](archbook-guide.md#18-bekannte-probleme)

## Kontakt
Dieses Repository ist in erster Linie für mich selbst gedacht und dient als persönliche Dokumentation. Ich bin ein kompletter Noob auf diesem Gebiet! Falls du Teile daraus verwenden möchtest und dabei auf Probleme stößt, wende dich bitte an den ITler deines Vertrauens.
