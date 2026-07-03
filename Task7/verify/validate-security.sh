#!/bin/bash

echo "Проверяем статус Gatekeeper constraints"
echo "---"

echo "1. Список всех constraints:"
kubectl get constraints -A
echo "---"

echo "2. Проверяем нарушения по privileged:"
kubectl get k8sdenyprivileged -o yaml
echo "---"

echo "3. Проверяем нарушения по hostpath:"
kubectl get k8sdenyhostpath -o yaml
echo "---"

echo "4. Проверяем нарушения по runasnonroot:"
kubectl get k8srequirerunasnonroot -o yaml
echo "---"

echo "5. Проверяем PodSecurity в namespace audit-zone:"
kubectl get namespace audit-zone -o yaml | grep pod-security
echo "---"

echo "6. Список подов в audit-zone:"
kubectl get pods -n audit-zone
echo "---"

echo "Готово!"