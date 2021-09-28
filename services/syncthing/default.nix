{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    group = "mbprtpmnr";
    guiAddress = ":8384";
    openDefaultPorts = true;
    declarative = { };
  };

  services.nginx = {
    virtualHosts = {
      "sync.mbprtpmnr.xyz" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "https://127.0.0.1:8384";
        };
      };
    };
  };
}
