# markl oh-my-zsh theme

function precmd() {
    #"$DF_ROOT/venv/bin/python3" $DOTFILES/bin/ps1.py top "$(tput cols)"
    "$DF_ROOT/venv/bin/pieprompt" top "$(tput cols)"
}

#PROMPT='%5{$("$DF_ROOT/venv/bin/python3" $DOTFILES/bin/ps1.py bottom "$(tput cols)")%}'
PROMPT='%5{$("$DF_ROOT/venv/bin/pieprompt" bottom "$(tput cols)")%}'
# PROMPT='╚═ ≓ '
RPROMPT='%{$fg[green]%}[%*]%{$reset_color%}'

