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

## 4. Odstranění aplikace
Odstranění se provede v opačném pořadí než spouštění.

### 4.1 Odstranění ingressu
```sh
$ kubectl delete -f svjis-ingress.yml
$ kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/cloud/deploy.yaml
```

### 4.2 Odstranění Load-Balanceru
```sh
$ kubectl delete -f svjis-loadbalancer.yml
```

### 4.3 Odstranění zbytku aplikace
```sh
$ kubectl delete -f svjis-app.yml
$ kubectl delete -f svjis-db.yml
$ kubectl delete -f svjis-secret.yml
$ kubectl delete -f svjis-configmap.yml
$ kubectl delete -f svjis-namespace.yml
```

## 5. Některé užitečné příkazy
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
