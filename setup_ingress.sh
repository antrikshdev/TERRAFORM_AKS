#!/bin/bash
namespace="$1"
DNSNAME="$2"
cert_manager_version="$3"
IP=""
PUBLICIPID=""
kubectl create namespace "$namespace"
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install nginx-ingress ingress-nginx/ingress-nginx  --namespace "$namespace"  --set controller.replicaCount=2   --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux     --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz
#kubectl --namespace ingress-basic get services -o wide -w nginx-ingress-ingress-nginx-controller

#Installation of ingress controller complete
#Last command displays IP of Ingress Controller
sleep 120

IP=$(kubectl --namespace "$namespace" get services -o wide nginx-ingress-ingress-nginx-controller | awk '{print $4}' | head -n3 | tail -n1)
PUBLICIPID=$(az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$IP')].[id]" --output tsv)
az network public-ip update --ids "$PUBLICIPID" --dns-name "$DNSNAME"
az network public-ip show --ids "$PUBLICIPID" --query "[dnsSettings.fqdn]" --output tsv
#Configure an FQDN for ingress controller done above
#DNS assignment to IP done, last command displays FQDN

#helm upgrade nginx-ingress ingress-nginx/ingress-nginx --namespace $namespace --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-dns-label-name"=$DNSLABEL --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz

kubectl label namespace "$namespace" cert-manager.io/disable-validation=true
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager --namespace "$namespace" --version "$cert_manager_version"  --set installCRDs=true   --set nodeSelector."beta\.kubernetes\.io/os"=linux   jetstack/cert-manager

#Installation of cert manager complete
sleep 30

kubectl apply -f cluster-issuer.yml --namespace "$namespace"

sleep 30
kubectl apply -f aks-helloworld-one.yaml --namespace "$namespace"
kubectl apply -f aks-helloworld-two.yaml --namespace "$namespace"
kubectl apply -f hello-world-ingress-https.yaml --namespace "$namespace"

#Setup complete, can go ahead with helm chart installation

