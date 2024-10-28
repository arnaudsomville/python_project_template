"""Testing src/processings/fizzbuzz.py functions."""

from processings.fizzbuzz import fizzbuzz, fizzbuzzs


def test_fizzbuzz() -> None:
    """Test fizzbuzz function."""
    assert fizzbuzz(0) == 'FizzBuzz'
    assert fizzbuzz(15) == 'FizzBuzz'
    assert fizzbuzz(3) == 'Fizz'
    assert fizzbuzz(6) == 'Fizz'
    assert fizzbuzz(5) == 'Buzz'
    assert fizzbuzz(4) == '4'
    assert fizzbuzz(7) == '7'
    assert fizzbuzz(-19) == '-19'


def test_fizzbuzzs() -> None:
    """Test fizzbuzzs function."""
    assert fizzbuzzs([15, 4, 2, 3, 7]) == 'FizzBuzz\n4\n2\nFizz\n7'
    assert fizzbuzzs([]) == ''
