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
    if group_id:
      data.append ({"namespace_id": group_id })
    url = f'{base_url}/projects'

    headers = { "PRIVATE-TOKEN": TOKEN,
                "Content-Type": "application/json" }
    print (data,url,headers)
    r = requests.post(url=url, headers=headers,json=data)

    print(json.dumps (  r.json(), indent=4 ))



def main():
    if sys.argv[1]=="--create-project":
        project_name=sys.argv[2]
        try:
            group_id=sys.argv[3]
        except:
            print ("1")
        create_projects(project_name,None)

if __name__ == '__main__':
    main()
