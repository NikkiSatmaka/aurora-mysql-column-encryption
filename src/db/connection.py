import os

from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

load_dotenv()

DBHOST = os.environ["DBHOST"]
DBNAME = os.environ["DBNAME"]
DBUSER = os.environ["DBUSER"]
DBPASS = os.environ["DBPASS"]

# Database connection (replace with your own connection details)
DATABASE_URL = f"mysql+pymysql://{DBUSER}:{DBPASS}@{DBHOST}/{DBNAME}"

engine = create_engine(DATABASE_URL, echo=True, future=True)
Session = sessionmaker(bind=engine, future=True)


def get_session():
    return Session()
