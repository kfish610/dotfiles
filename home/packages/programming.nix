{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Agda
    (agda.withPackages (p: with p; [
      standard-library
    ]))

    # Android
    android-tools
    android-studio

    # C/C++
    gnumake
    cmake
    gcc

    # Clojure
    clojure
    leiningen
    babashka

    # Coq
    coq
    coqPackages.vscoq-language-server
    coqPackages.coq-lsp

    # Dart
    flutter

    # Exercism
    exercism

    # Haskell
    stack
    haskell-language-server

    # Java/Scala
    jdk11
    sbt

    # LaTeX
    texlive.combined.scheme-full

    # Lean
    elan

    # Nix
    nil
    nixpkgs-fmt

    # Node
    nodejs_latest

    # Python
    micromamba
    python312
  ] ++ (
    let
      R = rWrapper.override { packages = with rPackages; [ languageserver httpgd rmarkdown ]; };
    in
    [
      # R
      R
      (python312Packages.radian.override { R = R; })
    ]
  );

  programs.zsh.initExtra = ''
    # Set NPM global in the user directory so it doesn't clash with Nix
    npm set prefix ~/.npm-global

    # Set up micromamba
    eval "$(micromamba shell hook --shell=zsh)"
  '';
}
