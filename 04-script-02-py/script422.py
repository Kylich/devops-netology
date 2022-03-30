'''
какие файлы модифицированы в репозитории, относительно локальных изменений
в его выводе есть не все изменённые файлы,
непонятен полный путь к директории, где они находятся
'''

# import os
import re
# folder = '~/netology/sysadm-homeworks'
folder = 'C:/Git/devops-netology'

print(re.match(r'[A-Za-z]', '1'))

# bash_command = [f"cd {folder}", "git status"]
# result_os = os.popen(' && '.join(bash_command)).read()
# is_change = False
# for result in result_os.split('\n'):
#     if result.find('modified') != -1:
#         prepare_result = folder + '/' + result.replace('\tmodified:   ', '')
#         print(prepare_result)
