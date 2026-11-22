--kurzor
--4
DECLARE
v_nev pokemonok.nev%TYPE;
BEGIN
select nev into v_nev from pokemonok where tipus = 'Tűz';
DBMS_OUTPUT.PUT_LINE('Név: ' || v_nev);
EXCEPTION
    when TOO_MANY_ROWS then 
DBMS_OUTPUT.PUT_LINE('Egyszerre több sor is érkezett, használj kurzort!');
END;
/

--5
DECLARE
v_tapasztalat_pont edzok.tapasztalat_pont%TYPE;
e_gyanus_pontszam EXCEPTION;
BEGIN
select tapasztalat_pont into v_tapasztalat_pont from edzok where id = 1;
if v_tapasztalat_pont = 1500 then raise e_gyanus_pontszam;
end if;

EXCEPTION
    when e_gyanus_pontszam then
        DBMS_OUTPUT.PUT_LINE('Túl kerek ez a pontszám, valami gyanús!');
END;
/

--6
DECLARE
cursor c_normal is
    select alap_hp
    from pokemonok
    where tipus = 'Normál'
    for update of alap_hp;
BEGIN
    for r in c_normal loop 
    update pokemonok
    set alap_hp = r.alap_hp +10
    where current of c_normal;
  END LOOP;
COMMIT;
DBMS_OUTPUT.PUT_LINE('A Normál típusok buffot kaptak!');
END;
/

--tárolt eljárás
--4
CREATE OR REPLACE PROCEDURE sp_szintlepes (
    p_befogas_id IN befogasok.id%TYPE
) IS
BEGIN
    update befogasok
       set szint = szint + 1
     where id = p_befogas_id;

    if SQL%ROWCOUNT = 0 then
        DBMS_OUTPUT.PUT_LINE('Hiba: Nem létezik ilyen befogás!');
    else
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Sikeres szintlépés!');
    end if;
END sp_szintlepes;
/

--5
CREATE OR REPLACE PROCEDURE sp_edzo_statisztika (
    p_edzo_id IN  NUMBER,
    p_nev     OUT VARCHAR2,
    p_db      OUT NUMBER
) IS
BEGIN
    select nev
      into p_nev
      from edzok
     where id = p_edzo_id;

    select count(*)
      into p_db
      from befogasok
     where id = p_edzo_id;
END;
/

--teszt
DECLARE
    v_nev VARCHAR2(50);
    v_db  NUMBER;
BEGIN
    sp_edzo_statisztika(1, v_nev, v_db);

    DBMS_OUTPUT.PUT_LINE('Edző neve: ' || v_nev);
    DBMS_OUTPUT.PUT_LINE('Befogott Pokémonok száma: ' || v_db);
END;
/

--triggerek
--4
CREATE OR REPLACE TRIGGER trg_xp_vedelem
BEFORE UPDATE OF tapasztalat_pont ON edzok
FOR EACH ROW
BEGIN
    IF :NEW.tapasztalat_pont < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Hiba: A tapasztalati pont nem lehet negatív!');
    END IF;
END;
/

--5, teszt
UPDATE edzok
   set tapasztalat_pont = -10
 where id = 1;

SELECT id, nev, tapasztalat_pont
  from edzok
where id = 1;