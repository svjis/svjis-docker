# Tomcat

## Jak sestavit image

Image sestavíte následujícím příkazem, který má několik parametrů:

```sh
docker build -t berk76/svjis-app:latest .
```

## Spuštění image

Porměnné prostředí

* `DB_SERVER` - databázový server
* `DB_USERNAME` - uživatelské jméno
* `DB_PASSWORD` - heslo 

```sh
docker run -e DB_SERVER=<db server> -e DB_USERNAME=<db user> -e DB_PASSWORD=<db password> -d --name svjis -p 8080:8080 berk76/svjis-app:latest
```

## Po spuštění

* Spusťte aplikaci na adrese http://localhost:8080. 
* Přihlašte se jako `admin` heslo je `masterkey`. 
* Proveďte konfiguraci aplikace dle [wiki](https://github.com/svjis/svjis/wiki/Parametrizace).
