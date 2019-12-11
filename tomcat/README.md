# Tomcat

## Jak sestavit image

Image sestavíte následujícím příkazem, který má několik parametrů:

* `DOMAIN` - URL vašeho SVJ.
* `DB_SR` - hostname nebo ip adresa databázového serveru
* `DB_US` - jméno uživatele (zpravidla `web`) 
* `DB_PW` - heslo uživatele 

```sh
docker build --build-arg DOMAIN=www.mysvj.com --build-arg DB_SR=server --build-arg DB_US=user --build-arg DB_PW=password -t tomcat .
```

## Spuštění image

```sh
docker run -d --name tom -p 8080:8080 tomcat
```

## Po spuštění

* Spusťte aplikaci na adrese http://localhost:8080. 
* Přihlašte se jako `admin` heslo je `masterkey`. 
* Proveďte konfiguraci aplikace dle [wiki](https://github.com/svjis/svjis/wiki/Parametrizace).
