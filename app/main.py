from fastapi import FastAPI, Depends
import oracledb
import os
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.orm import declarative_base, sessionmaker, Session
from fastapi.responses import RedirectResponse

from app.database import get_db, get_raw_connection
from app.models import Pokemon

app = FastAPI(title="Pokémon API - Biztonsági Teszt")


@app.get("/", include_in_schema=False)
def redirect_to_docs():
    """Automatikusan átirányít a Swagger UI dokumentációra."""
    return RedirectResponse(url="/docs")


# 🔴 1. ROSSZ PÉLDA: SQL Injection (Sebezhető!)
@app.get("/pokemon/vulnerable/{pokemon_nev}")
def get_pokemon_vulnerable(pokemon_nev: str):
    with get_raw_connection() as conn:
        with conn.cursor() as cursor:
            # Szigorúan TILOS: String összefűzés felhasználói bemenettel
            sql = f"SELECT pokedex_szam, nev, tipus FROM pokemonok WHERE nev = '{pokemon_nev}'"
            cursor.execute(sql)

            columns = [col[0].lower() for col in cursor.description]
            return [dict(zip(columns, row)) for row in cursor.fetchall()]


# 🟢 2. JÓ PÉLDA: Nyers SQL Bind Változókkal (Biztonságos)
@app.get("/pokemon/raw/{pokemon_nev}")
def get_pokemon_raw(pokemon_nev: str):
    with get_raw_connection() as conn:
        with conn.cursor() as cursor:
            # HELYES: Bind változó használata (:nev)
            sql = "SELECT pokedex_szam, nev, tipus FROM pokemonok WHERE nev = :nev"
            cursor.execute(sql, {"nev": pokemon_nev})

            columns = [col[0].lower() for col in cursor.description]
            return [dict(zip(columns, row)) for row in cursor.fetchall()]


# 🔵 3. ORM PÉLDA: SQLAlchemy
@app.get("/pokemon/orm/{pokemon_nev}")
def get_pokemon_orm(pokemon_nev: str, db: Session = Depends(get_db)):
    return db.query(Pokemon).filter(Pokemon.nev == pokemon_nev).all()
