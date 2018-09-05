#!/bin/sh

#  hvccFast.sh
#  
#
#  Created by PARKER Martin on 05/09/2018.
#
# this script quickly builds the xcode and android files you need from a _main.pd file using the hvcc.py library.
# it requires three arguments, the namespace of the unity plugins you want to create, the full path of _main.pd without _main.pd and your copyright notice
# example bash enzienScript.sh unsettled ~/Dropbox/mobilePhoneDev 'Copyright (c) tinpark 2020'
# To make the script work from anywhere you'll have to put it somewhere bash will find it
# You will have to modify this script if your ndk-build software is somewhere different than in your user library
# You will need xcode's commandline tools installed
#

cd $2;
mkdir $1;
python2.7 ~/hvcc/hvcc.py $2/_main.pd -o $2/$1 -n $1 -g unity --copyright "$3";
cd $1/unity/xcode;
xcodebuild -project Hv_$1_Unity.xcodeproj -arch x86_64 -alltargets;
cd ..;
cd android/jni;
~/Library/Android/sdk/ndk-bundle/ndk-build APP_ABI=armeabi-v7a -j;
