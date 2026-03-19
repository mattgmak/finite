{
  VERSION = "1.0.0";

  STATE_VERSION = "25.05";
  SYSTEM = "aarch64-linux";

  USERNAME = "goofy";
  USER_PASSWORD = "hackme";

  SSH_PORT = 1234;
  SSH_PUBLIC_KEY = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMq/zGCOmrHUwNRwjDsj8Sw0PDbnMd3Ck7H/ZKsHKPkM goofy@GoofyDesky";

  TIMEZONE = "Asia/Hong_Kong";

  ROUTER_IP = "192.168.50.1";
  STATIC_IP = "192.168.50.2";
  # Secondary IP when both Ethernet and WiFi are used (eth0 = STATIC_IP, wlan0 = STATIC_IP_WLAN)
  STATIC_IP_WLAN = "192.168.50.3";

  # WiFi: set SSID to enable. Create WIFI_SECRETS_FILE with line: psk_wifi=your_password
  WIFI_SSID = "AX55";
  # Must be a writable path on the root partition; /etc is a store symlink so use /var/lib
  WIFI_SECRETS_FILE = "/var/lib/wifi.secret";
  # "eth0" (default) or "wlan0" — which interface gets STATIC_IP and default gateway
  PRIMARY_INTERFACE = "wlan0";

  # GENERATE_WITH: sudo nix-store --generate-binary-cache-key homepc /etc/nix/signing-key /etc/nix/signing-key.pub
  TRUSTED_PUBLIC_KEYS = [ "YOUR_MACHINE_KEY_HERE" ];

  # Cloudflare NTP usage: https://developers.cloudflare.com/time-services/ntp/usage/#linux
  # Unbound fails on first boot if system clock is wrong (TLS cert validation).
  # Allow outbound NTP temporarily so the clock syncs and Unbound can start correctly.
  TIMESYNCD_SERVERS = [
    "162.159.200.1"
    "162.159.200.123"
  ];

  UNBOUND_SUBNETS = [
    "127.0.0.1/32 allow"
    "192.168.1.0/24 allow"
    "192.168.50.0/24 allow"
  ];

  # Example for Quad9
  # forward-addr = [
  #   "9.9.9.9@853#dns.quad9.net"
  #   "149.112.112.112@853#dns.quad9.net"
  # ];

  PRIVATE_DNS_SERVERS = [
    "146.70.192.62@853#sg-sin-dns-101.mullvad.net"
    "185.213.155.123@853#de-fra-dns-001.mullvad.net"
  ];

  UNBOUND_PORT = "5335";
}
