{ inputs, config, pkgs, lib, system, ... }:
{



  # Select internationalisation properties.
  modules.xinux.language = "ru_RU.UTF-8";
  modules.gnome.gsconnect.enable = true;
  modules.packagemanagers.appimage.enable = true;
  services.flatpak.enable = true;
}
