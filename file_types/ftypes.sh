MPATH=$1

function is_type_exist()
{
    mType=$1
    for t in ${file_types[@]}; do
        if [ x"$t" == x"$mType" ]; then
            return 0
        fi
    done
    return 1
}

function echo_types()
{
    for mt in ${file_types[@]}; do
        echo $mt
    done
}

function handle_types()
{
    for f in $files; do
        if [ -f $f ]; then
            mType=`echo $f|awk -F '/' '{print $NF}'|cut -d '.' -f 2-`
            is_type_exist $mType
            if [ $? -eq 1 ]; then
                file_types[${#file_types[@]}]=$mType
            fi

        fi
    done
}

if [ $# -lt 1 ]; then
    MPATH="."
    files=`ls $MPATH`
else
    files=`find $MPATH`
fi
file_types=()
handle_types
echo_types
