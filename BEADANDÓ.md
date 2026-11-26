-- 1. feladat 
select FIRST_NAME,LAST_NAME,EMAIL from HR.EMPLOYEES;

-- 2. feladat
select department_name from hr.departments order by department_name asc;

-- 3. feladat
select * from jobs where max_salary > 10000;

-- 4. feladat
select FIRST_NAME,LAST_NAME,EMAIL from hr.employees where manager_id is null;

-- 5. feladat
select city, state_province from locations where state_province is not null;

-- 6. feladat
select  first_name || ' ' || last_name as fullname, salary * 12 as fizu from hr.employees;

-- 7. feladat
select first_name, extract(year from hire_date) as felvetel_datum from hr.employees;

-- 8. feladat
select *, end_date - start_date as NAPOK_SZAMA from job_history;

-- 9. feladat
select first_name, salary, 
       case 
             when salary > 8000 then 'Kiemelt'
             else 'Átlagos'
       end
       as Riport
from hr.employees;

-- 10. feladat
select upper(region_name) from regions;

-- 11. feladat
select count(department_id) as RÉSZLEGEK_SZÁMA from departments;

-- 12. feladat
select min(salary) as lowest_salary, max(salary), max(salary) as highest_salary, round(avg(salary),2) as avg_salary
from hr.employees;

-- 13. feladat
select department_id, count(employee_id) as employees from hr.employees group by department_id;

-- 14. feladat
select department_id, avg(salary) as avg_salary from hr.employees group by department_id 
having avg(salary) > 7000;

-- 15. feladat
select employees.last_name, departments.department_name from employees inner join departments on employees.department_id = departments.department_id;

-- 16. feladat
select departments.department_name, locations.city from departments inner join locations on departments.location_id = locations.location_id;

-- 17. feladat
select employees.first_name, employees.last_name, jobs.job_title, departments.department_name from employees 
inner join jobs on employees.job_id = jobs.job_id
inner join departments on employees.department_id = departments.department_id;

-- 18. feladat
select first_name, last_name, region_name from hr.emp_details_view where region_name = 'Europe';

-- 19. feladat
select line, text from all_source where owner = 'HR' and name ='SECURE_DML' and type = 'PROCEDURE' order by line;

-- 20. feladat
select table_name, triggering_event, trigger_type from all_triggers 
where owner = 'HR' and trigger_name = 'UPDATE_JOB_HISTORY';


-- pokemonok tábla legkisebb alap_hp lekérés
DECLARE
    v_alap_hp pokemonok.alap_hp%type := 1000000;
    v_nev pokemonok.nev%type;
    v_tipus pokemonok.tipus%type;
BEGIN
    for pokemon in (select * from pokemonok)
    LOOP
        if pokemon.alap_hp < v_alap_hp then
            v_alap_hp := pokemon.alap_hp;
            v_nev := pokemon.nev;
            v_tipus := pokemon.tipus;
        end if;
    END LOOP;
    
    dbms_output.put_line(v_nev || ' pokemon rendelkezik a legkisebb HP-val, a tiipusa: ' || v_tipus);
END;
/

-- fibonacci
DECLARE
    v_szam_1 number := 0;
    v_szam_2 number := 1;
    v_szam_temp number;
BEGIN
    for i in 1..10
    loop
        dbms_output.put_line(v_szam_1);
        
        v_szam_temp := v_szam_1 + v_szam_2;
        v_szam_1 := v_szam_2;
        v_szam_2 := v_szam_temp;
    end loop;
END;
/