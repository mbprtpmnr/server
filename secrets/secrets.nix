let
  mbprtpmnr = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFVymCIOxK2eIXGkx3U1kA+f1tc9PSdFq9HZhPFYimYt";
  users = [ mbprtpmnr ];

  nixos-server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDyduyVhvmy1hyz+ZY+4u0UftQ2N0S7K4EfeJReEbx3Y";
  systems = [ nixos-server ];
in {
  "vaultwarden.age".publicKeys = users ++ systems;
  "mailPass.age".publicKeys = users ++ systems;
}
