----------------------------------
-- I. Változók és alapvető blokkok
----------------------------------

-- 1. rj egy névtelen PL/SQL blokkot, amely a DBMS_OUTPUT.PUT_LINE segítségével kiírja a konzolra: "Üdvözöllek a PL/SQL világában!"

SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Üdvözöllek a PL/SQL világában!');
END;
/

-- 2. Készíts egy blokkot, amelyben deklarálsz egy szöveges változót (v_nev) 'Pikachu' értékkel, és egy szám típusú változót (v_szint) 10-es értékkel. Írasd ki őket egy mondatba fűzve!

SET SERVEROUTPUT ON;

DECLARE
    v_nev VARCHAR2(50) := 'Pikachu';
    v_szint NUMBER := 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_nev || ' szintje: ' || v_szint);
END;
/

-- 3. Deklarálj egy v_edzo_nev változót az edzok tábla nev oszlopának típusával (%TYPE). Adj neki tetszőleges értéket, és írasd ki!

SET SERVEROUTPUT ON;

DECLARE
    v_edzo_nev edzok.nev%TYPE := 'Kiss Pista';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Az edző neve: ' || v_edzo_nev);
END;
/


-------------------------------------------------------------------------
-- II. Adatbázis adatok beolvasása (SELECT INTO) és Vezérlési szerkezetek
-------------------------------------------------------------------------

-- 4. Írj egy blokkot, amely beolvassa a 25-ös azonosítójú Pokémon (Pikachu) alap HP-ját a pokemonok táblából egy változóba, majd kiírja azt!

SET SERVEROUTPUT ON;

DECLARE
    v_hp pokemonok.alap_hp%TYPE;
BEGIN
    SELECT p.alap_hp
    INTO v_hp
    FROM pokemonok p
    WHERE p.id = 25;

    DBMS_OUTPUT.PUT_LINE('Pikachu alap HP-ja: ' || v_hp);
END;
/

-- 5. Kérdezd le az 1-es azonosítójú edző (Ash Ketchum) tapasztalati pontját (tapasztalat_pont) egy változóba! Írj egy IF-ELSIF-ELSE szerkezetet: ha az XP > 2000, írja ki, hogy "Mester", ha > 1000, akkor "Haladó", egyébként "Kezdő"!

SET SERVEROUTPUT ON;

DECLARE
    v_xp edzok.tapasztalat_pont%TYPE;
BEGIN
    SELECT e.tapasztalat_pont
    INTO v_xp
    FROM edzok e
    WHERE e.id = 1;

    IF v_xp > 2000 THEN
        DBMS_OUTPUT.PUT_LINE('Mester');
    ELSIF v_xp > 1000 THEN
        DBMS_OUTPUT.PUT_LINE('Haladó');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Kezdő');
    END IF;
END;
/

-- 6. Deklarálj egy v_tipus változót 'Tűz' kezdőértékkel. Készíts egy CASE szerkezetet (IF nélkül!), ami megvizsgálja a változót: ha 'Tűz', írja ki: "Támadó"; ha 'Víz', akkor "Kiegyensúlyozott"; egyébként "Egyéb".

SET SERVEROUTPUT ON;

DECLARE
    v_tipus VARCHAR2(50) := 'Tűz';
BEGIN
    CASE v_tipus
        WHEN 'Tűz' THEN
            DBMS_OUTPUT.PUT_LINE('Támadó');
        WHEN 'Víz' THEN
            DBMS_OUTPUT.PUT_LINE('Kiegyensúlyozott');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Egyéb');
    END CASE;
END;
/

----------------------------------
-- III. Ciklusok (LOOP, WHILE, FOR)
-----------------------------------

-- 7. Készíts egy egyszerű LOOP ciklust, ami 1-től 5-ig elszámol, és minden lépésben kiírja az aktuális számot! Ne felejtsd el az EXIT WHEN kilépési feltételt!

SET SERVEROUTPUT ON;

DECLARE
    v_szam NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_szam);
        v_szam := v_szam + 1;

        EXIT WHEN v_szam > 5;
    END LOOP;
END;
/

-- 8. Írj egy WHILE ciklust, ami egy v_hp változót növel 10-ről 50-re, tízesével lépkedve, és kiírja az értékeket!

SET SERVEROUTPUT ON;

DECLARE
    v_hp NUMBER := 10;
BEGIN
    WHILE v_hp <= 50 LOOP
        DBMS_OUTPUT.PUT_LINE(v_hp);
        v_hp := v_hp + 10;
    END LOOP;
END;
/

-- 9. Készíts egy FOR ciklust, ami 1-től 3-ig fut. Írja ki a konzolra: "Ciklus iteráció: [szám]"!

SET SERVEROUTPUT ON;

BEGIN
    FOR i IN 1..3 LOOP
        DBMS_OUTPUT.PUT_LINE('Ciklus iteráció: ' || i);
    END LOOP;
END;
/

-- 10. Komplex: Használj egy FOR ciklust (1..3), és minden iterációban szúrj be (INSERT) egy új fiktív Pokémont a pokemonok táblába. Az id legyen 100 + a ciklusváltozó, a neve "Tesztmon " és a ciklusváltozó, a típusa "Normál". A blokk végén véglegesíts (COMMIT)!

SET SERVEROUTPUT ON;

BEGIN
    FOR i IN 1..3 LOOP
        INSERT INTO pokemonok (id, nev, tipus)
        VALUES (100 + i, 'Tesztmon ' || i, 'Normál');
    END LOOP;

    COMMIT;
END;
/