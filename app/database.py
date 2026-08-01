import os
import oracledb
from sqlalchemy import create_engine
from sqlalchemy.orm import declarative_base, sessionmaker

DB_USER = os.environ.get("DB_USER")
DB_PASSWORD = os.environ.get("DB_PASSWORD")
DB_DSN = os.environ.get("DB_DSN")

if "/" in DB_DSN:
    host_port, service_name = DB_DSN.split("/")
    SQLALCHEMY_DATABASE_URL = f"oracle+oracledb://{DB_USER}:{DB_PASSWORD}@{host_port}/?service_name={service_name}"
else:
    SQLALCHEMY_DATABASE_URL = f"oracle+oracledb://{DB_USER}:{DB_PASSWORD}@{DB_DSN}"

engine = create_engine(SQLALCHEMY_DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()


def get_db():
    """Dependency injection a FastAPI-hoz (ORM)"""
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


def get_raw_connection():
    """Raw connection with psycopg2"""
    return oracledb.connect(user=DB_USER, password=DB_PASSWORD, dsn=DB_DSN)
