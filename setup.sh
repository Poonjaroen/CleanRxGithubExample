#! /bin/bash

cd ./CleanRxGithub; pod install; cd -;

cd ./lib/domain/GithubDomain/Example; pod install; cd -;

cd ./lib/platform/GithubNetworkPlatform/Example; pod install; cd -;

cd ./lib/utility/GithubNetwork/Example; pod install; cd -;

echo Done!
