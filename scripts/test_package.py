"""Small script to test the package."""

import os

import jax.numpy as jnp

from nixpython.dummy import double, sample_numbers, say_hello


def main() -> None:
    """Entry point of the script."""
    print("-- Testing the package works as expected.")
    say_hello(os.environ["USER"])
    print("-- Testing C-bindings work as expected.")
    print(sample_numbers(num_samples=10))
    print("-- Testing JAX-CUDA works as expected.")
    results = double(jnp.ones(3,))
    print(f"Array {results} is stored in device={results.device}")


if __name__ == "__main__":
    main()
