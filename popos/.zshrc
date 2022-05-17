# ZPLUG
# check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "softmoth/zsh-vim-mode"
zplug "plugins/git", from:oh-my-zsh

zplug "zdharma-continuum/fast-syntax-highlighting", defer:2

zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

# install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# then, source plugins and add commands to $PATH
zplug load

# GENERAL
# history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

#  auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files

# KEYBINDINGS
# use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# ALIASES
# list directory contents
alias ls='ls --color'
alias ll='ls -lh --color'
alias lsa='ls -lAh --color'

# cd'ing backward directories
alias -g ..='cd ..'
alias -g ...='cd ../..'
alias -g ....='cd ../../..'
alias -g .....='cd ../../../..'
alias -g ......='cd ../../../../..'

# remap keys
# remap Caps Lock to Esc and Esc to Grave Tilde
alias remap="xmodmap -e 'clear Lock' \
  -e 'keycode 9 = grave asciitilde grave asciitilde' \
  -e 'keycode 66 = Escape NoSymbol Escape'"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm

# NNN
# cd on quit
# https://github.com/jarun/nnn/wiki/Basic-use-cases#configure-cd-on-quit
n ()
{
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# trash-cli
export PATH=~/.local/bin:"$PATH"

