#!/bin/bash
set -e

VERSION="v2.9.1"
URL="https://github.com/codeion/react-native-pjsip-builder/releases/download/${VERSION}/release.tar.gz"
LOCK=".libs.lock"
DEST=".libs.tar.gz"
LIBS="android/src/main/jniLibs"
DOWNLOAD=true

if ! type "curl" > /dev/null; then
    echo "Missed curl dependency" >&2;
    exit 1;
fi
if ! type "tar" > /dev/null; then
    echo "Missed tar dependency" >&2;
    exit 1;
fi

if [ -f ${LOCK} ]; then
    CURRENT_VERSION=$(cat ${LOCK})

    if [ "${CURRENT_VERSION}" == "${VERSION}" ];then
        DOWNLOAD=false
    fi
fi

if [ "$DOWNLOAD" = true ]; then
    curl -L --silent "${URL}" -o "${DEST}"
    tar -xvf "${DEST}"
    rm "${LIBS}/arm64-v8a/libc++_shared.so"
    rm "${LIBS}/armeabi-v7a/libc++_shared.so"
    rm "${LIBS}/x86/libc++_shared.so"
    rm "${LIBS}/x86_64/libc++_shared.so"
    rm -f "${DEST}"

    echo "${VERSION}" > ${LOCK}
fi
