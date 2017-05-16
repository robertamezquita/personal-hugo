#!/bin/bash

## If deploy stops working for whatever reason, remove public and run:
rm -rf public
git rm -r --cached public
git submodule add --force -b master git@github.com:robertamezquita/robertamezquita.github.io.git public

## For notes on script and setting up the repo, see:
## https://gohugo.io/tutorials/github-pages-blog/

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo # if using a theme, replace by `hugo -t <yourtheme>`

# Go To Public folder
cd public
# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push --force origin master

# Come Back
cd ..
