.PHONY: install run test clean

install:
	pip install -r requirements.txt

run:
	uvicorn main:app --host 0.0.0.0 --port 8000 --reload

test:
	pytest .

clean:
	rm -rf __pycache__ .pytest_cache
