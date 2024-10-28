"""Testing src/utils/math.py functions."""

from pathlib import Path

import pytest
from pytest_mock import MockerFixture
from utils.pyproject import get_package_version

pyproject_file = Path(__file__).parents[2].resolve().joinpath('pyproject.toml')


def test_get_package_version_success(mocker: MockerFixture) -> None:
    """Test get_package_version_with a valid input file."""
    local_mocker = mocker.patch('builtins.open', mocker.mock_open(read_data=b'[project]\nversion = "0.1.0"\n'))
    assert get_package_version() == '0.1.0'
    local_mocker.assert_called_once_with(pyproject_file, 'rb')


def test_get_package_version_failure(mocker: MockerFixture) -> None:
    """Test get_package_version_with an invalid input file."""
    local_mocker = mocker.patch('builtins.open', mocker.mock_open(read_data=b''))
    with pytest.raises(RuntimeError):
        get_package_version()
    local_mocker.assert_called_once_with(pyproject_file, 'rb')
