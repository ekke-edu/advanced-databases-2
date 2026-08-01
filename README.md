# Adatbázisrendszerek II. - PL/SQL Gyakorlat (Pokémon Kiadás) 

Üdvözlünk a kurzuson! Ebben a félévben a Kanto régió adatbázisát és a hozzá tartozó Python (FastAPI) alapú backend rendszert fogjuk karbantartani és fejleszteni. Hogy ne menjen el az idő az Oracle adatbázis és a Python környezet bonyolult telepítésével, a kurzushoz egy DevContainer környezetet használunk. Ez azt jelenti, hogy egyetlen gombnyomással felépül a gépeden a teljes fejlesztői környezet!

## 🛠️ Előfeltételek

Mielőtt elkezdenéd, győződj meg róla, hogy a gépeden telepítve vannak az alábbiak:
1. [Git](https://git-scm.com/downloads)
2. [Docker Desktop](https://www.docker.com/products/docker-desktop/) (Indítsd is el, fusson a háttérben!)
3. [Visual Studio Code](https://code.visualstudio.com/)
4. A VS Code-ban telepítsd a **Dev Containers** nevű hivatalos Microsoft kiegészítőt.

---

## 🚀 Telepítés és Indítás

### 1. A projekt klónozása
Nyiss egy terminált a gépeden, és klónozd le a tárolót a saját gépedre:

```bash
git clone <IDE_JÖN_A_REPO_LINKJE>
cd pokemon-plsql-kurzus
```

### 2. Megnyitás VS Code-ban
Nyisd meg a letöltött mappát a VS Code-ban:

```bash
code .
```

### 3. A DevContainer elindítása
Amint megnyílik a VS Code, a jobb alsó sarokban fel fog ugrani egy kék ablak:
"Folder contains a Dev Container configuration file".
Kattints a Reopen in Container gombra!

> 📓 Megjegyzés: Az első indítás eltarthat néhány percig, amíg a Docker letölti az Oracle adatbázist, a Python 3.11-es környezetet és beállítja a kiegészítőket. Légy türelemmel! A csomagkezelő (Poetry) automatikusan feltelepíti a szükséges függőségeket (FastAPI, oracledb, pytest stb.) a konténer indulásakor.

### 4. Az adatbázis inicializálása és Tesztelés
A korábbi félévekkel ellentétben az adatbázis (az edzők és Pokémonok táblái, illetve a PL/SQL kódok) létrehozása most már teljesen automatizált. A Python teszt-infrastruktúránk gondoskodik a tiszta állapotról.

Nyiss egy új terminált a VS Code-ban (Terminal -> New Terminal), és futtasd le a teszteket:

```bash
make test
```

> ✅ Sikeres futás: A konzolon látnod kell, hogy az inicializáló szkriptek lefutnak, és a végpontok tesztjei (köztük a biztonságos ORM/Nyers SQL és a sebezhető SQL injection végpont) "PASSED" eredménnyel zárulnak.

### 5. Az API szerver indítása
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

## 📝 Munka menete a feladatokhoz

Minden hallgatónak a saját munkáját a következő módon kell elkezdenie:
- Klónozzátok le a branchet a saját gépetekre.
- Hozzátok létre a saját brancheteket a neptun kódotok alapján.
- A feladatok leírása az `exercises/tasks.MD` fájlban található.
- A fejlesztéseket a megfelelő Python fájlokban (pl. az `app/` mappában) és SQL fájlokban kell elvégeznetek.
- Folyamatosan ellenőrizzétek a kód működését a `make test` paranccsal!

> ❕**Fontos** - Semmiféleképpen ne a main vagy feature/pokedex-python-api branch-re próbáljátok fel töltelni.


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
