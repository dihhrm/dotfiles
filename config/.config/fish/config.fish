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

set -gx EDITOR nvim

# NVM load
load_nvm > /dev/stderr

# eza replace for ls
if type -q eza
 alias ll "eza -l -g --icons"
 alias lla "ll -A"
end



# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
