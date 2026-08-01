import os
import oracledb

DB_USER = os.environ.get("DB_USER")
DB_PASSWORD = os.environ.get("DB_PASSWORD")
DB_DSN = os.environ.get("DB_DSN")


def test_database_connection() -> None:
    print("🔍 Adatbázis kapcsolat ellenőrzése indítva...\n")
    print(f"   Felhasználó: {DB_USER}")
    print(f"   DSN: {DB_DSN}\n")

    try:
        with oracledb.connect(user=DB_USER, password=DB_PASSWORD, dsn=DB_DSN) as conn:
            print("✅ SIKERES CSATLAKOZÁS AZ ORACLE ADATBÁZISHOZ!\n")

            with conn.cursor() as cursor:
                cursor.execute("SELECT banner FROM v$version WHERE ROWNUM = 1")
                version_info = cursor.fetchone()

                if version_info:
                    print("📦 Adatbázis verzió:")
                    print(f"   {version_info[0]}\n")

                print("🚀 A környezet készen áll a fejlesztésre!")

    except oracledb.DatabaseError as e:
        error = e.args[0] if e.args else e
        print("❌ ADATBÁZIS HIBA:")
        print(f"   Kód: {getattr(error, 'code', 'ismeretlen')}")
        print(f"   Üzenet: {getattr(error, 'message', str(error))}")


if __name__ == "__main__":
    test_database_connection()
