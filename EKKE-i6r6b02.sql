--Meglévő két HR tábla átmásolása 
CREATE TABLE employees AS
SELECT * FROM hr.employees;

CREATE TABLE countries AS
SELECT * FROM hr.countries;

-- Hiányzó 5 tábla létrehozása (AI-al)
CREATE TABLE regions (
    region_id NUMBER
        CONSTRAINT pk_regions PRIMARY KEY,
    region_name VARCHAR2(50)
);

CREATE TABLE locations (
    location_id NUMBER
        CONSTRAINT pk_locations PRIMARY KEY,
    street_address VARCHAR2(100),
    postal_code VARCHAR2(20),
    city VARCHAR2(50),
    state_province VARCHAR2(50),
    country_id CHAR(2)
);

CREATE TABLE departments (
    department_id NUMBER
        CONSTRAINT pk_departments PRIMARY KEY,
    department_name VARCHAR2(50),
    manager_id NUMBER,
    location_id NUMBER
);

CREATE TABLE jobs (
    job_id VARCHAR2(20)
        CONSTRAINT pk_jobs PRIMARY KEY,
    job_title VARCHAR2(50),
    min_salary NUMBER,
    max_salary NUMBER
);

CREATE TABLE job_history (
    employee_id NUMBER,
    start_date DATE,
    end_date DATE,
    job_id VARCHAR2(20),
    department_id NUMBER,
    CONSTRAINT pk_job_history PRIMARY KEY (employee_id, start_date)
);

--Mintaadatok beszúrasa a 5 új táblaba (AI-al)
INSERT INTO regions (region_id, region_name) VALUES (1, 'Europe');
INSERT INTO regions (region_id, region_name) VALUES (2, 'Americas');
INSERT INTO regions (region_id, region_name) VALUES (3, 'Asia');
INSERT INTO regions (region_id, region_name) VALUES (4, 'Africa');

INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id)
VALUES (1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');

INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id)
VALUES (1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US');

INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id)
VALUES (2400, '8204 Arthur St', 'W1U 6AA', 'London', NULL, 'UK');

INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id)
VALUES (2700, 'Váci út 45.', '1134', 'Budapest', NULL, 'HU');

INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES (10, 'Administration', 200, 1700);

INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES (50, 'Shipping', 121, 1700);

INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES (60, 'IT', 103, 1400);

INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES (80, 'Sales', 145, 2400);

INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES (90, 'Executive', 100, 1700);

INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES (100, 'Finance', 108, 1700);

INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
VALUES ('AD_PRES', 'President', 20000, 40000);

INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
VALUES ('AD_VP', 'Administration Vice President', 15000, 30000);

INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
VALUES ('IT_PROG', 'Programmer', 4000, 10000);

INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
VALUES ('FI_MGR', 'Finance Manager', 8200, 16000);

INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
VALUES ('FI_ACCOUNT', 'Accountant', 4200, 9000);

INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id)
VALUES (101, TO_DATE('2018-09-21', 'YYYY-MM-DD'), TO_DATE('2021-10-27', 'YYYY-MM-DD'), 'FI_ACCOUNT', 100);

INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id)
VALUES (102, TO_DATE('2019-01-13', 'YYYY-MM-DD'), TO_DATE('2023-07-24', 'YYYY-MM-DD'), 'IT_PROG', 60);

INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id)
VALUES (103, TO_DATE('2020-03-01', 'YYYY-MM-DD'), TO_DATE('2022-06-15', 'YYYY-MM-DD'), 'FI_MGR', 100);

COMMIT;

--18-ashoz kellett .... (AI helpelt mert ez atom cumi vót)
CREATE OR REPLACE VIEW emp_details_view AS
SELECT employees.employee_id,
       employees.first_name,
       employees.last_name,
       employees.salary,
       departments.department_name,
       locations.city,
       countries.country_name,
       regions.region_name
FROM employees
JOIN departments
    ON employees.department_id = departments.department_id
JOIN locations
    ON departments.location_id = locations.location_id
JOIN countries
    ON locations.country_id = countries.country_id
JOIN regions
    ON countries.region_id = regions.region_id;
    
DELETE FROM regions;

INSERT INTO regions (region_id, region_name) VALUES (10, 'Europe');
INSERT INTO regions (region_id, region_name) VALUES (20, 'Americas');
INSERT INTO regions (region_id, region_name) VALUES (30, 'Asia');
INSERT INTO regions (region_id, region_name) VALUES (40, 'Oceania');
INSERT INTO regions (region_id, region_name) VALUES (50, 'Africa');

UPDATE locations
SET country_id = 'GB'
WHERE location_id = 2400;

COMMIT;

--19 es 20 ashoz legyen már valami
CREATE OR REPLACE PROCEDURE secure_dml IS
BEGIN
    IF TO_CHAR(SYSDATE, 'HH24:MI') NOT BETWEEN '08:00' AND '18:00' THEN
        RAISE_APPLICATION_ERROR(-20205, 'Munkaidőn kívül nem lehet módosítani.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER update_job_history
AFTER UPDATE OF job_id, department_id ON employees
FOR EACH ROW
BEGIN
    NULL;
END;
/