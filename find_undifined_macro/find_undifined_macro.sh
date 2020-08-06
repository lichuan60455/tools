#!/bin/sh

CHECKFIEL=$1
DSTFILEPATH=$2
DRAFTFILE=${DSTFILEPATH}Global_Default_Draft.h
CONFIGFILE=${DSTFILEPATH}Global_Default_Config.h
ANDROIDFILE=${DSTFILEPATH}Global_Default_Android.h

function is_macro_defined()
{
    macro=$1
    ret=$(grep -w $macro $DRAFTFILE)
    if [ x"" != x"$ret" ]; then
        return 0
    fi

    ret=$(grep -w $macro $CONFIGFILE)
    if [ x"" != x"$ret" ]; then
        return 0
    fi

    ret=$(grep -w $macro $ANDROIDFILE)
    if [ x"" != x"$ret" ]; then
        return 0
    fi

    return 1

}


macros=$(grep -rnvE "^#" $CHECKFIEL | grep -Eo "\bCVT_[A-Z|_|0-9]+")
for m in $macros; do
    is_macro_defined $m
    if [ $? -eq 1 ]; then
        echo "$m is not defined!"
    fi
done
