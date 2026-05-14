{
    description = "NixOS system flake.";

    inputs =
    {
        # https://github.com/NixOS/nixpkgs/tree/nixos-25.11
        nixpkgs.url = "github:nixos/nixpkgs/8fd9daa3db09ced9700431c5b7ad0e8ba199b575";
        # https://github.com/NixOS/nixpkgs (master)
        nixpkgs-master.url = "github:nixos/nixpkgs/9ec84f9983acabdf3e558f0e7f510cdbb34995b4";
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
