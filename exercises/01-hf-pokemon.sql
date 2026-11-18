-- A pokemonok táblát használva írj PL/SQL blokkot:
--      Lekéri és kiíratja a legkisebb ALAP_HP-val rendelkező pokémon nevét és típusát

SET SERVEROUTPUT ON;

BEGIN
    FOR p IN (
        SELECT p.nev,
               p.tipus
        FROM   pokemonok p
        WHERE  p.alap_hp = (
            SELECT MIN(p2.alap_hp)
            FROM   pokemonok p2
        )
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Név: ' || p.nev || ', típus: ' || p.tipus
        );
    END LOOP;
END;
/  