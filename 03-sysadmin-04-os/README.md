1. На лекции мы познакомились с [node_exporter](https://github.com/prometheus/node_exporter/releases). В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой [unit-файл](https://www.freedesktop.org/software/systemd/man/systemd.service.html) для node_exporter:

    * поместите его в автозагрузку,
        - создал конфигурационный файл `vim /etc/systemd/system/node_exporter.service`

        ```bash
        [Unit]
        Description=Node Exporter Service
        After=network.target

        [Service]
        User=nodeusr
        Group=nodeusr
        Type=simple
        ExecStart=/usr/local/bin/node_exporter
        ExecReload=/bin/kill -HUP $MAINPID
        Restart=on-failure

        [Install]
        WantedBy=multi-user.target
        ```
    * предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на `systemctl cat cron`),
        - проверка статуса
        ```bash
        node_exporter.service - Node Exporter Service
            Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
            Active: active (running) since Mon 2022-01-24 09:51:18 UTC; 4min 28s ago
        Main PID: 1719 (node_exporter)
            Tasks: 4 (limit: 1071)
            Memory: 2.2M
            CGroup: /system.slice/node_exporter.service
                    └─1719 /usr/local/bin/node_exporter
        ```
    * удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.
        - остановка, повторный запуск и автозагрузка работают


___

1. Ознакомьтесь с опциями node_exporter и выводом `/metrics` по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.

    - CPU
        - process_cpu_seconds_total
        - node_cpu_seconds_total
    - Память
        - node_memory_MemAvailable_bytes
        - node_memory_MemFree_bytes
    - Диск
        - node_disk_io_time_seconds_total
        - node_disk_read_time_seconds_total
        - node_disk_write_time_seconds_total
    - Сеть
        - node_network_receive_bytes_total
        - node_network_transmit_bytes_total

___

1. Установите в свою виртуальную машину [Netdata](https://github.com/netdata/netdata). Воспользуйтесь [готовыми пакетами](https://packagecloud.io/netdata/netdata/install) для установки (`sudo apt install -y netdata`). После успешной установки:
    * в конфигурационном файле `/etc/netdata/netdata.conf` в секции [web] замените значение с localhost на `bind to = 0.0.0.0`,
    * добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте `vagrant reload`:

    ```bash
    config.vm.network "forwarded_port", guest: 19999, host: 19999
    ```

    После успешной перезагрузки в браузере *на своем ПК* (не в виртуальной машине) вы должны суметь зайти на `localhost:19999`. Ознакомьтесь с метриками, которые по умолчанию собираются Netdata и с комментариями, которые даны к этим метрикам.

    - 1

___

1. Можно ли по выводу `dmesg` понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?
    - 1
    ___
1. Как настроен sysctl `fs.nr_open` на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (`ulimit --help`)?
    - 1

___
1. Запустите любой долгоживущий процесс (не `ls`, который отработает мгновенно, а, например, `sleep 1h`) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через `nsenter`. Для простоты работайте в данном задании под root (`sudo -i`). Под обычным пользователем требуются дополнительные опции (`--map-root-user`) и т.д.
    - 1

___
1. Найдите информацию о том, что такое `:(){ :|:& };:`. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (**это важно, поведение в других ОС не проверялось**). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов `dmesg` расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?
    - 1

___