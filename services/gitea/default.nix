{ config, pkgs, ... }:

{
  services.gitea = {
    enable = true;
    database.type = "sqlite3";
    appName = "mbprtpmnr";
    user = "gitea";
    domain = "gitea.mbprtpmnr.xyz";
    ssh.enable = true;
    rootUrl = "https://gitea.mbprtpmnr.xyz/";
    lfs.enable = true;
  };

  services.nginx = {
    virtualHosts = {
      "gitea.mbprtpmnr.xyz" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:3000";
        };
      };
    };
  };
}
