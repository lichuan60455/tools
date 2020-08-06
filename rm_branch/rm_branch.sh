#!/bin/sh
#用于删除无用的一些branch,除了本branch和test名字的branch

branches=`git branch|cut -d ' ' -f 2-`
current_branch=`git branch|grep "^*" | cut -d ' ' -f 2-`
for br in ${branches}; do
    if [ x"test" != x"${br}" -a x"${current_branch}" != x"${br}" ]; then
        git branch -D ${br}
    fi
done
