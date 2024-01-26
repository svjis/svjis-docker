USER=sysdba
PASSWORD=change-it
HOST=svjis-db
DATABASE=SVJIS_PRODUCTION

/usr/local/firebird/bin/isql -user "$USER" -password "$PASSWORD" -input '/firebird/database.sql' "$HOST:$DATABASE"
rm /firebird/database.sql
echo "EXECUTE PROCEDURE SP_CREATE_COMPANY 'New Company'; COMMIT;" > /firebird/comp.sql
/usr/local/firebird/bin/isql -user "$USER" -password "$PASSWORD" -input '/firebird/comp.sql' "$HOST:$DATABASE"
rm /firebird/comp.sql
