# Terraform Provider Hashicups


### 1. Создать бинарный файл плагина и разместить его в локальном репозитории
 
Перейти в папку с make-файлом и выполнить следующие действия:

а) Инициализировать модуль:

````shell
go mod init terraform-provider-hashicups-custom
````

б) Добавить отсутствующие модули и удалить неиспользуемые:
````shell
go mod tidy
````

в) Создать локальную копию зависимостей:
````shell
go mod vendor 
````

г) Вызвать make-файл, который скомпилирует плагин с размещением результата в бинарном файле, создаст директорию
плагинов в `~/.terraform.d/plugins` и скопировать туда созданный бинарный файл: 
````shell
make all
````


### 2. Проверить работоспособность плагина

а) После каждого изменения конфигурации следует перейти в папку terraform и инициализировать конфигурацию:
````shell
terraform init
````

б) После этого можно применять конфигурацию и получить результат:
````shell
terraform apply -auto-approve
````

Подробнее о создании и использовании пользовательских плагинов: 
https://learn.hashicorp.com/collections/terraform/providers

---
**API-сервера:**

Состояние сервера:
curl http://localhost:19090/health

Данные о заказах (jq - утилита форматирования `json`-вывода):
curl http://localhost:19090/coffees | jq

---

Создание пользователя:
````shell
curl -X POST localhost:19090/signup -d '{"username":"education", "password":"test123"}'
````

Аутентификация пользователя:
````shell
curl -X POST localhost:19090/signin -d '{"username":"education", "password":"test123"}'
````

Получение данных о заказе:
````shell
curl -X GET  -H "Authorization: ${HASHICUPS_TOKEN}" localhost:19090/orders/<Номер заказа>
````

Получение данных о заказе по параметру:
````shell
url -X POST -H "Authorization: ${HASHICUPS_TOKEN}" localhost:19090/orders -d '[{"coffee": { "id":1 }}]' | jq
````
