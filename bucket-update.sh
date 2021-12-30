#!/bin/bash

set -eu
export ANDROID_SDK_ROOT=/home/soto/i/android-sdk

cd "$(dirname $0)"

(cd ~/p/bucket; zip /home/soto/p/love-android/app/src/main/assets/game.love -r $(find * | grep -v '.md$' | grep -v '^luaunit'))
./gradlew installEmbedNoRecordDebug

adb shell am start -n re.weav.android.bucket/org.love2d.android.GameActivity
until [[ -n $(adb shell pidof -s re.weav.android.bucket) ]]; do
	sleep .01s
done
adb logcat --pid=$(adb shell pidof -s re.weav.android.bucket)
