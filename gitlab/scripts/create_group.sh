#!/usr/bin/env bash

base_url="http://test1.robointerativo.ru:8080/api/v4"
url=$base_url'/groups'

data=`echo '{ "name": "group_name",   "path": "group_name"}'| sed 's/group_name/'$1'/g'`

echo "${data}"

curl -v --request POST --header "PRIVATE-TOKEN: ${TOKEN}" \
    --header "Content-Type: application/json" \
    --data "${data}" \
    $url |jq
    
