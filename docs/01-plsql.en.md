# 1. PL/SQL Practice

In this section, we cover basic Oracle database connection and PL/SQL development.

## 🚀 Installation & Startup

### 1. Clone the project
```bash
git clone <YOUR_REPO_LINK_HERE>
cd pokemon-plsql-kurzus
```

### 2. Open in VS Code
```bash
code .
```

### 3. Start DevContainer
Click the "Reopen in Container" button (bottom right corner).

### 4. Database Connection

Fill in the Oracle Explorer connection details:
```
Connection Type: TNS
Connection Name: PokemonDB
TNS Name: POKEMON_DB
Username: poke_admin
Password: pokemon
```

✅ Check the _Save Password_ option.

### 5. Initialize the Database

1. Open the `init_pokemon_db.sql` file.
2. Press F5 or click the _Run Script_ button.
3. Select the `PokemonDB` connection.

Success indicator: _Pokédex Adatbázis Sikeresen Inicializálva!_

## Database Check Script

```bash
python db_checker.py
```

Successful output:
- ✅ SIKERES CSATLAKOZÁS AZ ORACLE ADATBÁZISHOZ!
- 📦 Adatbázis verzió
- 🚀 A környezet készen áll a fejlesztésre!
