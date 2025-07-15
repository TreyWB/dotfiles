
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Do not display error on non-matching patterns
unsetopt NOMATCH

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

## hide EOL sign ('%')
PROMPT_EOL_MARK=""

# ALIASES
alias win="cd /mnt/c/Users/treyb"
alias nvim="/opt/nvim-linux64/bin/nvim"
alias vim="/opt/nvim-linux64/bin/nvim"
alias vi="/usr/bin/vim"
alias gimp="/opt/GIMP-3.0.4-x86_64.AppImage"

# PATHS

## Oh-My-Posh
export PATH=$PATH:~/.local/bin

## Go
export PATH=$PATH:/usr/local/go/bin

## fnm
FNM_PATH="~/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="~/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

## Add bin 
export PATH=~/bin:$PATH


# TMUX AUTO-SAVE AND RESTORE
## Alias to save state of tmux session-server
alias 'tmux-save'="tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/save.sh"

# Start tmux server and restore sessions if not running
if ! tmux has-session 2>/dev/null; then
    touch /tmp/tmux_startup_restore

    tmux new-session -d
    sleep 1

    tmux has-session -t 0 2>/dev/null && tmux kill-session -t 0

    rm /tmp/tmux_startup_restore
fi

# Custom function to add pipenv indicator
add_pipenv_indicator() {
    if [[ -n "$PIPENV_ACTIVE" ]]; then
        # This will be called after each command to modify the prompt
        PROMPT="${PROMPT% } - & "
    fi
}

# Hook the function to run before each prompt
autoload -U add-zsh-hook
add-zsh-hook precmd add_pipenv_indicator

# Enable Oh-My-Posh Prompt
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/main.toml)"
