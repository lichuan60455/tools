#!/bin/sh
OLD_FILE="./differ_files/local/temp/"
NEW_FILE="./differ_files/delta/"

function compare_md5_of_file()
{
    src_file_name=$1
    dst_file_name=$2
    src_md5=`md5sum $src_file_name | awk '{print $1}'`
    dst_md5=`md5sum $dst_file_name | awk '{print $1}'`
    if [ $src_md5 == $dst_md5 ];
    then
        return 0
    else
        return 1
    fi
}

function is_auto_merge_file_type()
{
    auto_merge_file_type=("rel.md5sum.system.map" "md5sum.system.map" "bin" "so" "o" "vuduapp" "tgz" "18.tgz" "ko" "so.1" "mapfile" "a" "bin.lzhs.nosign" "bin2h")
    full_file_name=$1
    file_type=`echo $full_file_name | awk -F '/' '{print $NF}'|cut -d '.' -f 2-`
    for t in ${auto_merge_file_type[@]}
    do
        if [ $t == $file_type ]
        then
            return 0
        fi
    done
    return 1
}


function copy_files()
{
    src=`find ./delta`

    for src_file in $src
    do
        if [ -f $src_file ]; then
            dst_file="../"`echo $src_file | cut -d / -f 3-`
            if [ -f $dst_file ]; then
                compare_md5_of_file $src_file $dst_file
                #md5 is different
                if [ $? -ne 0 ]; then
                    is_auto_merge_file_type $src_file
                    if [ $? -ne 0 ]; then
                        #This file needs to merge manually
                        cp --parents $src_file $NEW_FILE
                        echo "cp --parents $src_file $NEW_FILE" >> log.txt
                        cp --parents $dst_file $OLD_FILE
                        echo "cp --parents $dst_file $OLD_FILE" >> log.txt
                    else
                        #This file can merge automatically
                        cp -fr $src_file $dst_file
                        echo "cp -fr $src_file $dst_file" >> log.txt
                    fi
                fi
                #this is new file
            else
                dir_name=`dirname $dst_file`
                mkdir -p $dir_name
                cp -fr $src_file $dst_file
                echo "cp -fr $src_file $dst_file" >> log.txt
            fi
        fi
    done
}

function clean_tmp()
{
    mv ./differ_files/delta/delta/release/ ./differ_files/delta/release/
    rm -rf ./differ_files/delta/delta/
    rm -rf ./differ_files/local/temp/
}

function reset_files()
{
    pushd .
    # clean mannual merge code
    rm -rf ./differ_files

    # clean mannual merge code
    # clean apollo
    cd ../release/apollo/
    pwd
    git checkout .
    git clean -dfx .

    # clean linux_core
    cd linux_core/
    pwd
    git checkout .
    git clean -dfx .

    # clean android
    cd ../../android/
    pwd
    git checkout .
    git clean -dfx .
    popd
}


function copy_files_stage_2()
{
    files=`find ./differ_files/local/`
    for f in $files; do
        if [ -f $f ]; then
            dst_file="../"`echo $f|cut -d '/' -f 4-`
            cp -fr $f $dst_file
            echo "cp -fr $f $dst_file" >> log.txt
        fi
    done
}

mkdir -p $OLD_FILE
mkdir -p $NEW_FILE

OPT=$1

if [ x$OPT == x"clean" ]; then
    reset_files
    return
elif [ x$OPT == x"stage1" ]; then
    echo "stage1: copying object files like: .o, .so, .jar into code. and copying .c, .cpp, .java, .txt, .h out of code to manual merge"
    if [ -f log.txt ]; then
        rm log.txt
    fi
    copy_files
    clean_tmp
elif [ x$OPT == x"stage2" ]; then
    echo "stage2: Copying mannual merged files into code"
    copy_files_stage_2
fi
