# Урок 5
Даны група хостов web-servers
* web1   
* web2
* web3
* lb1
Нужно установить на все хосты nginx

Для хостов web1-web3 Изменить файл /var/www/html/index.html
Указать в нем имя хоста. Можно использовать модуль **template**
Сделать шабон с таким сожержимым
    Running on server {{ inventory_hostname }}
