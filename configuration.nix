{ pkgs, config, ... }: {


  programs.java = {
    enable = true;
    package = pkgs.jdk21; # Set default JDK
  };

  programs.npm = {
    enable = true;
    # package = pkgs.nodejs_20.pkgs.npm;
  };

  environment.systemPackages = [
    # You can also install IJ with plugins (experimental).
    # For more information see <https://github.com/NixOS/nixpkgs/tree/nixos-24.05/pkgs/applications/editors/jetbrains>
    (with pkgs.jetbrains; plugins.addPlugins idea-ultimate [
      "nixidea"
      "ideavim"
    ])

    pkgs.nodejs

    pkgs.chromium

    # nix language server
    pkgs.nil
    pkgs.nixpkgs-fmt
    (pkgs.vscode-with-extensions.override {
      vscode = pkgs.vscodium;
      vscodeExtensions = [
        pkgs.vscode-extensions.jnoortheen.nix-ide
      ];
    })
  ];

  # For proprietary apps like IntelliJ Ultimate
  nixpkgs.config.allowUnfree = true;

  # allow intellij to remember passwords
  codchi.keyring.enable = true;

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "postgres" ];
    enableTCPIP = true;
  };
  codchi.secrets.env = {
    POSTGRES_PASSWORD.description = "Password for the local postgres instance";
  };

  systemd.services.codchi-postgres-init = {
    description = "Initialize PostgreSQL with custom password";
    after = [ "postgresql.service" ];
    requires = [ "postgresql.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      User = "postgres";
      Group = "postgres";
    };
    path = [ config.services.postgresql.package ];
    script = ''
      source /etc/codchi-env
      until pg_isready; do 
        echo "Waiting for PostgreSQL to be ready..."
        sleep 1
      done
      psql -d postgres -c "ALTER USER postgres WITH PASSWORD '"$CODCHI_POSTGRES_PASSWORD"';"
    '';
  };
}
