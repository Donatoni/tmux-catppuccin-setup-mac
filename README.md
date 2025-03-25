# tmux-catppuccin-setup-mac

A simple shell script to install and configure [Tmux](https://github.com/tmux/tmux) with the beautiful [Catppuccin](https://github.com/catppuccin/tmux) theme on macOS.

This script handles everything — installs Homebrew, Tmux, TPM (plugin manager), Nerd Font, and sets up a polished `.tmux.conf` for a perfect terminal experience.

## ✨ Features

- 💅 Catppuccin theme (Mocha flavor)
- 🖱 Mouse support enabled
- 📜 Scrollback history boost
- 🔡 JetBrains Mono Nerd Font (for icons & powerline look)
- 🔌 TPM (Tmux Plugin Manager) with useful plugins preloaded

## 🛠️ Requirements

- macOS (Apple Silicon or Intel)
- Terminal app or iTerm2 (recommended)

## 🚀 Installation

### 1. Download the script

You can clone this repo or just download the script file directly.

```bash
curl -O https://raw.githubusercontent.com/donatoni/tmux-catppuccin-setup-mac/main/setup_tmux_catppuccin.sh
```

### 2. Make it executable and run

```bash
chmod +x setup_tmux_catppuccin_v2.sh
./setup_tmux_catppuccin_v2.sh
```

### 3. After installation

- Open a new terminal window
- Launch Tmux:

```bash
tmux
```

- Then press `Ctrl + B`, followed by `I` (capital i) to install plugins via TPM.

### 4. Set your terminal font

In Terminal or iTerm2:
- Open Preferences → Profiles → Text
- Change the font to **JetBrains Mono Nerd Font**

## 📦 Plugins Installed

- [tmux-plugins/tpm](https://github.com/tmux-plugins/tpm)
- [tmux-plugins/tmux-sensible](https://github.com/tmux-plugins/tmux-sensible)
- [catppuccin/tmux](https://github.com/catppuccin/tmux)

## 🧼 Uninstall

To remove all components:

```bash
rm -rf ~/.tmux ~/.tmux.conf ~/.config/tmux ~/Library/Fonts/JetBrainsMono
```
