"""Testing src/utils/math.py functions."""

import pytest
from utils.math import modulo


def test_modulo() -> None:
    """Test modulo function."""
    assert modulo(5, 2) == 1
    assert modulo(-5, -2) == 1
    with pytest.raises(ZeroDivisionError):
        modulo(3, 0)
