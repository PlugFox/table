#!/bin/sh
#set -eux

# How to add latest sqlite and lcov
# ```
# echo "https://dl-cdn.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories
# echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
# echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
# apk update && apk --no-cache add sqlite sqlite-dev lcov
# ```
#
# How to configurate git:
# ```
# git config --global user.email "developer@domain.tld"
# git config --global user.name "Flutter Developer"
# git config --global credential.helper store
# git config --global --add safe.directory /opt/flutter
# ```

SRC=$PWD
PKG="/tmp/dart/package"
rm -rf $PKG; mkdir -p $PKG
echo "Testing: started"
date
cp "${PWD}/pubspec.yaml" "$PKG/pubspec.yaml"
cp "${PWD}/analysis_options.yaml" "$PKG/analysis_options.yaml"
cp "Makefile" "$PKG/Makefile"
for f in \
    "lib" \
    "example" \
    "test" \
    "tool" \
; do \
    dir="$(dirname "$f")"; \
    mkdir -p "$PKG$dir"; \
    cp -a "$SRC/$f" "$PKG/$f"; \
done
cd $PKG
error=false
timeout 300 flutter doctor > /dev/null
timeout 60 flutter pub get
timeout 60 dart format --set-exit-if-changed .
timeout 60 dart analyze --fatal-infos --fatal-warnings .
timeout 300 flutter test --no-pub --concurrency=6 --coverage test/all_test.dart || error=true
date
cd $SRC; rm -rf $PKG

if [ "$error" = true ] ;
then
    echo "Testing: error"
    exit -1
else
    echo "Testing: completed"
    exit 0
fi