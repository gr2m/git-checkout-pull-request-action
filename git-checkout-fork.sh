#!/bin/sh -l
set -e
set -o pipefail

# Find out if pull request is a fork. If it's not, we are all set.
FORK=`jq .pull_request.head.repo.fork "$GITHUB_EVENT_PATH"`
if [[ "$FORK" == "false" ]]; then
  echo "Pull request not from fork. Code already checked out correctly"
  exit 0
fi

# Check out remote branch based on pull request number
# Credit: https://github.community/t5/How-to-use-Git-and-GitHub/Checkout-a-branch-from-a-fork/m-p/78/highlight/true#M11
NUMBER=`jq .pull_request.number "$GITHUB_EVENT_PATH"`
git fetch origin pull/${NUMBER}/head:pr/${NUMBER}
git checkout "pr/${NUMBER}"
echo "Checked out code from pull request #${NUMBER}. Last commit: $(git log --oneline -n 1)"
