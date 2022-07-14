# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД - `\l`
- подключения к БД - `\c postgres`
- вывода списка таблиц - `\dt *.*`
- вывода описания содержимого таблиц - `\d database.table`
- выхода из psql - `\q`

## Задача 2

- Используя `psql` создайте БД `test_database`.
- Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).
- Восстановите бэкап БД в `test_database`.
- Перейдите в управляющую консоль `psql` внутри контейнера.
- Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.
- Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders`
с наибольшим средним значением размера элементов в байтах.
- **Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

```postgresql
SELECT `attname`, `avg_width` FROM `pg_stats` WHERE `tablename`='orders' ORDER BY  `avg_width` DESC LIMIT 1;

 attname | avg_width
---------+-----------
 title   |        16
(1 row)
```



## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.
```postgres
CREATE TABLE orders_1 (CHECK (price > 499)) INHERITS (orders);
CREATE TABLE orders_2 (CHECK (price <= 499)) INHERITS (orders);

CREATE RULE orders_1 AS ON INSERT TO orders WHERE (price > 499)
DO INSTEAD INSERT INTO orders_1 VALUES (NEW.*);

CREATE RULE orders_2 AS ON INSERT TO orders WHERE (price <= 499)
DO INSTEAD INSERT INTO orders_2 VALUES (NEW.*);

INSERT INTO orders_1 (title, price) (SELECT title, price FROM orders WHERE price > 499);
INSERT INTO orders_2 (title, price) (SELECT title, price FROM orders WHERE price <= 499);
```

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?
```postgresql
CREATE TABLE orders_1
    PARTITION OF orders
    FOR VALUES FROM (0) TO (499);

CREATE TABLE orders_2
    PARTITION OF orders
    FOR VALUES FROM (500) TO (MAXVALUE);
```
## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.
```postgres
pg_dump -h 172.66.0.2 -p 5432 -U postgres -O -F p  -C test_database > /docker/pgsql/test_database_dump.sql
```

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?
```postgres
CREATE TABLE public.orders (
    id integer NOT NULL CONSTRAINT must_be_different UNIQUE,
    title character varying(255) NOT NULL,
    price integer DEFAULT 0 CHECK (did >= 0)
);
```