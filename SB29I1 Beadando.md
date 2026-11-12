--1.feladat--
select first_name,last_name,email
from hr.employees;
--2.feladat--
select department_name 
from hr.departments
order by department_name asc; --elhanyagolható, mert alapból abc sorrendbe van
--3.feladat--
select *
from hr.jobs
where max_salary > 10000;
--4.feladat--
select first_name, last_name 
from hr.employees
where manager_id is null;
--5.feladat--
select city,state_province
from hr.locations 
where state_province is not null;
--6.feladat--
select first_name ||''|| last_name as dolgozo_neve,salary *12 as eves_fizetes
from hr.employees;
--7.feladat--
select first_name ||''|| last_name as dolgozo_neve,to_char(hire_date,'YYYY') as felvetel_eve
from hr.employees;
--8.feladat--
select end_date - start_date as idotartam_nap
from hr.job_history;
--9.feladat--
select 
    salary,
case 
    when salary > 8000 then 'Kiemelt'
    else 'Átlagos'
end as besorolas
 from hr.employees;
 --10.feladat--
 select upper(region_name )
 from hr.regions;
 --11.feladat--
 select count(department_id) as reszlegek_szama
 from hr.departments;
 --12.feladat--
 select max(salary) as legnagyobb_fizetes,round(avg(salary),2) as atlag_fizetes
 from hr.employees;
 --13.feladat--
select department_id, count(*) as dolgozok_szama
from hr.employees
group by department_id;
--14.feladat--
select department_id, count(*) as dolgozok_szama
from hr.employees
group by department_id
having avg(salary) >= 7000;
--15.feladat--
select 
    e.last_name,
    d.department_name
from hr.employees e
join hr.departments d
on e.department_id = d.department_id;
--16.feladat--       
select d.department_name,
       c.city
from hr.departments d
join hr.locations c
on d.location_id = c.location_id;
--17.feladat--
select 
    e.firt_name || '' || e.last_name as teljes_nev,
    j.job_tittle,
    d.department_name
from hr.employees e
join hr.jobs j
    on e.job_id=j.job_id
join hr.departments d
    on e.department_id =d.department_id;
--18.feladat--    
select *
from hr.emp_details_view
where region_name = 'Europe';
--19.feladat--
select *
from all_source
where name = 'secure_dml' and type = 'procedure';
 --20.feladat--   
 select *
 from all_triggers
 where trigger_name = 'update_job_history';
 
 --pokemonos--
 
declare
    v_nev pokemonok.nev%type;
    v_tipus pokemonok.tipus%type;
begin
    select nev, tipus
    into v_nev, v_tipus
    from pokemonok
    where alap_hp = (select min(alap_hp) from pokemonok);

    dbms_output.put_line(v_nev);
    dbms_output.put_line(v_tipus);
end;
/
--fibonacci függvény 10 számmal
 declare 
  a number := 0;
  b number := 1;
  c number;
begin
 for i in 1..10 loop
    dbms_output.put_line(a);
    
    c := a+b;
    a := b;
    b := c;
end loop;
end;
/
 



 
 
 


