#!/bin/sh

cd ~
  
# check if brew is installed
if ! command -v brew &> /dev/null
then
  echo "brew could not be found"
  echo "installing brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update
brew upgrade

echo "Installing formulae..."
brew install autoconf
brew install autojump
brew install awk
brew install coreutils
brew install colordiff
brew install direnv
brew install dive
brew install docker-compose
brew install fzf
# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
brew install gettext
brew install git
brew install git-extras
brew install git-flow
brew install gnu-sed
brew install go
brew install gradle
brew install grep
brew install groonga
brew install gzip
brew install helm
brew install htop
brew install icu4c
brew install jq
brew install k9s
brew install kubectl
brew install kubernetes-cli
brew install libidn2
brew install libnghttp2
brew install libpq
brew link --force libpq
brew install libunistring
brew install libuv
brew install lz4
brew install m4
brew install make
brew install mariadb
brew install mecab
brew install mecab-ipadic
brew install mongosh
brew install mpdecimal
brew install msgpack
brew install mysql-client
brew install ncurses
brew install node
brew install npm
brew install nvm
brew install oniguruma
brew install openjdk
brew install openssl
brew install openssl@3
brew install opentofu
# brew install orbstack
brew install pcre
brew install pcre2
brew install pkg-config
brew install pycparser
brew install pyenv
brew install pylint
brew install python
brew install python-setuptools
brew install readline
brew install redis
brew install six
brew install sqlite
brew install telnet
brew install tmux
brew install unzip
brew install watch
brew install webp
brew install wget
brew install xz
brew install yq
brew install zlib
brew install zplug
brew install zsh-autosuggestions
brew install zsh-git-prompt
brew install zsh-syntax-highlighting
brew install zstd
echo "Installed formulae."

# Install casks
echo "Installing casks..."
brew install --cack docker
brew install --cask orbstack
brew install --cask dbeaver-community
brew install --cask visual-studio-code
brew install --cask spotify
brew install --cask canva
brew install --cask caffeine
brew install --cask cmake
brew install --cask utm
brew install --cask obsidian
brew install --cask slack
brew install --cask headlamp
echo "Installed casks."

# --- TODO fix this orbstack conf ---

sudo ln -s "/Users/$(whoami)/.orbstack/run/docker.sock" "/Users/$(whoami)/.docker/run/docker.sock"

# Create a parallel multi-platform builder
docker buildx create --name custom_builder --use
# Make "buildx" the default
docker buildx install
# Build for multiple platforms
docker build --platform linux/amd64,linux/arm64 .

# Switch to OrbStack
docker context use orbstack
# Switch to Docker Desktop (uncomment)
# docker context use desktop-linux

# --- TODO fix this orbstack conf ---

brew cleanup
echo "Cleanup completed."

cd ~

# if there is no zshrc file
if [ ! -f ~/.zshrc ]
then
  echo "zshrc config not found, installing oh-my-zsh and powerlevel10k theme"
  # Create .zshrc file

  # Install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # Oh-my-zsh theme
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  echo "Ohmyzsh and powerlevel10k are correctly installing, setting up..."
  wget https://raw.githubusercontent.com/mbianchidev/easy-macbook-setup/main/.zshrc
  exec zsh
  echo "ZSH freshly installed - Setup complete, please restart your terminal."
fi

if [ -f ~/.zshrc ]
then
  # Substituting predefined zshrc with my own
  cd ~
  rm -f .zshrc
  wget https://raw.githubusercontent.com/mbianchidev/easy-macbook-setup/main/.zshrc
  exec zsh
  echo "ZSH reconfigured - Setup complete, please restart your terminal."
fi
