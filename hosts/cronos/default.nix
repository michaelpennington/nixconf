{
  config,
  pkgs,
  ...
}: {
  imports = [../../modules/common];
  networking.hostName = "cronos";

  # You will need to generate this later with 'nixos-generate-config'
  # imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "25.11"; # Match your installed version
}
