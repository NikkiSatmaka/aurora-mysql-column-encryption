import uuid

from sqlalchemy import Column, LargeBinary, String
from sqlalchemy.dialects.mysql import BINARY
from sqlalchemy.orm import declarative_base

Base = declarative_base()


class Employee(Base):
    __tablename__ = "employees"

    id = Column(BINARY(16), primary_key=True, default=lambda: uuid.uuid4().bytes)
    name = Column(String(100), nullable=False)
    ssn = Column(LargeBinary, nullable=False)

    # Utility methods for UUID conversion
    @staticmethod
    def to_uuid(binary_uuid):
        """Convert binary UUID to string UUID."""
        return str(uuid.UUID(bytes=binary_uuid))

    @staticmethod
    def from_uuid(uuid_string):
        """Convert string UUID to binary UUID."""
        return uuid.UUID(uuid_string).bytes
