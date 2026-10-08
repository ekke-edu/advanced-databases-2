---
title: Adatbázisrendszerek II. – SQL és PL/SQL Mesterkurzus
routerMode: hash
---

<div class="absolute inset-0 flex flex-col font-sans">
  <div class="w-full h-[55%] bg-[#1a2a5a] flex items-start justify-center pt-24 relative">
    <h1 class="text-6xl font-bold text-white tracking-wide z-10 m-0 border-none text-center">
      <strong>Adatbázisrendszerek II.</strong>
    </h1>
  </div>
  <div class="w-full h-[45%] bg-white flex flex-col items-center justify-start pt-5 relative text-[#1a2a5a]">
    <p class="text-3xl font-bold mt-2 mb-1">Szilvási István Péter</p>
    <p class="text-xl mt-4 opacity-80 m-0 font-bold">LBT_IM719G2 · Eger, 2026</p>
  </div>
  <div class="absolute top-[53.3%] left-1/2 transform -translate-x-1/2 -translate-y-1/2 flex flex-col items-center z-20 w-full">
    <div class="i-carbon-data-base text-6xl text-[#1a2a5a]" />
    <div class="w-[60%] border-b-2 border-white my-3"></div>
  </div>
</div>

---

::header::
Tematika
::default::

<div class="grid grid-cols-3 gap-5 mt-5">
  <div class="bg-white/5 p-6 rounded-xl border border-[#1a2a5a]/20">
    <div class="text-4xl font-bold text-[#1a2a5a]">01</div><h3 class="text-xl font-bold">DQL · Lekérdezés</h3>
    <p class="opacity-80">A HR sémában dolgozunk. SELECT, szűrés, JOIN, csoportosítás és rendezés segítségével nyerünk ki információt.</p>
  </div>
  <div class="bg-white/5 p-6 rounded-xl border border-[#1a2a5a]/20">
    <div class="text-4xl font-bold text-[#1a2a5a]">02</div><h3 class="text-xl font-bold">DDL + DML · Adatkezelés</h3>
    <p class="opacity-80">Saját sémában hozunk létre táblákat és kulcsokat, majd INSERT, UPDATE és DELETE utasításokkal kezeljük az adatokat.</p>
  </div>
  <div class="bg-white/5 p-6 rounded-xl border border-[#1a2a5a]/20">
    <div class="text-4xl font-bold text-[#1a2a5a]">03</div><h3 class="text-xl font-bold">PL/SQL · Programozás</h3>
    <p class="opacity-80">Változókkal, elágazásokkal, ciklusokkal, kivételekkel és adatbázis-objektumokkal automatizálunk.</p>
  </div>
</div>
<div class="mt-8 flex items-center justify-center gap-3 text-xl text-[#1a2a5a] font-bold"><span>DQL</span><div class="i-carbon-arrow-right"/><span>DDL + DML</span><div class="i-carbon-arrow-right"/><span>PL/SQL</span></div>

---

::header::
1. DQL a HR sémában
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <h3 class="text-2xl font-bold text-[#1a2a5a]">Vállalati adatok, összefüggések</h3>
    <p class="opacity-80">A HR séma dolgozókat, részlegeket, munkaköröket és fizetéstörténetet tartalmaz. Meglévő adatokból keresünk válaszokat.</p>
    <ul class="space-y-2 mt-5">
      <li class="flex items-center"><div class="i-carbon-checkmark text-green mr-3"/>SELECT és WHERE: kiválasztás, szűrés</li>
      <li class="flex items-center"><div class="i-carbon-checkmark text-green mr-3"/>JOIN: kapcsolódó táblák összefűzése</li>
      <li class="flex items-center"><div class="i-carbon-checkmark text-green mr-3"/>GROUP BY: csoportosítás és összesítés</li>
      <li class="flex items-center"><div class="i-carbon-checkmark text-green mr-3"/>ORDER BY: áttekinthető eredmény</li>
    </ul>
  </div>
  <div class="bg-[#1a2a5a] text-white rounded-xl p-5 text-sm leading-relaxed">
<pre v-pre class="text-white text-sm leading-relaxed">
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
    <p class="text-white/70 text-xs mt-2">Egy kérdés, több tábla, csoportosított válasz.</p>
  </div>
</div>

---

::header::
Lekérdezés és tiszta kód
::default::

<div class="grid grid-cols-2 gap-8">
  <div class="space-y-4">
    <h3 class="text-2xl font-bold text-[#1a2a5a]">A jó eredmény önmagában kevés</h3>
    <p class="opacity-80">A lekérdezést másnak is el kell tudnia olvasni, ellenőrizni és később módosítani.</p>
    <ul class="space-y-2">
      <li class="flex items-start"><div class="i-carbon-checkmark text-green mr-3 mt-1"/><span><strong>Aliasok:</strong> e és d jelöli a táblákat; az oszlopok eredete mindig világos.</span></li>
      <li class="flex items-start"><div class="i-carbon-checkmark text-green mr-3 mt-1"/><span><strong>Formázás:</strong> kulcsszavak nagybetűvel, logikai blokkok külön sorban.</span></li>
      <li class="flex items-start"><div class="i-carbon-checkmark text-green mr-3 mt-1"/><span><strong>Kifejező nevek:</strong> az alias mondja el, mit jelent a számított oszlop.</span></li>
    </ul>
  </div>
  <div class="bg-[#1a2a5a] text-white rounded-xl p-6">
<pre v-pre class="text-white text-sm leading-relaxed">
SELECT e.first_name,
       e.last_name,
       d.department_name
FROM employees e
JOIN departments d
  ON d.department_id = e.department_id
WHERE e.salary > 8000
ORDER BY e.last_name;
</pre>
    <p class="text-white/70 text-sm">A tiszta formázás a hibakeresésnél és a csapatmunkában is időt takarít meg.</p>
  </div>
</div>

---

::header::
2. Saját séma, saját homokozó
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <h3 class="text-2xl font-bold text-[#1a2a5a]">Mi az a séma?</h3>
    <p class="opacity-80">Az Oracle-ben a séma egy felhasználóhoz tartozó adatbázis-objektumok névtere. A saját sémában dolgozva a tábláink nem keverednek a csoporttársak objektumaival.</p>
    <p class="opacity-80">Itt építjük fel és próbáljuk ki a saját megoldásainkat, kontrollált környezetben.</p>
  </div>
  <div class="grid grid-cols-2 gap-4 text-center">
    <div class="bg-white/5 p-5 rounded-xl border border-[#1a2a5a]/20"><div class="i-carbon-user text-4xl mx-auto text-[#1a2a5a]"/><strong>Hallgató A</strong><p class="m-0 text-sm opacity-70">saját séma</p><code>EDZOK</code></div>
    <div class="bg-white/5 p-5 rounded-xl border border-[#1a2a5a]/20"><div class="i-carbon-user text-4xl mx-auto text-[#1a2a5a]"/><strong>Hallgató B</strong><p class="m-0 text-sm opacity-70">saját séma</p><code>EDZOK</code></div>
    <div class="col-span-2 flex justify-center"><div class="i-carbon-data-base text-4xl text-[#1a2a5a]"/></div>
    <p class="col-span-2 text-sm opacity-70 m-0">Azonos objektumnév, külön tulajdonos és névtér.</p>
  </div>
</div>

---

::header::
DDL · A szerkezet megtervezése
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div class="space-y-4">
    <h3 class="text-2xl font-bold text-[#1a2a5a]">Táblák és szabályok</h3>
    <p class="opacity-80">A DDL (Data Definition Language) az adatbázis szerkezetét írja le. A táblák oszlopai mellett azt is meghatározzuk, milyen adatok érvényesek.</p>
    <ul class="space-y-2">
      <li><strong>PRIMARY KEY:</strong> egyértelműen azonosítja a sort.</li>
      <li><strong>FOREIGN KEY:</strong> másik tábla létező sorára hivatkozik.</li>
      <li><strong>NOT NULL, CHECK:</strong> kizárja az érvénytelen állapotokat.</li>
    </ul>
  </div>
  <div class="bg-[#1a2a5a] text-white rounded-xl p-6 text-sm">
<pre v-pre class="text-white text-sm leading-relaxed">
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
DML · Adatmódosítás tranzakcióval
::default::

<div class="grid grid-cols-2 gap-8">
  <div>
    <h3 class="text-2xl font-bold text-[#1a2a5a]">A módosítások együtt kezelhetők</h3>
    <p class="opacity-80">Az INSERT, UPDATE és DELETE módosításai a tranzakció részei. COMMIT-tal véglegesítünk; ROLLBACK-kal visszavonjuk a még nem véglegesített módosításokat.</p>
    <p class="opacity-80">A tranzakciók határait tudatosan tervezzük: egy üzleti művelet összetartozó lépései együtt maradjanak sikeresek vagy együtt legyenek visszavonhatók.</p>
  </div>
  <div class="bg-[#1a2a5a] text-white rounded-xl p-5 text-sm">
<pre v-pre class="text-white text-sm leading-relaxed">
UPDATE edzok
SET fizetes = fizetes * 1.05
WHERE reszleg_id = 20;

-- Ellenőrzés után:
COMMIT;

-- Hiba esetén, COMMIT előtt:
ROLLBACK;
</pre>
    <div class="mt-3 grid grid-cols-2 gap-3 text-center"><div class="border border-white/30 p-3 rounded">COMMIT<br/><span class="text-xs opacity-70">véglegesítés</span></div><div class="border border-white/30 p-3 rounded">ROLLBACK<br/><span class="text-xs opacity-70">visszavonás</span></div></div>
  </div>
</div>

---

::header::
3. Miért PL/SQL?
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <h3 class="text-2xl font-bold text-[#1a2a5a]">SQL megmondja, mit kérünk</h3>
    <p class="opacity-80">A SQL deklaratív: leírjuk a kívánt adatot vagy módosítást, az adatbázis pedig végrehajtja a műveletet.</p>
    <h3 class="text-2xl font-bold text-[#1a2a5a] mt-6">PL/SQL megadja a lépéseket</h3>
    <p class="opacity-80">Változók, elágazások, ciklusok és hibakezelés segítségével fogalmazzuk meg az üzleti szabályokat a szerveren.</p>
  </div>
  <div class="bg-[#1a2a5a] text-white rounded-xl p-5 text-sm">
<pre v-pre class="text-white text-sm leading-relaxed">
DECLARE
  v_fizetes employees.salary%TYPE;
BEGIN
  SELECT salary
  INTO v_fizetes
  FROM employees
  WHERE employee_id = 100;

  IF v_fizetes > 10000 THEN
    DBMS_OUTPUT.PUT_LINE('Magas');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Normál');
  END IF;
END;
/
</pre>
    <p class="text-white/70 text-sm">Névtelen PL/SQL-blokk: DECLARE · BEGIN · END.</p>
  </div>
</div>

---

::header::
Adattípusok, amelyek együtt változnak az adattal
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <h3 class="text-2xl font-bold text-[#1a2a5a]">Használjuk a tábla definícióját</h3>
    <p class="opacity-80">A <code>%TYPE</code> attribútummal egy változó típusát egy oszlop típusához kötjük.</p>
    <p class="opacity-80">Így a PL/SQL-változó együtt fejlődik az oszloppal, és elkerüljük a típus vagy méret kézi megkettőzését.</p>
    <div class="mt-5 bg-white/5 p-4 rounded-xl border border-[#1a2a5a]/20"><strong class="text-[#1a2a5a]">Tipp:</strong> használd a valódi táblát és oszlopot, például <code>employees.salary%TYPE</code>.</div>
  </div>
  <div class="bg-[#1a2a5a] text-white rounded-xl p-6">
<pre v-pre class="text-white text-sm leading-relaxed">
DECLARE
  v_nev employees.last_name%TYPE;
  v_fizetes employees.salary%TYPE;
BEGIN
  SELECT last_name, salary
  INTO v_nev, v_fizetes
  FROM employees
  WHERE employee_id = 100;

  DBMS_OUTPUT.PUT_LINE(
    v_nev || ': ' || v_fizetes
  );
END;
/
</pre>
  </div>
</div>

---

::header::
4. Több sor: kurzorok
::default::

<div class="grid grid-cols-2 gap-8 items-center">
  <div>
    <h3 class="text-2xl font-bold text-[#1a2a5a]">A SELECT INTO egy sort vár</h3>
    <p class="opacity-80">A SELECT INTO pontosan egy sort töltsön be. Nulla találatnál NO_DATA_FOUND, több találatnál TOO_MANY_ROWS kivétel keletkezik.</p>
    <p class="opacity-80">Több sor feldolgozására kurzort, gyakran Cursor FOR Loop-ot használunk. A ciklus megnyitja, bejárja és lezárja a kurzort.</p>
  </div>
  <div class="bg-[#1a2a5a] text-white rounded-xl p-5 text-sm">
<pre v-pre class="text-white text-sm leading-relaxed">
BEGIN
  FOR r IN (
    SELECT employee_id, last_name
    FROM employees
    WHERE department_id = 50
    ORDER BY last_name
  ) LOOP
    DBMS_OUTPUT.PUT_LINE(
      r.employee_id || ' ' || r.last_name
    );
  END LOOP;
END;
/
</pre>
  </div>
</div>

---

::header::
Kurzorok, zárolás és kivételek
::default::

<div class="grid grid-cols-3 gap-5 mt-4">
  <div class="bg-white/5 p-5 rounded-xl border border-[#1a2a5a]/20"><div class="i-carbon-locked text-4xl text-[#1a2a5a]"/><h3 class="font-bold">FOR UPDATE</h3><p class="text-sm opacity-80">A kiválasztott sorokat zárolhatjuk a tranzakció végéig, hogy más tranzakció ne módosítsa őket párhuzamosan.</p></div>
  <div class="bg-white/5 p-5 rounded-xl border border-[#1a2a5a]/20"><div class="i-carbon-warning text-4xl text-[#1a2a5a]"/><h3 class="font-bold">Beépített kivételek</h3><p class="text-sm opacity-80">A NO_DATA_FOUND és TOO_MANY_ROWS a lekérdezés eredményének eseteit jelzi; kezeljük őket tudatosan.</p></div>
  <div class="bg-white/5 p-5 rounded-xl border border-[#1a2a5a]/20"><div class="i-carbon-rule text-4xl text-[#1a2a5a]"/><h3 class="font-bold">Saját üzleti hiba</h3><p class="text-sm opacity-80">A RAISE_APPLICATION_ERROR érthető, alkalmazás felé továbbítható hibát ad, például tiltott negatív fizetéskor.</p></div>
</div>
<div class="bg-[#1a2a5a] text-white rounded-xl p-4 mt-5 text-sm">
<pre v-pre class="text-white text-sm leading-relaxed">
IF p_fizetes < 0 THEN
  RAISE_APPLICATION_ERROR(-20001, 'A fizetés nem lehet negatív.');
END IF;
</pre>
</div>

---

::header::
5. Újrahasznosítható alprogramok
::default::

<div class="grid grid-cols-2 gap-8">
  <div class="bg-white/5 p-6 rounded-xl border border-[#1a2a5a]/20">
    <div class="i-carbon-function text-4xl text-[#1a2a5a]"/><h3 class="text-2xl font-bold text-[#1a2a5a]">Függvény</h3>
    <p class="opacity-80">Egy értéket számít ki és <code>RETURN</code>-nel ad vissza. Lekérdezésekben is használható, ha megfelelnek az SQL-hívás szabályainak.</p>
    <div class="bg-[#1a2a5a] text-white p-4 rounded text-sm">
<pre v-pre class="text-white text-sm leading-relaxed">
CREATE OR REPLACE FUNCTION
  eves_fizetes(p_havi NUMBER)
  RETURN NUMBER IS
BEGIN
  RETURN p_havi * 12;
END;
/
</pre>
    </div>
  </div>
  <div class="bg-white/5 p-6 rounded-xl border border-[#1a2a5a]/20">
    <div class="i-carbon-workflow-automation text-4xl text-[#1a2a5a]"/><h3 class="text-2xl font-bold text-[#1a2a5a]">Eljárás</h3>
    <p class="opacity-80">Egy műveletet vagy üzleti folyamatot hajt végre. IN, OUT és IN OUT paraméterekkel kommunikálhat a hívóval.</p>
    <div class="bg-[#1a2a5a] text-white p-4 rounded text-sm">
<pre v-pre class="text-white text-sm leading-relaxed">
CREATE OR REPLACE PROCEDURE
  udvozles(p_nev IN VARCHAR2) IS
BEGIN
  DBMS_OUTPUT.PUT_LINE(
    'Üdv, ' || p_nev
  );
END;
/
</pre>
    </div>
  </div>
</div>

---

::header::
Triggerekkel automatizálunk
::default::

<div class="grid grid-cols-2 gap-8">
  <div class="space-y-4">
    <h3 class="text-2xl font-bold text-[#1a2a5a]">A trigger eseményre fut le</h3>
    <p class="opacity-80">A trigger egy táblán vagy más adatbázis-objektumon bekövetkező eseményhez kötött PL/SQL-kód. INSERT, UPDATE vagy DELETE indíthatja el.</p>
    <div class="border-l-4 border-[#1a2a5a] pl-4"><strong>BEFORE</strong><p class="m-0 opacity-80">Validáció, érték ellenőrzése vagy kitöltése a művelet előtt.</p></div>
    <div class="border-l-4 border-[#1a2a5a]/40 pl-4"><strong>AFTER</strong><p class="m-0 opacity-80">Naplózás vagy más, sikeres művelet utáni teendő.</p></div>
    <p class="text-sm opacity-70">Sor szintű triggerekben a <code>:OLD</code> a korábbi, a <code>:NEW</code> az új oszlopértékre hivatkozik.</p>
  </div>
  <div class="bg-[#1a2a5a] text-white rounded-xl p-5 text-sm">
<pre v-pre class="text-white text-sm leading-relaxed">
CREATE OR REPLACE TRIGGER
  trg_edzok_fizetes
BEFORE INSERT OR UPDATE OF fizetes
ON edzok
FOR EACH ROW
BEGIN
  IF :NEW.fizetes < 0 THEN
    RAISE_APPLICATION_ERROR(
      -20001,
      'A fizetés nem lehet negatív.'
    );
  END IF;
END;
/
</pre>
  </div>
</div>