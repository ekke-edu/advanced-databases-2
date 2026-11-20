
SET SERVEROUTPUT ON;

DECLARE
    a NUMBER := 0;
    b NUMBER := 1;
    c NUMBER;
BEGIN
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(a);
        c := a + b;
        a := b;
        b := c;
    END LOOP;
END;
/
