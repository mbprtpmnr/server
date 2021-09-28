{
  description = "mbprtpmnr's NixOS Server";

  inputs = {
    stable.url = "github:NixOS/nixpkgs?ref=nixos-21.05";
    unstable.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    agenix.url = "github:ryantm/agenix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };
    fu.url = "github:numtide/flake-utils";
    fup = {
      url = "github:gytis-ivaskevicius/flake-utils-plus/1.3.0";
      inputs.flake-utils.follows = "fu";
    };
    npgh = {
      url = "github:seppeljordan/nix-prefetch-github";
      inputs.nixpkgs.follows = "unstable";
      inputs.flake-utils.follows = "fu";
    };
    snm = {
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver";
      inputs.nixpkgs.follows = "unstable";
      inputs.nixpkgs-21_05.follows = "stable";
      inputs.utils.follows = "fup";
    };
  };

  outputs = { self, stable, unstable, agenix, home-manager, fu, fup, snm, ... }@inputs:
    fup.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      channels.nixpkgs = {
        input = unstable;
        config = {
          allowUnfree = true;
        };
      };

      hostDefaults.modules = [
        inputs.agenix.nixosModules.age
      ];

      channels.nixpkgs.overlayBuilder = channels: [
        (final: prev: { inherit (channels) nixpkgs-stable; })
      ];

      hosts = {
        nixos-server = {
          modules = [
            { nix.generateRegistryFromInputs = true; }
            inputs.snm.nixosModule
            ./hosts/server/configuration.nix
            ./modules/security.nix
            ./services/acme
            ./services/gitea
            ./services/mailserver
            ./services/metrics
            ./services/nginx
            ./services/syncthing
            ./services/vaultwarden
            ./services/websites
          ];
        };
      };

      nixos-server = inputs.self.nixosConfigurations.nixos-server.config.system.build.toplevel;

    };
}
