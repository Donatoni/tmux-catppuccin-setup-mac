# tmux-catppuccin-setup-mac

A simple shell script to install and configure [Tmux](https://github.com/tmux/tmux) with the beautiful [Catppuccin](https://github.com/catppuccin/tmux) theme on macOS.

This script handles everything — it installs Homebrew (if missing), Tmux, TPM (Tmux Plugin Manager), Git, and the JetBrains Mono Nerd Font. It then sets up an enhanced `.tmux.conf` that includes a rich status line with CPU and battery indicators.

> **Note:** After running the script, you'll need to manually set your terminal's font to **JetBrains Mono Nerd Font** (in Terminal or iTerm2 Preferences).

## Features

- Catppuccin theme (Mocha flavor)
- Mouse support enabled
- Scrollback history boost
- JetBrains Mono Nerd Font (for icons and powerline look)
- TPM (Tmux Plugin Manager) with the following plugins preloaded:
  - tmux-sensible
  - tmux-cpu
  - tmux-battery
  - catppuccin/tmux
- Enhanced status line with CPU usage and battery indicators

## Requirements

- macOS (Apple Silicon or Intel)
- Terminal app or iTerm2 (recommended)

## Installation

### 1. Download the script

You can clone this repository or download the script file directly:

```bash
curl -O https://raw.githubusercontent.com/donatoni/tmux-catppuccin-setup-mac/main/setup_tmux_catppuccin.sh
```

### 2. Make it executable and run it

```bash
chmod +x setup_tmux_catppuccin.sh
./setup_tmux_catppuccin.sh
```

### 3. After installation

1. Open a new terminal window (or kill any active Tmux sessions with `tmux kill-server`).
2. Launch Tmux by typing:

   ```bash
   tmux
   ```

3. Press `Ctrl + B`, then Shift+I (capital I) to install all TPM plugins.

### 4. Set Your Terminal Font

Manually set your terminal's font to **JetBrains Mono Nerd Font**:

- For Terminal: Preferences → Profiles → Text → Change Font
- For iTerm2: Preferences → Profiles → Text → Font → Change Font

## Plugins Installed

- [catppuccin/tmux](https://github.com/catppuccin/tmux)
- [tmux-plugins/tpm](https://github.com/tmux-plugins/tpm)
- [tmux-plugins/tmux-sensible](https://github.com/tmux-plugins/tmux-sensible)
- [tmux-plugins/tmux-cpu](https://github.com/tmux-plugins/tmux-cpu)
- [tmux-plugins/tmux-battery](https://github.com/tmux-plugins/tmux-battery)

## Uninstall

To remove all installed components:

```bash
rm -rf ~/.tmux ~/.tmux.conf ~/.config/tmux ~/Library/Fonts/JetBrainsMono
```

## Additional Notes

- **CPU & Battery Indicators:**
  - On MacBooks, you'll see battery information in the Tmux status line.
  - On desktop Macs without batteries, the battery indicator may be hidden or not display any data.

- **TPM Plugin Installation:**
  After starting Tmux, press `Ctrl + B` then Shift+I (capital I) to ensure TPM installs all configured plugins.