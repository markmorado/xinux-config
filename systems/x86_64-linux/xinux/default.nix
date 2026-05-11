# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware.nix
      ./modules.nix
    ];

    # Define your hostname.
  networking.hostName = "xinux";
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
  ];

  # Set the keyboard layout.
  services.xserver.xkb.layout = "us,ru";
  services.xserver.xkb.options = "grp:lalt_lshift_toggle";
  console.useXkbConfig = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."dilshod" = {
    isNormalUser = true;
    description = "Dilshod";
    extraGroups = [ "wheel" "networkmanager" "dialout" "docker" ];
  };
  

  # Allow unfree packages
  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
    NIXOS_OZONE_WL = "0";
    ELECTRON_OZONE_PLATFORM_HINT = "x11";
  };

  environment.extraInit = ''
    export XDG_DATA_DIRS="/nix/store/gkmyy8i5wgkpha1p0a9yvym86zpxn4jf-gtk+3-3.24.51/share/gsettings-schemas/gtk+3-3.24.51:$XDG_DATA_DIRS"
  '';
  
  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    onlyoffice-desktopeditors
    yandex-music
    obsidian
    postman
    gradia
    nextcloud-client
    gsettings-desktop-schemas
    glib
    gtk3
    heroic
    winbox
    obs-studio
    docker-compose
    mission-center
  ];

  programs.steam.enable = true;
  programs.dconf.enable = true;

  # Docker
  virtualisation.docker.enable = true;

  #Enable Flatpak
  services.flatpak.enable = true;

  environment.shellAliases = {
    code = "code --ozone-platform=x11";
  };

  #Mount Disk-2 1TB SSD
  fileSystems."/mnt/games" = {
  device = "/dev/nvme1n1p1";
  fsType = "btrfs";
  options = [ "defaults" "nofail" ];
  };

  # Nvidia drivers
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11"; # Did you read the comment?


  programs.nix-data = {
    enable = true;
    systemconfig = "/etc/nixos/systems/x86_64-linux/xinux/default.nix";
    flake = "/etc/nixos/flake.nix";
    flakearg = "xinux";
  };
}
