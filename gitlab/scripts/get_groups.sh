#!/usr/bin/env bash
base_url=http://195.140.146.25:8080/api/v4
url=$base_url'/groups'
curl --request GET --header "PRIVATE-TOKEN: ${TOKEN}" \
   --header "Content-Type: application/json" \
   --url $url |jq
