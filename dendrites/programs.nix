{ pkgs, pkgs-master-patched, ... }:
{
    # system
    programs.ssh.startAgent = true;
    programs.gnupg.agent.enable = true;

    # compositor
    programs.hyprland = {
        enable = true;
        package = pkgs-master-patched.hyprland;
    };
    programs.foot.enable = true;
    programs.waybar.enable = true;

    # programs
    hardware.opentabletdriver.enable = true;
    virtualisation.waydroid = {
        enable = true;
        package = pkgs.waydroid-nftables;
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
    programs.steam =
    {
        enable = true;
        extraCompatPackages =
        [
            pkgs.proton-ge-bin
        ];

        gamescopeSession.enable = true;
    };
    programs.gamescope =
    {
        enable = true;

        # capSysNice = true; # makes gamescope crash in some cases...
    };

    # cli/tui
    programs.neovim.enable = true;
    programs.yazi.enable = true;
}
