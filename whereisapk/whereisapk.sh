#!/bin/sh
TARGET=$1

function find_apk()
{
    local target=$1
    fi=$(find . -name "*.apk")
    for f in $fi; do
        pkg=$(apkinfo name $f)
        if [ x"$target" == x"$pkg" ]; then
            echo $f
        fi
    done
}

if [ $# -eq 1 ]; then
    find_apk $TARGET
else
    echo "whereisapk [package name]"
fi

