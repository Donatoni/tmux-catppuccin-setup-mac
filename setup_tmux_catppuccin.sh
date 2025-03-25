#!/bin/bash
# setup_tmux_catppuccin.sh
# -----------------------------------------------
# This script installs and configures Tmux with the
# Catppuccin theme (Mocha flavor) and enhanced status
# line modules (CPU & battery) on macOS.
#
# It installs Homebrew (if missing), Tmux, Git, and
# JetBrains Mono Nerd Font, clones TPM and Catppuccin,
# and writes a new ~/.tmux.conf file.
#
# After running this script, you'll need to:
# 1. Open a new terminal or kill existing tmux sessions.
# 2. Run 'tmux' to start a session.
# 3. Press Ctrl+B then Shift+I to install TPM plugins.
# 4. Manually set your terminal's font to 'JetBrains Mono Nerd Font'.
# -----------------------------------------------

set -e

# Helper: Check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# 1. Install Homebrew if it's not already installed
install_homebrew() {
  if ! command_exists brew; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "✅ Homebrew is already installed."
    # Ensure brew is in our PATH for the current session
    eval "$(/opt/homebrew/bin/brew shellenv)" || true
  fi
}

# 2. Install Tmux, Git, and the JetBrains Mono Nerd Font
install_packages() {
  echo "📦 Installing Tmux and Git..."
  brew install tmux git

  echo "🔤 Installing JetBrains Mono Nerd Font..."
  brew tap homebrew/cask-fonts
  brew install --cask font-jetbrains-mono-nerd-font
}

# 3. Install TPM (Tmux Plugin Manager) if not already present
install_tpm() {
  if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "🔌 Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  else
    echo "✅ TPM is already installed."
  fi
}

# 4. Clone the Catppuccin Tmux theme if not already cloned
install_catppuccin() {
  echo "🎨 Installing Catppuccin Tmux theme..."
  mkdir -p "$HOME/.config/tmux"
  if [ ! -d "$HOME/.config/tmux/catppuccin" ]; then
    git clone https://github.com/catppuccin/tmux.git "$HOME/.config/tmux/catppuccin"
  else
    echo "✅ Catppuccin theme is already cloned."
  fi
}

# 5. Create or update the enhanced ~/.tmux.conf file
setup_tmux_conf() {
  echo "🛠 Setting up enhanced ~/.tmux.conf..."
  cat > "$HOME/.tmux.conf" <<'EOF'
# ~/.tmux.conf

# Enable mouse support and set the default terminal type
set -g mouse on
set -g default-terminal "tmux-256color"

# Configure Catppuccin theme options
set -g @catppuccin_flavor "mocha"
set -g @catppuccin_window_status_style "rounded"

# Load the Catppuccin theme
run ~/.config/tmux/catppuccin/tmux/catppuccin.tmux
# If using TPM for the theme, use:
# run ~/.tmux/plugins/tmux/catppuccin.tmux

# Enhanced status line configuration:
set -g status-left-length 100
set -g status-right-length 100
set -g status-left ""

# Combine modules for a rich status bar:
set -g status-right "#{E:@catppuccin_status_application}"
set -agF status-right "#{E:@catppuccin_status_cpu}"
set -ag status-right "#{E:@catppuccin_status_session}"
set -ag status-right "#{E:@catppuccin_status_uptime}"
set -agF status-right "#{E:@catppuccin_status_battery}"

# Load CPU and battery modules manually.
# (If you prefer TPM management, ensure they are in your plugin list.)
run ~/.config/tmux/plugins/tmux-plugins/tmux-cpu/cpu.tmux
run ~/.config/tmux/plugins/tmux-plugins/tmux-battery/battery.tmux

# TPM Plugin definitions:
set -g @plugin 'catppuccin/tmux'
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-cpu'
set -g @plugin 'tmux-plugins/tmux-battery'

# Increase scrollback history and enable vi mode for copy mode
set -g history-limit 10000
setw -g mode-keys vi

# Initialize TPM
run '~/.tmux/plugins/tpm/tpm'
EOF
}

# 6. Print final instructions for the user
final_instructions() {
  echo ""
  echo "✅ Setup complete!"
  echo "Next steps:"
  echo "1. Open a new terminal window or run 'tmux kill-server' to reset any active sessions."
  echo "2. Start tmux by running: tmux"
  echo "3. Inside tmux, press Ctrl+B then Shift+I (capital I) to install all TPM plugins."
  echo "4. IMPORTANT: Set your terminal's font to 'JetBrains Mono Nerd Font' in Preferences."
  echo "   (Terminal: Preferences → Profiles → Text, or in iTerm2: Preferences → Profiles → Text → Font)"
  echo "Enjoy your Catppuccin-themed Tmux with CPU & battery indicators!"
}

# Main execution sequence
main() {
  install_homebrew
  install_packages
  install_tpm
  install_catppuccin
  setup_tmux_conf
  final_instructions
}

# Run the main function
main