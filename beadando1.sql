-- =====================================================================
-- Adatbázisrendszerek II. - Beadandó I.
-- =====================================================================

SET SERVEROUTPUT ON;

-- =====================================================================
-- 1. DQL feladatok
-- =====================================================================

-- 1. Az összes dolgozó keresztneve, vezetékneve és e-mail címe az EMPLOYEES táblából!
SELECT first_name, last_name, email
FROM employees;

-- 2. Listázd ki a részlegek nevét a DEPARTMENTS táblából, ábécésorrendbe rendezve!
SELECT department_name
FROM departments
ORDER BY department_name;

-- 3. Munkakörök a JOBS táblában, ahol a MAX_SALARY meghaladja a 10 000-et!
SELECT job_id, job_title, min_salary, max_salary
FROM jobs
WHERE max_salary > 10000;

-- 4. Azok a dolgozók, akiknek nincs közvetlen felettesük (MANAGER_ID üres)!
SELECT *
FROM employees
WHERE manager_id IS NULL;

-- 5. Városok és államok/tartományok a LOCATIONS táblából, ahol a tartomány ki van töltve!
SELECT city, state_province
FROM locations
WHERE state_province IS NOT NULL;

-- 6. A dolgozók teljes neve egy oszlopban, és az éves fizetésük (SALARY * 12)!
SELECT first_name || ' ' || last_name AS teljes_nev,
       salary * 12 AS eves_fizetes
FROM employees;

-- 7. A dolgozók felvételi dátuma (HIRE_DATE) úgy, hogy csak az évet mutassa!
SELECT first_name,
       last_name,
       EXTRACT(YEAR FROM hire_date) AS felvetel_eve
FROM employees;

-- 8. JOB_HISTORY: az egyes korábbi munkakörök időtartama napokban!
SELECT employee_id,
       job_id,
       start_date,
       end_date,
       end_date - start_date AS napok_szama
FROM job_history;

-- 9. Riport: ha a fizetés nagyobb mint 8000, 'Kiemelt', egyébként 'Átlagos'!
SELECT first_name,
       last_name,
       salary,
       CASE
          WHEN salary > 8000 THEN 'Kiemelt'
          ELSE 'Átlagos'
       END AS kategoria
FROM employees;

-- 10. A régiók neve csupa nagybetűvel!
SELECT UPPER(region_name) AS regio_nev
FROM regions;

-- 11. Hány részleg található a DEPARTMENTS táblában?
SELECT COUNT(department_id) AS reszlegek_szama
FROM departments;

-- 12. A legalacsonyabb, a legmagasabb és az átlagos fizetés az egész cégre!
SELECT MIN(salary)           AS legalacsonyabb_fizetes,
       MAX(salary)           AS legmagasabb_fizetes,
       ROUND(AVG(salary), 2) AS atlag_fizetes
FROM employees;

-- 13. Részlegenként (DEPARTMENT_ID) hány fő dolgozik!
SELECT department_id,
       COUNT(*) AS letszam
FROM employees
GROUP BY department_id
ORDER BY department_id;

-- 14. Csak azok a részlegek, ahol az átlagos fizetés eléri a 7000-et!
SELECT department_id,
       COUNT(*)              AS letszam,
       ROUND(AVG(salary), 2) AS atlag_fizetes
FROM employees
GROUP BY department_id
HAVING AVG(salary) >= 7000
ORDER BY department_id;

-- 15. EMPLOYEES és DEPARTMENTS: a dolgozó vezetékneve a részlege nevével!
SELECT e.last_name,
       d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- 16. DEPARTMENTS és LOCATIONS: melyik részleg melyik városban található?
SELECT d.department_name,
       l.city
FROM departments d
JOIN locations l ON d.location_id = l.location_id;

-- 17. Háromtáblás lekérdezés: dolgozó neve, munkakör megnevezése, részleg neve!
SELECT e.first_name || ' ' || e.last_name AS dolgozo_nev,
       j.job_title,
       d.department_name
FROM employees e
JOIN jobs j        ON e.job_id = j.job_id
JOIN departments d ON e.department_id = d.department_id;

-- 18. EMP_DETAILS_VIEW: az összes dolgozó, majd az "Europe" régióban dolgozók!
SELECT *
FROM emp_details_view;

SELECT *
FROM emp_details_view
WHERE region_name = 'Europe';

-- 19. A SECURE_DML tárolt eljárás forráskódja az ALL_SOURCE nézetből!
SELECT line, text
FROM all_source
WHERE name = 'SECURE_DML'
  AND type = 'PROCEDURE'
ORDER BY line;

-- 20. Az UPDATE_JOB_HISTORY trigger táblája és kiváltó eseménye az ALL_TRIGGERS nézetből!
SELECT trigger_name,
       table_name,
       triggering_event,
       trigger_type
FROM all_triggers
WHERE trigger_name = 'UPDATE_JOB_HISTORY';

-- =====================================================================
-- 2. PL/SQL blokk: a legkisebb ALAP_HP-val rendelkező pokémon neve és típusa
--    (előtte futtasd le az init_pokemon_db.sql scriptet a saját sémádban)
-- =====================================================================

DECLARE
   v_nev     pokemonok.nev%TYPE;
   v_tipus   pokemonok.tipus%TYPE;
   v_alap_hp pokemonok.alap_hp%TYPE;
BEGIN
   SELECT nev, tipus, alap_hp
   INTO v_nev, v_tipus, v_alap_hp
   FROM pokemonok
   WHERE alap_hp IS NOT NULL
   ORDER BY alap_hp
   FETCH FIRST 1 ROW ONLY;

   DBMS_OUTPUT.PUT_LINE('A legkisebb alap HP-val rendelkező pokémon: '
                        || v_nev || ' (típus: ' || v_tipus
                        || ', alap HP: ' || v_alap_hp || ')');
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Nincs pokémon a táblában.');
END;
/

-- =====================================================================
-- 3. PL/SQL Fibonacci függvény és kiíratása
-- =====================================================================

CREATE OR REPLACE FUNCTION fibonacci (p_n IN PLS_INTEGER)
   RETURN NUMBER
IS
   v_elozo     NUMBER := 0;
   v_aktualis  NUMBER := 1;
   v_kovetkezo NUMBER;
BEGIN
   IF p_n < 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Az n nem lehet negatív!');
   ELSIF p_n = 0 THEN
      RETURN 0;
   END IF;

   FOR i IN 2 .. p_n LOOP
      v_kovetkezo := v_elozo + v_aktualis;
      v_elozo     := v_aktualis;
      v_aktualis  := v_kovetkezo;
   END LOOP;

   RETURN v_aktualis;
END fibonacci;
/

BEGIN
   FOR i IN 0 .. 15 LOOP
      DBMS_OUTPUT.PUT_LINE('F(' || i || ') = ' || fibonacci(i));
   END LOOP;
END;
/

SELECT fibonacci(10) AS fib_10 FROM dual;
