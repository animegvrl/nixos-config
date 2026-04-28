{
    description = "NixOS system flake.";

    inputs =
    {
        # https://github.com/NixOS/nixpkgs/tree/nixos-25.11
        nixpkgs.url = "github:nixos/nixpkgs/a4bf06618f0b5ee50f14ed8f0da77d34ecc19160";
        # https://github.com/NixOS/nixpkgs (master)
        nixpkgs-master.url = "github:nixos/nixpkgs/63049db4c80c938eed39fc750aaa4c0ef41d16c0";

        home-manager =
        {
            # https://github.com/nix-community/home-manager/tree/release-25.11
            url = "github:nix-community/home-manager/0d02ec1d0a05f88ef9e74b516842900c41f0f2fe";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, nixpkgs-master, home-manager, ... }:
    let
        nsenv = import ./nsenv.nix;
        system = nsenv.system;

        nixpkgs-master-patched = (import nixpkgs-master { inherit system; }).applyPatches
        {
            name = "nixpkgs-master-patched";
            src = nixpkgs-master;
            patches =
            [
                # ./dendrites/patches/labwc-0.9.6.patch
            ];
        };
        pkgs-master-patched = import nixpkgs-master-patched
        {
            inherit system;
            config.allowUnfreePredicate =
                pkg: builtins.elem (nixpkgs-master.lib.getName pkg)
                [
                    "osu-lazer-bin"
                ];
        };
    in
    {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem
        {
            specialArgs = { inherit nsenv pkgs-master-patched; };

            modules =
            [
                ./dendrites/configuration.nix

                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;

                    home-manager.users.${nsenv.username} = import ./dendrites/home.nix;

                    home-manager.extraSpecialArgs = { inherit nsenv pkgs-master-patched; };
                }
            ];
        };
    };
}
