set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER "nvim +Man!"
set -gx DOTFILES $HOME/.dotfiles

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
