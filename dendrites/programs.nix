{ pkgs, pkgs-master-patched, ... }:
{
    services.displayManager.ly =
    {
        enable = true;
        x11Support = false;
    };

    # system
    programs.ssh.startAgent = true;
    programs.gnupg.agent.enable = true;

    # compositor
    programs.hyprland = {
        enable = true;
        package = pkgs-master-patched.hyprland;
    };
    programs.hyprlock.enable = true;
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
    programs.gamemode =
    {
        enable = true;

        settings =
        {
            general =
            {
                reaper_freq = 12;
                desiredgov = "performance";
                igpu_power_threshold = -1;
                softrealtime = "auto";
                renice = 20;
                ioprio = 0;
                inhibit_screensaver = 1;
                disable_splitlock = 1;
            };

            cpu =
            {
                pin_cores = "no";
                park_cores = "no";
            };
        };
    };
}
