# Курсовая работа по итогам модуля "DevOps и системное администрирование"

Курсовая работа необходима для проверки практических навыков, полученных в ходе прохождения курса "DevOps и системное администрирование".

Мы создадим и настроим виртуальное рабочее место. Позже вы сможете использовать эту систему для выполнения домашних заданий по курсу

## Задание

1. Создайте виртуальную машину Linux.

- vagrant ssh
![vagrant ssh](https://raw.githubusercontent.com/Kylich/pcs-devsys-diplom/main/curs_0_vagrant_ssh.PNG)


2. Установите ufw и разрешите к этой машине сессии на порты 22 и 443, при этом трафик на интерфейсе localhost (lo) должен ходить свободно на все порты.

- ufw enabled
![ufw enabled](https://raw.githubusercontent.com/Kylich/pcs-devsys-diplom/main/curs_2_ufw_enable.PNG)


3. Установите hashicorp vault ([инструкция по ссылке](https://learn.hashicorp.com/tutorials/vault/getting-started-install?in=vault/getting-started#install-vault)).

- vault install
![vault install](https://raw.githubusercontent.com/Kylich/pcs-devsys-diplom/main/curs_1_vault_install.PNG)

4. Cоздайте центр сертификации по инструкции ([ссылка](https://learn.hashicorp.com/tutorials/vault/pki-engine?in=vault/secrets-management)) и выпустите сертификат для использования его в настройке веб-сервера nginx (срок жизни сертификата - месяц).

 - vault.sh
![vault sh 1](https://raw.githubusercontent.com/Kylich/pcs-devsys-diplom/main/curs_1.1_vault_sh_1.PNG)
![vault sh 2](https://raw.githubusercontent.com/Kylich/pcs-devsys-diplom/main/curs_1.2_vault_sh_2.PNG)
![vault sh 3](https://raw.githubusercontent.com/Kylich/pcs-devsys-diplom/main/curs_1.3_vault_sh_3.PNG)

 - vault generate
![vault generate](https://raw.githubusercontent.com/Kylich/pcs-devsys-diplom/main/curs_3_vault_generate.PNG)

5. Установите корневой сертификат созданного центра сертификации в доверенные в хостовой системе.

 - crt trusted
![crt trusted](https://raw.githubusercontent.com/Kylich/pcs-devsys-diplom/main/curs_5_site_trusted.PNG)

6. Установите nginx.

 - nginx installed
![crt trusted](https://raw.githubusercontent.com/Kylich/pcs-devsys-diplom/main/curs_8_nginx_installed.PNG)


7. По инструкции ([ссылка](https://nginx.org/en/docs/http/configuring_https_servers.html)) настройте nginx на https, используя ранее подготовленный сертификат:

 - nginx config
![nginx config](https://raw.githubusercontent.com/Kylich/pcs-devsys-diplom/main/curs_4_nginx_config.PNG)

8. Откройте в браузере на хосте https адрес страницы, которую обслуживает сервер nginx.

 - nginx worked
![nginx worked](https://raw.githubusercontent.com/Kylich/pcs-devsys-diplom/main/curs_5_site_certificated.PNG)

9. Создайте скрипт, который будет генерировать новый сертификат в vault:
 - vault.sh
![vault sh 1](https://raw.githubusercontent.com/Kylich/pcs-devsys-diplom/main/curs_1.1_vault_sh_1.PNG)
![vault sh 2](https://raw.githubusercontent.com/Kylich/pcs-devsys-diplom/main/curs_1.2_vault_sh_2.PNG)
![vault sh 3](https://raw.githubusercontent.com/Kylich/pcs-devsys-diplom/main/curs_1.3_vault_sh_3.PNG)

 - certificate regenerate
 ![certificate regenerate](https://raw.githubusercontent.com/Kylich/pcs-devsys-diplom/main/curs_7_site_recertificated.PNG)


10. Поместите скрипт в crontab, чтобы сертификат обновлялся какого-то числа каждого месяца в удобное для вас время.

 - cron enabled
  ![cron enabled](https://raw.githubusercontent.com/Kylich/pcs-devsys-diplom/main/curs_6_cron_minutely_certificated.PNG)

 - cron regenerate
 ![cron regenerate](https://raw.githubusercontent.com/Kylich/pcs-devsys-diplom/main/curs_9.2_cron_regenerate.PNG)
