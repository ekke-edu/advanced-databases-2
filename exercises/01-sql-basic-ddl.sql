-- 1. feladat: Hozd létre az edzok táblát! Tartalmazzon egy id oszlopot (legyen elsődleges kulcs, automatikusan generált sorszámmal), egy nev (szöveg, max 50 karakter) és egy regio (szöveg, max 50 karakter) oszlopot!

create table edzok (
    id number generated always as identity,
    nev varchar(50 char),
    regio varchar(50 char),
    constraint e_pk primary key (id)
);

-- 2. feladat: Hozd létre a pokemonok táblát! Oszlopai: id (szám, elsődleges kulcs), nev (szöveg, max 50), tipus (szöveg, max 50) és alap_hp (szám). Itt az id ne legyen automatikusan generált, mert a hivatalos Pokédex számokat fogjuk használni!

create table pokemonok (
    id number,
    nev varchar(50),
    tipus varchar(50),
    alap_hp number,
    constraint p_pk primary key (id)
);

-- 3. feladat: Hozd létre a befogasok kapcsolótáblát! Oszlopai: id (automatikusan generált elsődleges kulcs), szint (szám), valamint két idegen kulcs: edzo_id (hivatkozzon az edzok táblára) és pokemon_id (hivatkozzon a pokemonok táblára).

create table befogasok (
    id number generated always as identity,
    szint number,
    edzo_id number,
    pokemon_id number,
    constraint b_pk primary key (id),
    constraint fk_edzo_id foreign key (edzo_id) references edzok(id),
    constraint fk_pokemon_id foreign key (pokemon_id) references pokemonok(id)
);

-- 4. feladat: Módosítsd az edzok tábla szerkezetét (ALTER TABLE)! Adj hozzá két új oszlopot: kezdes_eve (szám) és tapasztalat_pont (szám).

alter table edzok add (
    kezdes_eve number,
    tapasztalat_pont number
);

-- 5. feladat: Hozz létre egy teszt_tabla nevű táblát egyetlen tetszőleges oszloppal, majd azonnal töröld is le a rendszerből (DROP TABLE)!

create table teszt_tabla (
    megjegyzes varchar(100)
);
drop table teszt_tabla;