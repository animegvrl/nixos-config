{ pkgs, pkgs-master-patched, ... }:
{
    programs.obs-studio =
    {
        enable = true;
        package = (pkgs.obs-studio.override
        {
            cudaSupport = true;
        });

        # plugins = [ pkgs.obs-studio-plugins.wlrobs ];
    };

    programs.ssh.startAgent = true;

    programs.foot.enable = true;
    programs.neovim.enable = true;
    programs.yazi.enable = true;
    programs.hyprland = {
        enable = true;
        package = pkgs-master-patched.hyprland;
    };
    programs.waybar.enable = true;
    programs.sway.enable = true;
    programs.labwc = {
        enable = true;
        package = pkgs-master-patched.labwc;
    };
    programs.gnupg.agent.enable = true;

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

}
