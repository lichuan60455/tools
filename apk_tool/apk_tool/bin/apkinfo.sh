#!/bin/sh
option=$1
apk_name=$2
apt=~/mtools/apk_tool/bin/aapt

function get_package_name()
{
   ${apt} dump badging $1 | grep -E "^package" | awk '{print $2}'|cut -d "'" -f 2
}

function get_package_version()
{
   ${apt} dump badging $1 | grep -E "^package" | awk '{print $3}'|cut -d "'" -f 2
}

function get_package_launcher_activity()
{
   ${apt} dump badging $1 | grep -E "^launchable-activity" | awk '{print $2}'|cut -d "'" -f 2
}

function get_package_all_info()
{
   ${apt} dump badging $1
}

if [ $# -lt 2 ]; then
    echo "Usage :
    1)apkinfo name xxx.apk
        Show package name of xxx.apk
    2)apkinfo version xxx.apk
        Show versionCode of xxx.apk
    3)apkinfo activity xxx.apk
        Show launchable-activity of xxx.apk
    4)apkinfo all xxx.apk
        Show all information of xxx.apk"
    return
elif [ $# -eq 0 ]; then
    ${apt}
    return
fi

if [ "${option}" == "name" ]; then
    get_package_name ${apk_name}
elif [ "${option}" == "version" ]; then
    get_package_version ${apk_name}
elif [ "${option}" == "activity" ]; then
    get_package_launcher_activity ${apk_name}
elif [ "${option}" == "all" ]; then
    get_package_all_info ${apk_name}
else
    $apt $*
fi
