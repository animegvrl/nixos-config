{ nsenv, pkgs, ... }:
{
    home.username = nsenv.username;
    home.homeDirectory = "/home/${nsenv.username}";

    home.packages = with pkgs;
    [
        librewolf
        coppwr
        zed-editor
        kdePackages.kdenlive
        miniserve
        tor-browser
    ];

    imports =
    [
        ./programs/bash.nix
        ./programs/labwc.nix
        ./programs/hyprland.nix
        ./programs/waybar.nix
        ./programs/vesktop.nix
        ./programs/mpv.nix
        ./programs/osu.nix
    ];

    dconf.settings =
    {
        "org/gnome/desktop/interface" =
        {
            enable-animations = false;
            color-scheme = "prefer-dark";
        };
        "org/gnome/desktop/a11y/interface" =
        {
            reduced-motion = true;
        };
        "org/gnome/desktop/wm/preferences" =
        {
            button-layout = ":";
        };
    };

    programs.fuzzel =
    {
        enable = true;

        settings =
        {
            main = { lines = 30; };
            colors = { background = "000000ff"; };
        };
    };

    programs.foot = {
        enable = true;

        settings = {
            main = {
                font = "Unifont:size=12";
                "initial-window-size-pixels" = "1280x720";
            };
            scrollback.lines = 100000;
            colors.background = "000000";
        };
    };

    programs.neovim.enable = true;

    programs.yazi.enable = true;

    programs.lutris =
    {
        enable = true;

        protonPackages =
        [
            pkgs.proton-ge-bin
        ];

        # extraPackages = with pkgs;
        # [
        #   gnutls
        #   openldap
        #   libgpg-error
        #   sqlite
        #   libpulseaudio
        #   vulkan-loader
        #   vulkan-tools
        # ];

        defaultWinePackage = pkgs.proton-ge-bin;
    };

    programs.btop =
    {
        enable = true;

        package = (pkgs.btop.override
        {
            cudaSupport = true;
        });
    };

    programs.obs-studio =
    {
        enable = true;
        package = (pkgs.obs-studio.override
        {
            cudaSupport = true;
        });

        # plugins = [ pkgs.obs-studio-plugins.wlrobs ];
    };

    home.stateVersion = "25.11";
}
