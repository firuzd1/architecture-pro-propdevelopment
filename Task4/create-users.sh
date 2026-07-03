#!/bin/bash

# Создание пользователей для кластера Kubernetes
# PropDevelopment — скрипт создания пользователей

# Пользователь 1 — разработчик (viewer)
openssl genrsa -out dev-user.key 2048
openssl req -new -key dev-user.key -out dev-user.csr -subj "/CN=dev-user/O=developers"

cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: dev-user
spec:
  request: $(cat dev-user.csr | base64 | tr -d '\n')
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth
EOF

kubectl certificate approve dev-user
kubectl get csr dev-user -o jsonpath='{.status.certificate}' | base64 -d > dev-user.crt

kubectl config set-credentials dev-user \
  --client-certificate=dev-user.crt \
  --client-key=dev-user.key

echo "Пользователь dev-user создан"

# Пользователь 2 — devops инженер (configurator)
openssl genrsa -out devops-user.key 2048
openssl req -new -key devops-user.key -out devops-user.csr -subj "/CN=devops-user/O=devops-engineers"

cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: devops-user
spec:
  request: $(cat devops-user.csr | base64 | tr -d '\n')
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth
EOF

kubectl certificate approve devops-user
kubectl get csr devops-user -o jsonpath='{.status.certificate}' | base64 -d > devops-user.crt

kubectl config set-credentials devops-user \
  --client-certificate=devops-user.crt \
  --client-key=devops-user.key

echo "Пользователь devops-user создан"

# Пользователь 3 — специалист по ИБ (privileged-admin)
openssl genrsa -out security-user.key 2048
openssl req -new -key security-user.key -out security-user.csr -subj "/CN=security-user/O=security-admins"

cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: security-user
spec:
  request: $(cat security-user.csr | base64 | tr -d '\n')
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth
EOF

kubectl certificate approve security-user
kubectl get csr security-user -o jsonpath='{.status.certificate}' | base64 -d > security-user.crt

kubectl config set-credentials security-user \
  --client-certificate=security-user.crt \
  --client-key=security-user.key

echo "Пользователь security-user создан"