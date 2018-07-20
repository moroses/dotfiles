#!/bin/bash

## Output functions modeled on @holman design

# nice print function
# parameters:
# --sep : four characters (preferred in color)
# --ind : indent level (0..n)
# ... : Text, will be broken in lines for printing on screen.
function nPrint() {
	local sep='\033[00;34m .. \033[0m';
	local ind=0;
	local err=0;
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
