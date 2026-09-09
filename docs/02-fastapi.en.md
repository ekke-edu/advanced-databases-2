# 2. FastAPI Practice

To save time on complex Oracle and Python environment setups, we use a DevContainer for this course. This means the entire development environment is built on your machine with a single click!

## 🚀 Installation & Startup

### Start the DevContainer
When VS Code opens, a blue notification will appear in the bottom right corner:
"Folder contains a Dev Container configuration file".
Click Reopen in Container!

> 📓 Note: The first startup may take a few minutes as Docker downloads the Oracle database, the Python 3.11 environment, and configures extensions. Be patient! The package manager (Poetry) will automatically install the necessary dependencies (FastAPI, oracledb, pytest, etc.).

### Initialize Database & Testing
Unlike previous semesters, database creation is now fully automated. Our Python testing infrastructure ensures a clean state.

Open a new terminal in VS Code (Terminal -> New Terminal) and run the tests:

```bash
make test
```

> ✅ Successful run: You should see the initialization scripts execute, and the endpoint tests (including secure ORM/Raw SQL and vulnerable SQL injection endpoints) complete with a "PASSED" result.

### Start the API Server
To see what we are working on, start the FastAPI server locally:

```bash
fastapi dev app/main.py
```

Alternatively, you can use the `make run` command:

```bash
make run
```

> 🌐 Try it out! Open http://localhost:8000/docs in your browser for an interactive Swagger UI!

## 📈 Performance Benchmarks

You can run performance tests using the benchmark script. First, start the FastAPI server, then run the benchmark in a new terminal:

```bash
make run
```

```bash
make benchmark
```

The script sends 100 requests to each tested endpoint and displays the results.
