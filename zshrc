export ZSH=~/.zsh

# Source git zshrc prompt style
source ~/dotfiles/zsh/lib/zsh-git-prompt/zshrc.sh

# Load all of the config files in ~/oh-my-zsh that end in .zsh
for config_file ($ZSH/lib/*.zsh) source $config_file

# Load and run compinit
autoload -U compinit
compinit -i

# this is a fix for vi in OS X
#alias vim="stty stop '' -ixoff; vim"

# this adds an extra line break before every new prompt
precmd() { print "" }

export TERM='xterm-256color'

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
