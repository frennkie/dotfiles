# autoload -U add-zsh-hook
autoload -Uz vcs_info

# # enable VCS systems you use
#zstyle ':vcs_info:*' enable git svn
#zstyle ':vcs_info:*:prompt:*' check-for-changes true

setopt prompt_subst
autoload -U promptinit
promptinit

precmd () { vcs_info }
PROMPT='[%D{%Y-%m-%d %K:%M:%S} - %{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}$(hostname -f)%{$reset_color%} in %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%} $(git_super_status)]
$: '

TRAPALRM() {
    zle reset-prompt
}


function title() {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")

  case $TERM in
  screen)
    print -Pn "\e]2;$a @ $2\a" # plain xterm title
    print -Pn "\ek$a\e\\"      # screen title (in ^A")
    print -Pn "\e_$2   \e\\"   # screen location
    ;;
  xterm*|rxvt)
    print -Pn "\e]2;$a @ $2\a" # plain xterm title
    ;;
  esac
}

# precmd is called just before the prompt is printed
function precmd() {
  title "zsh" "%n@%M: %55<...<%~"
}

# preexec is called just before any command line is executed
function preexec() {
  title "$1" "%n@%M: %35<...<%~"
}
