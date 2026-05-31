{
    description = "NixOS system flake.";

    inputs =
    {
        # https://github.com/NixOS/nixpkgs/tree/nixos-26.05
        nixpkgs.url = "github:nixos/nixpkgs/ec942ba042dad5ef097e2ef3a3effc034241f011";
        # https://github.com/NixOS/nixpkgs (master)
        nixpkgs-master.url = "github:nixos/nixpkgs/6e7c84f42969957c62e1a115b74879ae30afc17c";
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
