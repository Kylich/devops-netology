# Домашнее задание к занятию "3.9. Элементы безопасности информационных систем"

1. Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.
- ![screen](https://raw.githubusercontent.com/Kylich/devops-netology/main/03-sysadmin-09-security/1.jpg)
___
2. Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.
- ![screen](https://raw.githubusercontent.com/Kylich/devops-netology/main/03-sysadmin-09-security/2.jpg)
___
3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.
-
```bash
$ sudo openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/ssl/private/sign.key -out /etc/ssl/certs/sign.crt
Generating a RSA private key
.............+++++
................+++++
writing new private key to '/etc/ssl/private/sign.key'
-----
.....
```
```bash


root@Ubuntu:/etc/apache2/conf-available# vim ssl-params.conf


SSLCipherSuite EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH
SSLProtocol All -SSLv2 -SSLv3 -TLSv1 -TLSv1.1
SSLHonorCipherOrder On
Header always set X-Frame-Options DENY
Header always set X-Content-Type-Options nosniff
SSLCompression off
SSLUseStapling on
SSLStaplingCache "shmcb:logs/stapling-cache(150000)"
SSLSessionTickets Off
```
```bash
$ sudo vim /etc/apache2/sites-available/default-ssl.conf
<IfModule mod_ssl.c>
    <VirtualHost _default_:443>

        SSLCertificateFile /etc/ssl/certs/sign.crt
        SSLCertificateKeyFile /etc/ssl/private/sign.key

    </VirtualHost>
</IfModule>
```
```shell
$ sudo vim /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
    Redirect "/" "https://localhost/"
</VirtualHost>
```

```shell
$ sudo a2enmod ssl
$ sudo a2enmod headers
$ sudo a2ensite default-ssl
$ sudo a2enconf ssl-params
$ sudo systemctl restart apache2
```
![ssl](https://raw.githubusercontent.com/Kylich/devops-netology/main/03-sysadmin-09-security/ssl.jpg)
___
4. Проверьте на TLS уязвимости произвольный сайт в интернете.
-
```bash
root@Ubuntu:/etc/apache2/conf-available# nmap --script ssl-enum-ciphers -p 443 netology.ru

Starting Nmap 7.80 ( https://nmap.org ) at 2022-03-04 19:36 MSK
Nmap scan report for netology.ru (104.22.41.171)
Host is up (0.0019s latency).
Other addresses for netology.ru (not scanned): 104.22.40.171 172.67.21.207 2606:4700:10::ac43:15cf 2606:4700:10::6816:29ab 2606:4700:10::6816:28ab

PORT    STATE SERVICE
443/tcp open  https
| ssl-enum-ciphers:
|   TLSv1.0:
|     ciphers:
|       TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA (ecdh_x25519) - A
|       TLS_RSA_WITH_AES_128_CBC_SHA (rsa 2048) - A
|       TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA (ecdh_x25519) - A
|       TLS_RSA_WITH_AES_256_CBC_SHA (rsa 2048) - A
|       TLS_RSA_WITH_3DES_EDE_CBC_SHA (rsa 2048) - C
|     compressors:
|       NULL
|     cipher preference: server
|     warnings:
|       64-bit block cipher 3DES vulnerable to SWEET32 attack
|   TLSv1.1:
|     ciphers:
|       TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA (ecdh_x25519) - A
|       TLS_RSA_WITH_AES_128_CBC_SHA (rsa 2048) - A
|       TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA (ecdh_x25519) - A
|       TLS_RSA_WITH_AES_256_CBC_SHA (rsa 2048) - A
|     compressors:
|       NULL
|     cipher preference: server
|   TLSv1.2:
|     ciphers:
|       TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA (ecdh_x25519) - A
|       TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256 (ecdh_x25519) - A
|       TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256 (ecdh_x25519) - A
|       TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA (ecdh_x25519) - A
|       TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384 (ecdh_x25519) - A
|       TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384 (ecdh_x25519) - A
|       TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256 (ecdh_x25519) - A
|       TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256-draft (ecdh_x25519) - A
|       TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA (ecdh_x25519) - A
|       TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256 (ecdh_x25519) - A
|       TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (ecdh_x25519) - A
|       TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA (ecdh_x25519) - A
|       TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384 (ecdh_x25519) - A
|       TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (ecdh_x25519) - A
|       TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256 (ecdh_x25519) - A
|       TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256-draft (ecdh_x25519) - A
|       TLS_RSA_WITH_AES_128_CBC_SHA (rsa 2048) - A
|       TLS_RSA_WITH_AES_128_CBC_SHA256 (rsa 2048) - A
|       TLS_RSA_WITH_AES_128_GCM_SHA256 (rsa 2048) - A
|       TLS_RSA_WITH_AES_256_CBC_SHA (rsa 2048) - A
|       TLS_RSA_WITH_AES_256_CBC_SHA256 (rsa 2048) - A
|       TLS_RSA_WITH_AES_256_GCM_SHA384 (rsa 2048) - A
|     compressors:
|       NULL
|     cipher preference: client
|_  least strength: C
Nmap done: 1 IP address (1 host up) scanned in 2.55 seconds
```
___
5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.
-
```bash
nikita@Ubuntu:/etc/ssl$ ssh-keygen
Generating public/private rsa key pair.

nikita@Ubuntu:/etc/ssl$ ssh-copy-id -i .ssh/id_rsa vagrant@172.28.128.60

nikita@Ubuntu:/etc/ssl$ ssh vagrant@172.28.128.60
Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.4.0-80-generic x86_64)

kylich@Ubuntu:~$
```
___
6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.
-
```bash
nikita@Ubuntu:/etc/ssl$ sudo mv ~/.ssh/id_rsa ~/.ssh/id_rsa_mv
nikita@Ubuntu:/etc/ssl$ sudo cat ~/.ssh/config
Host kylich
    HostName 172.28.128.60
    User vagrant
    Port 22
    IdentityFile ~/.ssh/id_rsa_mv

nikita@Ubuntu:/etc/ssl$ ssh kylich
Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.4.0-80-generic x86_64)

kylich@Ubuntu:~$
```
___
7. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.
-
```bash
nikita@Ubuntu:/etc/ssl$ sudo tcpdump -nnei any -c 100 -w log.pcap

tcpdump: data link type LINUX_SLL2
tcpdump: listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
100 packets captured
138 packets received by filter
0 packets dropped by kernel
```
![wireshark](https://raw.githubusercontent.com/Kylich/devops-netology/main/03-sysadmin-09-security/wireshark.jpg)
