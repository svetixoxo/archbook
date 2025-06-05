# Bildschirmhelligkeit konfigurieren

## Erforderliche Software installieren
brightnessctl wird benötigt: `sudo pacman -S brightnessctl`

## Systemd-Service anlegen
Datei erstellen: `sudo vim /etc/systemd/system/unlock-gmux.service`

Inhalt der Datei:
```
[Unit]
Description=gmux_backlight control aktivieren
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/usr/bin/setpci -v -H1 -s 00:00.00 BRIDGE_CONTROL=0
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

Service aktivieren und starten: `sudo systemctl enable --now unlock-gmux.service`

## FN-Tasten konfigurieren
Datei bearbeiten: `sudo vim .config/hypr/hyprland.conf`

Tastenkürzel hinzufügen und Wert setzen:
```
bind = ,XF86MonBrightnessDown, exec, brightnessctl set 10%-
bind = ,XF86MonBrightnessUp, exec, brightnessctl set +10%
```
