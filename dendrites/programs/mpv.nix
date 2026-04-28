{ ... }:
{
    programs.mpv =
    {
        enable = true;

        config =
        {
            # TODO: maybe file an issue for this generating a weird file
            profile = "high-quality";
            keep-open = "yes";
            force-window = "immediate";
            save-position-on-quit = true;
            cache = "yes";
            demuxer-max-bytes = 4000000;
            demuxer-max-back-bytes = 1000000;

            ytdl-format = "bestvideo+bestaudio";

            screenshot-format = "png";
            screenshot-dir = "~/Pictures/mpv";
            screenshot-template = "%F-%p-%n";
            screenshot-high-bit-depth = "yes";

            slang = "eng,en";
            alang = "jpn,ja,eng,en";
        };
    };
}
