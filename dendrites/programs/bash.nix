{ ... }:
{
    # TODO: write the scripts with nix

    programs.bash =
    {
        enable = true;
        enableCompletion = true;

        shellAliases =
        let
            nixosConfigurationPath = "~/.config/nixos-config";
        in
        {
            zed = "zeditor";
            todo = "nvim ~/md/mainichi.md";
            ltodo = "nvim ~/md/linux.md";
            mntall = ''
                sudo mount -t ntfs -o ro /dev/disk/by-label/M2_WINDOWS /mnt/m2-windows/ ; \
                sudo mount -t ntfs -o ro /dev/disk/by-label/M2 /mnt/m2/ ; \
                sudo mount -t ntfs -o ro /dev/disk/by-label/SUS /mnt/sus/ ; \
                sudo mount -t ext4 -o ro /dev/disk/by-label/nixosROOT /mnt/nixos-old/
            '';
            unmntall = ''
                sudo umount /mnt/m2-windows/ ; \
                sudo umount /mnt/m2/ ; \
                sudo umount /mnt/sus/ ; \
                sudo umount /mnt/nixos-old/
            '';
            # nxec = "zed ${nixosConfigurationPath}/";
            nxec = ''
                here=$(pwd) ; \
                cd ${nixosConfigurationPath}/ ; \
                nvim ${nixosConfigurationPath}/ ; \
                cd $here
            '';
            nxrt = ''
                ${nixosConfigurationPath}/update-configuration.sh && \
                sudo nixos-rebuild test
            '';
            nxrs = ''
                ${nixosConfigurationPath}/update-configuration.sh && \
                sudo nixos-rebuild switch && \
                ${nixosConfigurationPath}/backup-configuration.sh
            '';
            nxrb = ''
                ${nixosConfigurationPath}/update-configuration.sh && \
                sudo nixos-rebuild boot && \
                ${nixosConfigurationPath}/backup-configuration.sh
            '';
        };
    };
}
