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

  # You will need to generate this later with 'nixos-generate-config'

  system.stateVersion = "25.11"; # Match your installed version
}
