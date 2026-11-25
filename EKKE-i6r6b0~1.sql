--1 Kérdezd le az összes dolgozó keresztnevét (FIRST_NAME)
--vezetéknevét (LAST_NAME)
--és e-mail címét (EMAIL) az EMPLOYEES táblából!
SELECT first_name,
       last_name,
       email
FROM employees;

--2 Listázd ki a részlegek nevét (DEPARTMENT_NAME) a DEPARTMENTS táblából,
--ábécésorrendbe rendezve!
SELECT department_name
FROM departments
ORDER by department_name;

--3 Keresd meg azokat a munkaköröket a JOBS táblában, 
--ahol a maximális fizetés (MAX_SALARY) meghaladja a 10 000-et!
SELECT *
FROM jobs
where max_salary > 10000;

--4 Kérdezd le azoknak a dolgozóknak az adatait, 
--akiknek nincs közvetlen felettesük (a MANAGER_ID mező üres az EMPLOYEES táblában)!
Select *
FROM employees
Where manager_id IS NULL;

--5 Listázd ki a LOCATIONS táblából a városokat (CITY) és az államokat/tartományokat (STATE_PROVINCE),
--de csak azokat a sorokat, ahol a tartomány ki van töltve!
SELECT city,
       state_province
From locations
WHERE state_province IS NOT NULL;

--6 Jelenítsd meg a dolgozók teljes nevét egyetlen oszlopban (pl. "Steven King"), 
--és egy új oszlopban számold ki az éves fizetésüket (a SALARY oszlop 12-szeresét)!
SELECT first_name || ' ' || last_name AS teljes_nev,
       salary * 12 AS eves_fizetes
FROM employees;
--7 Írasd ki a dolgozók felvételi dátumát (HIRE_DATE) úgy, hogy csak az évet mutassa!
Select first_name,
       last_name,
       EXTRACT(YEAR FROM hire_date) as felvetel_eve
FROM employees;

--8 A JOB_HISTORY táblából számold ki napokban, 
--hogy az egyes korábbi munkaköröket mennyi ideig töltötték be (a START_DATE és END_DATE különbsége)!
SELECT employee_id,
       job_id,
       end_date - start_date AS napok_szama
From job_history;

--9 Készíts egy riportot: ha a dolgozó fizetése (SALARY) nagyobb mint 8000,
--írja mellé, hogy 'Kiemelt', egyébként 'Átlagos'!
SELECT first_name,
       last_name,
       salary,
       CASE
           WHEN salary > 8000 THEN 'Kiemelt'
           ELSE 'Átlagos'
       End AS kategoria
FROM employees;

--10 Írasd ki a régiók nevét (REGION_NAME) a REGIONS táblából csupa nagybetűvel!
SELECT UPPER(region_name) AS regio_neve
FROM regions;

--11 Számold össze, hány részleg (DEPARTMENT_ID) található a DEPARTMENTS táblában!
SELECT COUNT(department_id) AS reszlegek_szama
FROM departments;

--12 Határozd meg a legalacsonyabb, a legmagasabb és az átlagos fizetést (SALARY)
--az egész cégre vonatkozóan az EMPLOYEES tábla alapján!
SELECT MIN(salary) AS legkisebb_fizetes,
       MAX(salary) AS legnagyobb_fizetes,
       AVG(salary) AS atlag_fizetes
FROM employees;

--13 Csoportosítsd a dolgozókat a DEPARTMENT_ID alapján, és írasd ki, hogy melyik részlegen hány fő dolgozik!
SELECT department_id,
       Count(*) AS dolgozok_szama
FROM employees
Group BY department_id;

--14 Bővítsd az előző feladatot: csak azokat a részlegeket listázd ki, ahol az átlagos fizetés eléri a 7000-et!
SELECT department_id,
       COUNT(*) AS dolgozok_szama,
       AVG(salary) AS atlag_fizetes
FROM employees
GRoup BY department_id
Having AVG(salary) >= 7000;

--15 Kapcsold össze az EMPLOYEES és a DEPARTMENTS táblákat, 
--és írasd ki a dolgozó vezetéknevét a részlege nevével együtt!
SELECT employees.last_name,
       departments.department_name
FROM employees
JOIN departments
    ON employees.department_id = departments.department_id;

--16 Kapcsold össze a DEPARTMENTS és LOCATIONS táblákat! Melyik részleg melyik városban található?
Select departments.department_name,
       locations.city
FROM departments
Join locations
    ON departments.location_id = locations.location_id;

--17 Írj háromtáblás lekérdezést! Kapcsold össze a dolgozókat, a munkaköröket (JOBS) és a részlegeket. 
--Írasd ki a dolgozó nevét, a munkakör megnevezését és a részleg nevét!
Select employees.first_name,
       employees.last_name,
       jobs.job_title,
       departments.department_name
from employees
JOIN jobs
    ON employees.job_id = jobs.job_id
JOIN departments
    on employees.department_id = departments.department_id;

--18 Kérdezd le az EMP_DETAILS_VIEW nézetből az összes dolgozót,
--majd szűrd ki azokat, akik a "Europe" régióban dolgoznak!
SELECT *
FROM emp_details_view;

SELECT *
FROM emp_details_view
WHERE region_name = 'Europe';

--19 Keresd ki a SECURE_DML nevű tárolt eljárás forráskódját az ALL_SOURCE rendszernézetből!
SELECT line,
       text
FROM all_source
WHERE name = 'SECURE_DML'
ORDER BY line;

--20 Kérdezd le az ALL_TRIGGERS rendszernézetből, 
--hogy az UPDATE_JOB_HISTORY trigger melyik táblához kapcsolódik, és milyen esemény váltja ki!
SELECT trigger_name,
       table_name,
       triggering_event
FROM all_triggers
WHERE trigger_name = 'UPDATE_JOB_HISTORY';
DROP TRIGGER update_job_history; -- mégis látta amit nemláttam ezé leválltam :D