-- Az n-dik fibonacci szám értéke
CREATE OR REPLACE FUNCTION fn_fibonacci (
    p_n IN NUMBER
)
RETURN NUMBER
IS
    v_a       NUMBER := 0;
    v_b       NUMBER := 1;
    v_kov     NUMBER;
BEGIN
    IF p_n IS NULL OR p_n < 0 OR p_n <> TRUNC(p_n) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nemnegatív egész számot adj meg!');
    END IF;

    FOR i IN 1..p_n LOOP
        v_kov := v_a + v_b;
        v_a := v_b;
        v_b := v_kov;
    END LOOP;

    RETURN v_a;
END fn_fibonacci;
/

-- kiírás
BEGIN
    FOR i IN 0..9 LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Fibonacci(' || i || ') = ' || fn_fibonacci(i)
        );
    END LOOP;
END;
/

-- A teljes sorozat az n-dik számig
CREATE OR REPLACE FUNCTION fn_fibonacci_sorozat (
    p_n IN NUMBER
)
RETURN NUMBER
IS
    v_a   NUMBER := 0;
    v_b   NUMBER := 1;
    v_kov NUMBER;
BEGIN
    IF p_n IS NULL OR p_n < 0 OR p_n <> TRUNC(p_n) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nemnegatív egész számot adj meg!');
    END IF;

    DBMS_OUTPUT.PUT(v_a);

    FOR i IN 1..p_n LOOP
        v_kov := v_a + v_b;
        v_a := v_b;
        v_b := v_kov;

        DBMS_OUTPUT.PUT(', ' || v_a);
    END LOOP;

    DBMS_OUTPUT.NEW_LINE;

    RETURN v_a;
END fn_fibonacci_sorozat;
/

-- kiírás
SET SERVEROUTPUT ON;

DECLARE
    v_eredmeny NUMBER;
BEGIN
    v_eredmeny := fn_fibonacci_sorozat(7);
END;
/