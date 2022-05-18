## Задача 1

- Опишите своими словами основные преимущества применения на практике IaaC паттернов.
	- быстрое и надежное масштабирование
	- возможность восстанавливать работу, просто перезапустив паттерн
	- уменьшение влияния человеческого фактора
- Какой из принципов IaaC является основополагающим?
	- Индемпотентность (2+2=4)


## Задача 2

- Чем Ansible выгодно отличается от других систем управление конфигурациями?
    - написан на python
    - подключение по ssh
    - yaml плейбуки
- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?
    - система push проще и дешевле для небольшого кол-ва серверов, pull - для большого 
## Задача 3

Установить на личный компьютер:

- VirtualBox
- Vagrant
- Ansible

```bash
kylich@kylich-laptop:~$ VBoxManage -v
6.1.32_Ubuntur149290
kylich@kylich-laptop:~$ vagrant --version
Vagrant 2.2.19
kylich@kylich-laptop:~$ ansible --version
ansible [core 2.12.5]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/kylich/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /home/kylich/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.10.4 (main, Apr  2 2022, 09:04:19) [GCC 11.2.0]
  jinja version = 3.0.3
  libyaml = True
```
