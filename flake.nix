{
    description = "NixOS system flake.";

    inputs =
    {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
        editerm-main.url = "github:cggjaicf/editerm/nix-flake";
    };

    outputs = { nixpkgs, nixpkgs-unstable, editerm-main, ... }:
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
        editerm = editerm-main.packages.${system}.default;
    in
    {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem
        {
            specialArgs = { inherit nsenv pkgs-unstable-patched editerm; };

            modules = [ ./dendrites/configuration.nix ];
        };
    };
}
