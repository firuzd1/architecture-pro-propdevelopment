#!/bin/bash

# Скрипт фильтрации audit.log
# PropDevelopment — поиск подозрительных событий

AUDIT_LOG="${1:-audit.log}"
OUTPUT="audit-extract.json"

echo "Анализируем файл: $AUDIT_LOG"
echo "---"

echo "1. Доступ к секретам:"
jq 'select(.objectRef.resource=="secrets" and .verb=="get")' $AUDIT_LOG

echo "---"
echo "2. Использование kubectl exec в чужих подах:"
jq 'select(.verb=="create" and .objectRef.subresource=="exec")' $AUDIT_LOG

echo "---"
echo "3. Привилегированные поды:"
jq 'select(.objectRef.resource=="pods" and .requestObject.spec.containers[].securityContext.privileged==true)' $AUDIT_LOG

echo "---"
echo "4. Удаление или изменение audit-policy:"
grep -i 'audit-policy' $AUDIT_LOG

echo "---"
echo "5. Создание RoleBinding с cluster-admin:"
jq 'select(.objectRef.resource=="rolebindings" and .requestObject.roleRef.name=="cluster-admin")' $AUDIT_LOG

echo "---"
echo "Сохраняем подозрительные события в $OUTPUT"

jq -s '[.[] | select(
  (.objectRef.resource=="secrets" and .verb=="get") or
  (.verb=="create" and .objectRef.subresource=="exec") or
  (.objectRef.resource=="pods" and .requestObject.spec.containers[].securityContext.privileged==true) or
  (.objectRef.resource=="rolebindings" and .requestObject.roleRef.name=="cluster-admin")
)]' $AUDIT_LOG > $OUTPUT

echo "Готово! Результат в $OUTPUT"