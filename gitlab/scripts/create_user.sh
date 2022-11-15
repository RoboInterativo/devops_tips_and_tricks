. ./.env

id=2
project_id=2
url=$base_url'users'
curl -v -X POST --header "PRIVATE-TOKEN: ${TOKEN}" \
-H 'Content-Type: application/json' \
--data '{"name":"alexp2","email":"alex.pricker2@gmail.com","username":"alexp2,password":"My6asS!2"}' \
$url
