{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # GUI Apps: most likely need to be installed elsewise due to issues with graphical apps on nix
    # options are install with flatpak, homebrew, or package layering
    wezterm
    # cosmic-term
    # fuzzel # rofi like launcher
  ];
}
