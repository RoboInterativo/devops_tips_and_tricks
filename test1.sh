TOKEN=glpat-7qBD9ti8omqujW2LgQDQ
url=http://nexus.robointerativo.ru:8080/api/v4/users
curl -v -X POST --header "PRIVATE-TOKEN: ${TOKEN}" \
-H 'Content-Type: application/json' \
--data '{"name":"alexp","email":"alex.pricker@yandex.ru","username":"alexp","password":"VERvAsTInEWInG"}' \
$url

#echo "curl -X POST --header PRIVATE-TOKEN: ${TOKEN}"
