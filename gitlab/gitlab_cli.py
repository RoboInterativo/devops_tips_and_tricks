#!/usr/bin/env python

import os
import sys
import requests
import json
TOKEN= os.getenv("TOKEN")

base_url="http://test1.robointerativo.ru:8080/api/v4"

# print ("This is the name of the script: ", sys.argv[1])
# print ("Number of arguments: ", len(sys.argv))
def create_projects(project_name,group_id):
    data={ "name": project_name,
           "description": "New Project",
           "initialize_with_readme": "true"
           }
    url = f'{base_url}/projects'

    headers = { "PRIVATE-TOKEN": TOKEN,
                "Content-Type": "application/json" }
    print (data,url,headers)
    r = requests.post(url=url, headers=headers,json=data)

    print(json.dumps (  r.json(), indent=4 ))


    # echo "Project_name="$project_name", group_id="$group_id
    #
    # data=`echo '{ "name": "project_name", '$name_space_block'"description": "New Project",    "initialize_with_readme": "true"}' | sed 's/project_name/'$1'/g'|sed 's/namespace_id_p/'$group_id'/g' `
    #
    # url=$base_url'/projects'
    # curl --request POST --header "PRIVATE-TOKEN: ${TOKEN}" \
    #    --header "Content-Type: application/json" \
    #    --data "${data}"  \
    #    --url $url |jq
    #
    # }
def main():
    if sys.argv[1]=="--create-project":
        project_name=sys.argv[2]
        create_projects(project_name,None)

if __name__ == '__main__':
    main()
