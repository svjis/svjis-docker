# SVJIS Kubernetes

Some commands
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
## Create schema
```
kubectl cp create-schema.sh svjis-db-deployment-865bbd64cf-bxx4j:/firebird/create-schema.sh
kubectl exec -it svjis-db-deployment-865bbd64cf-bxx4j -- bash "/firebird/create-schema.sh"
```
