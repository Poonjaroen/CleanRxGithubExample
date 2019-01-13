#! /bin/bash


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

echo '
####################################
##### Checking out workshop... #####
####################################

'
git checkout '9-workshop';
git checkout -b feature/workshop;
git checkout master ./setup.sh;
git checkout master ./CleanRxGithub/.gitignore;
echo '##### Done!'

echo '
###################################
##### Installing materials... #####
###################################

'
cd ./CleanRxGithub; pod install; cd -;

cd ./lib/domain/GithubDomain/Example; pod install; cd -;

cd ./lib/platform/GithubNetworkPlatform/Example; pod install; cd -;

cd ./lib/utility/GithubNetwork/Example; pod install; cd -;
echo '##### Done!'

echo '
################################
##### Starting workshop... #####
################################

'
git add .; git commit -m "Workshop start";

echo '
#####################
##### All Done! #####
#####################
'
