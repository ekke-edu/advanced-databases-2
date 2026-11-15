-- 1. feladat: Szúrj be (INSERT) egy új edzőt az edzok táblába! A neve legyen 'Ash Ketchum', régiója 'Kanto', kezdés éve 1997, tapasztalati pontja pedig 1500. (Az id oszlopot ne add meg, az automatikusan generálódik!)

insert into edzok (nev, regio, kezdes_eve, tapasztalat_pont) values
('Ash Ketchum', 'Kanto', 1997, 1500);

-- 2. feladat: Szúrj be három Pokémont a pokemonok táblába egyetlen tranzakción belül: Bulbasaur (id: 1, Fű, HP: 45), Charmander (id: 4, Tűz, HP: 39) és Pikachu (id: 25, Elektromos, HP: 35). Véglegesítsd a módosításokat a rendszerben!

insert into pokemonok (id, nev, tipus, alap_hp) values 
(1, 'Bulbasaur', 'Fű', 45);
insert into pokemonok (id, nev, tipus, alap_hp) values 
(4, 'Charmander', 'Tűz', 39);
insert into pokemonok (id, nev, tipus, alap_hp) values 
(25, 'Pikachu', 'Elektromos', 35);
commit;

-- 3. feladat: Rögzítsd a befogasok táblába, hogy Ash (akinek az id-ja 1) befogta Pikachut (akinek az id-ja 25), és a Pokémon szintje 50-es! Véglegesítsd!

insert into befogasok (szint, edzo_id, pokemon_id)
values (50, 1, 25);
commit;

-- 4. feladat: Módosítsd (UPDATE) Ash Ketchum tapasztalati pontját! Növeld meg a jelenlegi értékét 500-zal. Véglegesítsd!

update edzok
set tapasztalat_pont = tapasztalat_pont + 500
where nev = 'Ash Ketchum';
commit;

-- 5. feladat: Kezdj egy új tranzakciót! Töröld (DELETE) Ash Ketchum befogását a befogasok táblából. Kérdezd le a táblát, hogy lásd, eltűnt. Ezután vonjad vissza a tranzakciót (ROLLBACK), és ellenőrizd újra a táblát, hogy a törölt adat visszatért-e!

delete from befogasok
where edzo_id = 1 and pokemon_id = 25;

select * from befogasok;

rollback;

select * from befogasok;