{ config, lib, settings, ... }:

lib.mkIf (settings.TAILSCALE_ENABLE or false) {
  services.tailscale = {
    enable = true;
    extraUpFlags = [
      "--hostname=${settings.TAILSCALE_HOSTNAME or settings.HOSTNAME or "finite"}"
    ];
  };

  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
}
