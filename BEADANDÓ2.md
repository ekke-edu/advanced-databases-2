<!--KURZOROK-->

<!--4. FELADAT-->
DECLARE
v_nev pokemonok.NEV%TYPE;
v_tipus pokemonok.TIPUS%TYPE := 'Tűz';
BEGIN
    SELECT nev
    INTO v_nev
    FROM POKEMONOK
    WHERE TIPUS LIKE v_tipus;
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('Egyszerre több sor is érkezett, használj kurzort!');
END;
/

<!--5. FELADAT-->
DECLARE
v_edzo_id edzok.EDZO_ID%TYPE := 1;
v_tapasztalat_pont edzok.TAPASZTALAT_PONT%TYPE;
e_gyanus_pontszam EXCEPTION;
BEGIN
    SELECT tapasztalat_pont
    INTO v_tapasztalat_pont
    FROM edzok
    WHERE edzo_id = v_edzo_id;

    IF v_tapasztalat_pont = 1500 THEN
    RAISE e_gyanus_pontszam;
    END IF;
EXCEPTION
    WHEN e_gyanus_pontszam THEN
    DBMS_OUTPUT.PUT_LINE('Túl kerek ez a pontszám, valami gyanús!');
END;
/

<!--6. FELADAT-->
DECLARE
v_alap_hp pokemonok.ALAP_HP%TYPE;
CURSOR c_pokemonok IS
    SELECT alap_hp
    FROM POKEMONOK
    WHERE tipus LIKE 'Normál'
    FOR UPDATE OF alap_hp;
BEGIN
    OPEN c_pokemonok;
    LOOP
    FETCH c_pokemonok INTO v_alap_hp;
    EXIT WHEN c_pokemonok%NOTFOUND;
    UPDATE POKEMONOK
    SET alap_hp = v_alap_hp + 10
    WHERE CURRENT OF c_pokemonok;
    END LOOP;
    CLOSE c_pokemonok;
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('A Normál típusok buffot kaptak!');
END;
/

<!--TÁROLT ELJÁRÁSOK-->

<!--4. FELADAT-->
CREATE OR REPLACE PROCEDURE sp_szintlepes(p_befogas_id NUMBER) IS
BEGIN
    UPDATE befogasok
    SET szint = szint + 1
    WHERE befogas_id = p_befogas_id;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Hiba: Nem létezik ilyen befogás!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Sikeres szintlépés!');
    END IF;
END;
/

DECLARE
v_jelenlegi_szint befogasok.SZINT%TYPE;
v_uj_szint befogasok.SZINT%TYPE;
BEGIN
    SELECT szint
    INTO v_jelenlegi_szint
    FROM BEFOGASOK
    WHERE BEFOGAS_ID = 1;
    sp_szintlepes(1);
    SELECT szint
    INTO v_uj_szint
    FROM BEFOGASOK
    WHERE BEFOGAS_ID = 1;

    DBMS_OUTPUT.PUT_LINE('Régi szint: ' || v_jelenlegi_szint || ' Új szint: ' || v_uj_szint);
END;
/

<!--5. FELADAT-->

CREATE OR REPLACE PROCEDURE sp_edzo_statisztika(
    p_edzo_id IN edzok.edzo_id%TYPE,
    p_nev OUT edzok.NEV%TYPE,
    p_db OUT NUMBER)
IS
BEGIN
    SELECT edzok.nev,COUNT(befogasok.DATUM)
    INTO p_nev,p_db
    FROM edzok
    LEFT JOIN befogasok
    ON edzok.EDZO_ID = befogasok.EDZO_ID
    WHERE edzok.edzo_id = p_edzo_id
    GROUP BY edzok.EDZO_ID,edzok.nev;
END;
/

DECLARE
v_edzo_id edzok.EDZO_ID%TYPE :=1;
v_nev edzok.NEV%TYPE;
v_db NUMBER;
BEGIN
    sp_edzo_statisztika(v_edzo_id,v_nev,v_db);
    DBMS_OUTPUT.PUT_LINE('Név: '|| v_nev || ', Befogott pokemon: ' || v_db);
END;
/

<!--TRIGEREK-->

<!--4.FELADAT-->
CREATE OR REPLACE TRIGGER trg_xp_vedelem
BEFORE UPDATE OF tapasztalat_pont
ON edzok FOR EACH ROW
BEGIN
    IF :NEW.tapasztalat_pont < 0 THEN
        RAISE_APPLICATION_ERROR(-20001,'Az új xp nem lehet kisebb, mint 0');
    END IF;
END;
/

<!--5.FELADAT-->
UPDATE EDZOK
SET tapasztalat_pont = -50
WHERE EDZO_ID = 1;

SELECT tapasztalat_pont
FROM edzok
WHERE edzo_id = 1;

