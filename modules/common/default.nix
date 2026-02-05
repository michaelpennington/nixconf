{
  pkgs,
  inputs,
  ...
}: {
  users.users.mpennington = {
    isNormalUser = true;
    description = "Me";
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.fish; # Set default shell to fish
  };

  # 2. Enable Fish globally so /etc/shells is updated
  programs.fish.enable = true;

  # 3. Home Manager Configuration
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.mpennington = {pkgs, ...}: {
    # The state version is required and should match your release
    home.stateVersion = "25.11";

    # 4. Your Standard Environment Packages
    home.packages = with pkgs; [
      neovim # Editor
      git # Version Control
      ripgrep # Grep replacement
      starship # Shell Prompt
      fd # Find replacement (find fd)
      tmux # Terminal Multiplexer (Assuming tmux instead of termux)
      eza # Ls replacement
      zoxide # Cd replacement

      # Since you use fish, you might want these plugins enabled here or in programs.fish
    ];

    # Basic activation of tools to ensure config files are generated
    programs.starship.enable = true;
    programs.zoxide.enable = true;
    programs.eza.enable = true;

    # Git Configuration
    programs.git = {
      enable = true;
      userName = "Michael Pennington";
      userEmail = "michaeldanielpennington@gmail.com";
    };
  };
}
