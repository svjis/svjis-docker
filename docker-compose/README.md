# SVJIS Docker compose

Spuštění
```
docker-compose -f svjis.yml up
```

Zastavení
```
docker-compose -f svjis.yml down
```

## Vytvoření db schema

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