---
title: Adatbázisrendszerek II. – SQL és PL/SQL Mesterkurzus
routerMode: hash
---

<div class="absolute inset-0 flex flex-col font-sans">
  <div class="w-full h-[55%] bg-[#1a2a5a] flex items-start justify-center items-center pt-24 relative flex-col">
    <h1 class="text-6xl font-bold text-white tracking-wide z-10 m-0 border-none text-center">
      <strong>Adatbázisrendszerek II.</strong>
    </h1>
    <h2 class="text-xl">
      <strong>LBT_IM719G2</strong>
    </h2>
  </div>
  <div class="w-full h-[45%] bg-white flex flex-col items-center justify-start pt-6 relative text-[#1a2a5a]">
    <p class="text-3xl font-bold mt-2 mb-1">SQL és PL/SQL gyakorlat</p>
    <p class="text-xl mt-4 opacity-80 m-0 font-bold">Szilvási István Péter</p>
  </div>
  <div class="absolute top-[53.3%] left-1/2 transform -translate-x-1/2 -translate-y-1/2 flex flex-col items-center z-20 w-full">
    <img src="/assets/cover.png" class="h-24" />
    <div class="w-[60%] border-b-2 border-white my-3"></div>
  </div>
</div>

---

::header::
TÉMAKÖRÖK
::default::

<div class="grid grid-cols-4 gap-5 mt-5">
  <div class="bg-white/5 p-6 rounded-xl border border-[#1a2a5a]/20">
    <div class="text-4xl font-bold text-[#1a2a5a]">01</div><h3 class="text-xl font-bold">DQL</h3>
    <p class="opacity-80">A HR sémában vettük át a Data Query Language alapjait , vagyis a 
    <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">SELECT</code> és 
    <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">JOIN</code> utasításokat, a csoportosításokat és az aggregálást, hogy a nyers adatokból riportokat készítsünk.</p>
  </div>
  <div class="bg-white/5 p-6 rounded-xl border border-[#1a2a5a]/20">
    <div class="text-4xl font-bold text-[#1a2a5a]">02</div><h3 class="text-xl font-bold">DDL ÉS DML</h3>
    <p class="opacity-80">Létrehozzuk a saját adattábláinkat, beállítjuk az elsődleges és idegen kulcsokat, majd adatok beszúrásával (<code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">INSERT</code>), módosításával (<code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">UPDATE</code>) és törlésével (<code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">DELETE</code>) foglalkozunk, tranzakcióvezérléssel karöltve.</p>
  </div>
  <div class="bg-white/5 p-6 rounded-xl border border-[#1a2a5a]/20">
    <div class="text-4xl font-bold text-[#1a2a5a]">03</div><h3 class="text-xl font-bold">PL/SQL</h3>
    <p class="opacity-80">Bevezetjük a változókat, ciklusokat és hibakezelést. Megtanuljuk a tárolt eljárások, függvények és triggerek írását az üzleti folyamatok automatizálására.</p>
  </div>
  <div class="bg-white/5 p-6 rounded-xl border border-[#1a2a5a]/20">
    <div class="text-4xl font-bold text-[#1a2a5a]">04</div><h3 class="text-xl font-bold">GITHUB</h3>
    <p class="opacity-80">Beadandó leadása során használjuk a <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">FORK</code>, <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">CLONE</code> <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">COMMIT</code> és <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">PUSH</code> parancsokat. A saját verziónkat végül <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">PULL REQUEST</code> formájában adjuk le.</p>
  </div>
</div>

---

::header::
DQL
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <h3 class="text-2xl font-bold text-[#1a2a5a]">A lekérdezés felépítése</h3>
    <p class="opacity-80">A parancsok nem módosítják az adatbázist, csak eredményhalmazokat állítanak elő. A végrehajtás logikája kötött:</p>
    <ul class="space-y-2 mt-5">
      <li class="flex items-center"><div class="i-carbon-checkmark text-green mr-3"/><strong>SELECT:</strong> Kijelöli a megjelenítendő oszlopokat</li>
      <li class="flex items-center"><div class="i-carbon-checkmark text-green mr-3"/><strong>FROM, JOIN:</strong> Megadja a forrástáblákat és kapcsolataikat</li>
      <li class="flex items-center"><div class="i-carbon-checkmark text-green mr-3"/><strong>WHERE:</strong> Sor szintű szűrés csoportosítás előtt</li>
      <li class="flex items-center"><div class="i-carbon-checkmark text-green mr-3"/><strong>GROUP BY:</strong> Összesítésekhez csoportosít.</li>
      <li class="flex items-center"><div class="i-carbon-checkmark text-green mr-3"/><strong>HAVING:</strong> Kiszűri a nem megfelelő csoportokat.</li>
      <li class="flex items-center"><div class="i-carbon-checkmark text-green mr-3"/><strong>ORDER BY:</strong> Rendezi a végső listát.</li>
    </ul>
  </div>
  <div class="bg-slate-100 text-slate-900 border border-slate-300 rounded-xl p-5 text-sm leading-relaxed">
<pre v-pre class="text-slate-900 text-sm leading-relaxed">
SELECT d.department_name,
       COUNT(*) AS employee_count,
       ROUND(AVG(e.salary), 0) AS avg_salary
FROM employees e
JOIN departments d
  ON d.department_id = e.department_id
WHERE e.salary IS NOT NULL
GROUP BY d.department_name
HAVING COUNT(*) >= 3
ORDER BY avg_salary DESC;
</pre>
  </div>
</div>

---

::header::
ALIAS
::default::

<div class="grid grid-cols-2 gap-8">
  <div class="space-y-4">
    <p class="opacity-80">Az aliasok rövidebbé teszik a kódot</p>
    <ul class="space-y-2">
      <li class="flex items-start"><div class="i-carbon-checkmark text-green mr-3 mt-1"/><span><strong>Tábla alias (pl. e és d):</strong> Rövidíti a hivatkozásokat. Több tábla összekapcsolásakor (JOIN) kötelező használni, hogy megelőzzük a kétértelmű oszlopnevek miatti hibákat.</span></li>
      <li class="flex items-start"><div class="i-carbon-checkmark text-green mr-3 mt-1"/><span><strong>Oszlop alias (pl. AS reszleg_neve):</strong> Kifejező nevet ad a számított, aggregált mezőknek a végeredményben.</span></li>
    </ul>
    <p class="opacity-80 mt-4"><strong>Formázás:</strong> Az SQL nem érzékeny a kis/nagybetűkre, de a kulcsszavakat (SELECT, FROM) nagybetűvel, a mezőket kisbetűvel írjuk, és behúzásokkal tagoljuk a logikát.</p>
  </div>
  <div class="bg-slate-100 text-slate-900 border border-slate-300 rounded-xl p-6">
<pre v-pre class="text-slate-900 text-sm leading-relaxed">
SELECT e.first_name,
       e.last_name,
       d.department_name AS reszleg_neve
FROM employees e
JOIN departments d
  ON d.department_id = e.department_id
WHERE e.salary > 8000
ORDER BY e.last_name;
</pre>
  </div>
</div>

---

::header::
SÉMA
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <p class="opacity-80">A séma egy adott felhasználóhoz tartozó névtér. Tartalmazza a felhasználó összes saját objektumát (táblák, triggerek stb.).</p>
    <p class="opacity-80 mt-4">Mindenki saját sémában dolgozik, ami garantálja, hogy a kódjaitok nem ütköznek. Ha ketten is létrehoztok egy <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">EDZOK</code> táblát, azok fizikailag különállóak lesznek (pl. <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">HALLGATO_A.EDZOK</code> és <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">HALLGATO_B.EDZOK</code>). Itt bátran tesztelhetitek a DDL és DML utasításokat.</p>
  </div>
  <div class="grid grid-cols-2 gap-4 text-center">
    <div class="bg-white/5 p-5 rounded-xl border border-[#1a2a5a]/20">
      <div class="i-carbon-user text-4xl mx-auto text-[#1a2a5a]"/>
      <strong>Hallgató A</strong>
      <p class="m-0 text-sm opacity-70">saját séma</p>
      <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white"">EDZOK tábla</code>
    </div>
    <div class="bg-white/5 p-5 rounded-xl border border-[#1a2a5a]/20">
      <div class="i-carbon-user text-4xl mx-auto text-[#1a2a5a]"/>
      <strong>Hallgató B</strong>
      <p class="m-0 text-sm opacity-70">saját séma</p>
      <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">EDZOK tábla</code>
    </div>
  </div>
</div>

---

::header::
DDL
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div class="space-y-4">
    <p class="opacity-80">A Data Definition Language hozza létre (<code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">CREATE</code>), módosítja (<code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">ALTER</code>) és törli (<code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">DROP</code>) az adatbázis objektumait. Emellett kényszerekkel (constraints) védi az adatokat:</p>
    <ul class="space-y-2 text-sm">
      <li><strong>PRIMARY KEY:</strong> Egyedileg azonosítja a sort (nem lehet NULL és nem ismétlődhet).</li>
      <li><strong>FOREIGN KEY:</strong> Referenciális integritást biztosít; másik tábla létező elemére mutat.</li>
      <li><strong>NOT NULL:</strong> Kötelező mezőkitöltés.</li>
      <li><strong>CHECK:</strong> Egyedi validációs szabályok (pl. <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">fizetes >= 0</code>).</li>
    </ul>
    <div class="bg-amber-50 border border-amber-300 rounded-xl p-3 text-sm mt-4 text-[#1a2a5a]"><strong>Oracle sajátosság:</strong> A DDL parancsok automatikusan (implicit módon) COMMIT-olnak. Egy elrontott <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">DROP TABLE</code> után nem használhatsz <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">ROLLBACK</code>-et!</div>
  </div>
  <div class="bg-slate-100 text-slate-900 border border-slate-300 rounded-xl p-6 text-sm">
<pre v-pre class="text-slate-900 text-sm leading-relaxed">
CREATE TABLE edzok (
  edzo_id NUMBER
    CONSTRAINT pk_edzok PRIMARY KEY,
  nev VARCHAR2(100) NOT NULL,
  fizetes NUMBER(10, 2)
    CONSTRAINT ck_edzok_fizetes
    CHECK (fizetes >= 0),
  reszleg_id NUMBER,
  CONSTRAINT fk_edzok_reszleg
    FOREIGN KEY (reszleg_id)
    REFERENCES reszlegek(reszleg_id)
);
</pre>
  </div>
</div>

---

::header::
DML ÉS TRANZAKCIÓK
::default::

<div class="grid grid-cols-2 gap-8">
  <div>
    <p class="opacity-80">A DML utasítások kezelik magukat az adatokat (<code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">INSERT</code>, <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">UPDATE</code>, <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">DELETE</code>).</p>
    <p class="opacity-80 mt-4 text-rose-600 font-bold">Veszélyforrás: Ha a WHERE feltételt elfelejted az UPDATE vagy DELETE parancsnál, az a tábla összes sorát érinteni fogja!</p>    
    <h3 class="text-xl font-bold text-[#1a2a5a] mt-6">Tranzakcióvezérlés</h3>
    <p class="opacity-80">A módosítások nem válnak azonnal véglegessé. Két fő eszközünk van a vezérlésre:
    <br/>• <strong>COMMIT:</strong> Véglegesíti az elvégzett módosításokat.
    <br/>• <strong>ROLLBACK:</strong> Visszavonja a tranzakció minden lépését a legutóbbi COMMIT-ig hiba vagy elgépelés esetén.</p>
  </div>
  <div class="bg-slate-100 text-slate-900 border border-slate-300 rounded-xl p-5 text-sm">
<pre v-pre class="text-slate-900 text-sm leading-relaxed">
UPDATE edzok
SET fizetes = fizetes * 1.05
WHERE reszleg_id = 20;

-- Ha minden adat helyes:
COMMIT;

-- Ha hibáztunk (pl. lemaradt a WHERE):
ROLLBACK;
</pre>
  </div>
</div>

---

::header::
PL/SQL
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <h3 class="text-2xl font-bold text-[#1a2a5a]">Miért nem elég az SQL?</h3>
    <p class="opacity-80">Az SQL deklaratív nyelv, ami nagyszerű adatkinyerésre, de nem képes folyamatokat, döntési fákat leírni. A PL/SQL az Oracle procedurális nyelve, ami orvosolja ezt.</p>
    <p class="opacity-80 mt-4">Változókat, ciklusokat (FOR, WHILE) és elágazásokat (IF-THEN-ELSE) biztosít. Közvetlenül az adatbázisszerveren fut le, így a hálózati forgalom drasztikusan csökken, a futás pedig villámgyors lesz. Segítségével komplett üzleti logikát "zárhatunk be" az adatbázisba.</p>
  </div>
  <div class="bg-slate-100 text-slate-900 border border-slate-300 rounded-xl p-5 text-sm">
<pre v-pre class="text-slate-900 text-sm leading-relaxed">
DECLARE
  v_fizetes employees.salary%TYPE;
BEGIN
  SELECT salary INTO v_fizetes
  FROM employees WHERE employee_id = 100;

  IF v_fizetes > 10000 THEN
    DBMS_OUTPUT.PUT_LINE('Kiemelt');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Normál');
  END IF;
END;
/
</pre>
  </div>
</div>

---

::header::
PL/SQL BLOKK
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div class="space-y-4">
    <h3 class="text-2xl font-bold text-[#1a2a5a]">A kód strukturálása</h3>
    <p class="opacity-80">Minden PL/SQL program egy szigorúan felépített blokkra épül:</p>
    <ul class="space-y-3">
      <li><strong>DECLARE (opcionális):</strong> Változók, kurzorok és kivételek előzetes deklarálása.</li>
      <li><strong>BEGIN (kötelező):</strong> Az érdemi futtatható utasítások helye (logika + SQL parancsok).</li>
      <li><strong>EXCEPTION (opcionális):</strong> Futásidejű hibák intelligens kezelése. Itt előzhetjük meg, hogy a program "elszálljon".</li>
      <li><strong>END; (kötelező):</strong> A blokk lezárása.</li>
      <li><strong>/ (perjel):</strong> A fejlesztőkörnyezetek (pl. SQL Developer) számára jelöli a blokk végét, utasítva azt a szerver felé történő elküldésre.</li>
    </ul>
  </div>
  <div class="bg-slate-100 text-slate-900 border border-slate-300 rounded-xl p-5 text-sm">
<pre v-pre class="text-slate-900 text-sm leading-relaxed">
DECLARE
  v_szam NUMBER := 10;
BEGIN
  -- Hiba provokálása:
  v_szam := v_szam / 0; 
EXCEPTION
  WHEN ZERO_DIVIDE THEN
    DBMS_OUTPUT.PUT_LINE('Nullával osztás!');
END;
/
</pre>
  </div>
</div>

---

::header::
%TYPE ÉS %ROWTYPE
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <p class="opacity-80">Hardkódolt típusok (pl. <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">VARCHAR2(50)</code>) használata helyett kössük a változókat az adatbázis sémájához! Ha a táblaoszlop később módosul (pl. 100 karakterre), a PL/SQL kódunk is automatikusan, hibamentesen fog alkalmazkodni.</p>
    <ul class="space-y-2 mt-4">
      <li><strong>%TYPE:</strong> A változó pontosan felveszi a hivatkozott táblaoszlop adattípusát (pl. <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">employees.salary%TYPE</code>).</li>
      <li><strong>%ROWTYPE:</strong> Egy komplett "rekordot" hoz létre, ami a tábla összes oszlopának szerkezetét lemásolja. Egyetlen <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">SELECT *</code> utasítással beolvashatunk egy teljes sort.</li>
    </ul>
  </div>
  <div class="bg-slate-100 text-slate-900 border border-slate-300 rounded-xl p-6">
<pre v-pre class="text-slate-900 text-sm leading-relaxed">
DECLARE
  v_nev employees.last_name%TYPE;
  r_dolgozo employees%ROWTYPE;
BEGIN
  SELECT last_name INTO v_nev
  FROM employees WHERE employee_id = 100;

  -- Teljes sor rekordba töltése:
  SELECT * INTO r_dolgozo
  FROM employees WHERE employee_id = 100;
  
  DBMS_OUTPUT.PUT_LINE(r_dolgozo.salary);
END;
/
</pre>
  </div>
</div>

---

::header::
SELECT INTO ÉS KIVÉTELEK
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <h3 class="text-2xl font-bold text-[#1a2a5a]">Adat beemelése változókba</h3>
    <p class="opacity-80">A <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">SELECT ... INTO</code> záradékkal tudjuk az SQL lekérdezés eredményét PL/SQL változókba juttatni.</p>
    <p class="opacity-80 mt-4 font-bold text-rose-600">Szigorú szabály: Ez az utasítás pontosan egy (és csakis egy) sort adhat vissza!</p>
    <ul class="space-y-2 mt-2">
      <li>Nulla találat esetén: <strong>NO_DATA_FOUND</strong> kivétel.</li>
      <li>Több találat esetén: <strong>TOO_MANY_ROWS</strong> kivétel.</li>
    </ul>
    <p class="opacity-80 mt-4">Ha nem vagyunk biztosak abban, hogy a lekérdezés hány sort eredményez, használjunk kurzort. Az egy soros lekérdezéseknél pedig kötelező ezen hibák lekezelése az EXCEPTION blokkban.</p>
  </div>
  <div class="bg-slate-100 text-slate-900 border border-slate-300 rounded-xl p-5 text-sm">
<pre v-pre class="text-slate-900 text-sm leading-relaxed">
DECLARE
  v_fiz employees.salary%TYPE;
BEGIN
  SELECT salary INTO v_fiz
  FROM employees WHERE employee_id = 9999;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Nincs ilyen dolgozó!');
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('Több dolgozó!');
    RAISE; -- Hiba "feljebb" dobása
END;
/
</pre>
  </div>
</div>

---

::header::
KURZOROK
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <h3 class="text-2xl font-bold text-[#1a2a5a]">Több soros eredményhalmazok</h3>
    <p class="opacity-80">Mivel a SELECT INTO csak egy sort bír el, több adatsor (pl. egy részleg összes dolgozója) feldolgozásához kurzorokat használunk. A kurzor egy mutató a memóriában lévő adathalmazra.</p>
    <p class="opacity-80 mt-4">A legprofibb megoldás a <strong>Cursor FOR Loop</strong>, mert ez mindent automatizál:</p>
    <ol class="list-decimal pl-5 opacity-80 space-y-1">
      <li>Automatikusan deklarálja a ciklusváltozót.</li>
      <li>Megnyitja a kurzort (OPEN).</li>
      <li>Soronként beolvassa az adatokat, amíg van (FETCH).</li>
      <li>Hiba, vagy leállás esetén automatikusan lezárja azt (CLOSE).</li>
    </ol>
  </div>
  <div class="bg-slate-100 text-slate-900 border border-slate-300 rounded-xl p-5 text-sm">
<pre v-pre class="text-slate-900 text-sm leading-relaxed">
BEGIN
  -- Az 'r' ciklusváltozót nem kell DECLARE-ben megadni
  FOR r IN (
    SELECT employee_id, last_name, salary
    FROM employees
    WHERE department_id = 50
    ORDER BY salary DESC
  ) LOOP
    DBMS_OUTPUT.PUT_LINE(
      r.last_name || ': ' || r.salary
    );
  END LOOP;
END;
/
</pre>
  </div>
</div>

---

::header::
FOR UPDATE ÉS SAJÁT KIVÉTELEK
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div class="space-y-4">
    <h3 class="text-2xl font-bold text-[#1a2a5a]">FOR UPDATE (Sorok zárolása)</h3>
    <p class="opacity-80">Kurzoroknál a <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">FOR UPDATE</code> utasítással zárolhatjuk a kiválasztott sorokat. Ezzel megelőzhető a konkurens adatmódosítás (elveszett frissítés), amíg az aktuális tranzakciónk le nem zárul (COMMIT vagy ROLLBACK).</p>
    <h3 class="text-2xl font-bold text-[#1a2a5a] mt-6">Saját hibák generálása</h3>
    <p class="opacity-80">Üzleti szabályok megsértésekor (pl. a fizetés nem lehet negatív) a tranzakciót meg kell szakítani. A <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">RAISE_APPLICATION_ERROR</code> procedúrával saját hibakódot (-20000 és -20999 között) és üzenetet adhatunk a hívó kliensalkalmazás (Python, Java stb.) tudtára, nem csak a szerver konzoljára írunk.</p>
  </div>
  <div class="bg-slate-100 text-slate-900 border border-slate-300 rounded-xl p-5 text-sm">
<pre v-pre class="text-slate-900 text-sm leading-relaxed">
DECLARE
  v_fizetes NUMBER := -500;
BEGIN
  IF v_fizetes < 0 THEN
    -- Futás azonnali megszakítása:
    RAISE_APPLICATION_ERROR(
      -20001, 
      'Hiba: A fizetés nem lehet negatív!'
    );
  END IF;
END;
/
</pre>
  </div>
</div>

---

::header::
FÜGGVÉNY ÉS ELJÁRÁS
::default::

<div class="grid grid-cols-2 gap-8">
  <div class="bg-white/5 p-6 rounded-xl border border-[#1a2a5a]/20">
    <div class="i-carbon-function text-4xl text-[#1a2a5a]"/><h3 class="text-2xl font-bold text-[#1a2a5a]">Függvény</h3>
    <p class="opacity-80 mt-2"><strong>Értékek számítására és visszaadására</strong> való (kötelező <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">RETURN</code>). Előnye, hogy normál SQL lekérdezésekbe (DQL) is beilleszthető.</p>
    <div class="bg-slate-100 text-slate-900 border border-slate-300 p-4 rounded text-sm mt-4">
<pre v-pre class="text-slate-900 text-sm leading-relaxed">
CREATE OR REPLACE FUNCTION eves_fizetes(
  p_havi IN NUMBER
) RETURN NUMBER IS
BEGIN
  RETURN p_havi * 12;
END;
/
</pre>
    </div>
  </div>
  <div class="bg-white/5 p-6 rounded-xl border border-[#1a2a5a]/20">
    <div class="i-carbon-workflow-automation text-4xl text-[#1a2a5a]"/><h3 class="text-2xl font-bold text-[#1a2a5a]">Eljárás</h3>
    <p class="opacity-80 mt-2"><strong>Adatmódosítások</strong> elvégzésére szolgál. Bemenő és kimenő paraméterei vannak.</p>
    <div class="bg-slate-100 text-slate-900 border border-slate-300 p-4 rounded text-sm mt-4">
<pre v-pre class="text-slate-900 text-sm leading-relaxed">
CREATE OR REPLACE PROCEDURE uj_fizetes(
  p_id IN employees.employee_id%TYPE,
  p_szazalek IN NUMBER
) IS
BEGIN
  UPDATE employees 
  SET salary = salary * (1 + (p_szazalek/100))
  WHERE employee_id = p_id;
END;
/
</pre>
    </div>
  </div>
</div>

---

::header::
TRIGGER
::default::

<div class="grid grid-cols-2 gap-8">
  <div class="space-y-4">
    <p class="opacity-80">Olyan eseményvezérelt PL/SQL kódok, amelyek DML utasítások (INSERT, UPDATE, DELETE) hatására maguktól aktiválódnak.</p>
    <div class="border-l-4 border-[#1a2a5a] pl-4"><strong class="text-[#1a2a5a]">BEFORE Trigger:</strong> Még az adatmódosítás előtt lefut. Kiváló adatok validálására (pl. negatív fizetés megakadályozása <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">RAISE_APPLICATION_ERROR</code>-ral) vagy alapértelmezett értékek pótlására.</div>
    <div class="border-l-4 border-[#1a2a5a]/40 pl-4"><strong class="text-[#1a2a5a]">AFTER Trigger:</strong> Sikeres módosítás után aktiválódik. Tipikusan naplózásra, szinkronizációra használatos.</div>
    <p class="opacity-80 mt-2">Sorszintű (FOR EACH ROW) működésnél hozzáférünk a tranzakció előtti (<code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">:OLD</code>) és utáni (<code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">:NEW</code>) állapotokhoz.</p>
  </div>
  <div class="bg-slate-100 text-slate-900 border border-slate-300 rounded-xl p-5 text-sm flex flex-col justify-center">
<pre v-pre class="text-slate-900 text-sm leading-relaxed">
CREATE OR REPLACE TRIGGER trg_fizetes_vedelem
BEFORE UPDATE OF salary ON employees
FOR EACH ROW
BEGIN
  -- Szigorú növekedési szabály:
  IF :NEW.salary < :OLD.salary THEN
    RAISE_APPLICATION_ERROR(
      -20002,
      'A fizetés nem csökkenthető!'
    );
  END IF;
END;
/
</pre>
  </div>
</div>

---

::header::
GITHUB
::default::
<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <p class="opacity-80">A feladatok a következő Github organizációba található:
    <a target="_blank" href="https://github.com/ekke-edu/advanced-databases-2">EKKE-EDU Github nem hivatalos organizáció </a>
    </p>
    <p class="opacity-80">Az órai feladatokat a következő branch-ekbe találod:</p>
    <ul>
    <li><a target="_blank" href="https://github.com/ekke-edu/advanced-databases-2/tree/sql-basic">sql-basic</a></li>
    <li><a target="_blank" href="https://github.com/ekke-edu/advanced-databases-2/tree/plsql-basic/plsql.md">plsql-basic</a></li>
    <li><a target="_blank" href="https://github.com/ekke-edu/advanced-databases-2/tree/cursors-exceptions/cursors-exceptions.md">cursors-exceptions</a></li>
    <li><a target="_blank" href="https://github.com/ekke-edu/advanced-databases-2/tree/stored-procedures/stored-procedures.md">stored-procedures</a></li>
    <li><a target="_blank" href="https://github.com/ekke-edu/advanced-databases-2/tree/triggers/triggers.md">trieggers</a></li>
    </ul>
  </div>
  <div class="grid grid-cols-1  text-center">
    <img src="/assets/github_instructions/org.jpeg" class="h-[100%] w-full filter" />
  </div>
</div>

---

::header::
FORK
::default::
<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <p class="opacity-80">Az előző dián látható a <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">FORK</code> gomb. A megnyomása utána a következő képernyőt fogod látni.</p>
    <ul>
      <li>Owner: A saját Github fiókodat válaszd</li>
      <li>Repository name: Hagyd változatlanul</li>
      <li>Copy the main branch only checkbox: pipáld be</li>
    </ul>
  </div>
  <div class="grid grid-cols-1  text-center">
    <img src="/assets/github_instructions/fork.jpg" class="h-[100%] w-full filter" />
  </div>
</div>

---

::header::
CLONE
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <p class="opacity-80">Navigáljatok a saját Github profilotokra, ahová le forkoltátok a branch-et. Majd a <code  style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">< > CODE</code> gombnál válaszd a HTTPS-t és másold ki a linket alatta.</p>
  </div>  
  <div class="grid grid-cols-1  text-center">
    <img src="/assets/github_instructions/clone.jpg" class="h-[100%] w-full filter" />
  </div>
</div>

---

::header::
CLONE II.
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <p class="opacity-80">Klónozzátok le a képen látható módon a forkolt branchetek.</p>
    <p class="opacity-80">Ha VS Code van telepítve a gépetekre, a parancssorba a <code  style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white"> code .</code> paranccsal megnyitja a VS Code-ba a klónozott projektet.</p>
  </div>  
  <div class="grid grid-cols-1  text-center">
    <img src="/assets/github_instructions/clone2.jpg" class="h-[100%] w-full filter" />
  </div>
</div>

---

::header::
COMMIT, PUSH
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <p class="opacity-80">Csináljátok meg a beadandót, majd a bal oldali sávban a harmadik tabon láthatjátok a Git változásokat.</p>
    <p class="opacity-80">Egy lépés kimaradt a képről: a módosított fájlra vidd rá az egeret, és megjelenik egy + jel</p>
    <p>Miután sikerült <code  style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">STAGE</code> sikerült, a képen látható üzenetet írd be és nyomd meg a <code  style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">Commit&Push</code> gombot.</p>
  </div>  
  <div class="grid grid-cols-1  text-center">
    <img src="/assets/github_instructions/commit_push.jpg" class="h-[100%] w-full filter" />
  </div>
</div>

---

::header::
PULL REQUEST
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <p class="opacity-80">Kattintsatok a <code  style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">PULL REQUEST</code> menü gombra, majd válasszátok ki a jobb oldali legördülő listába az <code  style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">ekke-edu/advanced-databases-2 </code> repository-t.</p>
  </div>  
  <div class="grid grid-cols-1  text-center">
    <img src="/assets/github_instructions/pull_request.jpg" class="h-[100%] w-full filter" />
  </div>
</div>

---

::header::
BEADANDÓ
::default::
<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <p class="opacity-80"> A következő alkalom előtt oldjátok meg a következő feladatokat (a táblákat, csináljátok meg a saját sémátokba): </p>
    <ul>
      <li>DQL feladatokból amiket technikai okokból nem tudtunk megoldani: 2., 3., 5., 8., 10., 11., 15., 16., 17., 18., 19., 20. (Aki nem jelent meg, értelem szerűen az összeset)</li>
      <li>A <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">pokemonok</code> táblát használva írj PL/SQL blokkot:
        <ul>
          <li> Lekéri és kiíratja a legkisebb <code style="background-color: #1a2a5a;" class="bg-[#1a2a5a] text-white">ALAP_HP</code> -val rendelkező pokémon nevét és típusát </li>
        </ul> 
      </li>
      <li>PLSQL fibonacci függvény kiíratása</li>
    </ul>
  </div>  
  <div class="grid grid-cols-1  text-center">
  <table style="width:100%; border-collapse: collapse; font-family: sans-serif; font-size: 13px;">
  <thead>
    <tr style="background-color: #f2f2f2; border-bottom: 2px solid #ddd; text-align: left;">
      <th style="padding: 2px;">Tábla neve</th>
      <th style="padding: 2px;">Mezők (Oszlopok)</th>
    </tr>
  </thead>
  <tbody>
    <tr style="border-bottom: 1px solid #eee;">
      <td style="padding: 2px; font-weight: bold; white-space: nowrap;">COUNTRIES</td>
      <td style="padding: 2px; color: #333;">COUNTRY_ID, COUNTRY_NAME, REGION_ID</td>
    </tr>
    <tr style="border-bottom: 1px solid #eee; background-color: #fafafa;">
      <td style="padding: 2px; font-weight: bold; white-space: nowrap;">DEPARTMENTS</td>
      <td style="padding: 2px; color: #333;">DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID</td>
    </tr>
    <tr style="border-bottom: 1px solid #eee;">
      <td style="padding: 2px; font-weight: bold; white-space: nowrap;">EMPLOYEES</td>
      <td style="padding: 2px; color: #333;">EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID</td>
    </tr>
    <tr style="border-bottom: 1px solid #eee; background-color: #fafafa;">
      <td style="padding: 2px; font-weight: bold; white-space: nowrap;">JOB_HISTORY</td>
      <td style="padding: 2px; color: #333;">EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID</td>
    </tr>
    <tr style="border-bottom: 1px solid #eee;">
      <td style="padding: 2px; font-weight: bold; white-space: nowrap;">JOBS</td>
      <td style="padding: 2px; color: #333;">JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY</td>
    </tr>
    <tr style="border-bottom: 1px solid #eee; background-color: #fafafa;">
      <td style="padding: 2px; font-weight: bold; white-space: nowrap;">LOCATIONS</td>
      <td style="padding: 2px; color: #333;">LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID</td>
    </tr>
    <tr style="border-bottom: 1px solid #eee;">
      <td style="padding: 2px; font-weight: bold; white-space: nowrap;">REGIONS</td>
      <td style="padding: 2px; color: #333;">REGION_ID, REGION_NAME</td>
    </tr>
  </tbody>
</table>
  </div>
</div>

---

::header::
CSATLAKOZÁS
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <p class="opacity-80">OpenVPN kliens:</p>
     <p>Töltse le és telepítse az OpenVPN kliens szoftvert (https://openvpn.net/index.php/open-source/downloads.html).
      Töltse le és másolja az itt elérhető konfigurációs beállításokat tartalmazó állományt az Open VPN konfigurációs állomáynai közé. Például Windows esetén a C:\Program Files\OpenVPN\config\ almappába kell másolni.
      Az OpenVPN indítását követően a kapcsolódás során felhasználónévként használja Neptun kódját, illetve jelszóként akutális Neptun jelszavát.</p>
  </div>  
  <div class="grid grid-cols-1">
    <p class="opacity-80">SQL Developer konfiguráció:</p>
    <ul>
      <li>Name: Adjon nevet a kapcsolatnak (pl. "EKKE - Neptun kód")</li>
      <li>Database Type: Oracle</li>
      <li>Username: Neptun kód</li>
      <li>Password: kurzuson elhangzott / megváltoztatott jelszó</li>
      <li>Hostname: oracledb.uni-eszterhazy.hu</li>
      <li>Port: 1521</li>
      <li>Service Name: EKKEDEMO</li>
    </ul>
  </div>
</div>