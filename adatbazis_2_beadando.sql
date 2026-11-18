-- A Táblák létrehozását és feltöltését AI-al csináltattam meg.

-- ==========================================================
-- 1. MEGLÉVŐ TÁBLÁK TÖRLÉSE (Oracle szintaxis)
-- ==========================================================
DROP TABLE JOB_HISTORY CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEES CASCADE CONSTRAINTS;
DROP TABLE DEPARTMENTS CASCADE CONSTRAINTS;
DROP TABLE JOBS CASCADE CONSTRAINTS;
DROP TABLE LOCATIONS CASCADE CONSTRAINTS;
DROP TABLE COUNTRIES CASCADE CONSTRAINTS;
DROP TABLE REGIONS CASCADE CONSTRAINTS;

-- ==========================================================
-- 2. TÁBLÁK LÉTREHOZÁSA
-- ==========================================================

CREATE TABLE REGIONS (
    REGION_ID NUMBER PRIMARY KEY,
    REGION_NAME VARCHAR2(50)
);

CREATE TABLE COUNTRIES (
    COUNTRY_ID CHAR(2) PRIMARY KEY,
    COUNTRY_NAME VARCHAR2(50),
    REGION_ID NUMBER,
    FOREIGN KEY (REGION_ID) REFERENCES REGIONS(REGION_ID)
);

CREATE TABLE LOCATIONS (
    LOCATION_ID NUMBER PRIMARY KEY,
    STREET_ADDRESS VARCHAR2(100),
    POSTAL_CODE VARCHAR2(20),
    CITY VARCHAR2(50) NOT NULL,
    STATE_PROVINCE VARCHAR2(50),
    COUNTRY_ID CHAR(2),
    FOREIGN KEY (COUNTRY_ID) REFERENCES COUNTRIES(COUNTRY_ID)
);

CREATE TABLE JOBS (
    JOB_ID VARCHAR2(10) PRIMARY KEY,
    JOB_TITLE VARCHAR2(50) NOT NULL,
    MIN_SALARY NUMBER(10, 2),
    MAX_SALARY NUMBER(10, 2)
);

CREATE TABLE DEPARTMENTS (
    DEPARTMENT_ID NUMBER PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR2(50) NOT NULL,
    MANAGER_ID NUMBER,
    LOCATION_ID NUMBER,
    FOREIGN KEY (LOCATION_ID) REFERENCES LOCATIONS(LOCATION_ID)
);

CREATE TABLE EMPLOYEES (
    EMPLOYEE_ID NUMBER PRIMARY KEY,
    FIRST_NAME VARCHAR2(50),
    LAST_NAME VARCHAR2(50) NOT NULL,
    EMAIL VARCHAR2(100) NOT NULL UNIQUE,
    PHONE_NUMBER VARCHAR2(20),
    HIRE_DATE DATE NOT NULL,
    JOB_ID VARCHAR2(10) NOT NULL,
    SALARY NUMBER(10, 2),
    COMMISSION_PCT NUMBER(4, 2),
    MANAGER_ID NUMBER,
    DEPARTMENT_ID NUMBER,
    FOREIGN KEY (JOB_ID) REFERENCES JOBS(JOB_ID),
    FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID),
    FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID)
);

ALTER TABLE DEPARTMENTS
ADD CONSTRAINT fk_dept_manager
FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID);

CREATE TABLE JOB_HISTORY (
    EMPLOYEE_ID NUMBER,
    START_DATE DATE,
    END_DATE DATE NOT NULL,
    JOB_ID VARCHAR2(10) NOT NULL,
    DEPARTMENT_ID NUMBER,
    PRIMARY KEY (EMPLOYEE_ID, START_DATE),
    FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID),
    FOREIGN KEY (JOB_ID) REFERENCES JOBS(JOB_ID),
    FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID)
);

-- ==========================================================
-- 3. MINTAADATOK BESZÚRÁSA (Oracle DATE formátummal)
-- ==========================================================

-- REGIONS
INSERT INTO REGIONS VALUES (1, 'Európa');
INSERT INTO REGIONS VALUES (2, 'Amerika');
INSERT INTO REGIONS VALUES (3, 'Ázsia');

-- COUNTRIES
INSERT INTO COUNTRIES VALUES ('HU', 'Magyarország', 1);
INSERT INTO COUNTRIES VALUES ('DE', 'Németország', 1);
INSERT INTO COUNTRIES VALUES ('US', 'Egyesült Államok', 2);
INSERT INTO COUNTRIES VALUES ('JP', 'Japán', 3);

-- LOCATIONS
INSERT INTO LOCATIONS VALUES (1000, 'Andrássy út 12.', '1061', 'Budapest', 'Budapest', 'HU');
INSERT INTO LOCATIONS VALUES (1100, 'Hauptstraße 45.', '10115', 'Berlin', 'Berlin', 'DE');
INSERT INTO LOCATIONS VALUES (1200, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');
INSERT INTO LOCATIONS VALUES (1300, '2017 Shinjuku-ku', '1689', 'Tokió', 'Tokió', 'JP');

-- JOBS
INSERT INTO JOBS VALUES ('AD_PRES', 'Vezérigazgató', 20000.00, 40000.00);
INSERT INTO JOBS VALUES ('IT_PROG', 'Szoftverfejlesztő', 4000.00, 10000.00);
INSERT INTO JOBS VALUES ('SA_MAN', 'Értékesítési vezető', 10000.00, 20000.00);
INSERT INTO JOBS VALUES ('SA_REP', 'Értékesítési képviselő', 6000.00, 12000.00);
INSERT INTO JOBS VALUES ('HR_REP', 'HR munkatárs', 4000.00, 9000.00);

-- DEPARTMENTS
INSERT INTO DEPARTMENTS VALUES (10, 'Vezetőség', NULL, 1000);
INSERT INTO DEPARTMENTS VALUES (20, 'Informatika (IT)', NULL, 1000);
INSERT INTO DEPARTMENTS VALUES (30, 'Értékesítés', NULL, 1100);
INSERT INTO DEPARTMENTS VALUES (40, 'Emberi Erőforrások', NULL, 1200);

-- EMPLOYEES
INSERT INTO EMPLOYEES VALUES (100, 'István', 'Kovács', 'istvan.kovacs@ceg.hu', '+36-30-111-2233', DATE '2020-01-15', 'AD_PRES', 24000.00, NULL, NULL, 10);
INSERT INTO EMPLOYEES VALUES (101, 'Eszter', 'Nagy', 'eszter.nagy@ceg.hu', '+36-30-222-3344', DATE '2021-03-10', 'IT_PROG', 8500.00, NULL, 100, 20);
INSERT INTO EMPLOYEES VALUES (102, 'Gábor', 'Tóth', 'gabor.toth@ceg.hu', '+36-30-333-4455', DATE '2022-06-01', 'IT_PROG', 6200.00, NULL, 101, 20);
INSERT INTO EMPLOYEES VALUES (103, 'Anna', 'Szabó', 'anna.szabo@ceg.de', '+49-151-444-5566', DATE '2021-09-20', 'SA_MAN', 13500.00, 0.20, 100, 30);
INSERT INTO EMPLOYEES VALUES (104, 'Péter', 'Varga', 'peter.varga@ceg.de', '+49-151-555-6677', DATE '2023-02-14', 'SA_REP', 7500.00, 0.15, 103, 30);
INSERT INTO EMPLOYEES VALUES (105, 'Katalin', 'Horváth', 'katalin.horvath@ceg.com', '+1-555-019-8372', DATE '2022-11-05', 'HR_REP', 6500.00, NULL, 100, 40);

-- DEPARTMENTS frissítése
UPDATE DEPARTMENTS SET MANAGER_ID = 100 WHERE DEPARTMENT_ID = 10;
UPDATE DEPARTMENTS SET MANAGER_ID = 101 WHERE DEPARTMENT_ID = 20;
UPDATE DEPARTMENTS SET MANAGER_ID = 103 WHERE DEPARTMENT_ID = 30;
UPDATE DEPARTMENTS SET MANAGER_ID = 105 WHERE DEPARTMENT_ID = 40;

-- JOB_HISTORY
INSERT INTO JOB_HISTORY VALUES (102, DATE '2020-05-01', DATE '2022-05-31', 'HR_REP', 40);
INSERT INTO JOB_HISTORY VALUES (104, DATE '2021-01-10', DATE '2023-02-13', 'IT_PROG', 20);


-- 2.feladat
select * from departments order by department_name asc;


-- 3.feladat
select max_salary from jobs where max_salary > 10000;

-- 5.feladat
select city, state_province from locations where state_province is not null;

-- 8.feladat
select datediff(day, start_date, end_date) as betöltött_idő from job_history;

-- 10.feladat
select upper(region_name)as regiók from regions;

-- 11.feladat
select count(department_id) as reszlegek_szama from departments;

-- 15.feladat
select e.last_name, d.department_name from employees e 
inner join departments d on e.department_id = d.department_id;

-- 16.feladat
select l.city, d.department_name from departments d 
inner join locations l on d.location_id = l.location_id;

-- 17.feladat
select e.first_name, e.last_name, d.department_name, j.job_title from employees e 
inner join departments d on e.department_id = d.department_id
inner join jobs j on e.job_id = j.job_id;

-- 18.feladat
-- Csináltam egy view-t, mert nekem azt írta, hogy nincs ilyen létező view, nem tudom, hogy ez a feladat helyes megoldása vagy sem, de én így tudtam megoldani. AI csinálta a view-t
CREATE VIEW emp_details_view AS
SELECT
  e.employee_id,
  e.job_id,
  e.manager_id,
  e.department_id,
  d.location_id,
  l.country_id,
  e.first_name,
  e.last_name,
  e.salary,
  e.commission_pct,
  d.department_name,
  j.job_title,
  l.city,
  l.state_province,
  c.country_name,
  r.region_name
FROM
  employees e,
  departments d,
  jobs j,
  locations l,
  countries c,
  regions r
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
  AND c.region_id = r.region_id
  AND j.job_id = e.job_id;

select * from emp_details_view where region_name = 'Európa';

DROP VIEW emp_details_view;



-- 19.feladat
-- Itt sem kaptam vissza semmit, így csináltam egyet, AI írta a procedure-t
CREATE PROCEDURE secure_dml AS
BEGIN
  IF (TO_CHAR(SYSDATE, 'HH24:MI') NOT BETWEEN '08:00' AND '18:00') THEN
    RAISE_APPLICATION_ERROR(-20205, 'Csak munkaidőben módosíthatsz adatot!');
  END IF;
END secure_dml;

select line, text from all_source where name = 'SECURE_DML';

DROP PROCEDURE secure_dml;


-- 20.feladat
select table_name, triggering_event, trigger_type, status from all_triggers 
where trigger_name = 'UPDATE_JOB_HISTORY';

-- Pokemon feladat
select * from pokemonok;

declare
    v_nev pokemonok.nev%type;
    v_tipus pokemonok.tipus%type;
begin
    select nev, tipus into v_nev, v_tipus
    from pokemonok order by alap_hp fetch first 1 rows only;
    
    dbms_output.PUT_Line('A legkevesebb életerővel rendelkező pokemon nev: ' || v_nev|| ' tipusa ' || v_tipus);
end;
/

declare
    v_prev_1 number := 0;
    v_current number := 0;
    v_prev_2 number := 0;
BEGIN
  FOR i IN 0..60 LOOP
    v_current := i;
    if (v_current >= 2) then
        v_current := v_prev_2 + v_prev_1;
        dbms_output.put_line(v_current);
        v_prev_2 := v_prev_1;
        v_prev_1 := v_current;
        v_current := i;
    else 
        dbms_output.put_line(v_current);
        v_prev_1 := v_current;
        v_current := i;
    end if;
  END LOOP;
END;
/
    


