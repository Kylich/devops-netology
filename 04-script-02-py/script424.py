import json, requests

log_file = "log.json"

with open(log_file, 'r') as log_data:
    log_json = json.load(log_data)

for site, ip in log_json.items():
    with requests.get( f'http://{site}/', stream=True ) as r:
        ip_new = r.raw._original_response.fp.raw._sock.getpeername()[0]
    if ip != ip_new and ip:
        print( f'[ERROR] {site} IP mismatch: {ip} {ip_new}' )
        log_json[site] = ip_new
    elif not ip:
        log_json[site] = ip_new
        print(f'{site} - {ip_new}')
    else:
        print(f'{site} - {ip_new}')

with open(log_file, 'w') as log_data:
    json.dump(log_json, log_data)