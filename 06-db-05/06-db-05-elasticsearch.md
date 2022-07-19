# Домашнее задание к занятию "6.5. Elasticsearch"

## Задача 1

В этом задании вы потренируетесь в:
- установке elasticsearch
- первоначальном конфигурировании elastcisearch
- запуске elasticsearch в docker

Используя докер образ [centos:7](https://hub.docker.com/_/centos) как базовый и
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для elasticsearch
- соберите docker-образ и сделайте `push` в ваш docker.io репозиторий
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины

Требования к `elasticsearch.yml`:
- данные `path` должны сохраняться в `/var/lib`
- имя ноды должно быть `netology_test`

В ответе приведите:
- текст Dockerfile манифеста
```docker
FROM centos:centos7.9.2009
COPY elasticsearch-8.2.2-linux-x86_64.tar.gz .
RUN yum install -y java-11-openjdk wget curl perl-Digest-SHA
RUN export ES_HOME="/var/lib/elasticsearch" && \
    tar -xzf elasticsearch-8.2.2-linux-x86_64.tar.gz && \
    rm -f elasticsearch-8.2.2-linux-x86_64.tar.gz && \
    mv elasticsearch-8.2.2 ${ES_HOME} && \
    useradd -m -u 1000 elasticsearch && \
    chown elasticsearch:elasticsearch -R ${ES_HOME}
COPY --chown=elasticsearch:elasticsearch config/* /var/lib/elasticsearch/config/
USER 1000
WORKDIR /var/lib/elasticsearch/
EXPOSE 9200 9300
ENTRYPOINT ["bin/elasticsearch"]
```

- ссылку на образ в репозитории dockerhub
    - https://hub.docker.com/repository/docker/kylich/es-netology/general
- ответ `elasticsearch` на запрос пути `/` в json виде
```json
{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "1jxOaMjeQASfgV6f8TOKSg",
  "version" : {
    "number" : "8.2.2",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "bee86328705acaa9a6daede7140defd4d9ec56bd",
    "build_date" : "2022-07-18T23:04:11.875279988Z",
    "build_snapshot" : false,
    "lucene_version" : "8.11.1",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
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
  curl http://localhost:9200/_cat/indices

  green  open ind-1 DPKEoEAlT-ayiG4knJaL0w 1 0 0 0 208b 208b
  yellow open ind-3 7TaCyURsQJmEC5ybCao8bg 4 2 0 0 832b 832b
  yellow open ind-2 A9Q8jr6hQqmDZPBARGr37g 2 1 0 0 416b 416b

```

Получите состояние кластера `elasticsearch`, используя API.

```json
curl http://localhost:9200/_cluster/health

{
  "cluster_name": "netology",
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
  "active_shards_percent_as_number": 41.17647058823529
}
```

- Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?
  - Потому что в кластере всего один узел, а мы насоздавали реплики для индексов, и привязать их некуда.

- Удалите все индексы.
  ```
  curl -X DELETE http://localhost:9200/ind-{1..3}

  {"acknowledged":true}
  {"acknowledged":true}
  {"acknowledged":true}
  ```
---
## Задача 3

- Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.

- Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository)
данную директорию как `snapshot repository` c именем `netology_backup`.

- **Приведите в ответе** запрос API и результат вызова API для создания репозитория.

```json
curl -X PUT -H "Content-Type:application/json" -d '{"type": "fs", "settings": {"location": "/usr/src/elasticsearch/elasticsearch-7.10.2/snapshots"}}' http://localhost:9200/_snapshot/netology_backup

{"acknowledged":true}
```

```json
curl http://localhost:9200/_snapshot/netology_backup

{
  "netology_backup": {
    "type": "fs",
    "settings": {
      "location": "/usr/src/elasticsearch/elasticsearch-7.10.2/snapshots"
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
    "uuid": "TdQTCV2iTE2yfoL0fbBx3g",
    "version_id": 7100299,
    "version": "7.10.2",
    "indices": [
      "test"
    ],
    "data_streams": [],
    "include_global_state": true,
    "state": "SUCCESS",
    "start_time": "2021-09-30T16:40:30.920Z",
    "start_time_in_millis": 1633020030920,
    "end_time": "2021-09-30T16:40:30.920Z",
    "end_time_in_millis": 1633020030920,
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

```bash
ls -l /usr/src/elasticsearch/elasticsearch-7.10.2/snapshots/
total 20
-rw-r--r-- 1 elastic elastic  434 Sep 30 16:40 index-0
-rw-r--r-- 1 elastic elastic    8 Sep 30 16:40 index.latest
drwxr-xr-x 3 elastic elastic 4096 Sep 30 16:40 indices
-rw-r--r-- 1 elastic elastic  299 Sep 30 16:40 meta-TdQTCV2iTE2yfoL0fbBx3g.dat
-rw-r--r-- 1 elastic elastic  266 Sep 30 16:40 snap-TdQTCV2iTE2yfoL0fbBx3g.dat
```

- Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

```json
curl -X DELETE http://localhost:9200/test
{"acknowledged":true}

curl -X PUT -H "Content-Type:application/json" -d '{"settings": {"index": {"number_of_shards": 1, "number_of_replicas": 0}}}' http://localhost:9200/test-2
{"acknowledged":true,"shards_acknowledged":true,"index":"test-2"}

curl http://localhost:9200/_cat/indices
green open test-2 XHrn3FsrQ_epPdQHCT_6hA 1 0 0 0 208b 208b
```

- [Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `elasticsearch` из `snapshot`, созданного ранее.

- **Приведите в ответе** запрос к API восстановления и итоговый список индексов.

```json
curl -X POST http://localhost:9200/_snapshot/netology_backup/snapshot_1/_restore
{"accepted":true}

curl http://localhost:9200/_cat/indices
green open test-2 XHrn3FsrQ_epPdQHCT_6hA 1 0 0 0 208b 208b
green open test   rymNrEb6REWzbLTGMydikw 1 0 0 0 208b 208b
```
