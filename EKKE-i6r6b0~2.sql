-- Pukimon pikachu
SET SERVEROUTPUT ON;

DECLARE
    v_nev   VARCHAR2(100);
    v_tipus VARCHAR2(100);
BEGIN
    SELECT nev, tipus
    INTO v_nev, v_tipus
    FROM pokemonok
    WHERE alap_hp = (SELECT MIN(alap_hp) FROM pokemonok);

    DBMS_OUTPUT.PUT_LINE('Legkisebb HP-ju pokemon: ' || v_nev || ' (' || v_tipus || ')');
END;
/

--FIBO
CREATE OR REPLACE FUNCTION fibonacci(n NUMBER) RETURN NUMBER IS
BEGIN
    IF n <= 0 THEN
        RETURN 0;
    ELSIF n = 1 THEN
        RETURN 1;
    ELSE
        RETURN fibonacci(n - 1) + fibonacci(n - 2);
    END IF;
END;
/
SET SERVEROUTPUT ON;

BEGIN
    FOR i IN 0..9 LOOP
        DBMS_OUTPUT.PUT_LINE('F(' || i || ') = ' || fibonacci(i));
    END LOOP;
END;
/