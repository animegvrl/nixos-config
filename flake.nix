{
    description = "NixOS system flake.";

    inputs =
    {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    outputs = { nixpkgs, nixpkgs-unstable, ... }:
    let
        nsenv = import ./nsenv.nix;
        system = nsenv.system;

        nixpkgs-unstable-patched = (import nixpkgs-unstable { inherit system; }).applyPatches
        {
            name = "nixpkgs-unstable-patched";
            src = nixpkgs-unstable;
            patches = [];
        };
        pkgs-unstable-patched = import nixpkgs-unstable-patched
        {
            inherit system;
            config.allowUnfreePredicate =
                pkg: builtins.elem (nixpkgs-unstable.lib.getName pkg)
                [
                    "osu-lazer-bin"
                ];
        };
    in
    {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem
        {
            specialArgs = { inherit nsenv pkgs-unstable-patched; };

            modules = [ ./dendrites/configuration.nix ];
        };
    };
}
