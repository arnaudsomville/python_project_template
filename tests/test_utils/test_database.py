"""Testing src/utils/database.py functions."""

from utils.database import get_postgres_engine


def test_get_postgres_engine() -> None:
    """Test get_postgres_engine function."""
    engine = get_postgres_engine('postgres', 'postgres', 'postgres', 'localhost', 1234)
    engine.connect()
