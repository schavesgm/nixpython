"""Small module containing some dummy functions to bundle with the package."""

import jax
import numpy as np

__all__ = ["say_hello", "sample_numbers", "double"]


def say_hello(name: str = "user") -> None:
    """Say hello with a given name."""
    print(f"Hello {name}. `nixpython` works as expected.")


def sample_numbers(num_samples: int) -> np.ndarray:
    """Sample some numbers following the standard normal distribution."""
    return np.random.randn(num_samples)

@jax.jit
def double(inputs: jax.Array) -> jax.Array:
    """Return the double of the input array."""
    return 2.0 * inputs
