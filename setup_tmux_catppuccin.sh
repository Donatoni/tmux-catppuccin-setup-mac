#!/bin/bash

set -e

echo "🚀 Starting Tmux + Catppuccin setup..."

# Function to install Homebrew if not already installed
install_homebrew() {
  if ! command -v brew &>/dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "✅ Homebrew already installed."
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
}

# Install Tmux and Git
install_packages() {
  echo "📦 Installing Tmux and Git..."
  brew install tmux git
}

# Install TPM (Tmux Plugin Manager)
install_tpm() {
  echo "🔌 Installing TPM (Tmux Plugin Manager)..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

# Clone Catppuccin theme
install_catppuccin() {
  echo "🎨 Installing Catppuccin Tmux theme..."
  mkdir -p ~/.config/tmux
  git clone https://github.com/catppuccin/tmux.git ~/.config/tmux/catppuccin
}

# Set up .tmux.conf
setup_tmux_conf() {
  echo "🛠 Setting up .tmux.conf..."
  cat > ~/.tmux.conf <<EOF
# Catppuccin Theme
set -g @catppuccin_flavour 'mocha'
run-shell "~/.config/tmux/catppuccin/catppuccin.tmux"

# TPM Plugins
set -g @plugin 'catppuccin/tmux'
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# History scrollback
set -g history-limit 10000

# Mouse support
set -g mouse on

# Vi mode
setw -g mode-keys vi

# Initialize TPM
run '~/.tmux/plugins/tpm/tpm'
EOF
}

# Download and install Nerd Font (JetBrains Mono)
install_nerd_font() {
  echo "🔤 Installing JetBrains Mono Nerd Font..."
  mkdir -p ~/Library/Fonts
  curl -L -o "/tmp/JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
  unzip -o "/tmp/JetBrainsMono.zip" -d ~/Library/Fonts/JetBrainsMono
  echo "✅ Nerd Font installed. You may need to select it in your terminal settings."
}

# Final Instructions
final_message() {
  echo ""
  echo "✅ All done!"
  echo "👉 Open a new terminal and run 'tmux', then press Ctrl+B and I (capital i) to install plugins."
  echo "🎨 Make sure to change your terminal font to a Nerd Font like 'JetBrains Mono Nerd Font'."
  echo "💡 Use iTerm2 or another terminal that supports custom fonts and true color."
}

# Run all steps
install_homebrew
install_packages
install_tpm
install_catppuccin
setup_tmux_conf
install_nerd_font
final_message
