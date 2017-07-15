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

export TERM='screen-256color'

if test "$TERM" != linux; then
 # show current command, directory, and user in terminal title
 precmd() { print -Pn "\e]2;$0 (%~) %n@%m\a" 2>/dev/null }
 preexec() { print -Pn "\e]2;$1 (%~) %n@%m\a" 2>/dev/null }
fi

# generate random passwd (32 chars)
genpasswd() {
    openssl rand -base64 32
}

genpassphrase() {
    echo $(grep "^[^']\{3,5\}$" /usr/share/dict/words|shuf -n5)
}

dpkgclean() {
    dpkg --list |grep "^rc" | cut -d " " -f 3 | xargs sudo dpkg --purge
}

# avoid most common annoying correction:
alias sudo='nocorrect sudo'

export PATH="$PATH:$HOME/local/bin/" # add tmux dir
alias tmux="TERM=xterm-256color $HOME/local/bin/tmux"
