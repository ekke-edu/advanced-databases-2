A megoldandó feladatok szövegét is bemásolom ide.
A feladatok korábban készültek, most csak ismét lellenőrzöm őket az elérhető oracle teszt db -vel.
Az iskolai vpn probléma sajnos nem oldódott meg, így a benti sémákhoz való hozzáférést sem tudtam
ellenőrzizni.
A táblák egy részét online sémával néztem, "hr" alatt szerepeltek, ezért szerepel a táblák előtt.

2. Listázd ki a részlegek nevét (`DEPARTMENT_NAME`) a `DEPARTMENTS` táblából, ábécésorrendbe rendezve!

SELECT department_name
FROM hr.departments
ORDER BY department_name ASC;

3. Keresd meg azokat a munkaköröket a `JOBS` táblában, ahol a maximális fizetés (`MAX_SALARY`) meghaladja a 10 000-et!

SELECT *
FROM hr.jobs
WHERE max_salary > 10000;

5. Listázd ki a `LOCATIONS` táblából a városokat (`CITY`) és az államokat/tartományokat (`STATE_PROVINCE`), de csak azokat a sorokat, ahol a tartomány ki van töltve!

SELECT city, state_province
FROM hr.locations
WHERE state_province IS NOT NULL;

8. A `JOB_HISTORY` táblából számold ki napokban, hogy az egyes korábbi munkaköröket mennyi ideig töltötték be (a `START_DATE` és `END_DATE` különbsége)!

SELECT end_date - start_date napok
FROM hr.job_history;

10. Írasd ki a régiók nevét (`REGION_NAME`) a `REGIONS` táblából csupa nagybetűvel!

SELECT UPPER(region_name)
FROM hr.regions;

11. Számold össze, hány részleg (`DEPARTMENT_ID`) található a `DEPARTMENTS` táblában!

SELECT COUNT(department_id)
FROM hr.departments;

15. Kapcsold össze az `EMPLOYEES` és a `DEPARTMENTS` táblákat, és írasd ki a dolgozó vezetéknevét a részlege nevével együtt!

SELECT e.last_name,
d.department_name
FROM hr.employees e
JOIN hr.DEPARTMENTS d ON e.department_id = d.department_id;

16. Kapcsold össze a `DEPARTMENTS` és `LOCATIONS` táblákat! Melyik részleg melyik városban található?

SELECT d.department_name,
l.city
FROM hr.departments d
JOIN hr.locations l ON d.location_id = l.location_id;

17. Írj háromtáblás lekérdezést! Kapcsold össze a dolgozókat, a munkaköröket (`JOBS`) és a részlegeket. Írasd ki a dolgozó nevét, a munkakör megnevezését és a részleg nevét!

SELECT e.first_name,
e.last_name,
j.job_title,
d.department_name
FROM hr.employees e
JOIN hr.jobs j ON e.job_id = j.job_id
JOIN hr.departments d ON e.department_id = d.department_id;

18. Kérdezd le az `EMP_DETAILS_VIEW` nézetből az összes dolgozót, majd szűrd ki azokat, akik a "Europe" régióban dolgoznak!

(Ez a rész egyébként az alap oracle teszt -ből hiányzik. a github -os sql sémában viszont benne van)

SELECT *
FROM emp_details_view
WHERE region_name = 'Europe';

19. Keresd ki a `SECURE_DML` nevű tárolt eljárás forráskódját az `ALL_SOURCE` rendszernézetből!

(type nélkül is megy, mert nincs más. ez is csak a github -os oracle tesztből elérhető)

SELECT text
FROM all_source
WHERE name = 'SECURE_DML'
AND type = 'PROCEDURE';

20. Kérdezd le az `ALL_TRIGGERS` rendszernézetből, hogy az `UPDATE_JOB_HISTORY` trigger melyik táblához kapcsolódik, és milyen esemény váltja ki!

SELECT table_name,
triggering_event
FROM all_triggers
WHERE trigger_name = 'UPDATE_JOB_HISTORY';

A pokémon -os feladathoz (mivel a sulis elérés még problémás) ezt a file -t használtam.
https://github.com/lgreski/pokemonData/blob/master/Pokemon.csv

(nem biztos hogy jó így, a második tipust itt nem is néztem, illetve nem is értem miért van két tipusa. :))

create or replace PROCEDURE legkisebb_hp IS
v_nev    pokemon.name%TYPE;
v_tipus1 pokemon.type1%TYPE;
BEGIN
SELECT name, type1
INTO v_nev, v_tipus1
FROM pokemon
WHERE hp = (SELECT MIN(hp) FROM pokemon)
FETCH FIRST 1 ROWS ONLY;
DBMS_OUTPUT.PUT_LINE('név: ' || v_nev || ', tipus: ' || v_tipus1);
END;

