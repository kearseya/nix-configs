{pkgs ? import <nixpkgs> {}}: let
  tex = pkgs.texlive.combine {
    inherit
      (pkgs.texlive)
      scheme-medium
      standalone
      preview
      doublestroke
      setspace
      rsfs
      relsize
      ragged2e
      fundus-calligra
      microtype
      wasysym
      physics
      babel-english
      gnu-freefont
      mathastext
      cbfonts-fd
      ;
  };
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      python3
      python3Packages.virtualenv
      ffmpeg
      cairo
      pango
      tex
      pkg-config
      ninja
      meson
      stdenv.cc.cc.lib
      libGL
      libGLU
      xorg.libX11
      xorg.libXrandr
      xorg.libXinerama
      xorg.libXcursor
      xorg.libXi
      vlc
    ];

    # shellHook = ''
    #   export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.cairo}/lib:${pkgs.pango}/lib:${pkgs.libGL}/lib:${pkgs.xorg.libX11}/lib:${pkgs.xorg.libXrandr}/lib:$LD_LIBRARY_PATH
    #   export MANIM_PLAYER="${pkgs.vlc}/bin/vlc"
    #
    #   if [ ! -d "$HOME/Shells/.manim_venv" ]; then
    #     echo "Creating virtualenv..."
    #     virtualenv "$HOME/Shells/.manim_venv"
    #   fi
    #
    #   source "$HOME/Shells/.manim_venv/bin/activate"
    #
    #   if ! python -c "import manim" 2>/dev/null; then
    #     echo "Installing manim from GitHub..."
    #     pip install "manim @ git+https://github.com/ManimCommunity/manim.git@main"
    #   fi
    #
    #   echo "Manim shell ready. Run: manim -pql scene.py SceneName"
    # '';

    shellHook = ''
          export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.cairo}/lib:${pkgs.pango}/lib:${pkgs.libGL}/lib:${pkgs.xorg.libX11}/lib:${pkgs.xorg.libXrandr}/lib:$LD_LIBRARY_PATH

          # Override xdg-open to use vlc for media files
          mkdir -p "$HOME/Shells/.manim_venv/bin"
          cat > "$HOME/Shells/.manim_venv/bin/xdg-open" << 'EOF'
      #!/bin/sh
      exec ${pkgs.vlc}/bin/vlc --avcodec-hw=none --no-video-title-show "$@" 2>/dev/null
      EOF
          chmod +x "$HOME/Shells/.manim_venv/bin/xdg-open"
          export PATH="$HOME/Shells/.manim_venv/bin:$PATH"

          if [ ! -d "$HOME/Shells/.manim_venv" ]; then
            echo "Creating virtualenv..."
            virtualenv "$HOME/Shells/.manim_venv"
          fi

          source "$HOME/Shells/.manim_venv/bin/activate"

          if ! python -c "import manim" 2>/dev/null; then
            echo "Installing manim from GitHub..."
            pip install "manim @ git+https://github.com/ManimCommunity/manim.git@main"
          fi

          echo "Manim shell ready. Run: manim -pql scene.py SceneName"
    '';
  }
