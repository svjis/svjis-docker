# SVJIS Docker compose

Spuštění
```
docker-compose -f svjis.yml up
```

Zastavení
```
docker-compose -f svjis.yml down
```

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


## Prvotní vytvoření schematu

Zjistěte id DB kontejneru
```
docker ps
```
Přihlašte se do něj
```
docker exec -it docker-compose_svjis-db_1 bash
```
Spusťe postupně následující příkazy (heslo do databáze nahraďte za aktuální)
```sh
apt-get update
apt-get install -qy --no-install-recommends curl
curl -k -L -o /firebird/database.sql -L https://raw.githubusercontent.com/svjis/svjis/master/db_schema/database.sql
/usr/local/firebird/bin/isql -user 'sysdba' -password 'sdjfsdhf21f' -input '/firebird/database.sql' 'localhost:SVJIS_TEST'
rm /firebird/database.sql
echo "EXECUTE PROCEDURE SP_CREATE_COMPANY 'Test Company'; COMMIT;" > /firebird/comp.sql
/usr/local/firebird/bin/isql -user 'sysdba' -password 'sdjfsdhf21f' -input '/firebird/comp.sql' 'localhost:SVJIS_TEST'
rm /firebird/comp.sql
apt-get purge -qy --auto-remove curl
exit
```

## Po spuštění

* Spusťte aplikaci na adrese http://localhost:8080. 
* Přihlašte se jako `admin` heslo je `masterkey`. 
* Proveďte konfiguraci aplikace dle [wiki](https://github.com/svjis/svjis/wiki/Parametrizace).
