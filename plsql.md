> **Fontos:** Mielőtt elkezded a feladatokat, futtasd le a `SET SERVEROUTPUT ON;` parancsot a kliensedben, különben nem fogod látni a PL/SQL blokkok kiírásait!

## I. Változók és Alapvető Blokkok
1. Írj egy névtelen PL/SQL blokkot, amely a `DBMS_OUTPUT.PUT_LINE` segítségével kiírja a konzolra: *"Üdvözöllek a PL/SQL világában!"*
2. Készíts egy blokkot, amelyben deklarálsz egy szöveges változót (`v_nev`) 'Pikachu' értékkel, és egy szám típusú változót (`v_szint`) 10-es értékkel. Írasd ki őket egy mondatba fűzve!
3. Deklarálj egy `v_edzo_nev` változót az `edzok` tábla `nev` oszlopának típusával (`%TYPE`). Adj neki tetszőleges értéket, és írasd ki!

## II. Adatbázis adatok beolvasása (SELECT INTO) és Vezérlési szerkezetek
4. Írj egy blokkot, amely beolvassa a 25-ös azonosítójú Pokémon (Pikachu) alap HP-ját a `pokemonok` táblából egy változóba, majd kiírja azt!
5. Kérdezd le az 1-es azonosítójú edző (Ash Ketchum) tapasztalati pontját (`tapasztalat_pont`) egy változóba! Írj egy `IF-ELSIF-ELSE` szerkezetet: ha az XP > 2000, írja ki, hogy *"Mester"*, ha > 1000, akkor *"Haladó"*, egyébként *"Kezdő"*!
6. Deklarálj egy `v_tipus` változót 'Tűz' kezdőértékkel. Készíts egy `CASE` szerkezetet (IF nélkül!), ami megvizsgálja a változót: ha 'Tűz', írja ki: *"Támadó"*; ha 'Víz', akkor *"Kiegyensúlyozott"*; egyébként *"Egyéb"*.

## III. Ciklusok (LOOP, WHILE, FOR)
7. Készíts egy egyszerű `LOOP` ciklust, ami 1-től 5-ig elszámol, és minden lépésben kiírja az aktuális számot! Ne felejtsd el az `EXIT WHEN` kilépési feltételt!
8. Írj egy `WHILE` ciklust, ami egy `v_hp` változót növel 10-ről 50-re, tízesével lépkedve, és kiírja az értékeket!
9. Készíts egy `FOR` ciklust, ami 1-től 3-ig fut. Írja ki a konzolra: *"Ciklus iteráció: [szám]"*!
10. **Komplex:** Használj egy `FOR` ciklust (1..3), és minden iterációban szúrj be (`INSERT`) egy új fiktív Pokémont a `pokemonok` táblába. Az `id` legyen 100 + a ciklusváltozó, a neve *"Tesztmon "* és a ciklusváltozó, a típusa *"Normál"*. A blokk végén véglegesíts (`COMMIT`)!