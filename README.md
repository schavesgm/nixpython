# Python development environment using `devenv` 

This repository contains a small template to create a `Python` virtual environment using `devenv`.
The environment allows libraries using C-bindings, such as `numpy`, as well as CUDA-accelerated
libraries, such as `jax`. This repository is heavily based on
[nix-python-devenv](https://github.com/clementpoiret/nix-python-devenv/tree/main) but using `jax`
instead of `torch` and containing a standalone package to use as reference.

The development environment will have access to the any program installed globally. However, aliases
and some environmental variables might me erased.

## Features

- Python `3.x.x` environment with C-binding support and CUDA/CUDNN support.
- Package management using `uv` 
- Example script using `numpy` 

## How to use the environment

1. Install [`nix`](https://nixos.org/download/)
```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

2. Install [`devenv`](https://devenv.sh/)
```bash
nix-env --install --attr devenv -f https://github.com/NixOS/nixpkgs/tarball/nixpkgs-unstable
```

3. *(Optional)* Install [`direnv`](https://direnv.net/docs/installation.html)

4. Clone the repository and setup the development environment
```bash
# Allow direnv to manage the environment in the current folder
direnv allow

# Build and initialise the development environment
devenv shell

# Run the provided `checkenv` script inside the development environment
(nixpython) (devenv) checkenv
```

If no `uv.lock` file is present in the repository, `devenv shell` will raise an error message. This
can be solved by running `uv lock` once inside the environment (or outside is `uv` is installed
globally).
