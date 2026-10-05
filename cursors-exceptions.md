> **Fontos:** Továbbra is használd a `SET SERVEROUTPUT ON;` parancsot a kiíratásokhoz!

## I. Kurzorok (Több sor feldolgozása)
1. Írj egy PL/SQL blokkot, amelyben deklarálsz egy kurzort (`c_pokemonok`). A kurzor kérdezze le az összes Pokémon nevét és típusát a `pokemonok` táblából. Egy FOR ciklus segítségével iterálj végig a kurzoron, és írasd ki az adatokat *"Név - Típus"* formátumban!
2. Készíts egy paraméteres kurzort! A kurzor neve legyen `c_edzok`, paraméterként kapjon egy régió nevet (`p_regio`), és listázza ki az adott régióba tartozó edzők neveit. Futtasd le a kurzort a 'Kanto' régióra, és írasd ki az eredményeket!

## II. Kivételkezelés (Hibák elkapása)
3. Készíts egy blokkot, amely beolvassa a 999-es azonosítójú Pokémon nevét egy változóba, majd kiírja azt. (Mivel ilyen ID nincs, a program hibára fog futni). Írj a blokk végére egy kivételkezelő részt (`EXCEPTION`), kapd el a `NO_DATA_FOUND` hibát, és a hibaüzenet helyett írd ki: *"Nem található ilyen Pokémon a Pokedexben!"*
4. Próbálj meg beolvasni egy változóba olyan Pokémon nevet, aminek a típusa 'Tűz'. (Mivel a korábbi feladatokban több Tűz típusút is beszúrtunk, ez hibát fog dobni). Kapd el a `TOO_MANY_ROWS` kivételt, és írd ki: *"Egyszerre több sor is érkezett, használj kurzort!"*
5. Hozz létre egy saját, egyéni kivételt! Olvasd be az 1-es azonosítójú edző tapasztalati pontját. Ha ez az érték pontosan 1500, akkor válts ki (`RAISE`) egy saját, `e_gyanus_pontszam` nevű kivételt! A kivételkezelő ágban kapd el, és írd ki: *"Túl kerek ez a pontszám, valami gyanús!"*

## III. Adatmódosítás kurzorral (FOR UPDATE)
6. Készíts egy kurzort, amely lekérdezi a 'Normál' típusú Pokémonok alap HP-ját (`alap_hp`) a táblából. Használd a `FOR UPDATE` záradékot a kurzor deklarációjánál! Iterálj végig a sorokon, és minden érintett Pokémon HP-ját növeld meg 10-zel egy `UPDATE` utasítás segítségével, amely a `WHERE CURRENT OF` szerkezetet használja! A blokk végén véglegesítsd a tranzakciót (`COMMIT`), és írasd ki, hogy *"A Normál típusok buffot kaptak!"*