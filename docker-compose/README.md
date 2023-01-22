# SVJIS Docker compose

## 1. Spuštění aplikace

V souborech `svjis-dev.yml` a `create-schema.sh` změňte defaultní heslo `change-it` na nové.  

Spuštění
```
docker-compose -f svjis-dev.yml up
```

Zastavení
```
docker-compose -f svjis-dev.yml down
```

## 2. Vytvoření schematu databáze

Pokud jste SVJIS v docker compose spustili poprvé, tak bude potřeba vytvořit schema databáze.  

Stáhněte si poslední verzi databázového schema a zkopírujte ho do kontajneru
```
cd docker-compose
curl -k -L -o ./database.sql -L https://raw.githubusercontent.com/svjis/svjis/master/db_schema/database.sql
docker cp ./database.sql svjis_db:/firebird/
```

Zkopírujte skript pro vytvoření schematu a spusťte jej.
```
docker cp ./create-schema.sh svjis_db:/firebird/
docker exec -it svjis_db bash "/firebird/create-schema.sh"
```

## 3. Po spuštění

* Spusťte aplikaci na adrese http://localhost:8080. 
* Přihlašte se jako `admin` heslo je `masterkey` (po přihlášení si změňte heslo). 
* Proveďte konfiguraci aplikace dle [Dokumentace](https://svjis.github.io/Parametrizace/). Alternativně můžete spustit [automatický test](https://github.com/svjis/svjis-selenium), který vytvoří testovací obsah.

## 4. Administrace databáze

Přihlašte se do Firebirdadminu: http://localhost:8081

* Database: SVJIS_PRODUCTION
* Host: svjis-db
* Username: SYSDBA
* Password: change-it (v svjis.yml si nastavte vlastní heslo a to použijte i zde)
* Character Set: UTF8
* Server: FB_3.0
* Tlačítko Login
