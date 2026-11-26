-- ===== --
-- cursorok

-- 4. feladat
declare
    v_nev pokemonok.nev%type;
begin
    select nev into v_nev
    from pokemonok
    where tipus = 'Tűz';
    
exception
    when too_many_rows then
        dbms_output.put_line('Egyszerre több sor is érkezett, használj kurzort!');
end;
/

-- 5.feladat
declare
    v_tapasztalati_pont edzok.tapasztalati_pont%type;
    invalid_experiment_points exception;
begin
    select tapasztalati_pont into v_tapasztalati_pont
    from edzok
    where id = 1;
    
    if v_tapasztalati_pont = 1500 then
        raise invalid_experiment_points;
    end if;
    
exception 
    when invalid_experiment_points then
        dbms_output.put_line('Túl kerek ez a pontszám, valami gyanús!');
end;
/

-- 6. feladat
declare
    cursor c_pokemonok_hp is
        select alap_hp
        from pokemonok
        where tipus = 'Normál'
        for update;
begin
    for pokemon in c_pokemonok_hp
    loop
        update pokemonok
        set alap_hp = pokemonok.alap_hp + 10
        where current of c_pokemonok_hp;
    end loop;
    
    commit;
    
    dbms_output.put_line('A Normál típusú pokemonok buffot kaptak!');
end;
/


-- ======= --
-- procedures

-- 4. feladat
create or replace procedure sp_szintlepes
(
    p_befogas_id befogasok.id%type
)
is
begin
    update befogasok
    set szint = szint + 1
    where id = p_befogas_id;
    
    if sql%rowcount = 0 then
        dbms_output.put_line('Hiba: nem létezik ilyen befogás');
    else
        dbms_output.put_line('Sikeres szintlépés');
    end if;
    
end;
/

exec sp_szintlepes(2);

select * from befogasok;

-- 5. feladat
create or replace procedure sp_edzo_statisztika
(
    p_ezdo_id in edzok.id%type,
    p_nev out edzok.nev%type,
    p_db out number
)
is
begin
    select nev into p_nev
    from edzok
    where id = p_ezdo_id;
    
    select count(*) into p_db
    from befogasok
    where edzo_id = p_ezdo_id;
end;
/

declare
    v_nev edzok.nev%type;
    v_db number;
begin
    sp_edzo_statisztika(1, v_nev, v_db);
    
    dbms_output.put_line('Edző neve: ' || v_nev || ', Pokemonok száma: ' || v_db);
end;
/

-- ===== --
-- triggers

-- 4. feladat
select * from edzok;

create or replace trigger trg_xp_vedelem
before update of tapasztalati_pont on edzok
for each row
begin
    if :NEW.tapasztalati_pont < 0 then
        raise_application_error (-20001, 'Tapasztalati pont nem lehet negatív!');
    end if;
end;
/

-- 5. feladat
select * from edzok;

update edzok
set tapasztalati_pont =  -50
where id = 1;

select * from edzok;
