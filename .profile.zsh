export VISUAL="nvim"
export EDITOR="$VISUAL"
export TERM="xterm-256color"

alias vim=nvim
alias :e=nvim
alias :E=nvim
alias ezsh='nvim $DOTFILES/.zshrc'


if [[ -e ~/.fzf.zsh ]]; then
    function ff {
        nvim $(fzf)
    }
fi

# https://coderwall.com/p/_s_xda/fix-ssh-agent-in-reattached-tmux-session-shells
function fixssh {
  for key in SSH_AUTH_SOCK SSH_CONNECTION SSH_CLIENT; do
    if (tmux show-environment | grep "^${key}" > /dev/null); then
      value=`tmux show-environment | grep "^${key}" | sed -e "s/^[A-Z_]*=//"`
      export ${key}="${value}"
    fi
  done
}
