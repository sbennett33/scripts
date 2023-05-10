#!/bin/bash

set -e 

# checkout main
git checkout main

# pull the latest changes
git pull

# fetch and prune all the branches
git fetch --all --prune
