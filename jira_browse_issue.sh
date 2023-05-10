#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo "JIRA issue ID required" 1>&2
    exit 1
fi

open "https://levelall.atlassian.net/browse/${1}"
