#!/bin/bash

# Связывание пользователей с ролями
# PropDevelopment

# dev-user -> viewer
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: dev-user-viewer
subjects:
- kind: User
  name: dev-user
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: viewer
  apiGroup: rbac.authorization.k8s.io
EOF

echo "dev-user привязан к роли viewer"

# devops-user -> configurator
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: devops-user-configurator
subjects:
- kind: User
  name: devops-user
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: configurator
  apiGroup: rbac.authorization.k8s.io
EOF

echo "devops-user привязан к роли configurator"

# security-user -> privileged-admin
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: security-user-privileged-admin
subjects:
- kind: User
  name: security-user
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: privileged-admin
  apiGroup: rbac.authorization.k8s.io
EOF

echo "security-user привязан к роли privileged-admin"