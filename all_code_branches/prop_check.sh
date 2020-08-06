#!/bin/sh


pathes=("/ssd2/lichuan/mtk5510_fae_eu/" "/ssd2/lichuan/mtk5510_fae_eu/" "/ssd2/lichuan/hdd1/mtk5510/" "/ssd2/lichuan/hdd1/mtk5522/" "/ssd2/lichuan/hdd1/mtk5522_fae/" "/ssd2/lichuan/mtk5510_fae_us/" "/ssd2/lichuan/mtk5510_fae_sa/")


function handle_one_branch_in_apps()
{
    br=$1
    cd ./android_apps/
    if [ x"" != x"$br" ]; then
        git co $br
    fi
    git checkout .
    git pull
    grep -rnE "\\$\(ID_" map_apps.mk
    grep -rnE "\\$\(CVT_" map_apps.mk
    cd ../
}

function handle_one_branch_in_common()
{
    br=$1
    cd ./customers/
    if [ x"" != x"$br" ]; then
        git co $br
    fi
    git checkout .
    git pull
    grep -rnE "\\$\(ID_" common/Global_Default_Property.mk
    grep -rnE "\\$\(CVT_" common/Global_Default_Property.mk
    cd ../
}

function handle_one_path()
{
    mPath=$1
    pushd .
    cd $mPath
    i=0
    if [ -f .repo/manifests/versions/versions.txt ]; then
        for version in `cat .repo/manifests/versions/versions.txt | awk -F ':' '{print $2}'`; do
            echo "in version $version : "
            if [ $i -eq 0 ]; then
                upstream=`cat .repo/manifests/versions/${version}/default.xml |grep frameworks|grep -Eo upstream=\".*\" |awk -F '=' '{print $2}'|grep -Eo "[a-z|A-Z|_]+"`
                handle_one_branch_in_apps $upstream
                handle_one_branch_in_common $upstream
                i=1
            fi
            realVersion=`cat .repo/manifests/versions/${version}/default.xml |grep configuration |grep -vE "<!"|grep android_apps|grep -Eo "r_[0-9|a-z|A-Z|\.|_]+"`
            handle_one_branch_in_apps $realVersion
            realVersion=`cat .repo/manifests/versions/${version}/default.xml |grep configuration |grep -vE "<!"|grep customers|grep -Eo "r_[0-9|a-z|A-Z|\.|_]+"`
            handle_one_branch_in_common $realVersion
        done
    else
        handle_one_branch_in_apps
        handle_one_branch_in_common
    fi
    popd
}

for mpath in ${pathes[@]} ;do
    handle_one_path $mpath
    echo -e "\033[31m press enter to continue \033[0m"
    read key
done

