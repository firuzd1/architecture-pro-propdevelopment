# Инструкция для ревьюера — Task7

## Предварительные требования

- Minikube запущен
- kubectl настроен
- OPA Gatekeeper установлен

## Установка Gatekeeper

```bash
kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/release-3.14/deploy/gatekeeper.yaml
```

## Шаги для проверки

### 1. Создать namespace с PodSecurity

```bash
kubectl apply -f 01-create-namespace.yaml
```

### 2. Применить constraint templates

```bash
kubectl apply -f gatekeeper/constraint-templates/privileged.yaml
kubectl apply -f gatekeeper/constraint-templates/hostpath.yaml
kubectl apply -f gatekeeper/constraint-templates/runasnonroot.yaml
```

### 3. Применить constraints

```bash
kubectl apply -f gatekeeper/constraints/privileged.yaml
kubectl apply -f gatekeeper/constraints/hostpath.yaml
kubectl apply -f gatekeeper/constraints/runasnonroot.yaml
```

### 4. Проверить что небезопасные поды отклоняются

```bash
kubectl apply -f insecure-manifests/01-privileged-pod.yaml
# ожидаем ошибку

kubectl apply -f insecure-manifests/02-hostpath-pod.yaml
# ожидаем ошибку

kubectl apply -f insecure-manifests/03-root-user-pod.yaml
# ожидаем ошибку
```

### 5. Проверить что безопасные поды проходят

```bash
kubectl apply -f secure-manifests/01-secure.yaml
kubectl apply -f secure-manifests/02-secure.yaml
kubectl apply -f secure-manifests/03-secure.yaml
```

### 6. Запустить скрипты проверки

```bash
bash verify/verify-admission.sh
bash verify/validate-security.sh
```