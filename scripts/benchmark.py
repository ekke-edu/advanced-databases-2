import time
import requests

BASE_URL = "http://127.0.0.1:8000"
ITERATIONS = 100
TEST_POKEMON = "Bulbasaur"


def run_benchmark(endpoint_path, name):
    url = f"{BASE_URL}{endpoint_path}{TEST_POKEMON}"

    try:
        requests.get(url)
    except requests.ConnectionError:
        print(f"❌ Hiba: Nem tudok csatlakozni a FastAPI szerverhez ({BASE_URL}).")
        print("💡 Indítsd el a szervert először: 'make run'")
        return False
    start_time = time.perf_counter()

    for i in range(ITERATIONS):
        response = requests.get(url)
        if response.status_code != 200:
            print(f"❌ Hiba a(z) {i}. kérés során: {response.status_code}")
            return False

    end_time = time.perf_counter()

    total_time = end_time - start_time
    avg_time = (total_time / ITERATIONS) * 1000

    print(
        f"[{name.upper():<15}] \nÖsszes Idő: {total_time:.4f} s \nÁtlag Idő/Kérés: {avg_time:.2f} ms\n"
    )
    return True


if __name__ == "__main__":
    print(f"🚀 Teljesítményteszt indítása... (Kérések száma: {ITERATIONS} / Végpont)\n")

    success = run_benchmark("/pokemon/vulnerable/", "🥩 Sebezhető (Nyers)")
    if success:
        run_benchmark("/pokemon/raw/", "🛡️ Biztonságos (Nyers)")
        run_benchmark("/pokemon/orm/", "⛃ SQLAlchemy (ORM)")
        print("\n✅ Benchmark sikeresen befejeződött.")
