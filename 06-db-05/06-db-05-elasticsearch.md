# Домашнее задание к занятию "6.5. Elasticsearch"

## Задача 1



Используя докер образ [centos:7](https://hub.docker.com/_/centos) как базовый и
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для elasticsearch
- соберите docker-образ и сделайте `push` в ваш docker.io репозиторий
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины

Требования к `elasticsearch.yml`:
- данные `path` должны сохраняться в `/var/lib`
- имя ноды должно быть `netology_test`

```yml
node:
  name: netology_test
path:
  data: /var/lib/elasticsearch
xpack.ml.enabled: false
xpack.security.enabled: false
node.store.allow_mmap: false
```

В ответе приведите:
- текст Dockerfile манифеста
```docker
FROM centos:centos7.9.2009
WORKDIR /usr/src/elasticsearch
COPY ./elasticsearch-8.2.2-linux-x86_64.tar.gz /usr/src/elasticsearch/elasticsearch-8.2.2-linux-x86_64.tar.gz
RUN yum -y install sudo && tar -xzf elasticsearch-8.2.2-linux-x86_64.tar.gz
RUN /bin/sh -c 'mkdir /var/lib/elasticsearch && mkdir /var/lib/elasticsearch/data && useradd -s /sbin/nologin elastic'
RUN /bin/sh -c 'rm -f /usr/src/elasticsearch/elasticsearch-8.2.2/config/elasticsearch.yml'
COPY ./elasticsearch.yml /usr/src/elasticsearch/elasticsearch-8.2.2/config
RUN /bin/sh -c 'chown -R elastic /usr/src/elasticsearch/elasticsearch-8.2.2 && chown -R elastic /var/lib/elasticsearch'
EXPOSE 9200
EXPOSE 9300
ENTRYPOINT sudo -u elastic /usr/src/elasticsearch/elasticsearch-8.2.2/bin/elasticsearch
```

- ссылку на образ в репозитории dockerhub
    - https://hub.docker.com/repository/docker/kylich/es-netology/general
- ответ `elasticsearch` на запрос пути `/` в json виде
```json
{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "_na_",
  "version" : {
    "number" : "8.2.2",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "9876968ef3c745186b94fdabd4483e01499224ef",
    "build_date" : "2022-05-25T15:47:06.259735307Z",
    "build_snapshot" : false,
    "lucene_version" : "9.1.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
```
---

## Задача 2

В этом задании вы научитесь:
- создавать и удалять индексы
- изучать состояние кластера
- обосновывать причину деградации доступности данных

Ознакомтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html)
и добавьте в `elasticsearch` 3 индекса, в соответствии со таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |

Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.

```
  green  open ind-1 YsRI5sXWjfTgIvyquWYFaL 1 0 0 0 208b 208b
  yellow open ind-3 89YbM4v25mj8YzmTxuhY98 4 2 0 0 832b 832b
  yellow open ind-2 0lap1GzqTmfDz57dWNAYz6 2 1 0 0 416b 416b

```

Получите состояние кластера `elasticsearch`, используя API.

```json
{
  "cluster_name": "elasticsearch",
  "status": "yellow",
  "timed_out": false,
  "number_of_nodes": 1,
  "number_of_data_nodes": 1,
  "active_primary_shards": 7,
  "active_shards": 7,
  "relocating_shards": 0,
  "initializing_shards": 0,
  "unassigned_shards": 10,
  "delayed_unassigned_shards": 0,
  "number_of_pending_tasks": 0,
  "number_of_in_flight_fetch": 0,
  "task_max_waiting_in_queue_millis": 0,
  "active_shards_percent_as_number": 40.840881624187
}
```

- Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?
  - Из-за отсутствия возможности реплицирования

- Удалите все индексы.
---
## Задача 3

- Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.

- Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository)
данную директорию как `snapshot repository` c именем `netology_backup`.

- **Приведите в ответе** запрос API и результат вызова API для создания репозитория.

```json
$ curl -X PUT "localhost:9200/test?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  }
}
'

$ curl localhost:9200/_cat/indices?v
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases g8nBVXU6h0uof6LmVwyY1P   1   0         41            0     60.1mb         60.1mb
green  open   test             m0QmFpaggRRGx7hg5VD040   1   0          0            0       226b           226b
```

```

```json
curl http://localhost:9200/_snapshot/netology_backup

{
  "netology_backup": {
    "type": "fs",
    "settings": {
      "location": "/usr/src/elasticsearch/elasticsearch-8.2.2/snapshots"
    }
  }
}
```

- Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

```json
curl -X PUT -H "Content-Type:application/json" -d '{"settings": {"index": {"number_of_shards": 1, "number_of_replicas": 0}}}' http://localhost:9200/test

{"acknowledged":true,"shards_acknowledged":true,"index":"test"}
```

- [Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html)
состояния кластера `elasticsearch`.

```json
curl -X PUT -H "Content-Type:application/json" http://localhost:9200/_snapshot/netology_backup/snapshot_1?wait_for_completion=true

{
  "snapshot": {
    "snapshot": "snapshot_1",
    "uuid": "Fmvla9oqVInjM3JNjxykkA",
    "version_id": 7100299,
    "version": "8.2.2",
    "indices": [
      "test"
    ],
    "data_streams": [],
    "include_global_state": true,
    "state": "SUCCESS",
    "start_time": "2022-05-25T16:40:12.920Z",
    "start_time_in_millis": 1633022938429,
    "end_time": "2022-05-25T16:40:12.920Z",
    "end_time_in_millis": 1633022938429,
    "duration_in_millis": 0,
    "failures": [],
    "shards": {
      "total": 1,
      "failed": 0,
      "successful": 1
    }
  }
}

```

- **Приведите в ответе** список файлов в директории со `snapshot`ами.

```sh
ls -l /usr/src/elasticsearch/elasticsearch-8.2.2/snapshots/
total 20
-rw-r--r-- 1 elastic elastic  434 Jul 19 23:50 index-0
-rw-r--r-- 1 elastic elastic    8 Jul 19 23:50 index.latest
drwxr-xr-x 3 elastic elastic 4096 Jul 19 23:50 indices
-rw-r--r-- 1 elastic elastic  299 Jul 19 23:50 meta-tG8ZPQbHfomiVQv3JtP6p3.dat
-rw-r--r-- 1 elastic elastic  266 Jul 19 23:50 snap-tG8ZPQbHfomiVQv3JtP6p3.dat
```

- Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

```json
curl -X DELETE http://localhost:9200/test
{"acknowledged":true}

curl -X PUT -H "Content-Type:application/json" -d '{"settings": {"index": {"number_of_shards": 1, "number_of_replicas": 0}}}' http://localhost:9200/test-2
{"acknowledged":true,"shards_acknowledged":true,"index":"test-2"}

curl http://localhost:9200/_cat/indices
green open test-2 5k7uSmsuHxW5gnfbtN78Um 1 0 0 0 208b 208b
```

- [Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `elasticsearch` из `snapshot`, созданного ранее.

- **Приведите в ответе** запрос к API восстановления и итоговый список индексов.

```json
curl -X POST http://localhost:9200/_snapshot/netology_backup/snapshot_1/_restore
{"accepted":true}

curl http://localhost:9200/_cat/indices
green open test-2 5k7uSmsuHxW5gnfbtN78Um 1 0 0 0 208b 208b
green open test   UP6PnL6onUv2Bx2OZ0s1wb 1 0 0 0 208b 208b
```
