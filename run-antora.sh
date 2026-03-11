#!/usr/bin/env bash

usage() { echo "Usage: $0 [-f] [-l] [-h]" 1>&2; exit "${1}"; }

set -e -u -o pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ ! "$(2>&- command -v npx)" ]; then
  1>&2 echo npx could not be found
  exit 1
fi

OPTIONS=()

while getopts "hlf" opt; do
  case "${opt}" in
    h)
      usage 0
      ;;

    l)
	OPTIONS+=("--log-level=all")
      ;;

    f)
      OPTIONS+=("--fetch")
      ;;

    *)
      usage 1
      ;;
  esac
done

npx antora "${OPTIONS[@]}" "${SCRIPT_DIR}/antora-playbook.yml"
