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
    remove-boot-entry = "sudo /run/current-system/bin/switch-to-configuration boot";
    "cdd" = "cd ~/.dotfiles";
    reboot = "systemctl reboot";
    sn = "shutdown now";
    dim = "hyprsunset -t 4500 --gamma 50.0";
    py = "python3";
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
