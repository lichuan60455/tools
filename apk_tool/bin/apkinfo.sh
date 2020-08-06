#!/bin/sh
option=$1
apk_name=$2
apt=~/mytools/apk_tool/bin/aapt

function get_package_name()
{
   ${apt} dump badging $1 | grep -E "^package" | awk '{print $2}'|cut -d "'" -f 2
}

function get_package_version()
{
    get_package_version_code $1
    get_package_version_name $1
}
function get_package_version_code()
{
   ${apt} dump badging $1 | grep -Eo "versionCode='[^ ]+'"
}

function get_package_version_name()
{
   ${apt} dump badging $1 | grep -Eo "versionName='[^ ]+'"
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
        Show versionCode and version name of xxx.apk
    3)apkinfo versionCode xxx.apk
        Show versionCode xxx.apk
    4)apkinfo versionName xxx.apk
        Show versionName of xxx.apk
    5)apkinfo activity xxx.apk
        Show launchable-activity of xxx.apk
    6)apkinfo all xxx.apk
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
elif [ "${option}" == "versionCode" ]; then
    get_package_version_code ${apk_name}
elif [ "${option}" == "versionName" ]; then
    get_package_version_name ${apk_name}
elif [ "${option}" == "activity" ]; then
    get_package_launcher_activity ${apk_name}
elif [ "${option}" == "all" ]; then
    get_package_all_info ${apk_name}
else
    $apt $*
fi
