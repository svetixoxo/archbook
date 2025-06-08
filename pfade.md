### Hyprland
```bash
## Hyprland-Config
.config/hypr/hyprland.config   # ohne HyDE
.config/hypr/userprefs.conf    # mit HyDE
.config/hypr/hyprland.conf     # HyDE-Root

.config/hypr/hypridle.conf     # Ruhezustand etc.
.config/hypr/keybindings.conf  # Keybindings
```

### HyDe
```bash
.config/hyde/themes            # Themes
.config/hyde/themes/${HYDE_THEME}/hypr.theme
```

### Kitty
```bash
.zshrc
.config/kitty/current-theme.conf
.config/kitty/kitty.conf
.config/kitty/hyde.conf
.config/hyde/themes/${HYDE_THEME}/kitty.theme
```

### Waybar
```bash
.config/hyde/themes/${HYDE_THEME}/waybar.theme
```

### Rofi
```bash
.config/hyde/themes/${HYDE_THEME}/rofi.theme
```

### fastfetch
```bash
## Skript
.local/lib/hyde/fastfetch.sh

## Text ändern
.config/fastfetch/config.jsonc

## Logo ändern
# Eigene Logos
fast.config/fastfetch/logo/

# Wallbash-Icons
.local/share/icons/Wallbash-Icon/fastfetch/

# Theme-spezifische Logos
.config/hyde/themes/${HYDE_THEME}/logo/

# Aktuelles Hintergrundbild
$HYDE_CACHE_HOME/wall.quad
```
