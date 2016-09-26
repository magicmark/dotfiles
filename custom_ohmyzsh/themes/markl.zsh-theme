# markl
#
# <mark@larah.me> https://github.com/magicmark
# Theme inspired by robbyrussell and dst


ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})%{$reset_color%}"

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

local curr_user="%{$fg_bold[blue]%}%n%{$reset_color%}"
local curr_host="%{$fg_bold[green]%}%m%{$reset_color%}"
local curr_dir="%{$fg_bold[cyan]%}%~%{$reset_color%}"
local top_brace="%{$FG[139]%}╭─%{$reset_color%}"
local bottom_brace="%{$FG[139]%}╰─%{$reset_color%}"

PROMPT='
${top_brace} ${curr_user}${at_symbol}${curr_host}: ${curr_dir}$(git_prompt_info)$(virtualenv_info)
${bottom_brace} $(prompt_char)  '

RPROMPT='%{$fg[green]%}[%*]%{$reset_color%}'
ZLE_RPROMPT_INDENT=0

