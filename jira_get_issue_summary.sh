#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo "JIRA issue ID required" 1>&2
    exit 1
fi

jira issue list -q"key=${1}" --plain --no-headers --columns=summary | awk '{$1="";print $0}' | awk '{$1=$1;print}' 
