#!/bin/bash

set -e 

# store name of current branch
BRANCH=$(git branch | grep \* | cut -d ' ' -f2)

# checkout main
git checkout main

# pull the latest changes
git pull 

# fetch and prune all the branches
git fetch --all --prune

# checkout the original branch
git checkout $BRANCH

# rebase on main
git rebase main

# prompt to push the changes
read -p "Would you like to push the changes? [y/n] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  git push --force --no-verify
fi
