# Домашнее задание к занятию "3.8. Компьютерные сети, лекция 3"

1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP
-
```bash
vagrant@vagrant:~$ telnet route-views.routeviews.org
Trying 128.223.51.103...
Connected to route-views.routeviews.org.
User Access Verification
Username: rviews
route-views>show ip route 37.145.191.199
Routing entry for 37.144.0.0/14
    Known via "bgp 6447", distance 20, metric 0
    Tag 6939, type external
    Last update from 64.71.137.241 6d00h ago
    Routing Descriptor Blocks:
    * 64.71.137.241, from 64.71.137.241, 6d00h ago
        Route metric is 0, traffic share count is 1
        AS Hops 3
        Route tag 6939
        MPLS label: none
```
```bash
route-views>show bgp 37.145.191.199/32
% Network not in table
route-views>show bgp 37.145.191.199
BGP routing table entry for 37.144.0.0/14, version 307565308
Paths: (23 available, best #16, table default)
        94.142.247.3    from 94.142.247.3 (94.142.247.3)
        132.198.255.253 from 132.198.255.253 (132.198.255.253)
        154.11.12.212   from 154.11.12.212 (96.1.209.43)
        37.139.139.17   from 37.139.139.17 (37.139.139.17)
        140.192.8.16    from 140.192.8.16 (140.192.8.16)
        193.0.0.56      from 193.0.0.56 (193.0.0.56)
        208.51.134.254  from 208.51.134.254 (67.16.168.191)
        137.39.3.55     from 137.39.3.55 (137.39.3.55)
        162.251.163.2   from 162.251.163.2 (162.251.162.3)
        4.68.4.46       from 4.68.4.46 (4.69.184.201)
        217.192.89.50   from 217.192.89.50 (138.187.128.158)
        162.250.137.254 from 162.250.137.254 (162.250.137.254)
        212.66.96.126   from 212.66.96.126 (212.66.96.126)
        12.0.1.63       from 12.0.1.63 (12.0.1.63)
        206.24.210.80   from 206.24.210.80 (206.24.210.80)
        64.71.137.241   from 64.71.137.241 (216.218.252.164)
        209.124.176.223 from 209.124.176.223 (209.124.176.223)
        202.232.0.2     from 202.232.0.2 (58.138.96.254)
        203.181.248.168 from 203.181.248.168 (203.181.248.168)
        91.218.184.60   from 91.218.184.60 (91.218.184.60)
        203.62.252.83   from 203.62.252.83 (203.62.252.83)
        89.149.178.10   from 89.149.178.10 (213.200.83.26)
        208.74.64.40    from 208.74.64.40 (208.74.64.40)
```
___
2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.
- создаем dummy
```bash
vagrant@vagrant:~$ sudo modprobe -v dummy numdummies=2
insmod /lib/modules/5.4.0-91-generic/kernel/drivers/net/dummy.ko numdummies=0 numdummies=2
vagrant@vagrant:~$ lsmod | grep dummy
dummy                  16384  0
```
- таблица маршрутизации
```bash
vagrant@vagrant:~$ route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         _gateway        0.0.0.0         UG    100    0        0 eth0
10.0.2.0        0.0.0.0         255.255.255.0   U     0      0        0 eth0
_gateway        0.0.0.0         255.255.255.255 UH    100    0        0 eth0
10.0.8.0        0.0.0.0         255.255.255.0   U     0      0        0 dummy0
```
___
3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

```bash
vagrant@vagrant:~$ sudo netstat -tlpn
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      2315/systemd-resolv
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      675/sshd: /usr/sbin
tcp6       0      0 :::22                   :::*                    LISTEN      675/sshd: /usr/sbin
```
- используются протоколы tcp, tcp6. Названия программ можно посмотреть в столбце `program name`
___
4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?
```bash
vagrant@vagrant:~$ sudo ss -unap
State       Recv-Q       Send-Q              Local Address:Port             Peer Address:Port      Process
UNCONN      0            0                   127.0.0.53%lo:53                    0.0.0.0:*          users:(("systemd-resolve",pid=2315,fd=12))
UNCONN      0            0                  10.0.2.15%eth0:68                    0.0.0.0:*          users:(("systemd-network",pid=5487,fd=22))
```
- system-resolve - распознаватель для Системы доменных имён
- systemd-network - системный демон для управления сетевыми настройками
___
5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.
-
