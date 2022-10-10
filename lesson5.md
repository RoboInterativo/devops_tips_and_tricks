 Урок 5
===========================
Даны група хостов web-servers

* web1   
* web2
* web3
* lb1

Нужно установить на все хосты **nginx**

Для хостов **web1-web3** Изменить файл **/var/www/html/index.html**

Указать в нем имя хоста. Можно использовать модуль **template**

Сделать шабон с таким сожержимым

    Running on server {{ inventory_hostname }}

Для балансировщика нагрузки использовать файл конфигурации nginx  имя сайта

    server_name school.robointerativo.ru;

Настроить проксирование (балансировку нагрузку )

На сервера

    server 172.17.0.1:8081;
    server 172.17.0.1:8082;
    server 172.17.0.1:8083;

Пример конфигурационного файла

    upstream myapp1 {
              server SERVER1_HOST:PORT1;
              server SERVER2_HOST:PORT2;
              server SERVER3_HOST:PORT3;
     }


     server {
              listen 80;
              server_name SERVER_DNS_NAME;

      location / {
                proxy_pass http://myapp1;
       }

     }

Первый вариант скопировать готовый файл с помощью модуля **copy**

Cправка
=======
Модуль **ping** проверяет связь с хостом


    - name: Ping server {{inventory_hostname}}
      ping:

Модуль **debug** позволяет вывести на экран переменную

    - name: DEBUG
      debug:
        var: inventory_hostname

Модуль **shell**, выполнят комманду операционной системы

    - name: HOST
      shell: hostname

Модуль **copy** копирует файл с хоста ansible на целевой хоста

      - name: Copy Nginx conf
        copy:
          src: site.conf
          dest: /etc/nginx/sites-available/default


Модуль **apt** устанавливает пакет в операционной системе

    - name: apt
      apt:
        name: httpd
        state: present

Модуль **template** создает файл из шаблона

- name: use template
  template:
    src: index.html
    dest: /var/www/html/index.htm

МОдуль **service** и **systemd** запускает службу операционной системы
  - name: Make sure a service is running
    service:
      state: stopped
      name:  nginx
В любой блок можно добавить условия его исполнения
    when: условие
