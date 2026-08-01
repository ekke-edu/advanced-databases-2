## Feladatok

### Alapvető Végpontok és ORM (GET)

1. Készíts egy `GET /trainers` végpontot az `app/main.py` fájlban, ami lekéri és visszaadja az összes edzőt a rendszerből.
> Használd a beépített SQLAlchemy ORM modellt (Trainer vagy Edzo) a lekérdezéshez!
2. Készíts egy `GET /pokemon/{pokedex_id}` végpontot. A végpont adja vissza a Pokémon adatait.
> Kivételkezelés: Ha a Pokémon nem létezik, a FastAPI dobjon egy 404 Not Found HTTP hibát (HTTPException)!
---

### Pydantic Sémák és Adatmódosítás (POST)
3. Bővítsd ki a Pokémon lekérdező végpontot `(GET /pokemon)` úgy, hogy tudjon fogadni egy opcionális `tipus` Query paramétert (pl. `/pokemon?tipus=Tűz`). Ha meg van adva, csak az adott típusúakat listázza!
4. Készíts egy `POST /catches` végpontot. Hozz létre egy Pydantic modellt (`CatchCreate`) az `app/schemas.py` fájlban, ami várja az `edzo_id`, `pokemon_id` és `szint` adatokat. A végpont ORM segítségével mentse el az új rekordot az adatbázisba.
---

### Biztonság és Sebezhetőségek (Nyers SQL vs. Biztonságos Kód)
5.  Készíts egy `GET /search-trainer-vulnerable` végpontot, amely vár egy `nev` paramétert. A lekérdezést szövegösszefűzéssel építsd fel (pl. `f"SELECT * FROM edzok WHERE nev = '{nev}'"`), és futtasd le `session.execute()` segítségével!
> ⚠️ Ezt a végpontot a tesztek automatikusan támadni fogják. Figyeld meg a konzolon, hogyan szivárognak ki az adatok!
6.  Készíts egy `GET /search-trainer-safe` végpontot is. Itt már kötelező paraméterezett lekérdezést használnod, ahol az adatbázis-illesztőprogram végzi el a bemenet tisztítását!
> Győződj meg róla, hogy a make test futtatásakor ez a végpont már ellenáll a támadásnak!
---

### PL/SQL Integráció (Függvények és Eljárások hívása Pythonból)
7. Készíts egy `GET /trainers/{edzo_id}/max-level` végpontot. Ne Pythonban számold ki a maximumot, hanem hívd meg benne a PL/SQL-ben korábban megírt `fn_max_szint(p_edzo_id)` adatbázis függvényt!
> Használd a `session.execute(text("SELECT fn_max_szint(:id) FROM DUAL"), {"id": edzo_id})` szintaxist!
8. Készíts egy `POST /liga/lezaras` végpontot. Ennek a végpontnak a feladata, hogy elindítsa az adatbázisban a PL/SQL feladatsor végén megírt `sp_liga_lezaras` tárolt eljárást.
> Mivel ez egy eljárás, nem használhatsz SELECT-et a meghívására. Hívd meg CALL-lal (pl. CALL sp_liga_lezaras()), és a végpont térjen vissza egy {"message": "A Liga sikeresen lezárult, XP-k kiosztva!"} JSON válasszal.
---

### Komplex Napi Kihívás (API Logika + SQL)
9. Készíts egy `POST /events/kanto-bonus` végpontot. A végpont futtasson le egy nyers SQL `UPDATE` utasítást (amit az 11. PL/SQL feladatban is használtál), ami minden Kanto régiós edzőnek ad 500 XP-t.
A lekérdezés után a FastAPI végpont számolja össze, hány sor módosult (`cursor.rowcount` vagy SQLAlchemy result), és ha 0, dobjon egy 400-as hibát _Nincs kinek XP-t adni_ üzenettel. Ha volt módosítás, térjen vissza a módosított sorok számával!
---