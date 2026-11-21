------------------------------
-- I. Naplózás (AFTER Trigger)
------------------------------

-- 1. Hozz létre egy naplo nevű táblát! Oszlopai: id (automatikusan generált elsődleges kulcs), esemeny_tipus (szöveg, max 50), leiras (szöveg, max 200), és datum (DATE típus, alapértelmezett értéke legyen a rendszer aktuális ideje: DEFAULT SYSDATE).

-- a naplo már létezik, ezért naplo2
CREATE TABLE naplo2 (
    id              NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    esemeny_tipus   VARCHAR2(50),
    leiras          VARCHAR2(200),
    datum           DATE DEFAULT SYSDATE
);

-- 2. Készíts egy trg_szint_naplozas nevű triggert! A trigger fusson le a befogasok táblán történt minden egyes sor szintjének módosítása után (AFTER UPDATE OF szint ON befogasok FOR EACH ROW). A trigger szúrjon be egy sort a naplo táblába 'SZINTLÉPÉS' esemény típussal, a leírásban pedig fűzze össze a befogás azonosítóját, a régi szintet és az új szintet!

CREATE OR REPLACE TRIGGER trg_szint_naplozas
AFTER UPDATE OF szint ON befogasok      -- mire vonatkozik a változás, melyik táblában
FOR EACH ROW
BEGIN
    INSERT INTO naplo (
        esemeny_tipus,
        leiras
    )
    VALUES (
        'SZINTLÉPÉS',
        'ID: ' || :NEW.id ||
        ', Régi szint: ' || :OLD.szint ||
        ', Új szint: ' || :NEW.szint
    );
END;
/ 

-- ellenőrizni, mert órán valami nem stimmelt vele



-- 3. Teszteld a triggert! Írj egy UPDATE utasítást, ami az 1-es azonosítójú befogás szintjét megnöveli 2-vel. Véglegesítsd (COMMIT), majd kérdezd le a naplo tábla tartalmát, hogy látod-e az automatikusan létrejött bejegyzést!


------------------------------------------------
-- II. Validáció és Adatvédelem (BEFORE Trigger)
------------------------------------------------

-- 4. Írj egy trg_xp_vedelem nevű triggert! Ez a trigger az edzok tábla tapasztalat_pont oszlopának frissítése előtt fusson le soronként (BEFORE UPDATE OF tapasztalat_pont ON edzok FOR EACH ROW). Vizsgálja meg az új XP értéket: ha az kisebb mint 0, dobjon egy saját hibaüzenetet és állítsa meg a tranzakciót! (Használd a RAISE_APPLICATION_ERROR beépített eljárást -20001-es hibakóddal).


-- 5. Teszteld az adatvédelmet! Próbálj meg írni egy UPDATE utasítást, amely Ash Ketchum (id: 1) tapasztalati pontját beállítja -50-re. Figyeld meg a konzolon megjelenő hibaüzenetet, és ellenőrizd egy SELECT-tel, hogy a módosítás valóban nem történt meg!
