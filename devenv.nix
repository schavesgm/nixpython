{ pkgs, lib, ... }:
let 
    # Python version to use in the environment
    pythonVersion = "3.11.3";

    # Inputs required to run C-bindings in the environment
    buildInputs = with pkgs; [
      cudaPackages.cuda_cudart
      cudaPackages.cudatoolkit
      cudaPackages.cudnn
      stdenv.cc.cc
      libuv
      zlib
    ];
in {
  # Packages to include in the environment as CLI
  packages = with pkgs; [ git cudaPackages.cuda_nvcc ];

  # Define some environment variables
  env = {
    GREET = "Development environment activated.";
    LD_LIBRARY_PATH = "${
      lib.makeLibraryPath buildInputs
    }:/run/opengl-driver/lib:/run/opengl-driver-32/lib";
    XLA_FLAGS = "--xla_gpu_cuda_data_dir=${pkgs.cudaPackages.cudatoolkit}"; # For tensorflow with GPU support
    CUDA_PATH = pkgs.cudaPackages.cudatoolkit;
  };

  # Languages to allow in the environment. This executables.
  languages.python = {
    enable = true;
    version = pythonVersion;
    uv = {
      enable = true;
      sync.enable = true;
    };
  };

  # Commands to run when the shell is activated
  enterShell = ''
    # Initialise the shell environment
    echo $GREET

    # Create an alias to use neovim as vim
    alias vim=nvim

    # Activate the virtual environment
    source .devenv/state/venv/bin/activate
  '';

  # Create some scripts to use in the environment
  scripts.checkenv.exec = ''uv run python scripts/test_package.py'';
}
