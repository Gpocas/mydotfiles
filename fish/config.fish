if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g -x fish_greeting ''
end

starship init fish | source

eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
source ~/.asdf/asdf.fish
zoxide init fish | source

function storePathForWindowsTerminal --on-variable PWD
    if test -n "$WT_SESSION"
        printf "\e]9;9;%s\e\\" (wslpath -w "$PWD")
    end
end
