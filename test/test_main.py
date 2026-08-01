import pytest
from fastapi.testclient import TestClient
import sys
import os

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from scripts.reset_db import init_database


@pytest.fixture(scope="session", autouse=True)
def setup_database_for_all_tests():
    """
    Ez a fixture a teljes 'pytest' futtatás során csak EGYSZER fut le.
    Lefuttatja az init_pokemon_db.sql-t, így minden teszt egy tiszta adatbázist lát.
    """
    print("\n[Pytest] 🛠️ Adatbázis inicializálása a tesztekhez...")
    init_database()
    yield  # Itt indulnak a tesztek
    print("\n[Pytest] 🏁 Tesztek befejeződtek.")


from app.main import app

client = TestClient(app)


def test_raw_sql_safe_endpoint_normal_query():
    """A BIZTONSÁGOS végpont tesztelése normál adatokkal."""
    response = client.get("/pokemon/raw/Bulbasaur")
    assert response.status_code == 200
    data = response.json()
    assert len(data) == 1
    assert data[0]["nev"] == "Bulbasaur"


def test_orm_safe_endpoint_normal_query():
    """Az ORM végpont tesztelése normál adatokkal."""
    response = client.get("/pokemon/orm/Bulbasaur")
    assert response.status_code == 200
    data = response.json()
    assert len(data) == 1
    assert data[0]["nev"] == "Bulbasaur"


def test_sql_injection_vulnerable_endpoint():
    """
    TÁMADÁS A SEBEZHETŐ VÉGPONT ELLEN!
    """
    malicious_payload = "Bulbasaur' OR '1'='1"

    safe_response = client.get(f"/pokemon/raw/{malicious_payload}")
    assert len(safe_response.json()) == 0

    hacked_response = client.get(f"/pokemon/vulnerable/{malicious_payload}")
    hacked_data = hacked_response.json()

    assert len(hacked_data) > 1
    print(f"\n[!!!] SIKERES SQL INJECTION: {len(hacked_data)} adat szivárgott ki!")
