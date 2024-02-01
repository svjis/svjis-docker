USER=sysdba
PASSWORD=change-it
DATABASE=SVJIS_PRODUCTION

sleep 1s
cat /etc/hosts
/usr/local/firebird/bin/isql -user "$USER" -password "$PASSWORD" -input '/firebird/database.sql' "host.docker.internal:$DATABASE"
rm /firebird/database.sql
echo "EXECUTE PROCEDURE SP_CREATE_COMPANY 'New Company'; COMMIT;" > /firebird/comp.sql
/usr/local/firebird/bin/isql -user "$USER" -password "$PASSWORD" -input '/firebird/comp.sql' "host.docker.internal:$DATABASE"
rm /firebird/comp.sql
