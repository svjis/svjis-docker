# SVJIS Kubernetes

## 1. Start aplikace
```sh
$ kubectl apply -f svjis-namespace.yml
$ kubectl apply -f svjis-configmap.yml
$ kubectl apply -f svjis-secret.yml
$ kubectl apply -f svjis-db.yml
$ kubectl apply -f svjis-app.yml
```

### 1.1 Externí služba
Pro přístup k aplikaci je třeba spustit externí službu. Tou může být buď load-balancer nebo ingress.

#### 1.1.1 Load-Balancer
```sh
$ kubectl apply -f svjis-loadbalancer.yml
```

#### 1.1.2 Ingress
```sh
$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/cloud/deploy.yaml
$ kubectl get pod -n ingress-nginx
$ kubectl apply -f svjis-ingress.yml
$ kubectl get ingress -n svjis
```

## 2. Vytvoření db schematu
```sh
$ kubectl -n svjis cp create-schema.sh svjis-db-statefulset-0:/firebird/create-schema.sh
$ kubectl -n svjis exec -it svjis-db-statefulset-0 -- bash "/firebird/create-schema.sh"
```

## 3. Po spuštění
* Spusťte aplikaci na adrese http://localhost:8080 (v případě ingressu aplikace běží na https://svjis.com/). 
* Přihlašte se jako `admin` heslo je `masterkey` (po přihlášení si změňte heslo). 
* Proveďte konfiguraci aplikace dle [Dokumentace](https://svjis.github.io/Parametrizace/).


## 4. Instalace certifikátu
Pokud používáte Ingress, tak můžete nasadit certifikát pro vaši doménu.

### 4.1 Získání certifikátu
Certifikát lze získat od různých autorit různými způsoby. Uvedu zde jeden způsob jak získat certifikát od [Let's Encrypt](https://letsencrypt.org/). Co budete potřebovat:

* Budete potřebovat přístup k editaci zónového souboru DNS vaší domény. 
* Stáhněte si bash script [getssl](https://github.com/srvrco/getssl).

Vytvořte si konfiguraci pro vaší doménu (místo svjis.com vždy uveďte vaší doménu).
```sh
$ getssl -c svjis.com
```

Upravte vygenerovanou konfiguraci `$HOME/.getssl/getssl.cfg`.
```sh
# The staging server is best for testing (hence set as default)
#CA="https://acme-staging-v02.api.letsencrypt.org"
# This server issues full certificates, however has rate limits
CA="https://acme-v02.api.letsencrypt.org"

...

VALIDATE_VIA_DNS="true"
DNS_ADD_COMMAND="dns_add_acme_challenge.sh"
DNS_DEL_COMMAND="dns_del_acme_challenge.sh"
```

dns_add_acme_challenge.sh:
```sh
#!/bin/bash

fulldomain="$1"
token="$2"

echo "$fulldomain $token" > "dns_add_acme_challenge.output"

echo "Add $token into _acme-challenge.svjis.com TXT record."
read -p "Press any key to resume ..."
```

dns_del_acme_challenge.sh:
```sh
#!/bin/bash

fulldomain="$1"

echo "$fulldomain" > "dns_del_acme_challenge.output"
```

Pošlete žádost o vygenerování certifikátu
```sh
$ getssl svjis.com
```
Vložte token do _acme-challenge.az.svjis.com TXT záznamu jakmile o to budete požádáni. Po vygenerování certifikátu TXT záznam zase odstraňte.

### 4.2 Nasazení certifikátu
Vytvořte secret typu `kubernetes.io/tls` s certifikátem
```sh
$ kubectl -n svjis create secret tls svjis.com --key "svjis.com.key" --cert "svjis.com.crt"
```

Odkomentujte následující část konfigurace v souboru `svjis-ingress.yml` 
```yml
  tls:
  - hosts:
    - svjis.com
    secretName: svjis.com
```

Restartujte ingress
```sh
$ kubectl delete -f svjis-ingress.yml
$ kubectl apply -f svjis-ingress.yml
```

## 5. Odstranění aplikace
Odstranění se provede v opačném pořadí než spouštění.

### 5.1 Odstranění ingressu
```sh
$ kubectl delete -f svjis-ingress.yml
$ kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/cloud/deploy.yaml
```

### 5.2 Odstranění Load-Balanceru
```sh
$ kubectl delete -f svjis-loadbalancer.yml
```

### 5.3 Odstranění zbytku aplikace
```sh
$ kubectl delete -f svjis-app.yml
$ kubectl delete -f svjis-db.yml
$ kubectl delete -f svjis-secret.yml
$ kubectl delete -f svjis-configmap.yml
$ kubectl delete -f svjis-namespace.yml
```

## 6. Některé užitečné příkazy
```sh
$ kubectl apply -f <yml>
$ kubectl delete -f <yml>
$ kubectl get nodes | pod | services | replicaset | deployment
$ kubectl get pod -o wide
$ kubectl logs <pod>
$ winpty kubectl exec -it [podname] -- bash
```

Secret values are base64 encoded
```sh
$ echo -n 'username' | base64
```

Watching pod
```sh
$ kubectl get pod --watch
```
