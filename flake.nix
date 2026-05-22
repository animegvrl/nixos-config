{
    description = "NixOS system flake.";

    inputs =
    {
        # https://github.com/NixOS/nixpkgs/tree/nixos-25.11
        nixpkgs.url = "github:nixos/nixpkgs/687f05a9184cad4eaf905c48b63649e3a86f5433";
        # https://github.com/NixOS/nixpkgs (master)
        nixpkgs-master.url = "github:nixos/nixpkgs/f63696258acefca57e4f8318bf7102d9a08e04db";
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
