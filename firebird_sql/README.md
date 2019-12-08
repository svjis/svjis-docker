# Databáze Firebird

## Jak sestavit image

Image sestavíte následujícím příkazem, který má několik parametrů:

* `DB_PW` - heslo správce databáze (uživate sysdba)
* `COMPANY_NAME` - URL vašeho SVJ. Databáze může obsahovat více SVJ - jak přidat další společnost je popsáno ve wiki projektu SVJIS.

```sh
docker build --build-arg DB_PW=password --build-arg COMPANY_NAME=my.svj.com -t firebird .
```

## Spuštění image

Image spustíte následujícím příkazem.

```sh
docker run -d --name fb -p 3050:3050 firebird
```

## Dokonfigurace po prvním spuštění

Po prvním spuštění je třeba ještě vytvořit uživatele `web` kterým bude k databazi přistupovat aplikace. Připojte se k běžící instanci databáze. 

```sh
docker exec -it fb bash
```

Pak vytvořte uživatele dle následujícího postupu.

```sh
isql-fb
Use CONNECT or CREATE DATABASE to specify a database
SQL> connect localhost:SVJIS_PRODUCTION user sysdba password <password>;
Database: localhost:SVJIS_PRODUCTION, User: SYSDBA
SQL> create user web password '<password>';
SQL> quit;
```
