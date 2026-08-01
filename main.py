from fastapi import FastAPI, HTTPException
import oracledb
import os

app = FastAPI(
    title="Pokédex API",
    description="Adatbázisrendszerek II. - Python és Oracle PL/SQL Integráció",
    version="1.0.0",
)


# Segédfüggvény a kapcsolat létrehozásához
def get_db_connection():
    try:
        # A Thick mode kikapcsolása (vékony kliensként csatlakozunk)
        # Ez fontos a konténeres környezetben, így nem kell Oracle Instant Client-et telepíteni!
        connection = oracledb.connect(
            user=os.environ.get("DB_USER"),
            password=os.environ.get("DB_PASSWORD"),
            dsn=os.environ.get("DB_DSN"),
        )
        return connection
    except oracledb.DatabaseError as e:
        (error,) = e.args
        print(f"❌ Adatbázis csatlakozási hiba: {error.message}")
        raise HTTPException(
            status_code=500, detail="Nem sikerült csatlakozni az adatbázishoz."
        )


# 3. Az első végpontunk (Endpoint) - Az összes Pokémon lekérdezése
@app.get("/pokemon", summary="Összes Pokémon lekérdezése")
def get_all_pokemon():
    """
    Lekérdezi az összes Pokémont a POKEMONOK táblából.
    Bemutatja a Cursor használatát Pythonban.
    """
    conn = None
    try:
        # Kapcsolat megnyitása
        conn = get_db_connection()

        # Python "kurzor" létrehozása (hasonló, mint a PL/SQL kurzor!)
        cursor = conn.cursor()

        # SQL utasítás végrehajtása
        sql_query = """
            SELECT pokedex_szam, nev, tipus, alap_hp 
            FROM pokemonok 
            ORDER BY pokedex_szam
        """
        cursor.execute(sql_query)

        # Eredmények feldolgozása (Fetch)
        # A cursor.fetchall() egy listát ad vissza, amelyben tuple-ök vannak
        rows = cursor.fetchall()

        # Adatok átalakítása olvasható JSON (szótár) formátumba
        pokemon_list = []
        for row in rows:
            pokemon = {
                "pokedex_szam": row[0],
                "nev": row[1],
                "tipus": row[2],
                "alap_hp": row[3],
            }
            pokemon_list.append(pokemon)

        return pokemon_list

    except oracledb.DatabaseError as e:
        (error,) = e.args
        raise HTTPException(status_code=500, detail=f"Adatbázis hiba: {error.message}")

    finally:
        # ERŐFORRÁSOK FELSZABADÍTÁSA (Nagyon fontos!)
        # Ha a kapcsolat nyitva marad, a szerver egy idő után összeomlik a sok "lógó" kapcsolattól.
        if conn:
            cursor.close()
            conn.close()


# ROOT végpont a könnyebb tesztelésért
@app.get("/", include_in_schema=False)
def read_root():
    return {
        "message": "Üdvözöl a Pokédex API! Navigálj a /docs oldalra a teszteléshez!"
    }
