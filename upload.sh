#!/bin/bash

VersionString=`grep -E 's.version.*=' APIManagers.podspec`
VersionNumber=`tr -cd 0-9 <<<"$VersionString"`

NewVersionNumber=$(($VersionNumber + 1))
LineNumber=`grep -nE 's.version.*=' APIManagers.podspec | cut -d : -f1`
sed -i "" "${LineNumber}s/${VersionNumber}/${NewVersionNumber}/g" APIManagers.podspec

echo "current version is ${VersionNumber}, new version is ${NewVersionNumber}"

git add .
git commit -am ${NewVersionNumber}
git tag ${NewVersionNumber}
git push origin master --tags
#pod repo push PrivatePods APIManagers.podspec --verbose --allow-warnings --use-libraries
pod trunk push APIManagers.podspec --verbose --allow-warnings --use-libraries

