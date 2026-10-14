<!---2. feladat-->
SELECT department_name AS "Részleg nevek"
FROM departments
ORDER BY department_name ASC;

<!---3. feladat-->
SELECT *
FROM jobs
WHERE max_salary > 10000;

<!---5. feladat-->
SELECT city, state_province
FROM locations
WHERE state_province IS NOT NULL;

<!---8. feladat-->
<!--Date típusú a két dátum mezőm-->
SELECT job_id,(end_date - start_date) AS "Eltelt napok"
FROM job_history;

<!---10. feladat-->
SELECT UPPER(region_name)
FROM regions;

<!---11. feladat-->
SELECT COUNT(department_id) AS "Id szám"
FROM departments;


<!---15. feladat-->
SELECT last_name AS "Vezetéknév", department_name AS "Részlegnév"
FROM employees
INNER JOIN departments
ON employees.department_id = departments.department_id;

<!--16. feladat-->
SELECT department_name AS "Részleg neve", city AS "Város"
FROM departments
INNER JOIN locations
ON departments.location_id = locations.location_id;

<!--17. feladat-->
SELECT CONCAT(last_name,' ',first_name) AS "Dolgozó Neve",
job_title AS "Munkakör megnevezése",
department_name as "Részleg neve"
FROM employees
INNER JOIN jobs
ON employees.job_id = jobs.job_id
INNER JOIN departments
ON employees.department_id = departments.department_id;

<!--18. feladat-->
<!--19. feladat-->
Ezekhez szerintem nincs elég jogosultságom a szerveren.

<!--20. feladat-->
SELECT table_name,triggering_event
FROM sys.all_triggers
WHERE trigger_name = 'UPDATE_JOB_HISTORY';

<!--POKEMON LEKÉRDEZÉS-->
DECLARE
v_nev pokemonok.NEV%TYPE;
v_tipus pokemonok.TIPUS%TYPE;
BEGIN
    SELECT nev,tipus INTO
    v_nev,v_tipus
    FROM pokemonok
    WHERE ALAP_HP = (SELECT MIN(pokemonok.ALAP_HP) FROM pokemonok)
    FETCH FIRST 1 ROW ONLY;
    DBMS_OUTPUT.PUT_LINE(v_nev || ' ' || v_tipus);
END;
/

<!--FIBONACCI FÜGGVÉNY KIÍRATÁS-->
CREATE OR REPLACE FUNCTION fibonacci (n NUMBER)
RETURN NUMBER
IS
BEGIN
    IF n < 0 THEN
        RETURN NULL;
    ELSIF n = 0 THEN
       RETURN 0;
    ELSIF
        n = 1 THEN
        RETURN 1;
    ELSE
        RETURN fibonacci(n-1) + fibonacci(n-2);   
    END IF;
END;
/

SET SERVEROUTPUT ON;
DECLARE
    v_eredmeny NUMBER;
BEGIN
    FOR n IN 1..10
    LOOP
    v_eredmeny := fibonacci(n);
    DBMS_OUTPUT.PUT_LINE(v_eredmeny);
    END LOOP;
END;
/