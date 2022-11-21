#!/usr/bin/env bash
base_url="http://test1.robointerativo.ru:8080/api/v4"
function display_usage() {
  echo  -e "
  Usage: \e[1;34m $0  \e[0m
  Projects:
    Get projects
      \e[1;34m $0  \e[0m \e[1;32m--get-projects\e[0m
    Create project

      \e[1;34m $0  \e[0m \e[1;32m--create-project\e[0m PROJECT_NAME [\e[1;32m--group-id\e[0m GROUP_ID]

    Delete project
      \e[1;34m $0  \e[0m \e[1;32m--delete-project\e[0m  \e[1;32m--project_id\e[0m PROJECT_ID
      \e[1;34m $0  \e[0m \e[1;32m--delete-project\e[0m  \e[1;32m--project_name\e[0m PROJECT_NAME
  Groups:
    Get groups
      \e[1;34m $0  \e[0m \e[1;32m--get-groups\e[0m
    Create group
      \e[1;34m $0  \e[0m \e[1;32m--create-group\e[0m GROUP_NAME


  "

}
function create_groups() {
data=`echo '{ "name": "group_name",   "path": "group_name"}'| sed 's/group_name/'$1'/g'`

echo "${data}"
url=$base_url'/groups'
curl -v --request POST --header "PRIVATE-TOKEN: ${TOKEN}" \
    --header "Content-Type: application/json" \
    --data "${data}" \
    $url |jq

}
function get_groups() {
echo GET
url="$base_url/groups"
echo $url
 answer=`curl -v  --header "PRIVATE-TOKEN: ${TOKEN}" \
     --header "Content-Type: application/json" \
     $url `

     short_result=$(echo "${answer}" | jq '[.[] | {
    group_id: .id,
    group_name: .name,
    group_path: .path,
    project_creation_level: .project_creation_level
    }]')

      echo "${short_result}"

}
function get_projects() {
echo GET
url="$base_url/projects"
echo $url
 answer=`curl -v  --header "PRIVATE-TOKEN: ${TOKEN}" \
     --header "Content-Type: application/json" \
     $url `

    short_result=$(echo "${answer}" | jq '[.[] | {
    project_id: .id,
    project_name: .name,
    project_path: .path,
    group_name: .namespace.name,
    group_path: .namespace.path,
    path_with_namespace: .path_with_namespace,
    ssh_url_to_repo: .ssh_url_to_repo,
    http_url_to_repo: .http_url_to_repo,
    container_registry_enabled: .container_registry_enabled,
    issues_enabled: .issues_enabled,
    merge_requests_enabled: .merge_requests_enabled,
    wiki_enabled: .wiki_enabled,
    builds_enabled: .builds_enabled,
    snippets_enabled: .snippets_enabled,
    shared_runners_enabled: .shared_runners_enabled,
    lfs_enabled: .lfs_enabled,
    request_access_enabled: .request_access_enabled
    }]')

      echo "${short_result}"

}
function delete_projects_by_id() {
echo delete
url="$base_url/projects/$1"
echo $url
 curl -v --request DELETE --header "PRIVATE-TOKEN: ${TOKEN}" \
     --header "Content-Type: application/json" \
     $url |jq
#     --data "${data}" \
#     $url |jq

}
function delete_projects_name() {
  echo delete
  # cat 1 | jq -c '.[] | select( .name=="Diaspora Client")' | jq  '.id'
}

function delete_projects() {
  local project_id=${2}
  local project_name=${1}

  if [ -z "${project_name}" ]; then

  if [ -z "${project_id}" ]; then
    display_usage
    exit 1
  else
    echo "project name null, project_id good ${project_id}"
    delete_projects_by_id $project_id

  fi

  else
    echo project name good, project_id null


  fi


}
function create_projects() {
  local project_name=${1}
  local group_id=${2}
  if [ -z "${project_name}" ]; then
    echo "* Parameter PROJECT_NAME is missing" >&2
    display_usage
    exit 1
  fi
  if [ -z "${group_id}" ]; then
    echo "* Parameter GROUP is missing" >&2
    name_space_block=""
  else
      name_space_block='"namespace_id": namespace_id_p , '
  fi

echo "Project_name="$project_name", group_id="$group_id

data=`echo '{ "name": "project_name", '$name_space_block'"description": "New Project",    "initialize_with_readme": "true"}' | sed 's/project_name/'$1'/g'|sed 's/namespace_id_p/'$group_id'/g' `

url=$base_url'/projects'
curl --request POST --header "PRIVATE-TOKEN: ${TOKEN}" \
   --header "Content-Type: application/json" \
   --data "${data}"  \
   --url $url |jq

}


function main {
  local param=
  local p_project_name=
  local p_project_path=
  local p_group_id=
  local p_group_name=
  if [ -z "${1}" ]; then
    display_usage
    exit 1
  fi
while [[ $# -gt 0 ]]; do
    local param="$1"
    shift


    case "${param}" in
      --create-group)
      p_group_name="$1"
      action=createGroup
      shift
      ;;
      --create-project)
      p_project_name="$1"
      action=createProject
      shift
      ;;
      --group_id)
      p_group_id="$1"
      shift
      ;;
      --delete-project)
      # p_project_id="$1"
      action=deleteProject
      #shift
      ;;
      --get-projects)
      # p_project_id="$1"
      action=getProjects
      #shift
      ;;
      --get-groups)
      # p_project_id="$1"
      action=getGroups
      #shift
      ;;
      --project_id)
      p_project_id="$1"
      shift
      ;;
      --project_name)
      p_project_name="$1"
      shift
      ;;
    esac
done
case "${action}" in
  createGroup)
    create_groups "${p_group_name}"
  ;;
  getGroups)
    get_groups
  ;;
  getProjects)
    get_projects
  ;;
  createProject)
      echo $p_project_name  $p_project_path $group_id

      create_projects    "${p_project_name}" "${p_group_id}"
      ;;
  deleteProject)
      echo "name=$p_project_name  id=$p_project_id"

      delete_projects   "${p_project_name}" "${p_project_id}"
          ;;
  esac

}
main "$@"
