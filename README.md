<h1 align="center"> MiaFate dotfiles </h1>

### Como usar los dotfiles:
<br/>

1. En $HOME hacer `cd && git clone git@github.com:MiaFate/dotfiles.git && cd dotfiles`

2. Luego ir agregando los links de la siguiente manera:

<br/>

- `stow -vSt ~ user` crea el symlink de la carpeta user a $HOME
- `stow -vSt ~/.config config` crea el symlink de la carpeta config a $HOME/.config/
- `sudo stow -vSt /etc/nixos nix` crea el symlink de la carpeta nix a /etc/nixos/
