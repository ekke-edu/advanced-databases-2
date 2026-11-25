--Kurzoros dógok
--1. Írj egy PL/SQL blokkot, amelyben deklarálsz egy kurzort (c_pokemonok). 
--A kurzor kérdezze le az összes Pokémon nevét és típusát a pokemonok táblából. 
--Egy FOR ciklus segítségével iterálj végig a kurzoron, és írasd ki az adatokat "Név - Típus" formátumban!

SET SERVEROUTPUT ON;

DECLARE
    Cursor c_pokemonok IS
        SELECT nev, tipus
        FROM pokemonok;
BEGIN
    FOR r in c_pokemonok LOOP
        DBMS_OUTPUT.PUT_LINE(r.nev || ' - ' || r.tipus);
    End LOOP;
END;
/

--2. Készíts egy paraméteres kurzort! 
--A kurzor neve legyen c_edzok, paraméterként kapjon egy régió nevet (p_regio), és listázza ki az adott régióba tartozó edzők neveit.
--Futtasd le a kurzort a 'Kanto' régióra, és írasd ki az eredményeket!

DECLARE
    CURSOR c_edzok(p_regio VARCHAR2) is
        SELECT nev
        FROM edzok
        WHERE regio = p_regio;
Begin
    FOR r in c_edzok('Kanto') LOOP
        DBMS_OUTPUT.PUT_LINE(r.nev);
    END Loop;
END;
/

--3. Készíts egy blokkot, amely beolvassa a 999-es azonosítójú Pokémon nevét egy változóba, majd kiírja azt.
--(Mivel ilyen ID nincs, a program hibára fog futni).
--Írj a blokk végére egy kivételkezelő részt (EXCEPTION)
--kapd el a NO_DATA_FOUND hibát, és a hibaüzenet helyett írd ki: "Nem található ilyen Pokémon a Pokedexben!"

DECLARE
    v_nev pokemonok.nev%TYPE;
BEGIN
    SELECT nev
    INTO v_nev
    FROM pokemonok
    WHERE id = 999;

    DBMS_OUTPUT.PUT_LINE(v_nev);
EXCEPTION
    when NO_DATA_FOUND then
        DBMS_OUTPUT.PUT_LINE('Nem található ilyen Pokémon a Pokedexben!');
end;
/

--4.Próbálj meg beolvasni egy változóba olyan Pokémon nevet, aminek a típusa 'Tűz'.
--(Mivel a korábbi feladatokban több Tűz típusút is beszúrtunk, ez hibát fog dobni).
--Kapd el a TOO_MANY_ROWS kivételt, és írd ki: "Egyszerre több sor is érkezett, használj kurzort!"

DECLARE
    v_nev pokemonok.nev%Type;
BEGIN
    SELECT nev
    INTO v_nev
    FROM pokemonok
    WHERE tipus = 'Tűz';

    DBMS_OUTPUT.PUT_LINE(v_nev);
Exception
    WHEN TOO_MANY_ROWS then
        DBMS_OUTPUT.PUT_LINE('Egyszerre több sor is érkezett, használj kurzort!');
END;
/

--5. Hozz létre egy saját, egyéni kivételt! 
--Olvasd be az 1-es azonosítójú edző tapasztalati pontját.
--Ha ez az érték pontosan 1500, akkor válts ki (RAISE) egy saját, e_gyanus_pontszam nevű kivételt! 
--A kivételkezelő ágban kapd el, és írd ki: "Túl kerek ez a pontszám, valami gyanús!"

DECLARE
    v_xp edzok.tapasztalat_pont%TYPE;
    e_gyanus_pontszam EXCEPTION;
BEGIN
    select tapasztalat_pont
    into v_xp
    from edzok
    where id = 1;

    IF v_xp = 1500 THEN
        RAISE e_gyanus_pontszam;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Edző XP: ' || v_xp);
EXCEPTION
    When e_gyanus_pontszam Then
        DBMS_OUTPUT.PUT_LINE('Túl kerek ez a pontszám, valami gyanús!');
END;
/

--6. Készíts egy kurzort, amely lekérdezi a 'Normál' típusú Pokémonok alap HP-ját (alap_hp) a táblából.
--Használd a FOR UPDATE záradékot a kurzor deklarációjánál!
--Iterálj végig a sorokon, és minden érintett Pokémon HP-ját növeld meg 10-zel egy UPDATE utasítás segítségével,
--amely a WHERE CURRENT OF szerkezetet használja!
--A blokk végén véglegesítsd a tranzakciót (COMMIT), és írasd ki, hogy "A Normál típusok buffot kaptak!"

DECLARE
    CURSOR c_norm Is
        SELECT alap_hp
        FROM pokemonok
        WHERE tipus = 'Normál'
        FOR UPDATE;
BEGIN
    For r IN c_norm LOOP
        UPDATE pokemonok
        SET alap_hp = alap_hp + 10
        Where Current Of c_norm;
    END Loop;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('A Normál típusok buffot kaptak!');
END;
/

--_-__--____-_Tárolt Függvények, Eljárások INNENTŐL _-_-_-__---__

--1. Készíts egy fn_edzo_xp nevű tárolt függvényt, 
--amely paraméterként vár egy edző azonosítót (p_edzo_id), 
--és visszatérési értékként (RETURN NUMBER) megadja az adott edző tapasztalati pontját! 
--(Kezeld le a NO_DATA_FOUND kivételt: ha nincs ilyen edző, térjen vissza 0-val!)
--Írj egy teszt lekérdezést is (pl. SELECT fn_edzo_xp(1) FROM DUAL;)!

CREATE OR REPLACE FUNCTION fn_edzo_xp(
    p_edzo_id IN NUMBER
) RETURN NUMBER IS
    v_xp edzok.tapasztalat_pont%TYPE;
BEGIN
    SELECT tapasztalat_pont
    INTO v_xp
    FROM edzok
    WHERE id = p_edzo_id;

    RETURN v_xp;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/

SELECT fn_edzo_xp(1) FROM DUAL;

--2. Írj egy fn_pokemon_szam nevű függvényt, amely egy edző azonosítóját kapja meg,
--és összeszámolja a befogasok táblából, hogy az illetőnek hány Pokémonja van! 
--Próbáld ki úgy, hogy egy lekérdezésben listázod az összes edző nevét, mellé téve a függvényhívás eredményét!

CREATE OR REPLACE FUNCTION fn_pokemon_szam(
    p_edzo_id IN NUMBER
) Return Number Is
    v_db NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_db
    FROM befogasok
    WHERE edzo_id = p_edzo_id;

    return v_db;
END;
/

SELECT nev, fn_pokemon_szam(id) As pokemon_db
FROM edzok;

--3.Készíts egy sp_uj_pokemon nevű tárolt eljárást, amely paraméterként várja egy új Pokémon adatait (p_id, p_nev, p_tipus, p_hp)!
--Az eljárás szúrja be ezeket az adatokat a pokemonok táblába, és rögtön véglegesítse is (COMMIT).
--Hívd meg az eljárást, és hozz létre egy 'Mewtwo' nevű Pokémont (id: 150, Pszicho, HP: 106)!

CREATE OR REPLACE PROCEDURE sp_uj_pokemon(
    p_id    IN NUMBER,
    p_nev   IN VARCHAR2,
    p_tipus IN VARCHAR2,
    p_hp    IN NUMBER
) IS
BEGIN
    INSERT INTO pokemonok (id, nev, tipus, alap_hp)
    VALUES (p_id, p_nev, p_tipus, p_hp);

    COMMIT;
END;
/

BEGIN
    sp_uj_pokemon(150, 'Mewtwo', 'Pszicho', 106);
END;
/

SELECT * FROM pokemonok WHERE id = 150;

--4.Írj egy eljárást sp_szintlepes néven!
--Az eljárás paraméterként egy befogás azonosítóját (p_befogas_id) kapja.
--Növelje meg az adott befogás szintjét 1-gyel! 
--Használd az implicit kurzor SQL%ROWCOUNT attribútumát: ha a módosított sorok száma 0, írja ki a konzolra, hogy "Hiba: Nem létezik ilyen befogás!"
--egyébként véglegesítse az adatokat és írja ki: "Sikeres szintlépés!"

--SELECT * FROM befogasok; --hogyisvanaz Ájdii

CREATE OR REPLACE PROCEDURE sp_szintlepes(
    p_befogas_id IN NUMBER
) IS
BEGIN
    UPDATE befogasok
    SET szint = szint + 1
    WHERE id = p_befogas_id;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Hiba: Nem létezik ilyen befogás!');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Sikeres szintlépés!');
    END IF;
END;
/

SET SERVEROUTPUT ON;

BEGIN
    sp_szintlepes(1);
    sp_szintlepes(999);
END;
/

--5.Készíts egy sp_edzo_statisztika nevű eljárást, amely bemutatja az OUT paraméterek működését!
--Bemeneti (IN) paraméterként kapjon egy p_edzo_id-t. 
--Kimeneti (OUT) paraméterként adjon vissza két értéket: az edző nevét (p_nev) és a befogott Pokémonjainak számát (p_db).
--Írj egy névtelen blokkot, ahol változókat deklarálsz, meghívod velük az eljárást, majd kiíratod a kapott értékeket!

CREATE OR REPLACE PROCEDURE sp_edzo_statisztika(
    p_edzo_id IN Number,
    p_nev     OUT VARCHAR2,
    p_db      OUT NUMBER
) IS
BEGIN
    SELECT nev
    INTO p_nev
    FROM edzok
    WHERE id = p_edzo_id;

    SELECT COUNT(*)
    Into p_db
    From befogasok
    Where edzo_id = p_edzo_id;
END;
/

DECLARE
    v_nev VARCHAR2(100);
    v_db  Number;
BEGIN
    sp_edzo_statisztika(1, v_nev, v_db);
    DBMS_OUTPUT.PUT_LINE(v_nev || ': ' || v_db || ' db Pokémon');
END;
/

--______.::_.:_-:_---:__- NAPLÓZÁS előtte, utána INNENTŐL___..-::-_:_--___-_-

--1 Hozz létre egy naplo nevű táblát!
--Oszlopai: id (automatikusan generált elsődleges kulcs), 
--esemeny_tipus (szöveg, max 50), leiras (szöveg, max 200),
--és datum (DATE típus, alapértelmezett értéke legyen a rendszer aktuális ideje: DEFAULT SYSDATE).

CREATE TABLE naplo (
    id            NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    esemeny_tipus VARCHAR2(50),
    leiras        VARCHAR2(200),
    datum         DATE DEFAULT SYSDATE
);

--2 Készíts egy trg_szint_naplozas nevű triggert! 
--A trigger fusson le a befogasok táblán történt minden egyes sor szintjének módosítása után (AFTER UPDATE OF szint ON befogasok FOR EACH ROW).
--A trigger szúrjon be egy sort a naplo táblába 'SZINTLÉPÉS' esemény típussal, a leírásban pedig fűzze össze a befogás azonosítóját,
--a régi szintet és az új szintet!

CREATE OR REPLACE TRIGGER trg_szint_naplozas
AFTER UPDATE OF szint ON befogasok
FOR EACH ROW
BEGIN
    INSERT INTO naplo (esemeny_tipus, leiras)
    VALUES (
        'SZINTLÉPÉS',
        'Befogás ID: ' || :NEW.id || ' | Régi szint: ' || :OLD.szint || ' -> Új szint: ' || :NEW.szint
    );
END;
/

--3. Teszteld a triggert!
--Írj egy UPDATE utasítást, ami az 1-es azonosítójú befogás szintjét megnöveli 2-vel. 
--Véglegesítsd (COMMIT), majd kérdezd le a naplo tábla tartalmát, hogy látod-e az automatikusan létrejött bejegyzést!

UPDATE befogasok
Set szint = szint + 2
WHERE id = 1;

COMMIT;

SELECT * FROM naplo; --ottis van !!

--4.Írj egy trg_xp_vedelem nevű triggert!
--Ez az edzok tábla tapasztalat_pont oszlopának frissítése előtt fusson le soronként(BEFORE UPDATE OF tapasztalat_pont ON edzok FOR EACH ROW).
--Vizsgálja meg az új XP értéket: ha az kisebb mint 0, dobjon egy saját hibaüzenetet és állítsa meg a tranzakciót!
--(Használd a RAISE_APPLICATION_ERROR beépített eljárást -20001-es hibakóddal).

CREATE OR REPLACE TRIGGER trg_xp_vedelem
Before Update Of tapasztalat_pont on edzok
FOR EACH ROW
BEGIN
    IF :NEW.tapasztalat_pont < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Hiba: A tapasztalati pont nem lehet negatív!');
    END IF;
END;
/

--5 Teszteld az adatvédelmet!
--Próbálj meg írni egy UPDATE utasítást, amely Ash Ketchum (id: 1) tapasztalati pontját beállítja -50-re.
--Figyeld meg a konzolon megjelenő hibaüzenetet, és ellenőrizd egy SELECT-tel, hogy a módosítás valóban nem történt meg!

UPDATE edzok
SET tapasztalat_pont = -50
WHERE id = 1;

SELECT id, nev, tapasztalat_pont
FROM edzok
WHERE id = 1;