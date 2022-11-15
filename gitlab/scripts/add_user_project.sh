#!/usr/bin/env bash 
base_url=http://nexus.robointerativo.ru:8080/api/v4/
id=2
project_id=2
url=$base_url'projects/2/members'
curl -v --request POST --header "PRIVATE-TOKEN: ${TOKEN}" \
   --header "Content-Type: application/json" \
   --data '{ "user_id": , "access_level": 30 }' \
   --url $url
