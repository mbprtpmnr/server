{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
  ];

  age.secrets = {
    vaultwarden.file = ../../secrets/vaultwarden.age;
    mailPass.file = ../../secrets/mailPass.age;
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.forceInstall = true;
  boot.loader.timeout = 10;

  networking.hostName = "nixos-server";

  networking.useDHCP = false;
  networking.usePredictableInterfaceNames = false;

  networking.interfaces.eth0.useDHCP = true;
  networking.enableIPv6 = true;
  networking.tempAddresses = "disabled";
  # networking.interfaces.eth0.ipv6.addresses = [ {
  #   address = "2a01:7e01::f03c:92ff:fe4b:0a90";
  #   prefixLength = 64;
  # } ];
  # 
  # networking.defaultGateway6 = {
  #   address = "fe80::1";
  #   interface = "eth0";
  # };

  time.timeZone = "Europe/Bucharest";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  nix = {
    useSandbox = true;
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "05:00";
      options = "--delete-older-than 1d";
    };
    binaryCaches = [
      "https://cache.nixos.org"
      "https://cachix.cachix.org"
      "https://nix-community.cachix.org"
    ];
    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    trustedUsers = [ "root" "@wheel" ];
  };

  users.users.mbprtpmnr = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = "$6$5irWiugp2H5uCw$Rg.gbOfv0MOpqa931xpqaqjOzKWz6UQqtVwNmXRnCIdnKjNSx/1YLhkCQW9iRdvVSXLMmNjIPBY42dpR9yOs8.";
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO87WnrZNztW30J0TlnVsGxByBIqC1iqxv2yxb0JwGUq" ];
    uid = 1000;
    description = "mbprtpmnr";
    group = "mbprtpmnr";
  };

  users.users.root = {
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO87WnrZNztW30J0TlnVsGxByBIqC1iqxv2yxb0JwGUq" ];
    hashedPassword = "$6$8xoNulY8qBuo$KFQ3eaeJiEExHPd..LBuDLbPwIJA6S89DO17ACEY6eBTfjSUb3/HLJZPoKXWWhdK7AX7MXuZ8K4Gc0hcxoEWu.";
  };
  
  users.groups.mbprtpmnr = {
    name = "mbprtpmnr";
    gid = 1000;
  };

  security.sudo.extraRules = [
    { users = [ "mbprtpmnr" ];
      commands = [
        { command = "ALL" ;
          options= [ "NOPASSWD" ];
        }
      ];
    }
  ];

  environment.systemPackages = with pkgs; [
    git
    inetutils
    mtr
    sysstat
    htop
    vim
    curl
    wget
  ];

  services.tailscale.enable = true;

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  networking.firewall.allowedTCPPorts = [ 80 443 25 465 587 995 ];
  networking.firewall.allowedUDPPorts = [ ];

  system.stateVersion = "21.11";
}
