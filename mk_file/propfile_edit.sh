##/bin/sh
##ifeq ($(XXX),1)
#tmp=$(grep -E "^ifeq \(\\$\(CVT_[A-Z|_|0-9]+\)\,[ ]{0,1}1\)" Global_Default_Property.mk|grep -Eo "CVT_[A-Z|_|0-9]+")
#for element in $tmp
#do
#    low_case_element=`tr '[A-Z]' '[a-z]' <<< $element`
#    header=`echo $element| cut -d _ -f 1,2`
#    tail=`echo $low_case_element | cut -d _ -f 2-`
#    echo "#define ${element} 1" >> macro.txt
##    echo $element
##    echo $low_case_element
##    echo $header
##    echo $tail
##    if [ "$header" == "CVT_EN" ];
##    then
##        echo "enable"
##    elif [ "$header" == "CVT_DEF" ];
##    then
##        echo "default"
##    fi
#    sed -i "s/.*\<ifeq (\$(${element}\>.*/${tail}\=$\(shell $\(cvte_utility_get_macro_value\) ${element} \-m mk\)\nifeq \($\($tail\)\, 1\)/g" Global_Default_Property.mk
#done
#
##ifneq ($(XXX),1)
#temp1=$(grep -E "^ifneq \(\\$\(CVT_[A-Z|_|0-9]+\)\,[ ]{0,1}1\)" Global_Default_Property.mk|grep -Eo "CVT_[A-Z|_|0-9]+")
#for ele1 in $temp1
#do
#    low_case_ele1=`tr '[A-Z]' '[a-z]' <<< $ele1`
#    head1=`echo $ele1| cut -d _ -f 1,2`
#    tail1=`echo $low_case_ele1 | cut -d _ -f 2-`
#    echo "#define ${ele1} 1" >> macro.txt
#    sed -i "s/.*\<ifneq (\$(${ele1}\>.*/${tail1}\=$\(shell $\(cvte_utility_get_macro_value\) ${ele1} \-m mk\)\nifneq \($\($tail1\)\, 1\)/g" Global_Default_Property.mk
#done
#
##ifeq ($(XXX),0)
#tmp2=$(grep -E "^ifeq \(\\$\(CVT_[A-Z|_|0-9]+\)\,[ ]{0,1}0\)" Global_Default_Property.mk|grep -Eo "CVT_[A-Z|_|0-9]+")
#for ele2 in $tmp2
#do
#    low_case_ele2=`tr '[A-Z]' '[a-z]' <<< $ele2`
#    head2=`echo $ele2| cut -d _ -f 1,2`
#    tail2=`echo $low_case_ele2 | cut -d _ -f 2-`
#    echo "#define ${ele2} 1" >> macro.txt
#    sed -i "s/.*\<ifeq (\$(${ele2}\>.*/${tail2}\=$\(shell $\(cvte_utility_get_macro_value\) ${ele2} \-m mk\)\nifeq \($\($tail2\)\, 0\)/g" Global_Default_Property.mk
#done
#
##ifneq ($(XXX),0)
#temp3=$(grep -E "^ifneq \(\\$\(CVT_[A-Z|_|0-9]+\)\,[ ]{0,1}0\)" Global_Default_Property.mk|grep -Eo "CVT_[A-Z|_|0-9]+")
#for ele3 in $temp3
#do
#    low_case_ele3=`tr '[A-Z]' '[a-z]' <<< $ele3`
#    head3=`echo $ele3| cut -d _ -f 1,2`
#    tail3=`echo $low_case_ele3 | cut -d _ -f 2-`
#    echo "#define ${ele3} 1" >> macro.txt
#    sed -i "s/.*\<ifneq (\$(${ele3}\>.*/${tail3}\=$\(shell $\(cvte_utility_get_macro_value\) ${ele3} \-m mk\)\nifneq \($\($tail3\)\, 0\)/g" Global_Default_Property.mk
#done
#
##ifeq ($(XXX),null)
#temp4=$(grep -E "^ifeq \(\\$\(CVT_[A-Z|_|0-9]+\)\,[ ]{0,1}null\)" Global_Default_Property.mk|grep -Eo "CVT_[A-Z|_|0-9]+")
#for ele4 in $temp4
#do
#    low_case_ele4=`tr '[A-Z]' '[a-z]' <<< $ele4`
#    head4=`echo $ele4| cut -d _ -f 1,2`
#    tail4=`echo $low_case_ele4 | cut -d _ -f 2-`
#    echo "#define ${ele4} 1" >> macro.txt
#    sed -i "s/.*\<ifeq (\$(${ele4}\>.*/${tail4}\=$\(shell $\(cvte_utility_get_macro_value\) ${ele4} \-m mk -s\)\nifeq \($\($tail4\)\, null\)/g" Global_Default_Property.mk
#done
#
##ifneq ($(XXX),null)
#temp5=$(grep -e "^ifneq \(\\$\(cvt_[a-z|_|0-9]+\)\,[ ]{0,1}null\)" global_default_property.mk|grep -eo "cvt_[a-z|_|0-9]+")
#for ele5 in $temp5
#do
#    low_case_ele5=`tr '[a-z]' '[a-z]' <<< $ele5`
#    head5=`echo $ele5| cut -d _ -f 1,2`
#    tail5=`echo $low_case_ele5 | cut -d _ -f 2-`
#    echo "#define ${ele5} 1" >> macro.txt
#    sed -i "s/.*\<ifneq (\$(${ele5}\>.*/${tail5}\=$\(shell $\(cvte_utility_get_macro_value\) ${ele5} \-m mk -s\)\nifneq \($\($tail5\)\, null\)/g" global_default_property.mk
#done
#
function change_value()
{
    is_equal_str=$1
    value=$2
    macros=$(grep -E "^${is_equal_str} \(\\$\(CVT_[A-Z|_|0-9]+\)\,[ ]{0,1}${value}\)" Global_Default_Property.mk|grep -Eo "CVT_[A-Z|_|0-9]+")
    for mac in $macros
    do
        low_case_mac=`tr '[A-Z]' '[a-z]' <<< $mac`
        head_str=`echo ${mac}| cut -d _ -f 1,2`
        tail_str=`echo ${low_case_mac} | cut -d _ -f 2-`
        echo "#define ${mac} 1" >> macro.txt
        sed -i "s/.*\<${is_equal_str} (\$(${mac}\>.*/${tail_str}\=$\(shell $\(cvte_utility_get_macro_value\) ${mac} \-m mk\)\n${is_equal_str} \($\(${tail_str}\)\, ${value}\)/g" Global_Default_Property.mk
        sed -i "s/=\$(${mac})/=\$(${tail_str})/g" Global_Default_Property.mk
    done
}

change_value "ifeq" 1
change_value "ifneq" 1
change_value "ifeq" 0
change_value "ifneq" 0
change_value "ifeq" "null"
change_value "ifneq" "null"
change_value "ifeq" "NULL"
change_value "ifneq" "NULL"

