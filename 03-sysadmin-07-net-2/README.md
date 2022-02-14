# Домашнее задание к занятию "3.7. Компьютерные сети, лекция 2"

1. Проверьте список доступных сетевых интерфейсов на вашем компьютере. Какие команды есть для этого в Linux и в Windows?

- вот несколько способов в Linux
```bash
vagrant@vagrant:/sys/class/net$ ls
eth0  eth1  lo
```
- или

```bash
vagrant@vagrant:/sys/class/net$ ip -br link show
lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP>
eth0             UP             08:00:27:b1:28:5d <BROADCAST,MULTICAST,UP,LOWER_UP>
eth1             DOWN           08:00:27:3b:34:7e <BROADCAST,MULTICAST>
```
- или
```bash
vagrant@vagrant:/sys/class/net$ ifconfig
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.2.15  netmask 255.255.255.0  broadcast 10.0.2.255
        inet6 fe80::a00:27ff:feb1:285d  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:b1:28:5d  txqueuelen 1000  (Ethernet)
        RX packets 34218  bytes 24718362 (24.7 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 27686  bytes 2306501 (2.3 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 176  bytes 16684 (16.6 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 176  bytes 16684 (16.6 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

- в Windows
```bash
C:\Windows\system32>ipconfig

Настройка протокола IP для Windows


Адаптер Ethernet VirtualBox Host-Only Network:

   DNS-суффикс подключения . . . . . :
   Локальный IPv6-адрес канала . . . : fe80::d481:6a6a:92b1:7bc7%9
   IPv4-адрес. . . . . . . . . . . . : 192.168.56.1
   Маска подсети . . . . . . . . . . : 255.255.255.0
   Основной шлюз. . . . . . . . . :

Адаптер Ethernet VirtualBox Host-Only Network #2:

   DNS-суффикс подключения . . . . . :
   Локальный IPv6-адрес канала . . . : fe80::d1af:fbf7:8a4c:fda8%12
   IPv4-адрес. . . . . . . . . . . . : 192.168.33.1
   Маска подсети . . . . . . . . . . : 255.255.255.0
   Основной шлюз. . . . . . . . . :

Адаптер Ethernet Ethernet:

   DNS-суффикс подключения . . . . . :
   Локальный IPv6-адрес канала . . . : fe80::54bc:53f5:b269:973f%10
   IPv4-адрес. . . . . . . . . . . . : 192.168.0.63
   Маска подсети . . . . . . . . . . : 255.255.255.0
   Основной шлюз. . . . . . . . . : 192.168.0.1
```
---
2. Какой протокол используется для распознавания соседа по сетевому интерфейсу? Какой пакет и команды есть в Linux для этого?
- Протокол обнаружения соседей (англ. Neighbor Discovery Protocol, NDP ), команда lldpctl из пакета lldpd
---
3. Какая технология используется для разделения L2 коммутатора на несколько виртуальных сетей? Какой пакет и команды есть в Linux для этого? Приведите пример конфига.
-
---
4. Какие типы агрегации интерфейсов есть в Linux? Какие опции есть для балансировки нагрузки? Приведите пример конфига.
-
---
5. Сколько IP адресов в сети с маской /29 ? Сколько /29 подсетей можно получить из сети с маской /24. Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.
-
---
6. Задача: вас попросили организовать стык между 2-мя организациями. Диапазоны 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 уже заняты. Из какой подсети допустимо взять частные IP адреса? Маску выберите из расчета максимум 40-50 хостов внутри подсети.
-
---
7. Как проверить ARP таблицу в Linux, Windows? Как очистить ARP кеш полностью? Как из ARP таблицы удалить только один нужный IP?
-
---
---
---
 8. \* Установите эмулятор EVE-ng.
 Инструкция по установке - https://github.com/svmyasnikov/eve-ng
 Выполните задания на lldp, vlan, bonding в эмуляторе EVE-ng.
-
