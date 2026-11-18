-----------------------------------
-- I. Tárolt Függvények (Functions)
-----------------------------------

-- 1. Készíts egy fn_edzo_xp nevű tárolt függvényt, amely paraméterként vár egy edző azonosítót (p_edzo_id), és visszatérési értékként (RETURN NUMBER) megadja az adott edző tapasztalati pontját! (Kezeld le a NO_DATA_FOUND kivételt: ha nincs ilyen edző, térjen vissza 0-val!) Írj egy teszt lekérdezést is (pl. SELECT fn_edzo_xp(1) FROM DUAL;)!
CREATE OR REPLACE FUNCTION fn_edzo_xp (
    p_edzo_id IN NUMBER
)
RETURN NUMBER
IS
    v_xp NUMBER;
BEGIN
    SELECT e.tapasztalat_pont
    INTO   v_xp
    FROM   edzok e
    WHERE  e.edzo_id = p_edzo_id;

    RETURN v_xp;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END fn_edzo_xp;
/
-- ellenőrzés
SELECT fn_edzo_xp(1) AS tapasztalati_pont
FROM   DUAL;

-- 2. Írj egy fn_pokemon_szam nevű függvényt, amely egy edző azonosítóját kapja meg, és összeszámolja a befogasok táblából, hogy az illetőnek hány Pokémonja van! 
CREATE OR REPLACE FUNCTION fn_pokemon_szam (
    p_edzo_id IN NUMBER
)
RETURN NUMBER
IS
    v_darab NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_darab
    FROM   befogasok b
    WHERE  b.edzo_id = p_edzo_id;

    RETURN v_darab;
END fn_pokemon_szam;
/
-- Próbáld ki úgy, hogy egy lekérdezésben listázod az összes edző nevét, mellé téve a függvényhívás eredményét!
SELECT e.nev,
       fn_pokemon_szam(e.edzo_id) AS pokemonok_szama
FROM   edzok e
ORDER BY e.nev;



-------------------------------------
-- II. Tárolt Eljárások (Procedures)
-------------------------------------

-- 3. Készíts egy sp_uj_pokemon nevű tárolt eljárást, amely paraméterként várja egy új Pokémon adatait (p_id, p_nev, p_tipus, p_hp)! Az eljárás szúrja be ezeket az adatokat a pokemonok táblába, és rögtön véglegesítse is (COMMIT). 
CREATE OR REPLACE PROCEDURE sp_uj_pokemon (
    p_id    IN NUMBER,
    p_nev   IN VARCHAR2,
    p_tipus IN VARCHAR2,
    p_hp    IN NUMBER
)
IS
BEGIN
    INSERT INTO pokemonok (
        pokedex_szam,
        nev,
        tipus,
        alap_hp
    )
    VALUES (
        p_id,
        p_nev,
        p_tipus,
        p_hp
    );

    COMMIT;
END sp_uj_pokemon;
/
-- Hívd meg az eljárást, és hozz létre egy 'Mewtwo' nevű Pokémont (id: 150, Pszicho, HP: 106)!
BEGIN
    sp_uj_pokemon(150, 'Mewtwo', 'Pszicho', 106);
END;
/


-- 4. Írj egy eljárást sp_szintlepes néven! Az eljárás paraméterként egy befogás azonosítóját (p_befogas_id) kapja. Növelje meg az adott befogás szintjét 1-gyel! Használd az implicit kurzor SQL%ROWCOUNT attribútumát: ha a módosított sorok száma 0, írja ki a konzolra, hogy "Hiba: Nem létezik ilyen befogás!", egyébként véglegesítse az adatokat és írja ki: "Sikeres szintlépés!"
CREATE OR REPLACE PROCEDURE sp_szintlepes (
    p_befogas_id IN NUMBER
)
IS
BEGIN
    UPDATE befogasok
    SET    szint = szint + 1
    WHERE  befogas_id = p_befogas_id;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Hiba: Nem létezik ilyen befogás!');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Sikeres szintlépés!');
    END IF;
END sp_szintlepes;
/
-- ellenőrzés
SET SERVEROUTPUT ON;

BEGIN
    sp_szintlepes(1);
END;
/

-- 5. Készíts egy sp_edzo_statisztika nevű eljárást, amely bemutatja az OUT paraméterek működését! Bemeneti (IN) paraméterként kapjon egy p_edzo_id-t. Kimeneti (OUT) paraméterként adjon vissza két értéket: az edző nevét (p_nev) és a befogott Pokémonjainak számát (p_db). 
CREATE OR REPLACE PROCEDURE sp_edzo_statisztika (
    p_edzo_id IN  NUMBER,
    p_nev    OUT VARCHAR2,
    p_db     OUT NUMBER
)
IS
BEGIN
    SELECT e.nev
    INTO   p_nev
    FROM   edzok e
    WHERE  e.edzo_id = p_edzo_id;

    SELECT COUNT(*)
    INTO   p_db
    FROM   befogasok b
    WHERE  b.edzo_id = p_edzo_id;
END sp_edzo_statisztika;
/
-- Írj egy névtelen blokkot, ahol változókat deklarálsz, meghívod velük az eljárást, majd kiíratod a kapott értékeket!
SET SERVEROUTPUT ON;

DECLARE
    v_nev edzok.nev%TYPE;
    v_db  NUMBER;
BEGIN
    sp_edzo_statisztika(1, v_nev, v_db); -- 1 helyére bármi mehet

    DBMS_OUTPUT.PUT_LINE('Edző neve: ' || v_nev);
    DBMS_OUTPUT.PUT_LINE('Befogott Pokémonok száma: ' || v_db);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Hiba: Nem létezik ilyen edző!');
END;
/