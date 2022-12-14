# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
 
  # Make time compatible for dualbooting Windows
  time.hardwareClockInLocalTime = true;

  # Networking
  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; 

  # Enable Some Hardware 
  hardware.bluetooth.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
    time.timeZone = "America/Argentina/Buenos_Aires";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_AR.UTF-8";
    LC_IDENTIFICATION = "es_AR.UTF-8";
    LC_MEASUREMENT = "es_AR.UTF-8";
    LC_MONETARY = "es_AR.UTF-8";
    LC_NAME = "es_AR.UTF-8";
    LC_NUMERIC = "es_AR.UTF-8";
    LC_PAPER = "es_AR.UTF-8";
    LC_TELEPHONE = "es_AR.UTF-8";
    LC_TIME = "es_AR.UTF-8";          
  };

  # Enable the desktop environment.
  services.xserver.enable = true;
  services.xserver.windowManager.bspwm.enable = true;
  # Configure keymap in X11
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;



  services.xserver = {
    layout = "latam";
    xkbVariant = "";
  };

  # Configure coneclole keymap
  console.keyMap = "la-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  nixpkgs.config.pulseaudio = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput = { 
    enable = true;
    touchpad = {
      disableWhileTyping = true;
      sendEventsMode = "disabled-on-external-mouse";
    };
  };

  #habiitar docker
  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.miafate = {
    isNormalUser = true;
    description = "Mia Ramos";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Enable automatic login for the user.
  #services.getty.autologinUser = "raagh";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Enable zsh as default shell 
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    ohMyZsh.enable = true;
    ohMyZsh.plugins = [ "git" "npm" "vi-mode" ];
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
  };
   
  fonts.fonts = with pkgs; [
    noto-fonts-emoji
    dejavu_fonts
    liberation_ttf
    source-code-pro
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" "Meslo" ]; })
  ];

  # Packages 
  environment.systemPackages = with pkgs; [
    # App Dependencies
    cargo
    gcc
    ripgrep
    nodejs
    # Xorg
    xorg.xbacklight

    # Global Apps
    xrdp
    x11vnc
    vscode
    wget
    google-chrome
    firefox
    discord
    neovim
    sumneko-lua-language-server
    geany
    git
    lazygit
    neofetch
    bat
    exa
    htop
    galculator
    vlc
    stow
    xfce.xfce4-power-manager
    arandr

    # Desktop Environment
    polybar
    alacritty
    sxhkd
    picom
    pavucontrol
    blueberry
    xclip
    rofi
    dunst
    zathura
    portfolio
    flameshot
    nitrogen
    i3lock-color

    # Theming
    lxappearance-gtk2
    qogir-theme
    papirus-icon-theme
    pkgs.whitesur-gtk-theme
    pkgs.whitesur-icon-theme
    pkgs.mojave-gtk-theme
    pkgs.dracula-theme
    # Files
    unzip
    ranger
    ueberzug
    udiskie
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
  ];

  services.xserver.excludePackages = [ pkgs.xterm ];

  environment.variables.EDITOR = "nvim";
  nixpkgs.overlays = [
    (self: super: {
      neovim = super.neovim.override {
        viAlias = true;
        vimAlias = true;
      };
    })
  ];

  nixpkgs.config.packagesOverrides = pkgs: {
    polybar = pkgs.polybar.override {
      jackSupport = true;
      alsaSupport = true;
      githubSupport = true;
      mpdSupport = true;
      pulseSupport = true;
      iwSupport = true;
      nlSupport = true;
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  
  # Enable Trezor Hardware wallet support
  services.trezord.enable = true;

  # Open ports in the firewall.
   networking.firewall.allowedTCPPorts = [ 5900 5901 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
