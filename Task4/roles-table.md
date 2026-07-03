# Таблица ролей Kubernetes — PropDevelopment

| Роль | Полномочия | Группа пользователей | Описание |
|------|-----------|---------------------|----------|
| viewer | get, list, watch — pods, services, deployments, configmaps | developers, analysts | только просмотр ресурсов кластера, без права изменений |
| configurator | get, list, watch, create, update, patch — pods, services, deployments, configmaps, ingresses | devops-engineers | настройка кластера, деплой приложений |
| privileged-admin | все действия включая get secrets, delete, create roles, rolebindings | security-admins | полный доступ, включая просмотр секретов и управление ролями |

## Обоснование ролей

По условию задания нужно минимум три группы:
- **viewer** — разработчики и аналитики, которым нужно смотреть состояние кластера но не менять его
- **configurator** — devops-инженеры, которые деплоят и настраивают сервисы
- **privileged-admin** — специалист по ИБ и старшие администраторы, которым нужен доступ к секретам и управлению ролями