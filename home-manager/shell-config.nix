{
  config,
  pkgs,
  ...
}: let
  shell-aliases = {
    ".." = "cd ..";
    vim = "nvim";
    nr = "sudo nixos-rebuild switch --flake .#nixos-desktop";
    hr = "home-manager switch --flake .";
    ns = "nix-shell";
    "cdd" = "cd ~/.dotfiles";
  };
in {
  # Shell configurations (shell-aliases at top)
  programs.bash = {
    enable = true;
    shellAliases = shell-aliases;
  };

  programs.zsh = {
    enable = true;
    shellAliases = shell-aliases;
  };
}
