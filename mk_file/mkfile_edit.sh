#/bin/sh
tmp=$(grep -E "^ifeq \(\\$\(CVT_[A-Z|_|0-9]+\)\,1\)" map_apps.mk|grep -Eo "CVT_[A-Z|_|0-9]+")
for element in $tmp
do
    low_case_element=`tr '[A-Z]' '[a-z]' <<< $element`
    header=`echo $element| cut -d _ -f 1,2`
    tail=`echo $low_case_element | cut -d _ -f 2-`
    echo "#define ${element} 1" >> macro.txt
#    echo $element
#    echo $low_case_element
#    echo $header
#    echo $tail
#    if [ "$header" == "CVT_EN" ];
#    then
#        echo "enable"
#    elif [ "$header" == "CVT_DEF" ];
#    then
#        echo "default"
#    fi
    sed -i "s/.*\<${element}\>.*/${tail}\=$\(shell $\(cvte_utility_get_macro_value\) ${element} \-m mk\)\nifeq \($\($tail\)\,1\)/g" map_apps.mk
done
