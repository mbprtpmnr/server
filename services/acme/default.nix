{ config, pkgs, ... }:

{
  security.acme = {
    acceptTerms = true;
    email = "mbprtpmnr@pm.me";
  };
}
