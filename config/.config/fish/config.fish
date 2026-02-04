set fish_greeting ""

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# alias
command -qv nvim && alias n nvim
alias o opencode

set -gx EDITOR nvim

function fzf --wraps=fzf --description="Use fzf-tmux if in tmux session"

    if set --query TMUX # tmux: NÃO usar become
        command fzf-tmux \
            --bind 'enter:execute(nvim {} </dev/tty >/dev/tty 2>&1)+abort' \
            $argv
    else
        # terminal normal: pode usar become
        command fzf \
            --bind 'enter:become(nvim {})' \
            $argv
    end
    set -l opts "--bind=enter:become(nvim {})"
end

# NVM load
load_nvm >/dev/stderr

# eza replace for ls
if type -q eza
    alias ll "eza -l -g --icons"
    alias lla "ll -A"
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
