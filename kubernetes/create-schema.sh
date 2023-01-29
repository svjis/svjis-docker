USER=sysdba
PASSWORD=change-it
DATABASE=SVJIS_PRODUCTION

apt-get update
apt-get install -qy --force-yes --no-install-recommends curl
curl -k -L -o /firebird/database.sql -L https://raw.githubusercontent.com/svjis/svjis/master/db_schema/database.sql
/usr/local/firebird/bin/isql -user "$USER" -password "$PASSWORD" -input '/firebird/database.sql' "localhost:$DATABASE"
rm /firebird/database.sql
echo "EXECUTE PROCEDURE SP_CREATE_COMPANY 'Test Company'; COMMIT;" > /firebird/comp.sql
/usr/local/firebird/bin/isql -user "$USER" -password "$PASSWORD" -input '/firebird/comp.sql' "localhost:$DATABASE"
rm /firebird/comp.sql
apt-get purge -qy --auto-remove curl
