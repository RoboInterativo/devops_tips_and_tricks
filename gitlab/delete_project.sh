. ./.env

# curl  --header "PRIVATE-TOKEN: ${TOKEN}" \
#  --header "Content-Type: application/json" \
# --url $base_url'namespaces'
url=$base_url'projects/4'
curl --request DELETE --header "PRIVATE-TOKEN: ${TOKEN}" \
   --url $url |jq
