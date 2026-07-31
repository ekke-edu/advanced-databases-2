# Adatbázisrendszerek II. - PL/SQL Gyakorlat (Pokémon Kiadás) 

Üdvözlünk a kurzuson! Ebben a félévben a Kanto régió adatbázisát fogjuk karbantartani és fejleszteni. Hogy ne menjen el az idő az Oracle adatbázis bonyolult telepítésével, a kurzushoz egy **DevContainer** környezetet használunk. Ez azt jelenti, hogy egyetlen gombnyomással felépül a gépeden a teljes fejlesztői környezet!

## 🛠️ Előfeltételek

Mielőtt elkezdenéd, győződj meg róla, hogy a gépeden telepítve vannak az alábbiak:
1. [Git](https://git-scm.com/downloads)
2. [Docker Desktop](https://www.docker.com/products/docker-desktop/) (Indítsd is el, fusson a háttérben!)
3. [Visual Studio Code](https://code.visualstudio.com/)
4. A VS Code-ban telepítsd a **Dev Containers** nevű hivatalos Microsoft kiegészítőt.

---

## 🚀 Telepítés és Indítás

### 1. A projekt klónozása
Nyiss egy terminált a gépeden, és klónozd le a tárolót a saját gépedre:

```bash
git clone <IDE_JÖN_A_REPO_LINKJE>
cd pokemon-plsql-kurzus
```

### 2. Megnyitás VS Code-ban
Nyisd meg a letöltött mappát a VS Code-ban:

```bash
code .
```

### 3. A DevContainer elindítása
Amint megnyílik a VS Code, a jobb alsó sarokban fel fog ugrani egy kék ablak:
"Folder contains a Dev Container configuration file".
Kattints a Reopen in Container gombra!

> 📓 Megjegyzés: Az első indítás eltarthat néhány percig, amíg a Docker letölti az Oracle adatbázist és beállítja a kiegészítőket. Légy türelemmel!

### 4. Csatlakozás az Adatbázishoz
Ha a környezet betöltött, csatlakoznunk kell a háttérben futó Oracle adatbázishoz:

1. A VS Code bal oldali sávjában keress egy új, Adatbázis hengert formázó ikont (Oracle Explorer).

2. Kattints a + (Add Connection) gombra.

3. Töltsd ki az űrlapot pontosan az alábbi adatokkal:

```
Connection Type: TNS
Connection Name: PokemonDB
TNS Name: POKEMON_DB
Username: poke_admin
Password: pokemon
```
> ✅ Pipáld be a _Save Password_ opciót!

> Kattints a _Create Connection_ gombra.

### 5. Az adatbázis inicializálása
Ahhoz, hogy elkezdhessük a feladatokat, létre kell hoznunk az edzők és Pokémonok tábláit:

1. A VS Code fájlkezelőjében (bal oldalt) nyisd meg az `init_pokemon_db.sql` fájlt.

>❕**Fontos** – Kapcsolat ellenőrzése: Nézz rá a VS Code jobb alsó sarkára. Ott látnod kell a `PokemonDB`-t aktív kapcsolatként. Ha ott esetleg _No connection attached_ szerepel, kattints rá, és válaszd ki a `PokemonDB`-t, különben nem fog tudni futni a kód!

2. Futtasd le a szkriptet.

> Nyomj F5-öt a billentyűzeten vagy a VS Code jobb felső sarkában lévő _Run Script (F5)_ gombra kattints rá.

3. A felugró ablakban válaszd ki az imént létrehozott `PokemonDB` kapcsolatot.

> A konzolon / Output ablakban látnod kell a sikeres futást jelző _Pokédex Adatbázis Sikeresen Inicializálva!_ üzenetet.
