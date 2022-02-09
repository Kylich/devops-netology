# Домашнее задание к занятию "3.6. Компьютерные сети, лекция 1"


1. Работа c HTTP через телнет.
- Подключитесь утилитой телнет к сайту stackoverflow.com
`telnet stackoverflow.com 80`
- отправьте HTTP запрос
- В ответе укажите полученный HTTP код, что он означает?
```bash
vagrant@vagrant:~$ telnet stackoverflow.com 80
Trying 151.101.193.69...
Connected to stackoverflow.com.
Escape character is '^]'.
GET /questions HTTP/1.0
HOST: stackoverflow.com

HTTP/1.1 301 Moved Permanently
cache-control: no-cache, no-store, must-revalidate
location: https://stackoverflow.com/questions
x-request-guid: 1469294c-1ca7-476c-b1df-42d69c0e9bbe
feature-policy: microphone 'none'; speaker 'none'
content-security-policy: upgrade-insecure-requests; frame-ancestors 'self' https://stackexchange.com
Accept-Ranges: bytes
Date: Wed, 09 Feb 2022 10:24:34 GMT
Via: 1.1 varnish
Connection: close
X-Served-By: cache-hel1410032-HEL
X-Cache: MISS
X-Cache-Hits: 0
X-Timer: S1644402274.139033,VS0,VE110
Vary: Fastly-SSL
X-DNS-Prefetch-Control: off
Set-Cookie: prov=ffbc18c8-e7c2-a06f-8e45-3a71acde47dc; domain=.stackoverflow.com; expires=Fri, 01-Jan-2055 00:00:00 GMT; path=/; HttpOnly

Connection closed by foreign host.
```
___
___
___

2. Повторите задание 1 в браузере, используя консоль разработчика F12.
- откройте вкладку `Network`
- отправьте запрос http://stackoverflow.com
- найдите первый ответ HTTP сервера, откройте вкладку `Headers`
- укажите в ответе полученный HTTP код.
- проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?
- приложите скриншот консоли браузера в ответ.

```bash
HTTP/2 200 OK
cache-control: private
content-type: text/html; charset=utf-8
content-encoding: gzip
strict-transport-security: max-age=15552000
x-frame-options: SAMEORIGIN
x-request-guid: ef53bf6c-a24b-4fa0-a851-079159893a5a
feature-policy: microphone 'none'; speaker 'none'
content-security-policy: upgrade-insecure-requests; frame-ancestors 'self' https://stackexchange.com
accept-ranges: bytes
date: Wed, 09 Feb 2022 10:32:04 GMT
via: 1.1 varnish
x-served-by: cache-hel1410033-HEL
x-cache: MISS
x-cache-hits: 0
x-timer: S1644402724.981122,VS0,VE134
vary: Accept-Encoding,Fastly-SSL
x-dns-prefetch-control: off
X-Firefox-Spdy: h2
```

![2-screen](https://raw.githubusercontent.com/Kylich/devops-netology/main/03-sysadmin-07-net/2.png)
___
___
___
3. Какой IP адрес у вас в интернете?
    - IP 10.0.2.15
```bash
vagrant@vagrant:~$ ifconfig
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.2.15  netmask 255.255.255.0  broadcast 10.0.2.255
        inet6 fe80::a00:27ff:feb1:285d  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:b1:28:5d  txqueuelen 1000  (Ethernet)
        RX packets 257  bytes 28353 (28.3 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 89  bytes 12210 (12.2 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 8  bytes 776 (776.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 8  bytes 776 (776.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

___
___
___

4. Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой `whois`


___
___
___

5. Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой `traceroute`
```bash
vagrant@vagrant:~$ traceroute -AI 8.8.8.8
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  _gateway (10.0.2.2) [*]  0.859 ms  0.766 ms  0.695 ms
 2  NeyshRouter (192.168.0.1) [*]  2.098 ms  2.019 ms  2.255 ms
 3  5x19x0x110.static-business.spb.ertelecom.ru (5.19.0.110) [AS41733]  7.535 ms 5x19x0x106.static-business.spb.ertelecom.ru (5.19.0.106) [AS41733]  8.155 ms 5x19x0x110.static-business.spb.ertelecom.ru (5.19.0.110) [AS41733]  7.327 ms
 4  5x19x0x250.static-business.spb.ertelecom.ru (5.19.0.250) [AS41733]  4.745 ms  5.089 ms  5.037 ms
 5  net131.234.188-158.ertelecom.ru (188.234.131.158) [AS9049]  3.458 ms  3.395 ms  3.579 ms
 6  net131.234.188-159.ertelecom.ru (188.234.131.159) [AS9049]  3.245 ms  5.029 ms  5.331 ms
 7  74.125.244.129 (74.125.244.129) [AS15169]  5.277 ms  4.209 ms  4.144 ms
 8  74.125.244.132 (74.125.244.132) [AS15169]  3.652 ms  3.529 ms  3.469 ms
 9  72.14.232.85 (72.14.232.85) [AS15169]  4.844 ms  4.792 ms  4.714 ms
10  142.251.51.187 (142.251.51.187) [AS15169]  6.755 ms  6.703 ms  6.652 ms
11  216.239.54.201 (216.239.54.201) [AS15169]  9.233 ms  9.182 ms  9.226 ms
12  * * *
13  * * *
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  dns.google (8.8.8.8) [AS15169]  14.079 ms * *
```

___
___
___

6. Повторите задание 5 в утилите `mtr`. На каком участке наибольшая задержка - delay?
```bash
My traceroute  [v0.93]
vagrant (10.0.2.15)                                                            2022-02-09T12:09:53+0000
Keys:  Help   Display mode   Restart statistics   Order of fields   quit
                                                               Packets               Pings
 Host                                                        Loss%   Snt   Last   Avg  Best  Wrst StDev
 1. _gateway                                                  0.0%    19    1.6   0.9   0.6   1.7   0.3
 2. NeyshRouter                                               0.0%    19    1.2   2.5   1.2   9.2   1.9
 3. 5x19x0x106.static-business.spb.ertelecom.ru               0.0%    19   33.6  29.0   2.8 142.7  37.0
    5x19x0x110.static-business.spb.ertelecom.ru
 4. 5x19x0x250.static-business.spb.ertelecom.ru               0.0%    19    3.3   5.3   2.8  15.7   3.6
 5. net131.234.188-158.ertelecom.ru                           0.0%    19    3.8   4.4   3.6   5.9   0.6
 6. net131.234.188-159.ertelecom.ru                           0.0%    19    3.8   3.4   2.8   5.3   0.6
 7. 74.125.244.129                                            0.0%    19    6.1   5.7   3.6  11.4   2.3
 8. 74.125.244.132                                            0.0%    19    2.8   5.9   2.8  18.8   4.6
 9. 72.14.232.85                                              0.0%    19    5.1   4.9   3.9   7.5   1.0
10. 142.251.51.187                                            0.0%    19    7.8  10.2   7.2  22.7   4.7
11. 216.239.54.201                                            0.0%    19    8.2   9.4   7.9  14.7   1.9
12. (waiting for reply)
13. (waiting for reply)
14. (waiting for reply)
15. (waiting for reply)
16. (waiting for reply)
17. (waiting for reply)
18. (waiting for reply)
19. (waiting for reply)
20. (waiting for reply)
21. dns.google                                               16.7%    18    7.6   9.1   7.1  18.4   3.0
````

___
___
___

7. Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой `dig`


___
___
___

8. Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой `dig`


___
___
___
