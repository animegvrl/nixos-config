{ nsenv, ... }:
{
    networking.hostName = nsenv.hostname; # Define your hostname.

    # Configure network connections interactively with nmcli or nmtui.
    networking.networkmanager.enable = true;

    # VPN
    networking.wg-quick.interfaces =
    {
        mega-4-de =
        {
            autostart = true;
            configFile = "/home/${nsenv.username}/wg-conf/mega-4-de.conf";
        };
    };

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    networking.firewall.enable = true;
    networking.firewall.allowedTCPPorts = [ 80 ];
    networking.firewall.allowedUDPPorts = [ 80 ];
}
