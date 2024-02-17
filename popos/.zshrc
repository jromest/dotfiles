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
setopt inc_append_history # write to the history file immediately, not when the shell exits
setopt hist_ignore_space # don't record an event starting with a space
setopt hist_expire_dups_first  # expire a duplicate event first when trimming history
setopt hist_ignore_dups # don't record an event that was just recorded again
setopt hist_save_no_dups # do not write a duplicate event to the history file
setopt hist_ignore_all_dups # delete an old recorded event if a new event is a duplicate

# auto/tab complete
zmodload zsh/complist # should be called before compinit
zstyle ':completion:*' menu select # allow to select in the menu
autoload -U compinit; compinit
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

# FZF
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# BAT
alias bat=batcat

# NNN
# onedark theme
BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
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

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
