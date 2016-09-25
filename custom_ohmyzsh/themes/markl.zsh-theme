# markl
#
# <mark@larah.me> https://github.com/magicmark
# Theme adapted from dst


ZSH_THEME_GIT_PROMPT_PREFIX=" git:(%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function virtualenv_info {
    if [ $VIRTUAL_ENV ]; then
        local venv=`basename $VIRTUAL_ENV`
        echo " virtualenv:(%{$FG[166]%}${venv}%{$reset_color%})"
    fi
}

function u2253 {
    echo "%{$fg[white]%}≓%{$reset_color%}"
}

function prompt_char {
    if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo $(u2253); fi
}

# ====================
# Status line parts
# ======================

local curr_user="%{$FG[199]%}%n%{$reset_color%}"
local at_symbol="%{$FG[217]%}@%{$reset_color%}"
local curr_host="%{$FG[118]%}%m%{$reset_color%}"
local curr_dir="%{$FG[117]%}%~%{$reset_color%}"
local curr_git=`git rev-parse --abbrev-ref HEAD`
local top_brace="%{$FG[139]%}╭─%{$reset_color%}"
local bottom_brace="%{$FG[139]%}╰─%{$reset_color%}"

PROMPT='
${top_brace} ${curr_user}${at_symbol}${curr_host}: ${curr_dir}$(git_prompt_info)$(virtualenv_info)
${bottom_brace} $(prompt_char)  '

RPROMPT='%{$fg[green]%}[%*]%{$reset_color%}'
ZLE_RPROMPT_INDENT=0

