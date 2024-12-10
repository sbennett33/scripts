#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo "JIRA issue ID required" 1>&2
    exit 1
fi

BRANCH_NAME=`jira issue list -q"key=${1}" --plain --no-headers --columns=summary | awk '{$1="";print $0}' | awk '{$1=$1;print}' | tr '[:upper:]' '[:lower:]' | tr -d '[:punct:]' | tr ' ' '-'`

# store name of current branch
BRANCH="sbennett/${1}-${BRANCH_NAME}"

# checkout main
git checkout main

# pull the latest changes
git pull 

# fetch and prune all the branches
git fetch --all --prune

# checkout the original branch
git checkout -b $BRANCH

jira issue move $1 "IN PROGRESS"

# get any new dependencies
mix deps.get

# compile the app
mix do clean, compile

# run any pending migrations
doppler run -- mix ecto.migrate

# start editor
nvim .
