# SVJIS Kubernetes

## 1. Start aplikace
```
kubectl apply -f svjis-configmap.yml
kubectl apply -f svjis-secret.yml
kubectl apply -f svjis-db.yml
kubectl apply -f svjis-app.yml
```

## 2. Vytvoření db schematu
```
kubectl cp create-schema.sh svjis-db-statefulset-0:/firebird/create-schema.sh
kubectl exec -it svjis-db-statefulset-0 -- bash "/firebird/create-schema.sh"
```

## 3. Po spuštění
* Spusťte aplikaci na adrese http://localhost:8080. 
* Přihlašte se jako `admin` heslo je `masterkey` (po přihlášení si změňte heslo). 
* Proveďte konfiguraci aplikace dle [wiki](https://github.com/svjis/svjis/wiki/Parametrizace).

## 4. Odstranění aplikace
```
kubectl delete -f svjis-app.yml
kubectl delete -f svjis-db.yml
kubectl delete -f svjis-secret.yml
kubectl delete -f svjis-configmap.yml
```

## 5. Některé příkazy
```
kubectl apply -f <yml>
kubectl delete -f <yml>
kubectl get nodes | pod | services | replicaset | deployment
kubectl get pod -o wide
kubectl logs <pod>
winpty kubectl exec -it [podname] -- bash
```

Secret values are base64 encoded
```
echo -n 'username' | base64
```

Watching pod
```
kubectl get pod --watch
```
