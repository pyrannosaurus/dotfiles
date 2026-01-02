echo "loading from .bashrc"
set -o vi

cyan='\e[36m'
yellow='\e[33m'
red='\e[31m'
magenta='\e[35m'
reset='\e[m'

git_prompt=""
for file in \
    "/usr/share/git-core/contrib/completion/git-prompt.sh"
do
    if [ -f "$file" ]; then
        source "$file"
        git_prompt='$(__git_ps1 " (${magenta}%s${reset})")'
        break
    fi
done
PROMPT_COMMAND='PS1="${cyan}\u${reset}@${red}\H ${yellow}\w${reset}${git_prompt} \$ "'

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUPSTREAM="auto"

for file in \
    "/usr/share/bash-completion/completions/git" \
    "$HOME/.local_config"
do
    [ -f "$file" ] && . "$file"
done
