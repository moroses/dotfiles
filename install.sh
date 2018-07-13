#!/bin/bash

# TODO: Add directory change

## Output functions modeled on @holman design

# nice print function
# parameters:
# --sep : four characters (preferred in color)
# --ind : indent level (0..n)
# ... : Text, will be broken in lines for printing on screen.
function nPrint() {
	local sep='\033[00;34m .. \033[0m';
	local ind=0;
	while [ "${1::2}" = '--' ]; do
		case "${1}" in
			'--sep')
				sep="${2}";
				shift
				;;
			'--ind')
				ind="${2}";
				shift
				;;
			'--err')
				err=1;
				;;
			*)
				echo 'WTF?!?';
				exit 5
				;;
		esac
		shift
	done
	local indt='';
	if [ $ind -ne 0 ]; then
		for (( i=1; i<=${ind}; i++ )); do
#		for i in {1.."${ind}"}; do
			indt="${indt}\t";
		done;
	fi

	local IFS=$'\n';

	for l in "${@}"; do
		l="$l\n";
		l=${l//};
		while [[ $l ]]; do
			local o="${l%%\\n*}";
#			if [ $o = '' ]; then
#				break;
#			fi
			if [ "${err}" ]; then
				printf "\r [${sep}] ${indt} ${o}\n" >&2;
			else
				printf "\r [${sep}] ${indt} ${o}\n";
			fi
			l=${l#*\\n};
		done;
	done;

	return 0;
}

function notify() {
	nPrint "${@}";
}

function ask() {
	nPrint --sep '\033[00;33m ?? \033[0m' "${@}"
}

function fail() {
	nPrint --sep '\033[00;31mFAIL\033[m' --err "${@}";
}

function success() {
	nPrint --sep '\033[00;32m OK \033[0m' "${@}";
}

function warn() {
	nPrint --sep '\033[00;36mWARN\033[0m' "${@}";
}

# getSelection()
# 1 - value to search
# ...- list to search in
# return - matching value from list or ''

function getSelection() {
	local val="${1}";
	shift;
	for cmd in "${@}"; do
		if [ "${cmd}" = "${val}" ]; then
			echo "${cmd}"
			return 0;
		fi
	done;
	echo '';
	return 1;
}

# nonEmpty()
# 1 - Area of ``error''
# 2 - value's name
# 3 - value
# return - value or output an error message and exit

function nonEmpty() {
	func="${1}";
	name="${2}";
	value="${3}";
	if [ -z "${value}" ]; then
		fail "function ${func} received an empty value for ${name}";
		return 1;
	fi
	echo "${value}";
#	return 0;
}

# Every handle with a postfix of .symb will be linked to the home directory with a ``.'' prefix.
# Every handle with a postfix of .config will be linked to the home directory .config folder.
# bin/ directory will be added to the path.
# In every folder the script ``pre.sh'' will be loaded first and ``post.sh'' will be loaded after the ``link'' process.

# Main ``flow'' of the script modeled by @

COMMANDS=()
COMMANDS+=('main');

function main() {
	if [ "${1}" = "--help" ]; then
		main_help
		return 0;
	fi

	dotfiles='~/dotfiles/';
	target='~/';
	dummy=1;

	while [ "${1::2}" = "--" ]; do
		case "${1}" in
			'--dotfiles-src')
				dotfiles="${2}";
				shift
				;;
			'--target')
				target="${2}";
				shift
				;;
			'--dummy')
				dummy="${2}";
				shift
				;;
			*)
				warn "'${1} ${2}' is an unknown option."
				shift
				;;
		esac;
		shift
	done;

	cmd="$( getSelection "${1}" "${COMMANDS[@]}" )";
	shift;

	test=$(nonEmpty 'main' 'command' $cmd) || return 1;

	if [ "${1}" = "--help" ]; then
		"${cmd}_help";
	else
		$cmd "${@}";
	fi

	return 0;
}

function main_help() {
	oneline=".files link utility."
	if [ "${1}" = '--one-line' ]; then
		echo "${oneline[@]}";
		return ;
	fi
	local usage="\
usage: ${0} [OPTIONS] COMMAND [ARGS]\n\
\n\
Options:\n\
--help : Prints this help message and exit.\n\
--version : Print the ${0} version and exit.\n\
--dotfiles-src DIR : sets the directory to load .files from.\n\
--target DIR : set the directory to load the .files to.\n\
\n\
Commands:\n\
";

	for command in "${COMMANDS[@]}"; do
		cmds+="${command}: ";
		cmds+=$("${command}_help" --one-line);
		cmds+="\n";
	done;

	local additional="\
For additional help type:\n\
${0} [COMMAND] --help\
";

	notify "$oneline";
	notify "${usage[@]}";
	notify --ind 1 "${cmds[@]}";
	notify "${additional[@]}"
}

COMMANDS+=('link');

function link_help() {
	local target="TARGET";
	local dotfiles="DOTFILES";
	local oneline='Links the various files to the respected location';
	if [ "${1}" = "--one-line" ]; then
		echo "${oneline[@]}";
		return ;
	fi
	local fullline="\
Generates links from ${dotfiles} to ${target}, according to the following rules:";
	local fileMappings="\
NAME.symb -> link created in ${target}/.NAME";
	local folderMappings="\
NAME.config -> links for the contents of 'NAME.config' created in ${target}/config/NAME/\n\
NAME.ssh -> links for the contents of 'NAME.ssh' created in ${target}/.shh/\n\
bin/ -> Links for the contents of bin directory will be linked to ${target}/bin/\
";
	notify "link: ${oneline[@]}";
	notify "${fullline[@]}";
	notify "File mappings:";
	notify --ind 1 "${fileMappings[@]}" ;
	notify "Folder mappings:";
	notify --ind 1 "${folderMappings[@]}";
}

function link() {
	notify "Hi! You made it!";
	return 0;
}

#COMMANDS+=('link');
#COMMANDS+=('delete');

main "${@}" || exit 1;

#test="$( getSelection "YoYo" "Test" "Run_me" "Yo" "YoYo" )";
#notify "Exit code ${?}\nReturn value ${test}"

#notify "Exit code ${?}\nReturn value ${test}"

#for cmd in {notify,ask,warn,success,fail}; do
#	$cmd "Line 1.\nLine 2.";
#done;
