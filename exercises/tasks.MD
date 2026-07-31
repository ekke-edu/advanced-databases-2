## Feladatok

### Ismétlés (QL, DML, DDL) és Segédfüggvények

1. Írasd ki az edzők nevét és azt, hogy hány éve kezdték a pályafutásukat (aktuális év - `kezdes_eve`)!
2.  Készíts lekérdezést, amely régiónként csoportosítva megadja az edzők átlagos tapasztalati pontját, de csak ott, ahol az átlag > 1000!
3. Listázd ki a Pokémonokat! Ha az alap_hp nagyobb mint 100, írd mellé egy új oszlopban, hogy 'TANK', különben 'NORMÁL'. 
> Használj SQL CASE WHEN ... THEN ... END szerkezetet.
---

### CTAS, INSERT INTO ... SELECT
4. Hozd létre `CTAS`-sal a `tuz_pokemonok` táblát, amely tartalmazza a Tűz típusú Pokémonokat!
5. Oak professzor minden 2024-ben kezdő edzőnek automatikusan ad egy Bulbasaur-t (pokedex: 1), 5-ös szinten. Írj egy `INSERT INTO ... SELECT` utasítást, ami ezt rögzíti a befogasok táblában!
---

### Szkriptek és Vezérlési Szerkezetek
6.  Írd át a fenti `IF-ELSIF` szerkezetet `CASE` kifejezésre!
7.  Kérdezd le a 25-ös azonosítójú (Pikachu) alap_hp-ját! Ha `> 50`, írd ki: _Erős alkat_, egyébként _Törékeny_.
8. Módosítsd a 4-es edző XP-jét +100-zal, ha jelenleg kisebb mint 500!
---

### Ciklusok (LOOP)
9. Írj egy `WHILE` ciklust, ami egy `v_szint` változót növel 5-ről 8-ra. Írd ki minden lépésben: _A Pokémon szintet lépett: [szint]_
10. Írj egy `FOR` ciklust (1..3). Minden iterációban szúrj be egy fiktív edzőt az `edzok` táblába. A nevük legyen _NPC Edző_ és a ciklus sorszáma (pl. _NPC Edző 1_), a régiójuk _Johto_. 
>Véglegesíts a COMMIT utasítással.
---

### 1. Napi Komplex Összefoglaló Feladat
11. A Kanto régió Bajnoksága közeledik. A Liga döntött: minden Kanto régiós edző kap 500 bónusz XP-t! Készíts egy PL/SQL blokkot, ami:
    - Kiszámolja és kiírja, hány Kanto-i edző van.
    - Ha ez a szám 0, írja ki: _Nincs kinek XP-t adni_.
    - Ha van, írj egy egyetlen `UPDATE` utasítást (**ciklus nélkül!**), ami odaadja a bónusz XP-t.
    - Szúrjon be egy sort a `naplo` táblába az eseményről (_XP_BONUSZ_).
> Véglegesíts a COMMIT utasítással.
---

### Kivételkezelés és Kurzorok
12. Készíts egy kurzort, amely kiírja az összes Pokémon nevét és típusát a pokemonok táblából!

13. Próbáljunk lekérdezni egy Pokémont a befogások közül, aminek a szintje kisebb vagy egyenlő mint 0. (Ilyen elvileg nincs). Hozz létre egy saját `e_csalo_szint` kivételt. Ha a szint <= 0, dobd el a kivételt és a konzolon írd ki: _Hibás adat, a szint nem lehet 0!_
---

### Tárolt Alprogramok (Függvények és Eljárások)
14. Írj egy `fn_max_szint(p_edzo_id)` függvényt, amely visszaadja az adott edző legmagasabb szintű Pokémonjának szintjét (_MAX aggregáló_)!

15. Készíts egy eljárást `sp_ritkitas(p_edzo_id)`, ami törli az edző összes 10-es szint alatti Pokémonját a rendszerből!
---

### Tranzakciók, Táblák Zárolása és Triggerek
16. Írj egy PL/SQL blokkot, amely kurzor segítségével végigmegy a `befogasok` táblán (**FOR UPDATE záradékkal**). Növelje meg minden Pokémon szintjét 1-gyel. 
> Véglegesíts a COMMIT utasítással.

17. Készíts egy triggert `trg_szint_naplozas` néven, amely `AFTER UPDATE` fut le. Ha egy Pokémon szintje módosul, szúrjon be egy sort a naplo táblába (_SZINTLEPES', edzo_id, regi szint, uj szint_).
---

### 2. Napi Komplex Zárófeladat (Pokémon Liga Lezárása)
18. Készíts egy `sp_liga_lezaras` nevű tárolt eljárást!
   - Kurzorral iteráljon végig az összes edzőn (**FOR UPDATE zárolással** a `tapasztalat_pont` oszlopra).
   - Minden edzőnél számolja össze (**SELECT INTO**) a hozzá tartozó Pokémonok szintjeinek összegét.
   - Adja hozzá ezt a számított _csapat erőt_ az edző `tapasztalat_pont`-jához.
   - Ha az edzőnek egyetlen Pokémonja sincs, dobjon egy saját kivételt (`e_nincs_pokemon`).
   - A kivételkezelő blokkban (**a cikluson belül!**) írja a `naplo` táblába: 
   _[Nev] edzőnek nincs - Pokémonja_, de a feldolgozás menjen tovább a következő edzőre!
> Véglegesíts a COMMIT utasítással.
---
