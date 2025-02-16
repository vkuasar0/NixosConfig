{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.settings = {
    main = {
      plugins = "keyfile";
    };
    connection = {
      store-passwords = "yes";
    };
  };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LANGUAGE = "";
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.adb.enable = true;
  programs.git.enable = true;

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.wayland = true;
    excludePackages = with pkgs; [xterm];
  };
  # For android tools
  services.udev.packages = with pkgs; [
    android-udev-rules
  ];
  # Debloat gnome:
  environment.gnome.excludePackages = (with pkgs; [
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    evince # document viewer
    geary # email reader
    gedit # text editor
    gnome-characters
    gnome-music
    gnome-photos
    gnome-terminal
    gnome-tour
    hitori # sudoku game
    iagno # go game
    tali # poker game
    totem # video player
  ]);
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment = {
    sessionVariables = {
      # Sometimes cursor becomes invisible on nvidia
      # WLR_NO_HARDWARE_CURSORS = "1";
      # Hint for electron apps
      NIXOS_OZONE_WL = "1"; 
      # XDG_SESSION_TYPE = "wayland";
      # CLUTTER_BACKEND = "wayland";
    };
    variables = {
      CHROME_EXECUTABLE = "${pkgs.brave}/bin/brave";
    };
  };

  # Desktop portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "history-substring-search" ];
      theme = "kphoen";
    };
  };
  users.defaultUserShell = pkgs.zsh;
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  users.users.vishwa = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "kvm" "adbusers" ];
  };

  systemd.tmpfiles.rules = [
    "d /etc/nixos/modules/home-manager/dotfiles/nvim 0775 root users -"
  ];


   # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    clang
    binutils
    unzip
    xz
    lua
    luajit
    libnotify
    kitty
    waybar
    rofi-wayland
    wl-clipboard
    lshw
    fastfetch
    btop
    nvtopPackages.full
    networkmanagerapplet
    brightnessctl
    mako
    bluez
    bluez-tools
    blueman
    openjdk
    python3Full
    vscode
    android-studio
    cargo
    rustc
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
