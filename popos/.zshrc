### ZINIT
# Load ZINIT, clone if necessary
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load prompt
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh' atinit''
zinit light sindresorhus/pure
zstyle :prompt:pure:git:stash show yes # show git stash status

# Oh My Zsh git library
zinit ice wait lucid
zi snippet OMZL::git.zsh

# Oh My Zsh git plugit (required by git library)
zinit ice wait lucid
zinit snippet OMZP::git
zi cdclear -q  # forget completion from git plugin

# You Should Use (remind existing aliases)
zinit ice wait lucid
zinit light MichaelAquilina/zsh-you-should-use
export YSU_MESSAGE_POSITION="after"

# Vim Mode
zinit light softmoth/zsh-vim-mode

# Compinit, syntax highlighting, completions, autosuggestions
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# End ZINIT

### GENERAL
# set neovim as default terminal editor
export EDITOR="nvim"
export VISUAL="nvim"

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
# autoload -U compinit; compinit # manage by zinit (zicompinit)
_comp_options+=(globdots) # Include hidden files

# Changing/making/removing directory
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

### KEYBINDINGS
# use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

### ALIASES
# list directory contents
alias ls='ls --color'
alias ll='ls -lh --color'
alias lsa='ls -lAh --color'

# cd'ing directories
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -- -='cd -'

alias -g tmk='tmux kill-server'

### FZF
# [-s "/usr/share/doc/fzf/"] && source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

### BAT
alias bat=batcat

# use bat for man pages
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"

### NNN
# theme
BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

# use gio trash
export NNN_TRASH=2

# cd on quit
# https://github.com/jarun/nnn/wiki/Basic-use-cases#configure-cd-on-quit
n ()
{
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # `-e` to open text files in the terminal
    nnn -e "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

### NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
