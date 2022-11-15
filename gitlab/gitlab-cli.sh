#!/usr/bin/env bash
base_url="http://test1.robointerativo.ru:8080/api/v4"
function display_usage() {
  echo echo "Usage: $0
  Create project
    $0 --create-project PROJECT_NAME [--group-id GROUP_ID] "
}
function create_groups() {
data=`echo '{ "name": "group_name",   "path": "group_name"}'| sed 's/group_name/'$1'/g'`

echo "${data}"

curl -v --request POST --header "PRIVATE-TOKEN: ${TOKEN}" \
    --header "Content-Type: application/json" \
    --data "${data}" \
    $url |jq

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
while [[ $# -gt 0 ]]; do
    local param="$1"
    shift

    case "${param}" in
      --create-project)
      p_project_name="$1"
      action=createProject
      shift
      ;;
      --group_id)
      p_group_id="$1"
      shift
      ;;
    esac
done
case "${action}" in
  createProject)
      echo $p_project_name  $p_project_path $group_id

      create_projects    "${p_project_name}" "${p_group_id}"
      ;;
  esac

}
main "$@"
