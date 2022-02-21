# Домашнее задание к занятию "3.8. Компьютерные сети, лекция 3"

1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP
```bash
telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32
```
-
```bash
route-views>show ip route x.x.80.138
Routing entry for x.x.0.0/17
  Known via "bgp 6447", distance 20, metric 0
  Tag 6939, type external
  Last update from 64.71.137.241 1d04h ago
  Routing Descriptor Blocks:
  * 64.71.137.241, from 64.71.137.241, 1d04h ago
      Route metric is 0, traffic share count is 1
      AS Hops 3
      Route tag 6939
      MPLS label: none
```

```bash
route-views>show bgp x.x.80.138
BGP routing table entry for x.x.0.0/17, version 311631538
Paths: (23 available, best #7, table default)
  Not advertised to any peer
  Refresh Epoch 1
  8283 1299 9049 41733
    94.142.247.3 from 94.142.247.3 (94.142.247.3)
      Origin incomplete, metric 0, localpref 100, valid, external
      Community: 1299:30000 8283:1 8283:101
      unknown transitive attribute: flag 0xE0 type 0x20 length 0x18
        value 0000 205B 0000 0000 0000 0001 0000 205B
              0000 0005 0000 0001
      path 7FE146EF9488 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3333 9002 9049 41733
    193.0.0.56 from 193.0.0.56 (193.0.0.56)
        Origin IGP, localpref 100, valid, external
        path 7FE15FBDC7A0 RPKI State not found
        rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  852 1299 9049 41733
    154.11.12.212 from 154.11.12.212 (96.1.209.43)
      Origin IGP, metric 0, localpref 100, valid, external
      path 7FE123047088 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  1351 6939 9049 41733
    132.198.255.253 from 132.198.255.253 (132.198.255.253)
      Origin IGP, localpref 100, valid, external
      path 7FE0D90C6248 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  57866 9002 9049 41733
    37.139.139.17 from 37.139.139.17 (37.139.139.17)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 9002:0 9002:64667
      path 7FE103C04A70 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20130 6939 9049 41733
```

___
2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.
-
```bash
vagrant@vagrant:~$ sudo modprobe -v dummy numdummies=2
insmod /lib/modules/5.4.0-91-generic/kernel/drivers/net/dummy.ko numdummies=0 numdummies=2

vagrant@vagrant:~$ lsmod | grep dummy
dummy                  16384  0

vagrant@vagrant:~$ ifconfig -a | grep dummy
dummy0: flags=130<BROADCAST,NOARP>  mtu 1500
dummy1: flags=130<BROADCAST,NOARP>  mtu 1500

vagrant@vagrant:~$ sudo route add -net 192.168.36.0 netmask 255.255.255.0 eth0
vagrant@vagrant:~$ sudo route add -net 192.168.30.0 netmask 255.255.255.0 eth0

vagrant@vagrant:~$ route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         _gateway        0.0.0.0         UG    100    0        0 eth0
10.0.2.0        0.0.0.0         255.255.255.0   U     0      0        0 eth0
_gateway        0.0.0.0         255.255.255.255 UH    100    0        0 eth0
192.168.30.0    0.0.0.0         255.255.255.0   U     0      0        0 eth0
192.168.36.0    0.0.0.0         255.255.255.0   U     0      0        0 eth0
```
___
3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.
-
```bash
vagrant@vagrant:~$ sudo netstat -tulpn
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      671/sshd: /usr/sbin
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      600/systemd-resolve
tcp6       0      0 :::22                   :::*                    LISTEN      671/sshd: /usr/sbin
udp        0      0 127.0.0.53:53           0.0.0.0:*                           600/systemd-resolve
udp        0      0 10.0.2.15:68            0.0.0.0:*                           598/systemd-network
```
Используются протоколы tcp, upd, tcp6. Названия программ указаны в столбце `program name`

___
4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?
-
___
5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.
-
___
___
___
## Задание для самостоятельной отработки (необязательно к выполнению)

6*. Установите Nginx, настройте в режиме балансировщика TCP или UDP.

7*. Установите bird2, настройте динамический протокол маршрутизации RIP.

8*. Установите Netbox, создайте несколько IP префиксов, используя curl проверьте работу API.
