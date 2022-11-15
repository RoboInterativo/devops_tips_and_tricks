. ./.env

base_url="http://test1.robointerativo.ru:8080/api/v4"
data=`echo '{ "name": "project_name", "description": "New Project",    "initialize_with_readme": "true"}' | sed 's/project_name/'$1'/g'`

url=$base_url'/projects'
curl --request POST --header "PRIVATE-TOKEN: ${TOKEN}" \
   --header "Content-Type: application/json" \
   --data "${data}"  \
   --url $url |jq
