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
			printf "\r [${sep}] ${indt} ${o}\n";
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
	nPrint --sep '\033[00;31mFAIL\033[m' "${@}";
        echo '';
        exit;
}

function success() {
	nPrint --sep '\033[00;32m OK \033[0m' "${@}";
}

function warn() {
	nPrint --sep '\033[00;36mWARN\033[0m' "${@}";
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
		cmds+="${command}:";
		cmds+=$("${command}_help" --one-line);
	done;

	local additional="\
For additional help type:\n\
${0} [COMMAND] --help\n\
";

	notify "$oneline";
	notify "${usage[@]}";
	notify --ind 1 "${cmds[@]}";
	notify "${additional[@]}"
}

#COMMANDS+=('link');
#COMMANDS+=('delete');

main "${@}" || exit 1;

#for cmd in {notify,ask,warn,success,fail}; do
#	$cmd "Line 1.\nLine 2.";
#done;
