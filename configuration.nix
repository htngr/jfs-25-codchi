{ pkgs, ... }: {

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

}
