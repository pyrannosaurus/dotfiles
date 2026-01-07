echo "loading from .bashrc"
set -o vi

cyan='\e[36m'
yellow='\e[33m'
red='\e[31m'
magenta='\e[35m'
reset='\e[m'

for file in \
    "/usr/share/git-core/contrib/completion/git-prompt.sh" \
    "$HOME/dotfiles/git-prompt.sh"
do
    if [ -f "$file" ]; then
        source "$file"
        break
    fi
done

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUPSTREAM="auto"

PS1="${cyan}\u${reset}@${red}\H ${yellow}\w${reset}\$(__git_ps1 ' (${magenta}%s${reset})') \$ "

for file in \
    "/usr/share/bash-completion/completions/git" \
    "$HOME/.local_config"
do
    [ -f "$file" ] && . "$file"
done
alias grepdev='grep --color=auto --exclude-dir={.git,node_modules,venv,env,__pycache__,site-packages,dist,build,.next,.perl-libs}'
