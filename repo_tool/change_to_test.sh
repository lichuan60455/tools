#!/bin/sh
#this tool is use to change to test branch.

REPOSITORYS=$(repo forall -c "pwd")
for rep in $REPOSITORYS; do
    #echo $rep
    pushd . &> /dev/null
    cd $rep
    testbr=$(git br|grep -Eo "test")
    if [ x"test" == x"$testbr" ]; then
        pwd
    fi
    popd &> /dev/null
done
