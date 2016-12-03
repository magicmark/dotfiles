#!/usr/bin/zsh

if [ -n "$DEVBOX" ]; then
    function rvim {
        local filepath="scp://markl@$DEVBOX/~/pg/$1"
        nvim "$filepath"
    }
fi
