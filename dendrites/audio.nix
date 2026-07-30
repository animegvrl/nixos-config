{ ... }:
{
    services.pulseaudio =
    {
        enable = false;
        support32Bit = true;
    };

    services.pipewire =
    {
        enable = true;
        audio.enable = true;
        pulse.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        jack.enable = true;
        wireplumber.enable = true;

    #     extraConfig.pipewire-pulse."92-low-latency" =
    #     {
    #         context.modules =
    #         [
    #             {
    #                 name = "libpipewire-module-protocol-pulse";
    #                 args =
    #                 {
    #                     pulse.min.req = "8/44100";
    #                     pulse.default.req = "8/44100";
    #                     pulse.max.req = "8/44100";
    #                     pulse.min.quantum = "8/44100";
    #                     pulse.max.quantum = "8/44100";
    #                 };
    #             }
    #         ];
    #         stream.properties =
    #         {
    #             node.latency = "8/44100";
    #             resample.quality = 1;
    #         };
    #     };

    #     wireplumber.extraConfig =
    #     {
    #         "99-low-latency" =
    #         {
    #             "monitor.alsa.rules" =
    #             [
    #                 {
    #                     matches =
    #                     [
    #                         { "node.name" = "~alsa_output.*"; }
    #                     ];

    #                     actions =
    #                     {
    #                         update-props =
    #                         {
    #                             "device.profile" = "pro-audio";
    #                             "device.profile.name" = "pro-output-0";
    #                             "device.profile.description" = "Pro";
    #                             "device.profile.pro" = "true";

    #                             "api.alsa.headroom" = 0;
    #                             "api.alsa.period-size" = 64;
    #                             "api.alsa.period-num" = 1;
    #                             "alsa.resolution_bits" = 8;

    #                             # everything below might be placebo
    #                             "clock.quantum-floor" = 16;
    #                             "clock.min-quantum" = 16;
    #                             "clock.quantum" = 16;
    #                             "clock.force-quantum" = 16;
    #                             "clock.max-quantum" = 16;
    #                             "clock.quantum-limit" = 16;

    #                             # "node.pause-on-idle" = "false";

    #                             "priority.driver" = 100;
    #                             "priority.session" = 100;

    #                             "audio.channels" = 2;
    #                             # "audio.format" = "S16LE";
    #                             "audio.rate" = 44100;

    #                             "api.acp.pro-channels" = 2;

    #                             # "api.alsa.start-delay" = 0;
    #                             # "api.alsa.multirate" = "false";
    #                             "api.alsa.disable-batch" = "true";

    #                             "latency.internal.rate" = 0;
    #                             "latency.internal.ns" = 0;

    #                             # "clock.name" = "api.alsa.0";

    #                             # "session.suspend-timeout-seconds" = 0;
    #                         };
    #                     };
    #                 }
    #             ];
    #         };
    #     };
    };

    security.rtkit.enable = true;

    # security.pam.loginLimits =
    # [
    #     {
    #         domain = "@audio";
    #         item = "memlock";
    #         type = "-";
    #         value = "unlimited";
    #     }
    #     {
    #         domain = "@audio";
    #         item = "rtprio";
    #         type = "-";
    #         value = "99";
    #     }
    #     {
    #         domain = "@audio";
    #         item = "nice";
    #         type = "-";
    #         value = "-20";
    #     }
    #     {
    #         domain = "@audio";
    #         item = "nofile";
    #         type = "soft";
    #         value = "999999"; # 99999
    #     }
    #     {
    #         domain = "@audio";
    #         item = "nofile";
    #         type = "hard";
    #         value = "999999"; # 99999
    #     }
    # ];
}
