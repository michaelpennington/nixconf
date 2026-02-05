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

  boot.loader = {
    systemd-boot.enable = true;
    grub = {
      enable = false;
      device = "/dev/nvme0n1p1";
    };
    efi.canTouchEfiVariables = true;
  };
  system.stateVersion = "25.11"; # Match your installed version
}
