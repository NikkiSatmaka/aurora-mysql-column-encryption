from db.connection import engine
from models.employee import Base  # Import the Base from the models


# Function to create all tables
def create_tables():
    """Creates tables in the database based on SQLAlchemy models."""
    Base.metadata.create_all(engine)


# Function to drop all tables (for testing purposes)
def drop_tables():
    """Drops all tables in the database (useful for testing)."""
    Base.metadata.drop_all(engine)
