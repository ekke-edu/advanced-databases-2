import oracledb
import os
import sys

# Konfiguráció
DB_USER = os.environ.get("DB_USER")
DB_PASSWORD = os.environ.get("DB_PASSWORD")
DB_DSN = os.environ.get("DB_DSN")

# Meghatározzuk az SQL fájl pontos útvonalát (a projekt gyökeréhez képest)
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_ROOT = os.path.dirname(SCRIPT_DIR)
SQL_FILE_PATH = os.path.join(PROJECT_ROOT, "database", "init_pokemon_db.sql")


def execute_sql_script(cursor, filepath):
    with open(filepath, "r", encoding="utf-8") as f:
        lines = f.readlines()

    statements = []
    current_statement = []
    in_plsql_block = False

    for line in lines:
        stripped = line.strip()

        # 1. Kliens parancsok és üres sorok kiszűrése (ha épp nem PL/SQL blokkban vagyunk)
        if not in_plsql_block:
            if not stripped or stripped.startswith("--"):
                continue
            if stripped.upper().startswith(
                ("SET ", "PROMPT ", "SPOOL ", "EXIT", "REM ")
            ):
                continue

        # 2. PL/SQL blokk detektálása
        # Ha a sor ezekkel kezdődik, akkor belépünk egy PL/SQL blokkba
        if stripped.upper().startswith(
            (
                "DECLARE",
                "BEGIN",
                "CREATE OR REPLACE TRIGGER",
                "CREATE OR REPLACE PROCEDURE",
                "CREATE OR REPLACE FUNCTION",
                "CREATE OR REPLACE PACKAGE",
            )
        ):
            in_plsql_block = True

        # Hozzáadjuk a sort az aktuális utasításhoz
        if (
            stripped != "/" or in_plsql_block
        ):  # A sima perjeleket kihagyjuk a sima SQL-nél
            current_statement.append(line)

        # 3. Utasítás lezárásának detektálása
        if in_plsql_block:
            # PL/SQL blokk esetén a perjel (/) egy új sorban jelenti a blokk végét az Oracle scriptekben
            if stripped == "/":
                # Kész a blokk, kimentjük (a perjel nélkül)
                stmt_str = "".join(current_statement[:-1]).strip()
                if stmt_str:
                    statements.append(stmt_str)
                current_statement = []
                in_plsql_block = False
        else:
            # Sima SQL utasítás esetén a pontosvessző (;) a vége
            if stripped.endswith(";"):
                # Összefűzzük, és levágjuk a pontosvesszőt a legvégéről (de csak onnan!)
                stmt_str = "".join(current_statement).strip()
                if stmt_str.endswith(";"):
                    stmt_str = stmt_str[:-1]
                if stmt_str:
                    statements.append(stmt_str)
                current_statement = []

    # 4. Futtatás
    for statement in statements:
        clean_stmt = statement.strip()
        if not clean_stmt:
            continue

        try:
            cursor.execute(clean_stmt)
        except oracledb.DatabaseError as e:
            (error_obj,) = e.args

            # DROP parancsoknál előforduló "nem létezik" hibák elnyomása
            if error_obj.code in (942, 2289, 4080, 24344):
                print(
                    f"ℹ️ Átugorva (még nem létezett): {clean_stmt[:50].replace(chr(10), ' ')}..."
                )
                continue
            else:
                print(
                    f"\n❌ Hiba az alábbi utasítás futtatásakor:\n{clean_stmt[:150]}\n"
                )
                print(f"Részletes Oracle hiba: {e}\n")
                raise e


def init_database():
    print("🔄 Adatbázis inicializálása folyamatban (.sql script alapján)...")

    with oracledb.connect(user=DB_USER, password=DB_PASSWORD, dsn=DB_DSN) as conn:
        with conn.cursor() as cursor:
            execute_sql_script(cursor, SQL_FILE_PATH)
            conn.commit()
            print("✅ Adatbázis állapot sikeresen visszaállítva az alapértelmezettre!")


if __name__ == "__main__":
    init_database()
