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
    # hacks to install tdlib 1.7.10 on darwin
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
              version = "1.7.10";

              src = fetchFromGitHub {
                owner = "tdlib";
                repo = "td";
                # https://github.com/tdlib/td/issues/1718
                rev = "a53cb30e99f937cfd64e0266fa558785a184a553";
                sha256 = "FX+66JRsigauLq2JLx0InWiedGeQJ9+ox+D/Bqik9ik=";
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
