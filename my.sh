#!/bin/bash
#用来匹配的列
_command="Command:";
#期望的值
_expect="Sleep"
#需要显示的列
_dest='Info:'

function getItem(){
	mysql -uroot -p1 -e 'show processlist\G'| grep -A 8 "* $1. row"| grep -v "* $1. row"| grep $2|xargs;
}

function getSum(){
	echo `mysql -uroot -p1 -e 'show processlist'| wc -l`
}

tmp=$(getSum);
_sum=$(($tmp-1));
echo $_sum;

for((i=1;i<$_sum;i++));do


#	echo "command:$_command";
	result=$(getItem "$i" "$_command");
#	echo "result-->$result";
	msg=$(echo $result | awk -F ': ' '{print $2}');
#	echo "msg-->$msg";
#	echo "expected-->$_expect";
	if [ "$msg" == "$_expect" ];then
#	echo "aa";
#	echo $msg;
	echo $(getItem "$i" "$_dest");
#	else
#	echo '....';
	fi


done;
