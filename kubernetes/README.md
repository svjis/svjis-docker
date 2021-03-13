# SVJIS Kubernetes

## 1. Start aplikace
```sh
$ kubectl apply -f svjis-configmap.yml
$ kubectl apply -f svjis-secret.yml
$ kubectl apply -f svjis-db.yml
$ kubectl apply -f svjis-app.yml
$ kubectl apply -f svjis-loadbalancer.yml
```

Místo loadbalanceru je možné spustit ingress router:

```sh
$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/cloud/deploy.yaml
$ kubectl get pod -n ingress-nginx
$ kubectl apply -f svjis-ingress.yml
$ kubectl get ingress
```

## 2. Vytvoření db schematu
```sh
$ kubectl cp create-schema.sh svjis-db-statefulset-0:/firebird/create-schema.sh
$ kubectl exec -it svjis-db-statefulset-0 -- bash "/firebird/create-schema.sh"
```

## 3. Po spuštění
* Spusťte aplikaci na adrese http://localhost:8080 (v případě ingressu aplikace běží na https://svjis.com/). 
* Přihlašte se jako `admin` heslo je `masterkey` (po přihlášení si změňte heslo). 
* Proveďte konfiguraci aplikace dle [wiki](https://github.com/svjis/svjis/wiki/Parametrizace).

## 4. Odstranění aplikace
Pro odstranění ingressu:
```sh
$ kubectl delete -f svjis-ingress.yml
$ kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/cloud/deploy.yaml
```
Pro zbytek apliakce:
```sh
$ kubectl delete -f svjis-loadbalancer.yml
$ kubectl delete -f svjis-app.yml
$ kubectl delete -f svjis-db.yml
$ kubectl delete -f svjis-secret.yml
$ kubectl delete -f svjis-configmap.yml
```

## 5. Některé příkazy
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
