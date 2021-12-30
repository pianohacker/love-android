#!/usr/bin/env bash

set -eu
export ANDROID_SDK_ROOT=/home/soto/i/android-sdk

cd "$(dirname $0)"

(cd ~/p/bucket; zip /home/soto/p/love-android/app/src/main/assets/game.love -r *)
./gradlew bundleEmbedNoRecordRelease
