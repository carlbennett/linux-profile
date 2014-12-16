#!/bin/sh

ORIGIN_BRANCH=$1
TARGET_ID=$2
TARGET_BRANCH=$3

if [ "$ORIGIN_BRANCH" == "" ] || [ "$TARGET_ID" == "" ] || [ "$TARGET_BRANCH" == "" ]; then
  printf "\n  Usage: $0 <origin-branch> <remote-id> <remote-branch>\n\n"
  printf "Example: $0 master user testing\n"
  printf "Explain: Pull latest origin master branch and then merge user's testing branch.\n\n"
  exit 1
fi

trap 'printf "\n\e[1;31mKeyboard interrupt.\e[0;0m\n"; stty echo; exit 1' 2
stty -echo

printf "\e[1;33mPulling latest changes and merging remote branch...\e[0;0m\n"
git checkout $ORIGIN_BRANCH
git reset --hard origin/$ORIGIN_BRANCH
git pull origin $ORIGIN_BRANCH
git fetch $TARGET_ID $TARGET_BRANCH
CODE=$?
if [ "$CODE" -ne 0 ]; then
  printf "\n\e[1;31mFailed to retrieve target branch to merge.\e[0;0m\n"
else
  git merge $TARGET_ID/$TARGET_BRANCH
fi
git status
if [ "$CODE" -ne 0 ]; then
  trap 'printf "\n\e[1;32mLatest origin branch changes have been pulled, \e[1;31mbut the target branch was not merged.\e[0;0m\n"; stty echo; exit 1' 2
else
  trap 'printf "\n\e[1;32mLatest changes have been pulled and merged.\e[0;0m\n"; stty echo; exit 0' 2
fi
printf "\n\e[1;33mPress the enter key to show diff, or Ctrl+C to finish.\e[0;0m\n"; read
git diff origin/$ORIGIN_BRANCH
if [ "$CODE" -ne 0 ]; then
  printf "\n\e[1;32mLatest origin branch changes have been pulled, \e[1;31mbut the target branch was not merged.\e[0;0m\n"
else
  printf "\n\e[1;32mLatest changes have been pulled and merged.\e[0;0m\n"
fi

stty echo
exit $CODE
