# Домашнее задание к занятию "3.5. Файловые системы"

1. Узнайте о [sparse](https://ru.wikipedia.org/wiki/%D0%A0%D0%B0%D0%B7%D1%80%D0%B5%D0%B6%D1%91%D0%BD%D0%BD%D1%8B%D0%B9_%D1%84%D0%B0%D0%B9%D0%BB) (разряженных) файлах.

- полезная функция, придется реализовывать у себя
___
1. Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

- "файл" - это просто указатель на определенный inode, который единый для всех жестких ссылок и в котором хранятся права доступа. поэтому права задаются всех жестким ссылкам
___
1. Сделайте `vagrant destroy` на имеющийся инстанс Ubuntu. Данная конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2.5 Гб.
```bash
vagrant@vagrant:~$ lsblk | grep sd
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0    1G  0 part /boot
└─sda3                      8:3    0   63G  0 part
sdb                         8:16   0  2.5G  0 disk
sdc                         8:32   0  2.5G  0 disk
```
___
1. Используя `fdisk`, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.

  - `# fdisk /dev/sdb`
___
1. Используя `sfdisk`, перенесите данную таблицу разделов на второй диск.

  - `# sfdisk -d /dev/sdb > partsdb && sfdisk /dev/sdc < partsdb`
___
1. Соберите `mdadm` RAID1 на паре разделов 2 Гб.

  - `# mdadm --create --verbose /dev/raid1 -l 1 -n 2 /dev/sd{b1,c1}`
___
1. Соберите `mdadm` RAID0 на второй паре маленьких разделов.

  - `# mdadm --create --verbose /dev/raid0 -l 0 -n 2 /dev/sd{b2,c2}`
___
1. Создайте 2 независимых PV на получившихся md-устройствах.

  - `# pvcreate /dev/raid1 /dev/raid0`
___
1. Создайте общую volume-group на этих двух PV.

  - `# vgcreate volgroup /dev/raid1 /dev/raid0`
___
1. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.

  - `# lvcreate -L 100M volgroup /dev/raid0`
___
1. Создайте `mkfs.ext4` ФС на получившемся LV.

  - `# mkfs.ext4 /dev/volgroup/lvol0`
___
1. Смонтируйте этот раздел в любую директорию, например, `/tmp/new`.

  - `# mkdir /tmp/new && mount /dev/volgroup/lvol0 /tmp/new`
___
1. Поместите туда тестовый файл, например `wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz`.

  - `# wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz`
___
1. Прикрепите вывод `lsblk`.

```bash
root@vagrant:/tmp/new# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                       7:0    0 55.4M  1 loop  /snap/core18/2128
loop1                       7:1    0 70.3M  1 loop  /snap/lxd/21029
loop2                       7:2    0 32.3M  1 loop  /snap/snapd/12704
loop3                       7:3    0 43.4M  1 loop  /snap/snapd/14549
loop4                       7:4    0 55.5M  1 loop  /snap/core18/2284
loop5                       7:5    0 61.9M  1 loop  /snap/core20/1270
loop6                       7:6    0 67.2M  1 loop  /snap/lxd/21835
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0    1G  0 part  /boot
└─sda3                      8:3    0   63G  0 part
  └─ubuntu--vg-ubuntu--lv   253:0  0 31.5G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
│ └─raid1                   9:1    0    2G  0 raid1
└─sdb2                      8:18   0  511M  0 part
  └─raid0                   9:0    0 1018M  0 raid0
    └─volgroup-lvol0        253:1  0  100M  0 lvm   /tmp/new
sdc                         8:32   0  2.5G  0 disk
├─sdc1                      8:33   0    2G  0 part
│ └─raid1                   9:1    0    2G  0 raid1
└─sdc2                      8:34   0  511M  0 part
  └─raid0                   9:0    0 1018M  0 raid0
    └─volgroup-lvol0        253:1  0  100M  0 lvm   /tmp/new
```

___
1. Протестируйте целостность файла:

```bash
root@vagrant:~# gzip -t /tmp/new/test.gz
root@vagrant:~# echo $?
0
```
- done
___
1. Используя pvmove, переместите содержимое PV с RAID0 на RAID1.

  - `# pvmove /dev/raid0`
___
1. Сделайте `--fail` на устройство в вашем RAID1 md.

  - `# mdadm /dev/raid1 --fail /dev/sdb1 && mdadm -D /dev/raid1`
___
1. Подтвердите выводом `dmesg`, что RAID1 работает в деградированном состоянии.

```bash
root@vagrant:/tmp/new# dmesg |grep raid1
[ 5128.974860] md/raid1:raid1: not clean -- starting background reconstruction
[ 5128.974861] md/raid1:raid1: active with 2 out of 2 mirrors
[ 5128.974897] raid1: detected capacity change from 0 to 2144337920
[ 5128.981159] md: resync of RAID array raid1
[ 5139.695155] md: raid1: resync done.
[ 7475.964568] md/raid1:raid1: Disk failure on sdb1, disabling device.
               md/raid1:raid1: Operation continuing on 1 devices.
```
___
1. Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:

    ```bash
    root@vagrant:~# gzip -t /tmp/new/test.gz
    root@vagrant:~# echo $?
    0
    ```

  - done
___
1. Погасите тестовый хост, `vagrant destroy`.

  - done
___
