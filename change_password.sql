DECLARE
    v_current_user VARCHAR2(128);
BEGIN
    -- 1. Lekérjük az aktuális felhasználónevet
    SELECT USER INTO v_current_user FROM DUAL;
    
    -- 2. Dinamikusan végrehajtjuk az ALTER USER parancsot
    EXECUTE IMMEDIATE 'ALTER USER ' || v_current_user || ' IDENTIFIED BY "ÚJ_JELSZÓ"';
END;
/