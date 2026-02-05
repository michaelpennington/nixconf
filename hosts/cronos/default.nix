{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/common
    ./hardware-configuration.nix
  ];
  networking.hostName = "cronos";

  boot.loader.systemd-boot.enable = true;

  system.stateVersion = "25.11"; # Match your installed version
}
