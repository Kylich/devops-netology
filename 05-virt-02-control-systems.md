## Задача 1

- Опишите своими словами основные преимущества применения на практике IaaC паттернов.
- Какой из принципов IaaC является основополагающим?

## Задача 2

- Чем Ansible выгодно отличается от других систем управление конфигурациями?
    - 111
- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?
    - 111

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

## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

- Создать виртуальную машину.
- Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды
```
docker ps
```
