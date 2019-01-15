#! /bin/bash

black='\033[0;30m'
red='\033[0;31m'
green='\033[0;32m'
orange='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
light_gray='\033[0;37m'
dark_gray='\033[1;30m'
light_red='\033[1;31m'
light_green='\033[1;32m'
yellow='\033[1;33m'
light_blue='\033[1;34m'
light_purple='\033[1;35m'
light_cyan='\033[1;36m'
white='\033[1;37m'
nc='\033[0m'

function notify () {
  text=$1; len=$((${#text}+12)) line=""
  for i in `seq 1 $len`; do line=$line"-"; done;
  printf "${yellow}$line\n----- ${green}$text${yellow} -----\n$line\n\n${nc}"
} 

function warn () {
  text=$1; len=$((${#text})) line=""
  for i in `seq 1 $len`; do line=$line"-"; done;
  printf "${yellow}$text\n${yellow}$line\n${nc}"
}

function fin () {
  printf "${yellow}-- ${green}Done!\n\n"
}

notify 'Checking required tools...';
if [[ `which brew` != *"brew"* ]]; then
  warn "It seems that you don't have Homebrew installed, installing...\n"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
fi

if [[ `which curl` != *"curl"* ]]; then
  warn "It seems that you don't have CURL installed, installing...\n"
  brew install curl;
fi

if [[ `which pod` != *"poddd"* ]]; then
  warn "It seems that you don't have ${light_red}cocoapods${nc} installed, installing...\n"
  printf "${light_green} installing ${light_red}cocoapods${nc}${light_green} required elevated rights please provide\n${nc}"
  sudo gem install cocoapods
fi

fin


printf "
${green}WW  WW  WW ${blue}EEEEEEEE ${red}LL       ${orange}CCCCCCCCC ${light_purple}OOOOOOOO ${cyan}MM      MM ${blue}EEEEEEEE ${white}!!  !!
${green}WW  WW  WW ${blue}EE       ${red}LL       ${orange}CC        ${light_purple}OO    OO ${cyan}MMM    MMM ${blue}EE       ${white}!!  !!
${green}WW  WW  WW ${blue}EEEEEE   ${red}LL       ${orange}CC        ${light_purple}OO    OO ${cyan}MM MM M MM ${blue}EEEEEE   ${white}!!  !!
${green}WW  WW  WW ${blue}EE       ${red}LL       ${orange}CC        ${light_purple}OO    OO ${cyan}MM  MM  MM ${blue}EE       ${white}
${green}WWWWWWWWWW ${blue}EEEEEEEE ${red}LLLLLLLL ${orange}CCCCCCCCC ${light_purple}OOOOOOOO ${cyan}MM      MM ${blue}EEEEEEEE ${white}!!  !!
${light_red}==========================================================================
${light_red}==========================================================================

${nc}"

notify "Forking your workshop..."

do_fork () {
  printf "${light_cyan}What's your Github.com credentials?\n${nc}";
  read -p "Username: " user;
  read -p "Password: " -s pass;
  token=`echo -n $user:$pass | base64`;
  repo="https://api.github.com/repos/myste1tainn/CleanRxGithubExample/forks";
  echo ''
  fork_result=`curl -X POST -H Authorization:\ Basic\ $token $repo 2>&1`
}

do_fork;

if [[ $fork_result == *"Not found"* ]]; then
  warn "Repository: $repo cannot be found, exiting..."
  exit
fi

if [[ $fork_result == *"rate limit"* ]]; then
  warn "It seems the endpoint have reach it's limit, please try again later, exiting..."
  exit
fi

while [[ $fork_result == *"Bad"* ]]; do do_fork; done;

# Sleep for 5 seconds waiting for the fork to complete
sleep 5s

fin

function install_materials () {
  notify "Installing materials for $1..."
  cd ./CleanRxGithub; pod install; cd -;
  cd ./lib/domain/GithubDomain/Example; pod install; cd -;
  cd ./lib/platform/GithubNetworkPlatform/Example; pod install; cd -;
  cd ./lib/utility/GithubNetwork/Example; pod install; cd -;
  fin;
}

function checkout_required_files () {
  git checkout origin/master ./setup.sh;
  git checkout origin/master ./CleanRxGithub/.gitignore;
}

function clone_and_checkout () {
  branch=$1
  notify "Checking out $branch..."
  git clone "https://github.com/$user/CleanRxGithubExample.git" "cleanrx-$branch";

  cd "./cleanrx-$branch";
  git fetch --all;
  if [[ "$branch" == "workshop" ]]; then
    git checkout '9-workshop';
    git checkout -b feature/workshop;
    checkout_required_files;
  else
    git checkout $branch;
    checkout_required_files;
  fi

  git add .; git commit -m "$branch start";

  fin;
  install_materials $branch;
  cd ..;
}

clone_and_checkout 'workshop'
clone_and_checkout 'hint'

notify "Starting workshop..."


notify 'All Done!'

sleep 2s;

open ./cleanrx-workshop/CleanRxGithub/CleanRxGithub.xcworkspace;
open ./cleanrx-hint/CleanRxGithub/CleanRxGithub.xcworkspace;
open "https://github.com/$user/CleanRxGithubExample.git";

cd ./cleanrx-workshop;
