import oracledb
import os

# 1. Környezeti változók beolvasása a DevContainer operációs rendszeréből
DB_USER = os.environ.get("DB_USER")
DB_PASSWORD = os.environ.get("DB_PASSWORD")
DB_DSN = os.environ.get("DB_DSN")


def test_database_connection():
    print("🔍 Adatbázis kapcsolat ellenőrzése indítva...\n")

    # Gyors ellenőrzés, hogy a devcontainer.json átadta-e a változókat
    if not all([DB_USER, DB_PASSWORD, DB_DSN]):
        print(
            "❌ Hiba: Hiányoznak a környezeti változók! Ellenőrizd a devcontainer.json fájlt."
        )
        return

    try:
        # 2. Csatlakozás (a 'with' blokk gondoskodik a conn.close() automatikus hívásáról)
        with oracledb.connect(user=DB_USER, password=DB_PASSWORD, dsn=DB_DSN) as conn:
            print("✅ SIKERES CSATLAKOZÁS AZ ORACLE ADATBÁZISHOZ!\n")

            # 3. Rendszerinformáció lekérdezése tesztképpen
            with conn.cursor() as cursor:
                # Lekérdezzük a pontos Oracle verziót
                cursor.execute("SELECT banner FROM v$version WHERE ROWNUM = 1")
                version_info = cursor.fetchone()

                if version_info:
                    print("📦 Adatbázis verzió:")
                    print(f"   {version_info[0]}\n")

                print("🚀 A környezet készen áll a fejlesztésre!")

    except oracledb.DatabaseError as e:
        (error,) = e.args
        print("❌ ADATBÁZIS HIBA:")
        print(f"   Kód: {error.code}")
        print(f"   Üzenet: {error.message}")


if __name__ == "__main__":
    test_database_connection()
