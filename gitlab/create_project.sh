. ./.env

# curl  --header "PRIVATE-TOKEN: ${TOKEN}" \
#  --header "Content-Type: application/json" \
# --url $base_url'namespaces'
url=$base_url'projects'
curl --request POST --header "PRIVATE-TOKEN: ${TOKEN}" \
   --header "Content-Type: application/json" \
   --data '{ "name": "robo34project", "description": "New Project",    "initialize_with_readme": "true"}' \
   --url $url |jq
