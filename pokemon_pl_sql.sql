
SELECT TABLE_NAME
FROM USER_TABLES
WHERE TABLE_NAME = 'POKEMONOK';



SELECT *
FROM POKEMONOK;


SET SERVEROUTPUT ON;

BEGIN
    FOR p IN (
        SELECT nev, tipus
        FROM pokemonok
        WHERE alap_hp = (SELECT MIN(alap_hp) FROM pokemonok)
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE(p.nev || ' - ' || p.tipus);
    END LOOP;
END;
/


