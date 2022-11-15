
base_url="http://test1.robointerativo.ru:8080/api/v4"

data=`echo '{ "group_access": 40 , "description": "New Project",    "initialize_with_readme": "true"}' | sed 's/project_name/'$1'/g'`

url=$base_url'/projects/${id}/share'
curl --request POST --header "PRIVATE-TOKEN: ${TOKEN}" \
   --header "Content-Type: application/json" \
   --data "${data}"  \
   --url $url |jq
