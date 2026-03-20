{lib, settings, ...}:

let
  hasWifi = settings.WIFI_SSID or "" != "";
  isWlanPrimary = (settings.PRIMARY_INTERFACE or "eth0") == "wlan0";
in
{
  networking.hostName = settings.HOSTNAME or "finite";

  # Point DNS resolution to Pi-hole
  networking.nameservers = [ "127.0.0.1" ];

  networking.wireless.enable = hasWifi;

  networking.wireless.networks = lib.mkIf hasWifi {
    ${settings.WIFI_SSID} = {
      pskRaw = "ext:psk_wifi";
    };
  };

  networking.wireless.secretsFile = lib.mkIf hasWifi settings.WIFI_SECRETS_FILE;

  # Lock ip address
  networking.defaultGateway = {
    address = settings.ROUTER_IP;
    interface = settings.PRIMARY_INTERFACE or "eth0";
  };

  # disable dynamic IP assignment
  networking.useDHCP = lib.mkForce false;

  networking.interfaces.eth0 = lib.mkIf (!isWlanPrimary) {
    useDHCP = lib.mkForce false;
    ipv4.addresses = [
      {
        address = settings.STATIC_IP;
        prefixLength = 24;
      }
    ];
  };

  networking.interfaces.wlan0 = lib.mkIf hasWifi {
    useDHCP = lib.mkForce false;
    ipv4.addresses = [
      {
        address = if isWlanPrimary then settings.STATIC_IP else (settings.STATIC_IP_WLAN or "192.168.50.3");
        prefixLength = 24;
      }
    ];
  };
}
