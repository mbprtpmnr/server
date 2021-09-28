{ config, pkgs, ... }:

{
  services.vaultwarden = {
    enable = true;
    config = {
      domain = "https://vault.mbprtpmnr.xyz";
      signupsAllowed = true;
    };
    environmentFile = config.age.secrets.vaultwarden.path;
  };

  services.nginx = {
    virtualHosts = {
      "vault.mbprtpmnr.xyz" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:8000";
        };
      };
    };
  };
}
