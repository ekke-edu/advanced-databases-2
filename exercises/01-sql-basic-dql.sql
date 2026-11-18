-- 1. Kérdezd le az összes dolgozó keresztnevét (FIRST_NAME), vezetéknevét (LAST_NAME) és e-mail címét (EMAIL) az EMPLOYEES táblából!

select first_name, last_name, email
from employees;

-- 2. Listázd ki a részlegek nevét (DEPARTMENT_NAME) a DEPARTMENTS táblából, ábécésorrendbe rendezve!

SELECT d.department_name
FROM departments d
ORDER BY d.department_name ASC;

-- 3. Keresd meg azokat a munkaköröket a JOBS táblában, ahol a maximális fizetés (MAX_SALARY) meghaladja a 10 000-et!

SELECT j.job_title,
       j.max_salary
FROM jobs j
WHERE j.max_salary > 10000;

-- 4. Kérdezd le azoknak a dolgozóknak az adatait, akiknek nincs közvetlen felettesük (a MANAGER_ID mező üres az EMPLOYEES táblában)!

SELECT *
FROM employees e
WHERE e.manager_id IS NULL;

-- 5. Listázd ki a LOCATIONS táblából a városokat (CITY) és az államokat/tartományokat (STATE_PROVINCE), de csak azokat a sorokat, ahol a tartomány ki van töltve!

SELECT l.city,
       l.state_province
FROM locations l
WHERE l.state_province IS NOT NULL;

-- 6. Jelenítsd meg a dolgozók teljes nevét egyetlen oszlopban (pl. "Steven King"), és egy új oszlopban számold ki az éves fizetésüket (a SALARY oszlop 12-szeresét)!

SELECT e.first_name || ' ' || e.last_name AS teljes_nev,
       e.salary * 12 AS eves_fizetes
FROM employees e;

-- 7. Írasd ki a dolgozók felvételi dátumát (HIRE_DATE) úgy, hogy csak az évet mutassa!

SELECT e.first_name || ' ' || e.last_name AS teljes_nev,
       TO_CHAR(e.hire_date, 'YYYY') AS felvetel_eve
FROM employees e;

-- 8. A JOB_HISTORY táblából számold ki napokban, hogy az egyes korábbi munkaköröket mennyi ideig töltötték be (a START_DATE és END_DATE különbsége)!

SELECT j.employee_id,
       j.job_id,
       j.start_date,
       j.end_date,
       j.end_date - j.start_date AS eltelt_napok
FROM job_history j;

-- 9. Készíts egy riportot: ha a dolgozó fizetése (SALARY) nagyobb mint 8000, írja mellé, hogy 'Kiemelt', egyébként 'Átlagos'!

SELECT e.first_name || ' ' || e.last_name AS teljes_nev,
       e.salary AS fizetes,
       CASE
           WHEN e.salary > 8000 THEN 'Kiemelt'
           ELSE 'Átlagos'
       END AS besorolas
FROM employees e;

-- 10. Írasd ki a régiók nevét (REGION_NAME) a REGIONS táblából csupa nagybetűvel!

SELECT UPPER(r.region_name) AS regio_neve
FROM regions r;

-- 11. Számold össze, hány részleg (DEPARTMENT_ID) található a DEPARTMENTS táblában!

SELECT COUNT(d.department_id) AS reszlegek_szama
FROM departments d;

-- 12. Határozd meg a legalacsonyabb, a legmagasabb és az átlagos fizetést (SALARY) az egész cégre vonatkozóan az EMPLOYEES tábla alapján!

SELECT MIN(e.salary) AS legalacsonyabb_fizetes,
       MAX(e.salary) AS legmagasabb_fizetes,
       ROUND(AVG(e.salary)) AS atlagos_fizetes
FROM employees e;

-- 13. Csoportosítsd a dolgozókat a DEPARTMENT_ID alapján, és írasd ki, hogy melyik részlegen hány fő dolgozik!

SELECT e.department_id AS reszleg_azonosito,
       COUNT(*) AS dolgozok_szama
FROM employees e
GROUP BY e.department_id
ORDER BY e.department_id;

-- 14. Bővítsd az előző feladatot: csak azokat a részlegeket listázd ki, ahol az átlagos fizetés eléri a 7000-et!

SELECT e.department_id AS reszleg_azonosito,
       COUNT(*) AS dolgozok_szama,
       ROUND(AVG(e.salary)) AS atlagos_fizetes
FROM employees e
GROUP BY e.department_id
HAVING AVG(e.salary) >= 7000
ORDER BY e.department_id;

-- 15. Kapcsold össze az EMPLOYEES és a DEPARTMENTS táblákat, és írasd ki a dolgozó vezetéknevét a részlege nevével együtt!

SELECT e.last_name AS vezeteknev,
       d.department_name AS reszleg_neve
FROM employees e
JOIN departments d
  ON e.department_id = d.department_id;

-- 16. Kapcsold össze a DEPARTMENTS és LOCATIONS táblákat! Melyik részleg melyik városban található?

SELECT
  d.department_name AS reszleg_neve,
  l.city AS varos
FROM departments d
JOIN locations l
  ON d.location_id = l.location_id
ORDER BY
  d.department_name;

-- 17. Írj háromtáblás lekérdezést! Kapcsold össze a dolgozókat, a munkaköröket (JOBS) és a részlegeket. Írasd ki a dolgozó nevét, a munkakör megnevezését és a részleg nevét!

SELECT
  TRIM(e.first_name || ' ' || e.last_name) AS dolgozo_neve,
  j.job_title AS munkakor_megnevezese,
  d.department_name AS reszleg_neve
FROM employees e
JOIN jobs j
  ON e.job_id = j.job_id
LEFT JOIN departments d  -- nem biztos, hogy minden dolgozónak van részlege, ezért a LEFT
  ON e.department_id = d.department_id
ORDER BY
  e.last_name,
  e.first_name;

-- 18. Kérdezd le az EMP_DETAILS_VIEW nézetből az összes dolgozót, majd szűrd ki azokat, akik a "Europe" régióban dolgoznak!

-- nézetből lekérés összes adat
SELECT *
FROM emp_details_view v;

-- csak az európai nevek
SELECT TRIM(v.first_name || ' ' || v.last_name) AS dolgozo_neve
FROM emp_details_view v
--WHERE v.region_name = 'Europe'
ORDER BY
  v.last_name,
  v.first_name;

-- 19. Keresd ki a SECURE_DML nevű tárolt eljárás forráskódját az ALL_SOURCE rendszernézetből!

SELECT
  s.text
FROM all_source s
WHERE s.name = 'SECURE_DML' -- csak ez az eljárás érdekel
  AND s.type = 'PROCEDURE'
ORDER BY  -- ez meg azért, hogy olvasási sorrendben jelenjen meg
  s.owner,
  s.line;

-- 20. Kérdezd le az ALL_TRIGGERS rendszernézetből, hogy az UPDATE_JOB_HISTORY trigger melyik táblához kapcsolódik, és milyen esemény váltja ki!

SELECT t.trigger_name,
       t.table_name,
       t.triggering_event
FROM all_triggers t
WHERE t.trigger_name = 'UPDATE_JOB_HISTORY';

