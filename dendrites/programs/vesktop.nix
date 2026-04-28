{ ... }:
{
    programs.vesktop =
    {
        enable = true;

        settings =
        {
            appBadge = false;
            arRPC = false;
            checkUpdates = false;
            customTitleBar = true;
            disableMinSize = true;
            minimizeToTray = true;
            tray = true;
            splashBackground = "#000000";
            splashColor = "#ffffff";
            splashTheming = true;
            staticTitle = true;
            hardwareAcceleration = false;
            discordBranch = "stable";
        };

        vencord.settings =
        {
            autoUpdate = false;
            autoUpdateNotification = false;
            notifyAboutUpdates = false;
            useQuickCss = false;
            disableMinSize = true;
            plugins =
            {
                FixYoutubeEmbeds.enabled = true;
                ImageZoom =
                {
                    enabled = true;
                    saveZoomValues = true;
                    invertScroll = true;
                    nearestNeighbour = false;
                    square = true;
                    zoom = 3.4;
                    size = 290;
                    zoomSpeed = 0.5;
                };
                NoF1.enabled = true;
                ValidReply.enabled = true;
                VoiceMessages =
                {
                    enabled = true;
                    noiseSuppression = false;
                    echoCancellation = false;
                };
            };
        };
    };
}
