# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"

## Обязательные задания

1. Мы выгрузили JSON, который получили через API запрос к нашему сервису:
	```json
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175
            },
            { "name" : "second",
            "type" : "proxy",
            "ip : 71.78.22.43
            }
        ]
    }
	```
  Нужно найти и исправить все ошибки, которые допускает наш сервис
    -
```json
{
    "info": "Sample JSON output from our service\t",
    "elements": [
        {
            "name": "first",
            "type": "server",
            "ip": "7175"
        },
        {
            "name": "second",
            "type": "proxy",
            "ip" : "71.78.22.43"
        }
    ]
}
```



2. В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: { "имя сервиса" : "его IP"}. Формат записи YAML по одному сервису: - имя сервиса: его IP. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

```python
import json, requests
import socket
import yaml

log_file = "04-script-03-yaml/log.json"

with open(log_file, 'r') as log_data:
    log_json = json.load(log_data)

for site, ip in log_json.items():
    # with requests.get( f'http://{site}/', stream=True ) as r:
    #     ip_new = r.raw._original_response.fp.raw._sock.getpeername()[0]

    try: ip_new = socket.gethostbyname( site )
    except: ip_new = False

    if ip_new:
        if ip != ip_new and ip:
            print( f'[ERROR] {site} IP mismatch: {ip} {ip_new}' )
            log_json[site] = ip_new
        elif not ip:
            log_json[site] = ip_new
            print(f'{site} - {ip_new}')
        else:
            print(f'{site} - {ip_new}')
    else:
        print('get ip false')

with open(log_file, 'w') as log_data:
    json.dump(log_json, log_data)

with open('04-script-03-yaml/log.yaml', 'w') as log_data:
    yaml.dump(log_json, log_data, default_flow_style=False)
```


## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так как команды в нашей компании никак не могут прийти к единому мнению о том, какой формат разметки данных использовать: JSON или YAML, нам нужно реализовать парсер из одного формата в другой. Он должен уметь:
   * Принимать на вход имя файла
   * Проверять формат исходного файла. Если файл не json или yml - скрипт должен остановить свою работу
   * Распознавать какой формат данных в файле. Считается, что файлы *.json и *.yml могут быть перепутаны
   * Перекодировать данные из исходного формата во второй доступный (из JSON в YAML, из YAML в JSON)
   * При обнаружении ошибки в исходном файле - указать в стандартном выводе строку с ошибкой синтаксиса и её номер
   * Полученный файл должен иметь имя исходного файла, разница в наименовании обеспечивается разницей расширения файлов

---

### Как сдавать задания

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---