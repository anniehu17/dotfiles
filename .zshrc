# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Basic path
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Oh My Zsh plugins
plugins=(git)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Load z script
source ~/z.sh

# Run neofetch on startup
neofetch
