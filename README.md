# k8szone

AKS Playground.

## Azure Login
```shell
az login
```

## Install K8s
```shell
cd terraform
terraform init
terraform apply -auto-approve
...
terraform destroy
```

## Install Azure Vote
```shell
./install-vote.sh
```

## Install Kubernetes Dashboard
```shell
helm install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard

#kubectl delete clusterrolebinding kubernetes-dashboard

kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard --user=clusterUser

kubectl proxy

curl http://localhost:8001/api/v1/namespaces/default/services/https:kubernetes-dashboard:https/proxy/

```