{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [ "8.8.8.8"
 ];
    defaultGateway = "157.230.16.1";
    defaultGateway6 = {
      address = "";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address="157.230.20.8"; prefixLength=20; }
{ address="10.19.0.5"; prefixLength=16; }
        ];
        ipv6.addresses = [
          { address="fe80::ac52:4bff:fec1:bd78"; prefixLength=64; }
        ];
        ipv4.routes = [ { address = "157.230.16.1"; prefixLength = 32; } ];
        ipv6.routes = [ { address = ""; prefixLength = 128; } ];
      };
            eth1 = {
        ipv4.addresses = [
          { address="10.114.0.2"; prefixLength=20; }
        ];
        ipv6.addresses = [
          { address="fe80::30db:71ff:fe5f:7901"; prefixLength=64; }
        ];
        };
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="ae:52:4b:c1:bd:78", NAME="eth0"
    ATTR{address}=="32:db:71:5f:79:01", NAME="eth1"
  '';

  networking.firewall.allowedTCPPorts = [ 80 443 22 ];
}
