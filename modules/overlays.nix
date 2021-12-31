{ inputs, nixpkgs, stable, ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      # expose stable packages via pkgs.stable
      stable = import stable { system = prev.system; };
    })
    (final: prev: rec {
      # install comma from shopify repo
      comma = import inputs.comma rec {
        pkgs = import nixpkgs { system = prev.system; };
      };
    })
    # Hacks to install latest version tdlib on darwin
    (final: prev: rec {
      tdlib =
        if prev.stdenvNoCC.isDarwin then
          (
            let
              inherit (prev)
                fetchFromGitHub gperf openssl readline zlib cmake lib stdenv;
              inherit (prev.darwin) Security;
            in
            stdenv.mkDerivation rec {
              pname = "tdlib";
              version = "1.8.0";

              src = fetchFromGitHub {
                owner = "tdlib";
                repo = "td";
                rev = "b3ab664a18f8611f4dfcd3054717504271eeaa7a";
                sha256 = "OBgzFBi+lIBbKnHDm5D/F3Xi4s1x4geb+1OoBP3F+qY=";
              };

              buildInputs = [ gperf openssl readline zlib ];
              nativeBuildInputs = [ cmake ];

              meta = with lib; {
                description = "Cross-platform library for building Telegram clients";
                homepage = "https://core.telegram.org/tdlib/";
                license = [ licenses.boost ];
                platforms = platforms.unix;
                maintainers = [ maintainers.vyorkin ];
              };
            }
          )
        else
          prev.tdlib;
    })
    # Emacs overlay
    inputs.emacs-overlay.overlay
  ];
}
