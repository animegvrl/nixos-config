{ pkgs, pkgs-master-patched, ... }:
{
    home.packages =
    [
        pkgs-master-patched.osu-lazer-bin
    ];

    home.file.".local/share/applications/osu!.desktop".text = ''
        [Desktop Entry]
        Version=1.5
        Name=osu!lazer
        Icon=osu
        Categories=Game
        Comment=A free-to-win rhythm game. Rhythm is just a *click* away!
        Type=Application
        MimeType=application/x-osu-beatmap-archive;application/x-osu-skin-archive;application/x-osu-beatmap;application/x-osu-storyboard;application/x-osu-replay;x-scheme-handler/osu;
        StartupWMClass=osu!
        SingleMainWindow=true
        Terminal=false
        StartupNotify=true
        # https://download.nvidia.com/XFree86/Linux-x86_64/525.78.01/README/openglenvvariables.html
        # https://github.com/PipeWire/pipewire?tab=readme-ov-file#usage
        Exec=env PIPEWIRE_LATENCY=8/44100 __GL_MaxFramesAllowed=1 __GL_SYNC_TO_VBLANK=0 osu! %U
        # Exec=env PIPEWIRE_LATENCY=8/44100 __GL_MaxFramesAllowed=1 __GL_SYNC_TO_VBLANK=0 gamemoderun osu! %U

        # X-AppImage-Version=2026.406.0-lazer
    '';
}
