-- Kurzor feladatok

-- 4.Feladat
-- Adatokat ai-al generáltattam
INSERT INTO pokemonok (id, nev, tipus, alap_hp) VALUES (5, 'Charmeleon', 'Tűz', 58);
INSERT INTO pokemonok (id, nev, tipus, alap_hp) VALUES (6, 'Charizard', 'Tűz', 78);
INSERT INTO pokemonok (id, nev, tipus, alap_hp) VALUES (37, 'Vulpix', 'Tűz', 38);
INSERT INTO pokemonok (id, nev, tipus, alap_hp) VALUES (58, 'Growlithe', 'Tűz', 55);

declare
    v_nev pokemonok.nev%type;
begin
    select nev 
    into v_nev
    from pokemonok
    where tipus = 'Tűz';

    dbms_output.put_line('A Pokémon neve: ' || v_nev);

exception
    when TOO_MANY_ROWS then
        dbms_output.put_line('Egyszerre több sor is érkezett, használj kurzort');
end;
/

-- 5.Feladat
declare
    v_tapasztalat_pont edzok.tapasztalat_pont%type;
    
    e_gyanus_pontszam EXCEPTION;
begin
    select tapasztalat_pont
    into v_tapasztalat_pont
    from edzok
    where id = 1;
    
    if v_tapasztalat_pont = 15000 then
        raise e_gyanus_pontszam;
    end if;
    
    dbms_output.put_line('Az edző pontszáma: ' || v_tapasztalat_pont);
    
exception
    WHEN e_gyanus_pontszam THEN
        DBMS_OUTPUT.PUT_LINE('Túl kerek ez a pontszám, valami gyanús!');
end;
/

-- 6.Feladat
-- Itt is ai generálta az inserteket
INSERT INTO pokemonok (id, nev, tipus, alap_hp) VALUES (5, 'Snorlax', 'Normál', 160);
INSERT INTO pokemonok (id, nev, tipus, alap_hp) VALUES (2, 'Eevee', 'Normál', 55);
INSERT INTO pokemonok (id, nev, tipus, alap_hp) VALUES (3, 'Jigglypuff', 'Normál', 115);


declare
   cursor c_normal_pokemonok_hp is
    select alap_hp from pokemonok where tipus = 'Normál' for update of alap_hp;
    
    v_hp pokemonok.alap_hp%TYPE;
begin
    open c_normal_pokemonok_hp;
    loop
        fetch c_normal_pokemonok_hp into v_hp;
        exit when c_normal_pokemonok_hp%NOTFOUND;
    
        update pokemonok
        set alap_hp = v_hp + 10
        where current of c_normal_pokemonok_hp;
    end loop;
    close c_normal_pokemonok_hp;

    commit;
    dbms_output.put_line('A Normál típusok buffot kaptak!');
end;
/

-- Tárolt eljárások

-- 4.Feladat

-- Procedure
CREATE OR REPLACE PROCEDURE SP_SZINTLEPES 
(
  P_BEFOGAS_ID IN NUMBER 
) AS 
BEGIN
  update befogasok set szint = szint + 1 where befogasok.id = p_befogas_id;
  if sql%ROWCOUNT = 0 then
        dbms_output.put_line('Hiba: Nem létezik ilyen befogás!');
    else
        commit;
        dbms_output.put_line('Sikeres szintlépés!');
    end if;
END SP_SZINTLEPES;

-- Lefut
execute sp_szintlepes(1);

-- Hibát dob
execute sp_szintlepes(2);

-- 5.Feladat

-- Procedure
CREATE OR REPLACE PROCEDURE SP_EDZO_STATISZTIKA 
(
  P_EDZO_ID IN NUMBER 
, P_NEV OUT VARCHAR2 
, P_DB OUT NUMBER 
) AS 
BEGIN
  select e.nev, count(b.id)
    into p_nev, p_db
    from edzok e
    inner join befogasok b on e.id = b.edzo_id
    where e.id = p_edzo_id
    group by e.nev;
END SP_EDZO_STATISZTIKA;

-- Névtelen block 
declare
    v_edzo_id number := 1;
    v_nev     edzok.nev%type;
    v_db      number;
begin
    sp_edzo_statisztika(
        p_edzo_id => v_edzo_id,
        p_nev     => v_nev,
        p_db      => v_db
    );

    dbms_output.put_line('Edző neve: ' || v_nev);
    dbms_output.put_line('Befogott Pokémonok száma: ' || v_db);
end;
/

-- Triggerek

-- 4.Feladat

-- Trigger
CREATE OR REPLACE TRIGGER TRG_XP_VEDELEM 
BEFORE UPDATE OF tapasztalat_pont ON edzok FOR EACH ROW
BEGIN
  if :new.tapasztalat_pont < 0 then
    RAISE_APPLICATION_ERROR(-20001,
      'XP nem lehet negatív');
  end if;
END;
/

-- 5.Feladat

-- Ellenőrzés
update edzok set tapasztalat_pont = -50 where id = 1;

select * from edzok;

-- Egy kérdésem lenne. Feltűnhetett, hogy én kicsivel írom az SQL-utasításokat. Na most engem eddig nem zavart, de most, mivel pl. a procedure-nél az automatikusan
-- legenerált utasítások nagybetűvel vannak, és ez már zavar engem is, hogy hol kicsivel, hol naggyal vannak írva, ezért érdemes áttérni nekem is nagybetűkre?
-- A gyakorlatban mennyire írnak az emberek kisbetűvel lekérdezéseket? A választ előre is köszönöm!
