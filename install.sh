#!/bin/bash

# TODO: Add directory change

## Output functions modeled on @holman design


function notify() {
        printf "\r [ \033[00;34m..\033[0m ] $1\n";
#        echo -e " [ \e[34m..\e[0m ] $1";
}

function ask() {
        printf "\r [ \033[00;33m??\033[0m ] $1\n";
}

function fail() {
        printf "\r\033[2K [\033[00;31mFAIL\033[0m] $1\n";
        echo '';
        exit;
}

function success() {
        printf "\r\033[2K [ \033[00;32mOK\033[0m ] $1\n";
}

function warn() {
        printf "\r\033[2K [\033[00;36mWARN\033[0m] $1\n";
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
	mapfile usage <<-EOF
		usage: ${0} [OPTIONS] COMMAND [ARGS]

		Options:
		--help : Prints this help message and exit.
		--version : Print the ${0} version and exit.
		--dotfiles-src DIR : sets the directory to load .files from.
		--target DIR : set the directory to load the .files to.

		Commands:
	EOF

	for command in "${COMMANDS[@]}"; do
		cmds+="${command}:";
		cmds+=$("${command}_help" --one-line);
	done;

	mapfile additional <<-EOF
		For additional help type:
		${0} [COMMAND] --help
		EOF

	prnt=("${oneline[@]}" "${usage[@]}" "${cmds[@]}" "${additional[@]}");

	local IFS=$'\n';
	for line in "${prnt[@]}"; do
		notify $line
	done;

}

#COMMANDS+=('link');
#COMMANDS+=('delete');

#notify "Starting script."
#mapfile test <<-EOF
#	Yo yo!!!
#	\e[91mFurther testing\e[0m
#	Welcome to my new and awesome install script!!!
#EOF
#IFS=$'\n';
#for line in "${test[@]}"; do
#	notify $line;
#done;

main "${@}" || exit 1;

#for cmd in {notify,ask,success,warn,fail}; do
#        $cmd "Testing"
#done;
