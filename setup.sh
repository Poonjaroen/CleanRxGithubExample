#! /bin/bash

function notify () {
  text=$1;
  len=$((${#text}+12))
  line=""
  for i in `seq 1 $len`; do line=$line"#"; done;
  printf "$line\n##### $text #####\n$line\n"
}

function warn () {
  text=$1;
  len=$((${#text}))
  line=""
  for i in `seq 1 $len`; do line=$line"-"; done;
  printf "$text\n$line\n"
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

echo '##### Done!'


echo '
www    wwwwwwww    www  eeeeeeeeee  lll        ccccccccccc  oooooooooooo  mm          mmm  eeeeeeeeee  !!!  !!!
 www  wwww  wwww  www   eee         lll        ccccccccccc  oooooooooooo  mmmm       mmmm  eee         !!!  !!!
  ww  www    www  ww    eeeeeeee    lll        cccc         oooo    oooo  mm mm     mm mm  eeeeeeee    !!!  !!!
   wwwww      wwwww     eeeeeeee    lll        cccc         oooo    oooo  mm  mm   mm  mm  eeeeeeee    !!!  !!!
    www        www      eee         lllllllll  ccccccccccc  oooooooooooo  mm   mm mm   mm  eee                 
     w          w       eeeeeeeeee  lllllllll  ccccccccccc  oooooooooooo  mm     m     mm  eeeeeeeeee  !!!  !!!

===============================================================================================================
===============================================================================================================

'

notify "Forking your workshop..."

do_fork () {
  echo "What's your Github.com credentials?"
  read -p "Username: " user
  read -p "Password: " -s pass
  token=`echo -n $user:$pass | base64`
  fork_result=`curl -X POST -H 'Authorization: Basic $token' 'https://api.github.com/repos/msyte1tainn/CleanRxGithubExample/forks' 2>&1`
}

do_fork;
while [[ $fork_result == "Bad" ]]; do do_fork; done;

# Sleep for 2 seconds waiting for the fork to complete
sleep 2s

echo '#### Done!'

notify "Checking out workshop..."
git clone "https://github.com/repos/$user/CleanRxGithubExample";
cd ./CleanRxGithubExample;
git checkout '9-workshop';
git checkout -b feature/workshop;
git checkout master ./setup.sh;
git checkout master ./CleanRxGithub/.gitignore;

echo '##### Done!'

notify "Installing materials..."
cd ./CleanRxGithub; pod install; cd -;

cd ./lib/domain/GithubDomain/Example; pod install; cd -;

cd ./lib/platform/GithubNetworkPlatform/Example; pod install; cd -;

cd ./lib/utility/GithubNetwork/Example; pod install; cd -;
echo '##### Done!'

notify "Starting workshop..."
git add .; git commit -m "Workshop start";

notify 'All Done!'
