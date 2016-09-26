# markl
#
# <mark@larah.me> https://github.com/magicmark
# Theme adapted from dst


ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function virtualenv_info {
    if [ $VIRTUAL_ENV ]; then
        local venv=`basename $VIRTUAL_ENV`
        echo " %{$FX[bold]%}($venv)%{$reset_color%}"
    fi
}

function u2253 {
    echo "%{$fg_bold[white]%}≓%{$reset_color%}"
}

function prompt_char {
    if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo $(u2253); fi
}

# ====================
# Status line parts
# ======================

local curr_user="%{$fg[blue]%}%n%{$reset_color%}"
local curr_host="%{$fg[green]%}%m%{$reset_color%}"
local curr_dir="%{$FG[117]%}%~%{$reset_color%}"
# local curr_git=`git rev-parse --abbrev-ref HEAD`

PROMPT='
╭─ ${curr_user}@${curr_host}: ${curr_dir}$(git_prompt_info)$(virtualenv_info)
╰─ $(prompt_char) '

RPROMPT='%{$fg[green]%}[%*]%{$reset_color%}'
ZLE_RPROMPT_INDENT=0

