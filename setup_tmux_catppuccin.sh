#!/bin/bash

set -e

echo "🚀 Starting Tmux + Catppuccin enhanced setup..."

# -------------------------------------
# 1. Install Homebrew if not installed
# -------------------------------------
install_homebrew() {
  if ! command -v brew &>/dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "✅ Homebrew already installed."
    # Ensure brew is in our PATH
    eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || true
    eval "$(/usr/local/bin/brew shellenv)" 2>/dev/null || true
  fi
}

# ----------------------------
# 2. Install Tmux, Git, Fonts
# ----------------------------
install_packages() {
  echo "📦 Installing Tmux, Git, and Nerd Font..."
  brew install tmux git
  brew tap homebrew/cask-fonts
  brew install --cask font-jetbrains-mono-nerd-font
}

# -------------------------------------------
# 3. Install TPM (Tmux Plugin Manager) if needed
# -------------------------------------------
install_tpm() {
  if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "🔌 Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  else
    echo "✅ TPM already installed."
  fi
}

# ------------------------------
# 4. Clone Catppuccin Tmux theme
# ------------------------------
install_catppuccin() {
  echo "🎨 Installing Catppuccin Tmux theme..."
  mkdir -p ~/.config/tmux
  if [ ! -d ~/.config/tmux/catppuccin ]; then
    git clone https://github.com/catppuccin/tmux.git ~/.config/tmux/catppuccin
  else
    echo "✅ Catppuccin already cloned."
  fi
}

# -----------------------
# 5. Setup ~/.tmux.conf
# -----------------------
setup_tmux_conf() {
  echo "🛠 Setting up an enhanced ~/.tmux.conf..."

cat > ~/.tmux.conf <<'EOF'
# ~/.tmux.conf

# Options to make tmux more pleasant
set -g mouse on
set -g default-terminal "tmux-256color"

# Configure the Catppuccin plugin
set -g @catppuccin_flavor "mocha"
set -g @catppuccin_window_status_style "rounded"

# Load Catppuccin theme
run ~/.config/tmux/catppuccin/tmux/catppuccin.tmux
# If you're using TPM to manage the theme, use:
# run ~/.tmux/plugins/tmux/catppuccin.tmux

# Setup enhanced status line with modules
# Define the maximum length for status left/right
set -g status-left-length 100
set -g status-right-length 100

# Clear any existing left status (optional)
set -g status-left ""

# Configure the right status line:
# Here we combine several modules provided by the Catppuccin theme.
set -g status-right "#{E:@catppuccin_status_application}"
set -agF status-right "#{E:@catppuccin_status_cpu}"
set -ag status-right "#{E:@catppuccin_status_session}"
set -ag status-right "#{E:@catppuccin_status_uptime}"
set -agF status-right "#{E:@catppuccin_status_battery}"

# If you prefer installing CPU & Battery plugins via TPM, add them below.
# Otherwise, you can clone them manually and run them:
run ~/.config/tmux/plugins/tmux-plugins/tmux-cpu/cpu.tmux 2>/dev/null
run ~/.config/tmux/plugins/tmux-plugins/tmux-battery/battery.tmux 2>/dev/null

# TPM Plugin definitions
set -g @plugin 'catppuccin/tmux'
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-cpu'
set -g @plugin 'tmux-plugins/tmux-battery'

# Increase scrollback history
set -g history-limit 10000

# Enable vi mode for copy mode
setw -g mode-keys vi

# Initialize TPM (Tmux Plugin Manager)
run '~/.tmux/plugins/tpm/tpm'
EOF
}

# -----------------------------------------
# 6. Manually clone CPU/Battery plugins
#    (Optional if using TPM to do the same)
# -----------------------------------------
install_cpu_battery_plugins() {
  echo "🔋 Installing CPU & Battery plugins (manual clone)..."
  mkdir -p ~/.config/tmux/plugins/tmux-plugins
  cd ~/.config/tmux/plugins/tmux-plugins

  # tmux-cpu
  if [ ! -d tmux-cpu ]; then
    git clone https://github.com/tmux-plugins/tmux-cpu
  else
    echo "✅ tmux-cpu already cloned."
  fi

  # tmux-battery
  if [ ! -d tmux-battery ]; then
    git clone https://github.com/tmux-plugins/tmux-battery
  else
    echo "✅ tmux-battery already cloned."
  fi

  cd ~
}

# ------------------
# 7. Final Messages
# ------------------
final_message() {
  echo ""
  echo "✅ All done!"
  echo "👉 Open a new terminal or tab and run 'tmux'."
  echo "   Then press Ctrl+B, followed by Shift+I (capital i) to install plugins via TPM."
  echo ""
  echo "📝 IMPORTANT: Manually set your terminal's font to 'JetBrains Mono Nerd Font'."
  echo "   In iTerm2 or Terminal: Preferences > Profiles > Text > Font"
  echo ""
  echo "💡 If you're on a desktop Mac, you won't see battery info. CPU usage should show."
  echo "🎉 Enjoy your Catppuccin-themed Tmux!"
}

# ----------------
# Run all steps
# ----------------
install_homebrew
install_packages
install_tpm
install_catppuccin
setup_tmux_conf
install_cpu_battery_plugins
final_message