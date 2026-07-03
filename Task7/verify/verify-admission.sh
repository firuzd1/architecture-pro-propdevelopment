#!/bin/bash

echo "Проверяем что небезопасные поды отклоняются в audit-zone"
echo "---"

echo "1. Тест privileged pod — должен быть отклонён:"
kubectl apply -f ../insecure-manifests/01-privileged-pod.yaml
echo "---"

echo "2. Тест hostpath pod — должен быть отклонён:"
kubectl apply -f ../insecure-manifests/02-hostpath-pod.yaml
echo "---"

echo "3. Тест root user pod — должен быть отклонён:"
kubectl apply -f ../insecure-manifests/03-root-user-pod.yaml
echo "---"

echo "Проверяем что безопасные поды проходят валидацию"
echo "---"

echo "4. Тест secure pod 1 — должен быть принят:"
kubectl apply -f ../secure-manifests/01-secure.yaml
echo "---"

echo "5. Тест secure pod 2 — должен быть принят:"
kubectl apply -f ../secure-manifests/02-secure.yaml
echo "---"

echo "6. Тест secure pod 3 — должен быть принят:"
kubectl apply -f ../secure-manifests/03-secure.yaml
echo "---"

echo "Готово!"