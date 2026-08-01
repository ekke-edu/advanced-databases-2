from sqlalchemy import Column, Integer, String
from app.database import Base


class Pokemon(Base):
    __tablename__ = "pokemonok"

    pokedex_szam = Column(Integer, primary_key=True, index=True)
    nev = Column(String)
    tipus = Column(String)
