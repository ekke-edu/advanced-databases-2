![Oracle](https://img.shields.io/badge/Oracle-F80000?style=flat&logo=oracle&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)
![DevContainers](https://img.shields.io/badge/DevContainers-0078D4?style=flat&logo=visualstudiocode&logoColor=white)

# Adatbázisrendszerek II. - PL/SQL Gyakorlat (Pokémon Kiadás) 

Üdvözlünk a kurzuson! Ebben a félévben a Kanto régió adatbázisát fogjuk karbantartani és fejleszteni.

📚 **Curso Info:** [https://io.uni-eszterhazy.hu/downloadCourseInfo/101966](https://io.uni-eszterhazy.hu/downloadCourseInfo/101966)

## 🛠️ Előfeltételek

1. [Git](https://git-scm.com/downloads)
2. [Docker Desktop](https://www.docker.com/products/docker-desktop/)
3. [Visual Studio Code](https://code.visualstudio.com/)
4. **Dev Containers** Microsoft kiegészítő VS Code-ban

## 🚀 Telepítés és Indítás

### 1. A projekt klónozása
```bash
git clone <IDE_JÖN_A_REPO_LINKJE>
cd pokemon-plsql-kurzus
```

### 2. Megnyitás VS Code-ban
```bash
code .
```

### 3. DevContainer elindítása
Kattints a "Reopen in Container" gombra (jobb alsó sarok).

### 4. Csatlakozás az Adatbázishoz

Töltsd ki az Oracle Explorer csatlakozási adatokat:
```
Connection Type: TNS
Connection Name: PokemonDB
TNS Name: POKEMON_DB
Username: poke_admin
Password: pokemon
```

✅ Pipáld be a _Save Password_ opciót.

### 5. Az adatbázis inicializálása

1. Nyisd meg az `init_pokemon_db.sql` fájlt.
2. Nyomj F5-öt vagy kattints a _Run Script_ gombra.
3. Válaszd ki a `PokemonDB` kapcsolatot.

Sikeres futás jelzése: _Pokédex Adatbázis Sikeresen Inicializálva!_

## Adatbázis ellenőrző script

```bash
python db_checker.py
```

Vagy egyedi változók:
```bash
DB_USER=poke_admin DB_PASSWORD=pokemon DB_DSN=POKEMON_DB python3 db_checker.py
```

Sikeres kimenet:
- ✅ SIKERES CSATLAKOZÁS AZ ORACLE ADATBÁZISHOZ!
- 📦 Adatbázis verzió
- 🚀 A környezet készen áll a fejlesztésre!
