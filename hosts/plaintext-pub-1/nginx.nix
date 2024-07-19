{ pkgs, ... }:

{
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "imborge@proton.me";

  security.acme.certs  = {
    "plaintext.pub".email = "imborge@proton.me";
  };

  services.nginx = {
    enable = true;
    virtualHosts."plaintext.pub" = {
      # forceSSL = true;
      forceSSL = true;
      enableACME = true;

      # serverAliases = [ "www.plaintext.pub" ];
      locations."/" = {
        return = "200 '<html><body>Yo</body></html>'";
        extraConfig = ''
          default_type text/html;
        '';
      };
    };
  };
}
