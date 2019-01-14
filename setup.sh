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
  text=$1;
  len=$((${#text}+12))
  line=""
  for i in `seq 1 $len`; do line=$line"-"; done;
  printf "${yellow}$line\n----- ${green}$text${yellow} -----\n$line\n\n${nc}"
}

function warn () {
  text=$1;
  len=$((${#text}))
  line=""
  for i in `seq 1 $len`; do line=$line"-"; done;
  printf "${yellow}$text\n$line\n${nc}"
}

function fin () {
  printf "${yellow}-- ${green}Done!\n\n"
}

notify 'Checking required tools...';
if [[ `which brew` != *"brew"* ]]; then
  printf "It seems that you don't have Homebrew installed, installing...\n"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
fi

if [[ `which curl` != *"curl"* ]]; then
  printf "It seems that you don't have CURL installed, installing..."
  brew install curl;
fi

fin


printf "
${green}wwww      wwww      wwww  ${blue}eeeeeeeeee  ${red}lll        ${orange}ccccccccccc  ${light_purple}oooooooooooo  ${cyan}mmm           mmm  ${blue}eeeeeeeeee  ${white}!!!  !!!
${green} www    wwwwwwww    www   ${blue}eeeeeeeeee  ${red}lll        ${orange}ccccccccccc  ${light_purple}oooooooooooo  ${cyan}mmmm         mmmm  ${blue}eeeeeeeeee  ${white}!!!  !!!
${green}  www  wwww  wwww  www    ${blue}eee         ${red}lll        ${orange}cccc         ${light_purple}oooo    oooo  ${cyan}mmmmm       mmmmm  ${blue}eee         ${white}!!!  !!!
${green}   ww  www    www  ww     ${blue}eeeeeeee    ${red}lll        ${orange}cccc         ${light_purple}oooo    oooo  ${cyan}mmm mm     mm mmm  ${blue}eeeeeeee    ${white}!!!  !!!
${green}    wwwww      wwwww      ${blue}eeeeeeee    ${red}lll        ${orange}cccc         ${light_purple}oooo    oooo  ${cyan}mmm  mm   mm  mmm  ${blue}eeeeeeee    ${white}!!!  !!!
${green}     www        www       ${blue}eee         ${red}lll        ${orange}cccc         ${light_purple}oooo    oooo  ${cyan}mmm   mm mm   mmm  ${blue}eee         ${white}        
${green}      w          w        ${blue}eeeeeeeeee  ${red}lllllllll  ${orange}ccccccccccc  ${light_purple}oooooooooooo  ${cyan}mmm     m     mmm  ${blue}eeeeeeeeee  ${white}!!!  !!!
${green}      w          w        ${blue}eeeeeeeeee  ${red}lllllllll  ${orange}ccccccccccc  ${light_purple}oooooooooooo  ${cyan}mmm     m     mmm  ${blue}eeeeeeeeee  ${white} !    !

${light_red}===================================================================================================================
${light_red}===================================================================================================================

${nc}"

notify "Forking your workshop..."

do_fork () {
  printf "${light_cyan}What's your Github.com credentials?\n${nc}";
  read -p "Username: " user;
  read -p "Password: " -s pass;
  token=`echo -n $user:$pass | base64`
  fork_result=`curl -X POST -H 'Authorization: Basic $token' 'https://api.github.com/repos/myste1tainn/CleanRxGithubExample/forks' 2>&1`
}

do_fork;
while [[ $fork_result == "Bad" ]]; do do_fork; done;

 Sleep for 2 seconds waiting for the fork to complete
sleep 2s

fin

notify "Checking out workshop..."
git clone "https://github.com/repos/$user/CleanRxGithubExample";
cd ./CleanRxGithubExample;
git checkout '9-workshop';
git checkout -b feature/workshop;
git checkout master ./setup.sh;
git checkout master ./CleanRxGithub/.gitignore;

fin

notify "Installing materials..."
cd ./CleanRxGithub; pod install; cd -;

cd ./lib/domain/GithubDomain/Example; pod install; cd -;

cd ./lib/platform/GithubNetworkPlatform/Example; pod install; cd -;

cd ./lib/utility/GithubNetwork/Example; pod install; cd -;
fin

notify "Starting workshop..."
git add .; git commit -m "Workshop start";

notify 'All Done!'
