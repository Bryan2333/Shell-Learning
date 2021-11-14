#!/usr/bin/env bash

## 这是一个用来查询nginx日志的脚本

export date=`cat nginx.log | cut -d " " -f 2 | sed 's/.//' | sort -t "/" -nk 1 | cut -d "/" -f1,2  | uniq` ##从日志文件中获取日期

function get-choose {

echo -n "请输入您的选择："

read choose ##从键盘获得choose变量

}

function processlog {

	cat nginx.log | grep "${logchoose}" | nali

}

function logmenu {

	echo "以下为保留有日志的日期"
	for datename in ${date}
	do
		echo "${datename}"
	done
	echo "输入back返回上级菜单"
	echo -n "请输入您要查询的日期："
	read logchoose

}

function log-select {

if [ "${logchoose}" = "" ] ##如果用户直接回车
then clear && echo -e "\033[41;37m 您输入的日期有误，请重新输入 \033[0m"  && logmenu && log-select
elif [[ "${date}" =~ "${logchoose}" ]]
then processlog && echo -e "\033[34m 按任意键返回上级菜单 \033[0m" && read -n 1 && clear && logmenu && log-select
elif [ "${logchoose}" = back ]
then clear && menu && get-choose && menu-select
else clear && echo -e "\033[41;37m 您输入的日期有误，请重新输入 \033[0m" && logmenu && log-select
fi

}

function menu {

	echo "这是一个用来查询NGINX日志的脚本"
	echo "1、日志查询"
	echo "2、返回菜单"
	echo "3、退出"

}

function menu-select {

	case ${choose} in
        1) clear && logmenu && log-select                                 ;;
        2) clear && menu && get-choose && menu-select	                   ;;
        3) exit ;;
	*) clear && echo -e "\033[41;37m 您的输入有误，请重新输入 \033[0m"  && menu && get-choose && menu-select ;;
esac

}

menu

get-choose

menu-select
