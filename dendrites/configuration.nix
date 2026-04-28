# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ nsenv, pkgs, pkgs-master-patched, ... }:
{
    # Include the results of the hardware scan.
    imports =
    [
        ../hardware-configuration.nix
        ./networking.nix
        ./audio.nix
    ];

    boot.kernelPackages = pkgs.linuxPackages_zen;

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.supportedFilesystems = [ "ntfs" ];

    nix.settings =
    {
        experimental-features = [ "nix-command" "flakes" ];

        substituters = [ "https://cache.nixos-cuda.org" ];
        trusted-public-keys =
        [
            "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
        ];
    };

    # services.dbus.enable = true;
    security.polkit.enable = true;

    fonts.packages = [ pkgs.unifont ];

    hardware.opentabletdriver.enable = true;

    ### NVIDIA ###
    hardware.graphics =
    {
        enable = true;
        enable32Bit = true;
    };

    services.xserver.videoDrivers = ["nvidia"];

    nixpkgs.config.allowUnfree = true; # TODO: predicate

    hardware.nvidia =
    {
        modesetting.enable = true;

        powerManagement =
        {
            enable = false;
            finegrained = false;
        };

        open = false;

        nvidiaSettings = true;

        # package = ;
    };
    ### NVIDIA ###

    # Set your time zone.
    time.timeZone = "Europe/Berlin";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    # xdg.portal =
    # {
        # enable = true;
        # wlr.enable = true;

        # extraPortals =
        # [
        #     pkgs.xdg-desktop-portal-gtk
        #     pkgs.xdg-desktop-portal-gnome
        #     pkgs.xdg-desktop-portal-wlr
        # ];

        # config.common = {
        #     default = "gtk"; # TODO: try to set this up properly
        #     "org.freedesktop.impl.portal.Screenshot" = "wlr";
        #     "org.freedesktop.impl.portal.ScreenCast" = "wlr";
        # };
    # };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${nsenv.username} =
    {
        isNormalUser = true;
        extraGroups = [ "wheel" "audio" "networkmanager" ]; # Enable ‘sudo’ for the user.
    };

    virtualisation.waydroid.enable = true;

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

    # List packages installed in system profile.
    # You can use https://search.nixos.org/ to find more packages (and options).
    environment.systemPackages = with pkgs;
    [
        vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        git

        pavucontrol

        # pkgs-master-patched.xwayland-satellite
        # xwayland-satellite
        wine-wayland
    ];

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    # system.copySystemConfiguration = true; # doesn't work with flakes.

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "25.11"; # Did you read the comment?
}
