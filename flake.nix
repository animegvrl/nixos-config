{
    description = "NixOS system flake.";

    inputs =
    {
        # https://github.com/NixOS/nixpkgs/tree/nixos-25.11
        nixpkgs.url = "github:nixos/nixpkgs/a4bf06618f0b5ee50f14ed8f0da77d34ecc19160";
        # https://github.com/NixOS/nixpkgs (master)
        nixpkgs-master.url = "github:nixos/nixpkgs/63049db4c80c938eed39fc750aaa4c0ef41d16c0";
    };

    outputs = { nixpkgs, nixpkgs-master, ... }:
    let
        nsenv = import ./nsenv.nix;
        system = nsenv.system;

        nixpkgs-master-patched = (import nixpkgs-master { inherit system; }).applyPatches
        {
            name = "nixpkgs-master-patched";
            src = nixpkgs-master;
            patches = [];
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

            modules = [ ./dendrites/configuration.nix ];
        };
    };
}
