{ config, userConfig, pkgs, lib, inputs, ... }:

let
  nix-misc   = inputs.nix-misc.packages.x86_64-linux;
  userConfig =
    if builtins.pathExists ./user.nix
    then import ./user.nix
    else {};
in
{

  imports = [
    ./programs.nix
  ];

  _module.args.userConfig = userConfig;

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";

  # User account
  home.username = userConfig.home.username;
  home.homeDirectory = userConfig.home.homeDirectory;

  # Themeing
  qt.enable = false;
  stylix.enable = true;
  stylix.targets.qt.enable = false;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";

  # Fonts
  fonts.fontconfig.enable = true;

  # Hyprland compositor
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = pkgs.hyprland;

    # Declarative Hyprland settings
    settings = {

      # Monitors, use 'hyprctl monitors'
      monitor = [
        "DP-1,     2560x1440@165,    0x0, 1"
        "HDMI-A-2, 2560x1440@60,  2560x0, 1"
      ];

      input = {

        # Mouse
        accel_profile = "flat";

        # Keyboard
        repeat_rate  = 60;
        repeat_delay = 200;
      };

      # Disable hyprlands default wallpaper
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      general = {
        border_size = 2;
        # Override Stylix.
        "col.active_border" = lib.mkForce "rgb(4ade80)";
        "col.inactive_border" = lib.mkForce "rgba(595959aa)";
      };

      # Muscle memory
      bind = [
        "SUPER_SHIFT,      P, exec,grim -g \"$(slurp)\" - | swappy -f -"
      	"SUPER_SHIFT, RETURN, exec,footclient -e zsh"
        "SUPER, D,            exec,wofi --show drun"
        "SUPER, Q,            killactive"
        "SUPER, R,            exec,cd ~/git/dotfiles && home-manager switch --flake .#cm"
        "SUPER, P,            exec,emacsclient -c -n"
        "SUPER, G,            exec,firefox"
        "SUPER_SHIFT, backspace, exit"

        "SUPER, H, movefocus,l"
        "SUPER, J, movefocus,d"
        "SUPER, K, movefocus,u"
        "SUPER, L, movefocus,r"

        "SUPER_SHIFT, H, movewindow,l"
        "SUPER_SHIFT, J, movewindow,d"
        "SUPER_SHIFT, K, movewindow,u"
        "SUPER_SHIFT, L, movewindow,r"

        "SUPER, F,   fullscreen,1"
        "SUPER, SPC, togglefloating" 

        "SUPER,       minus, togglespecialworkspace"
        "SUPER_SHIFT, minus, movetoworkspacesilent,special"
      ] ++ builtins.concatMap
      (x: [
        "SUPER,       ${toString (lib.mod x 10)}, workspace, ${toString x}"
        "SUPER_SHIFT, ${toString (lib.mod x 10)}, movetoworkspacesilent, ${toString x}"
      ]) (lib.range 1 10);

      # No animations please
      #animation = [
      #  "global, 0, 0, default"
      #  "specialWorkspace, 0"
      #];

      exec-once = [
        # Global clipboard buffer
        "wl-paste -p --watch wl-copy &"
        "wl-clip-persist --clipboard both &"
      ];
    };
  };

  # Startup emacs server
  services.emacs.enable = true;

  # Minimal Wayland environment
  home.packages = with pkgs; with nix-misc; [
    slurp                       # Select screen cordinates
    grim                        # Take a screenshot
    swappy                      # Minimal image editor
    git-fuzzy                   # Pretty git diff
    nixgl.nixGLIntel            # OpenGL Intel wrapper
    xdg-desktop-portal-hyprland # Wayland portal backend
    xdg-desktop-portal-gtk      # Makes GTK apps work properly
    fd                          # Super fast find
    xeyes                       # X11 Testing
    font-awesome                # Icons
    wl-clipboard                # Clipboard management
    wl-clip-persist             # Clipboard management
  ];
}


