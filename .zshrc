# autoload -Uz colors && colors
autoload -U colors && colors
setopt PROMPT_SUBST
PROMPT='%F{cyan}%n%f@%F{yellow}%m%f %~ %# '
# Add Git branch info (built-in Zsh version)
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{green}+%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}!%f'
zstyle ':vcs_info:git:*' formats '%F{magenta}(%b)%f%u%c '
PROMPT='${vcs_info_msg_0_}'$PROMPT
autoload -Uz compinit
compinit

# Only start ssh-agent if one isn't already running
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
fi
# --- Zsh Vim Mode Configuration ---
bindkey -v
export KEYTIMEOUT=20

# Use Vim keys for searching history
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Allow backspace to work normally in insert mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey -M viins 'kj' vi-cmd-mode
