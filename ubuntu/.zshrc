# ==============================
# OHMYZSH DEFAULT CONFIGURATIONS
# ==============================


export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh


# User configuration

# Do not display error on non-matching patterns
unsetopt NOMATCH


# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi


# ===============================
# PERSONAL DEFAULT CONFIGURATIONS
# ===============================

# MISC

## hide EOL sign ('%')
PROMPT_EOL_MARK=""

# ALIASES
alias win="cd /mnt/c/Users/treyb"
alias python="python3"
alias obs="cd /mnt/c/Users/treyb/Documents/Obsidian-Vault"
alias vim="/usr/bin/nvim"
alias vi="/usr/bin/vim"

# PATHS

## Oh-My-Posh
export PATH=$PATH:/home/trey/.local/bin

## Go
export PATH=$PATH:/usr/local/go/bin

## fnm
FNM_PATH="/home/trey/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/trey/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

## Add bin 
export PATH=~/bin:$PATH


# TMUX AUTO-SAVE AND RESTORE

## Alias to save state of tmux session-server
alias 'tmux-save'="tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/save.sh"

# Start tmux server and restore sessions if not running
if ! tmux has-session 2>/dev/null; then
    # Create a flag file to indicate this is the initial startup
    touch /tmp/tmux_startup_restore

    # Start server and create a temporary session to trigger restore
    tmux new-session -d
    sleep 1

    # Only try to kill session 0 if it exists
    tmux has-session -t 0 2>/dev/null && tmux kill-session -t 0

    # Remove the flag file after restore is complete
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
