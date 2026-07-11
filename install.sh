#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d-%H%M%S)"

log() { printf '\033[1;34m==>\033[0m %s\n' "$1"; }

# ---- linking -----------------------------------------------------------------

link() {
  # link <source in repo> <destination under $HOME>
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    return 0 # already correct
  fi

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mkdir -p "$BACKUP_DIR"
    log "Backing up existing $dst -> $BACKUP_DIR/"
    mv "$dst" "$BACKUP_DIR/$(basename "$dst")"
  fi

  ln -s "$src" "$dst"
  log "Linked $dst -> $src"
}

link_dotfiles() {
  link "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
  link "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
  link "$DOTFILES_DIR/git/gitignore_global" "$HOME/.gitignore_global"
  link "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
  link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
}

# ---- package installation ----------------------------------------------------

install_lazygit_linux() {
  command -v lazygit >/dev/null 2>&1 && return 0
  log "Installing lazygit..."
  local tag ver
  # Avoid api.github.com here — it's unauthenticated-rate-limited (60/hr). The
  # releases/latest redirect on github.com itself isn't subject to that limit.
  tag=$(curl -fsS -o /dev/null -w '%{redirect_url}' "https://github.com/jesseduffield/lazygit/releases/latest")
  ver="${tag##*/v}"
  curl -fsSLo /tmp/lazygit.tar.gz \
    "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${ver}_Linux_x86_64.tar.gz"
  tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
  sudo install /tmp/lazygit /usr/local/bin
}

install_packages() {
  case "$OSTYPE" in
  darwin*)
    if ! command -v brew >/dev/null 2>&1; then
      log "Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || eval "$(/usr/local/bin/brew shellenv)" 2>/dev/null || true
    fi
    log "Installing packages (incl. Ghostty) via Homebrew..."
    brew bundle --file="$DOTFILES_DIR/Brewfile"
    ;;
  linux-gnu*)
    if command -v apt-get >/dev/null 2>&1; then
      log "Installing core CLI packages via apt..."
      sudo apt-get update
      sudo apt-get install -y git zsh curl neovim ripgrep fd-find fzf build-essential unzip
      install_lazygit_linux
      log "Not auto-installing Ghostty on Linux — packaging varies by distro."
      log "See: https://ghostty.org/docs/install/binary"
    else
      log "No apt-get found — install git, zsh, neovim, ripgrep, fd, fzf, lazygit manually for your distro, then re-run."
    fi
    ;;
  *)
    log "Unrecognized OS ($OSTYPE) — skipping package installation, will still link dotfiles."
    ;;
  esac
}

install_oh_my_zsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log "Installing Oh My Zsh..."
    RUNZSH=no KEEP_ZSHRC=yes /bin/bash -c \
      "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
  local custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  [ -d "$custom/plugins/zsh-autosuggestions" ] || {
    log "Installing zsh-autosuggestions plugin..."
    git clone --depth=1 -q https://github.com/zsh-users/zsh-autosuggestions "$custom/plugins/zsh-autosuggestions"
  }
  [ -d "$custom/plugins/zsh-syntax-highlighting" ] || {
    log "Installing zsh-syntax-highlighting plugin..."
    git clone --depth=1 -q https://github.com/zsh-users/zsh-syntax-highlighting "$custom/plugins/zsh-syntax-highlighting"
  }
}

# ---- run (temporary, block-by-block) ------------------------------------------

log "dotfiles repo: $DOTFILES_DIR"
install_packages
install_oh_my_zsh
link_dotfiles

rustup component add rust-analyzer

log "Done. Restart your terminal (or: source ~/.zshrc)."
