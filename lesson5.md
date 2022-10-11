 Урок 5
===========================
Даны група хостов web-servers

* web1   
* web2
* web3
* lb1

Чтобы запустить эти хосты войдите в папку docker_images/ssh-pod
и запустите

    ./run.sh

Для проверки наберите

        docker ps

**Задача**

Нужно установить на все хосты **nginx** при помощи ansible

Для хостов **web1-web3** изменить файл **/var/www/html/index.html**

Указать в нем имя хоста. Можно использовать модуль **template**

Сделать шабон с таким сожержимым

    Running on server {{ inventory_hostname }}

Для балансировщика нагрузки (lb1) использовать файл конфигурации nginx  

имя сайта если занимаешься с нами server_name school.robointerativo.ru;

или можно указать внешний ip-adress

Используй здесь блок условий **when** чтобы таска запустилась только на хосте
балансировщика

Настроить проксирование (балансировку нагрузку ) на сервера (адреса тут адрес докера)

    server 172.17.0.1:8081;
    server 172.17.0.1:8082;
    server 172.17.0.1:8083;

Пример конфигурационного файла **nginx**

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

ИТОГО:  у Вас должен получится ansible playbook

* который уставливает nginx на 4 хоста
* меняет конфигурационный файл на lb1
* меняет index.html на всех 4 для простоты
* останавливает nginx коммандой service
* запускает Nginx

После выполнения сценария вы должны наблюдать по адресу балансировщика страницу,
с информацией какой сервер сейчас работает.


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
