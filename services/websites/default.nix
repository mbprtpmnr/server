{ config, pkgs, ... }:

{
  services.nginx = {
    # My personal website
    virtualHosts = {
      "mbprtpmnr.xyz" = {
        forceSSL = true;
        enableACME = true;
        root = "/var/www/mbprtpmnr.xyz";
        locations."/" = { };
        locations."/".extraConfig = ''
          autoindex on;
        '';
      };
    };

    # My special friend website
    virtualHosts = {
      "complexfecioras.ro" = {
        forceSSL = true;
        enableACME = true;
        root = "/var/www/complexfecioras.ro";
        locations."/" = { };
        locations."/".extraConfig = ''
          autoindex on;
        '';
      };
    };
  };
}
