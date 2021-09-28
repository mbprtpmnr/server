{ config, pkgs, lib, ... }:

let
  domains = [ "mbprtpmnr.xyz" ];
  fqdn = "mail.mbprtpmnr.xyz";
in {
  mailserver = {
    enable = true;
    inherit domains fqdn;

    loginAccounts = {
      "me@mbprtpmnr.xyz" = {
        hashedPasswordFile = config.age.secrets.mailPass.path;
        aliases = [
          "master@mbprtpmnr.xyz"
        ];
        catchAll = domains;
      };
    };
    certificateScheme = 3;
    enableImap = true;
    enablePop3 = true;
    enableImapSsl = true;
    enablePop3Ssl = true;
    enableManageSieve = true;
  };
}
