#!/bin/bash

# Zielordner (dein Git-Repo)
REPO=~/archbook

# Dateien/Ordner kopieren (pass die Pfade an!)
mkdir -p $REPO/system/etc
mkdir -p $REPO/system/home/chanelxoxo/.config

sudo cp /etc/hostname $REPO/system/etc/
sudo cp -r /etc/systemd $REPO/system/etc/
cp -r ~/.config/hypr $REPO/system/home/chanelxoxo/.config/

# In das Repo wechseln
cd $REPO || { echo "Repo-Ordner nicht gefunden"; exit 1; }

# Git: Änderungen hinzufügen, committen und pushen
git add .
git commit -m "Automatisches Backup: $(date +"%Y-%m-%d %H:%M:%S")"
git push origin master

---

hiermit ausführbar machen:
chmod +x backup.sh

---

hiermit ausführen:
./backup.sh
