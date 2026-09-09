![FastAPI](https://img.shields.io/badge/FastAPI-005571?style=flat&logo=fastapi)
![SQLAlchemy](https://img.shields.io/badge/SQLAlchemy-D71F00?style=flat&logo=sqlalchemy&logoColor=white)
![Pytest](https://img.shields.io/badge/Pytest-0A9EDC?style=flat&logo=pytest&logoColor=white)

# 2. Gyakorlat (FastAPI)

Hogy ne menjen el az idő az Oracle adatbázis és a Python környezet bonyolult telepítésével, a kurzushoz egy DevContainer környezetet használunk. Ez azt jelenti, hogy egyetlen gombnyomással felépül a gépeden a teljes fejlesztői környezet!

## 🚀 Telepítés és Indítás

### A DevContainer elindítása
Amint megnyílik a VS Code, a jobb alsó sarokban fel fog ugrani egy kék ablak:
"Folder contains a Dev Container configuration file".
Kattints a Reopen in Container gombra!

> 📓 Megjegyzés: Az első indítás eltarthat néhány percig, amíg a Docker letölti az Oracle adatbázist, a Python 3.11-es környezetet és beállítja a kiegészítőket. Légy türelemmel! A csomagkezelő (Poetry) automatikusan feltelepíti a szükséges függőségeket (FastAPI, oracledb, pytest stb.) a konténer indulásakor.

### Az adatbázis inicializálása és Tesztelés
A korábbi félévekkel ellentétben az adatbázis (az edzők és Pokémonok táblái, illetve a PL/SQL kódok) létrehozása most már teljesen automatizált. A Python teszt-infrastruktúránk gondoskodik a tiszta állapotról.

Nyiss egy új terminált a VS Code-ban (Terminal -> New Terminal), és futtasd le a teszteket:

```bash
make test
```

> ✅ Sikeres futás: A konzolon látnod kell, hogy az inicializáló szkriptek lefutnak, és a végpontok tesztjei (köztük a biztonságos ORM/Nyers SQL és a sebezhető SQL injection végpont) "PASSED" eredménnyel zárulnak.

### Az API szerver indítása
Hogy lásd, min is fogunk dolgozni, indítsd el a FastAPI szervert lokálisan:

```bash
fastapi dev app/main.py
```
> (Ha a fastapi parancs nem működne, használd a poetry run uvicorn app.main:app --reload parancsot!)

Esetleg használhatod a korábban ismert `make` parancsot is, amit a `Makefile`-ba hoztam létre:

```bash
make run
```

> 🌐 Próbáld ki! Nyisd meg a böngésződben a http://localhost:8000/docs címet. Itt egy interaktív Swagger UI felület fogad, ahol kattintgatva kipróbálhatod az adatbázishoz kapcsolódó API végpontokat!

## 📈 Teljesítménytesztek

A teljesítményteszteket a benchmark szkripttel futtathatod. Először indítsd el a FastAPI szervert, majd egy új terminálban futtasd a benchmarkot:

```bash
make run
```

```bash
make benchmark
```

A script 100 darab kérést küld minden vizsgált végpontra, és az alábbi formában mutatja az eredményeket:
- összes idő
- átlagos idő/kérés miliszekundumban

Ha a szerver nem fut, a benchmark értesítést ad, hogy előbb indítsd el a `make run` parancsot.
