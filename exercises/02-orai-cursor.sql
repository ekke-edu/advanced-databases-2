-- jogosultságok engedélyezése, ha blokkolva van:
-- alter user sajátkód identified by "jelszó" account unlock;

-- cursor lényege, hogy több kimeneti adatot tudunk felhasználni

--------------------------------------
-- I. Kurzorok (Több sor feldolgozása)
--------------------------------------

-- 1. Írj egy PL/SQL blokkot, amelyben deklarálsz egy kurzort (c_pokemonok). A kurzor kérdezze le az összes Pokémon nevét és típusát a pokemonok táblából. Egy FOR ciklus segítségével iterálj végig a kurzoron, és írasd ki az adatokat "Név - Típus" formátumban!

-- azért for ciklus, mert akkor nem kell megnyitni - használni - lezárni. ezt kezeli nekünk a for ciklus

DECLARE 
    CURSOR c_pokemonok IS  -- a c-vel jelzem, hogy ez cursor IS olyan, mint a := a pszeudokódban
        SELECT nev, tipus FROM pokemonok;
    BEGIN 
        FOR r_pokemon IN c_pokemonok LOOP  -- az r csak egy saját magunknak jelzés, hogy rekordról van szó
            DBMS_OUTPUT.PUT_LINE(r_pokemon.nev || ' - ' || r_pokemon.tipus);
        END LOOP;
    END;
    /

-- 2. Készíts egy paraméteres kurzort! A kurzor neve legyen c_edzok, paraméterként kapjon egy régió nevet (p_regio), és listázza ki az adott régióba tartozó edzők neveit. Futtasd le a kurzort a 'Kanto' régióra, és írasd ki az eredményeket!


-- c_edzok('Kanto');

-- DECLARE 
--     CURSOR c_edzok(p_regio VARCHAR2) IS -- VARCHAR2 többet enged
--         SELECT nev
--         FROM edzok 
--         WHERE regio = p_regio;
-- BEGIN 
--     FOR r_edzo IN c_edzok(p_regio) LOOP 
--         DBMS_OUTPUT.PUT_LINE(p_regio || ' ' || 'edzők: ' || r_edzo.nev);
--     END LOOP;
-- END;
-- /


-- kiegészítés -> for ciklus nélkül

DECLARE 
    CURSOR c_edzok(p_regio VARCHAR2) IS
        SELECT nev
        FROM edzok 
        WHERE regio = p_regio;
    v_edzo_nev edzok.nev%TYPE;
BEGIN 
    OPEN c_edzok('Kanto');
    LOOP 
        FETCH c_edzok INTO v_edzo_nev; -- megnyitjuk a kapcsolatot

        EXIT WHEN c_edzok%NOTFOUND; -- lezárjuk a kapcsolatot
        DBMS_OUTPUT.PUT_LINE(v_edzo_nev);
    END LOOP;
END;
/



--------------------------------------
-- II. Kivételkezelés (Hibák elkapása)
--------------------------------------

-- 3. Készíts egy blokkot, amely beolvassa a 999-es azonosítójú Pokémon nevét egy változóba, majd kiírja azt. (Mivel ilyen ID nincs, a program hibára fog futni). Írj a blokk végére egy kivételkezelő részt (EXCEPTION), kapd el a NO_DATA_FOUND hibát, és a hibaüzenet helyett írd ki: "Nem található ilyen Pokémon a Pokedexben!"

DECLARE -- használhatnánk kurzort is, de tudjuk, hogy pontosan 1-ről van szó
    v_nev pokemonok.nev%TYPE;
    -- segíség a 5-eshez: e_pontszam exception; -- a típusa exception, ha hiba van 
BEGIN 
    SELECT nev 
    INTO v_nev 
    FROM pokemonok 
    -- WHERE id = 999;
    WHERE POKEDEX_SZAM = 999;
    -- segítség a 5-eshez: raise e_pontszam;
    DBMS_OUTPUT.PUT_LINE('Név: ' || v_nev);

EXCEPTION 
    -- when e_pontszam, then ..... hibakezelés
    WHEN NO_DATA_FOUND THEN 
    DBMS_OUTPUT.PUT_LINE('Not found!');
END;
/



---------------------------------- innentől HF --

-- 4. Próbálj meg beolvasni egy változóba olyan Pokémon nevet, aminek a típusa 'Tűz'. (Mivel a korábbi feladatokban több Tűz típusút is beszúrtunk, ez hibát fog dobni). Kapd el a TOO_MANY_ROWS kivételt, és írd ki: "Egyszerre több sor is érkezett, használj kurzort!"
-- HF 
-- ha csak egy tűz van, csináljunk többet, hogy hibát dobjon!
-- declare lekérdezés, select into változóba mentés, EXCEPTION


-- 5. Hozz létre egy saját, egyéni kivételt! Olvasd be az 1-es azonosítójú edző tapasztalati pontját. Ha ez az érték pontosan 1500, akkor válts ki (RAISE) egy saját, e_gyanus_pontszam nevű kivételt! A kivételkezelő ágban kapd el, és írd ki: "Túl kerek ez a pontszám, valami gyanús!"
-- HF
-- váltsuk ki a hibát! ha nincs 1500, akkor kérdezzük le a 7-est
-- edző pontja elmentés select into, vizsgálat, jó/nem jó exception. a gyanús pontszámot el kell rakni és kiíratni


--------------------------------------------
-- III. Adatmódosítás kurzorral (FOR UPDATE)
--------------------------------------------

--     Készíts egy kurzort, amely lekérdezi a 'Normál' típusú Pokémonok alap HP-ját (alap_hp) a táblából. Használd a FOR UPDATE záradékot a kurzor deklarációjánál! Iterálj végig a sorokon, és minden érintett Pokémon HP-ját növeld meg 10-zel egy UPDATE utasítás segítségével, amely a WHERE CURRENT OF szerkezetet használja! A blokk végén véglegesítsd a tranzakciót (COMMIT), és írasd ki, hogy "A Normál típusok buffot kaptak!"
