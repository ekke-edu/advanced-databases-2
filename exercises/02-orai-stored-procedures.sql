-----------------------------------
-- I. Tárolt Függvények (Functions)
-----------------------------------

-- 1. Készíts egy fn_edzo_xp nevű tárolt függvényt, amely paraméterként vár egy edző azonosítót (p_edzo_id), és visszatérési értékként (RETURN NUMBER) megadja az adott edző tapasztalati pontját! (Kezeld le a NO_DATA_FOUND kivételt: ha nincs ilyen edző, térjen vissza 0-val!) Írj egy teszt lekérdezést is (pl. SELECT fn_edzo_xp(1) FROM DUAL;)!


CREATE OR REPLACE FUNCTION fn_edzo_xp (p_edzo_id IN NUMBER)
RETURN NUMBER
IS
    v_xp edzok.tapasztalat_pont%TYPE;
BEGIN
    SELECT tapasztalat_pont
    INTO   v_xp
    FROM   edzok
    WHERE  pokedex_szam = p_edzo_id; -- nálam nem id, hanem pokedex_szam

    RETURN v_xp;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/
-- ellenőrzés
SELECT fn_edzo_xp(1)
FROM   DUAL;


-- 2. Írj egy fn_pokemon_szam nevű függvényt, amely egy edző azonosítóját kapja meg, és összeszámolja a befogasok táblából, hogy az illetőnek hány Pokémonja van! 

CREATE OR REPLACE FUNCTION fn_pokemon_szam (p_edzo_id IN NUMBER)
RETURN NUMBER IS v_darab NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_darab
    FROM   befogasok
    WHERE  edzo_id = p_edzo_id;

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
        pokedex_szam, -- itt nem id, mert a táblában nem az van
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

-- meghívás így történik 
EXECUTE sp_uj_pokemon(4,'Teszt','Föld', 43);


-- innentől HF---------

-- 4. Írj egy eljárást sp_szintlepes néven! Az eljárás paraméterként egy befogás azonosítóját (p_befogas_id) kapja. Növelje meg az adott befogás szintjét 1-gyel! Használd az implicit kurzor SQL%ROWCOUNT attribútumát: ha a módosított sorok száma 0, írja ki a konzolra, hogy "Hiba: Nem létezik ilyen befogás!", egyébként véglegesítse az adatokat és írja ki: "Sikeres szintlépés!"

-- exeption-nal oldjuk meg, nem sima if-fel



-- 5. Készíts egy sp_edzo_statisztika nevű eljárást, amely bemutatja az OUT paraméterek működését! Bemeneti (IN) paraméterként kapjon egy p_edzo_id-t. Kimeneti (OUT) paraméterként adjon vissza két értéket: az edző nevét (p_nev) és a befogott Pokémonjainak számát (p_db). 

-- Írj egy névtelen blokkot, ahol változókat deklarálsz, meghívod velük az eljárást, majd kiíratod a kapott értékeket!
