como usar los dotfiles:

en $HOME hacer `cd && git clone git@github.com:MiaFate/dotfiles.git && cd dotfiles`

`stow -vSt ~ user` crea el symlink de la carpeta user a $HOME
`stow -vSt ~/.config config` crea el symlink de la carpeta config a $HOME/.config/
`stow -vSt /etc/nixos nix` crea el symlink de la carpeta nix a /etc/nixos/
