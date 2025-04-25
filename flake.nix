{
  description = "My NixVim configuration. It also includes a NixOS module with bundled dependencies.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      perSystem =
        { pkgs, system, ... }:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit pkgs;
            module = import ./config.nix;
            extraSpecialArgs = { };
          };
          nvim_package = nixvim'.makeNixvimWithModule nixvimModule;
        in
        {
          checks.default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          packages.default = nvim_package;
        };

      flake = {
        nixosModules.default =
          { pkgs, ... }:
          {
            imports = [ nixvim.nixosModules.nixvim ];

            programs.nixvim = {
              imports = [ ./config.nix ];
              enable = true;
              defaultEditor = true;
            };

            environment.systemPackages = with pkgs; [
              # conform-nvim - Golang tools
              gofumpt
              golines
              go-tools

              # conform-nvim - Lua tools
              stylua

              # conform-nvim - Nix tools
              nixfmt-rfc-style

              # conform-nvim - JS/TS/HTML/CSS tools
              nodePackages.prettier
              eslint_d
              deno

              # conform-nvim - TOML tools
              taplo

              # conform-nvim - Python tools
              ruff

              # conform-nvim - SHish tools
              shfmt
              shellcheck

              # conform-nvim - SQL tools
              sqlfluff
            ];
          };

      };
    };
}
