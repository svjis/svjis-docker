# SVJIS Docker compose

Spuštění
```
docker-compose -f svjis.yml up
```

Zastavení
```
docker-compose -f svjis.yml down
```

## Vytvoření schema databáze

Pokud jste docker compose spustili poprvé, tak bude potřeba vytvořit schema databáze.  

Zjistěte id DB kontejneru
```
docker ps
```
Zkopírujte skript pro vytvoření schematu a spusťte jej.
```
docker cp ./create-schema.sh docker-compose_svjis-db_1:/firebird/
docker exec -it docker-compose_svjis-db_1 bash "/firebird/create-schema.sh"
```

## Po spuštění

* Spusťte aplikaci na adrese http://localhost:8080. 
* Přihlašte se jako `admin` heslo je `masterkey`. 
* Proveďte konfiguraci aplikace dle [wiki](https://github.com/svjis/svjis/wiki/Parametrizace).

## Administrace databáze

Pokud jste spustili aplikaci poprvé tak je třeba vytvořit DB schema:  

Přihlašte se do Firebirdadminu: http://localhost:8081

* Database: SVJIS_TEST
* Host: svjis-db
* Username: SYSDBA
* Password: sdjfsdhf21f (v svjis.yml si nastavte vlastní heslo a to použijte i zde)
* Character Set: UTF8
* Server: FB_3.0
* Tlačítko Login