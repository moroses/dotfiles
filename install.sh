#!/bin/bash

# TODO: Add diretory change

## Output functions modeled on @holman design

function notify() {
        printf "\r [ \033[00;34m..\033[0m ] $1\n";
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
# Every handle with a postfix of .symb will be linked to the home diretory with a ``.'' prefix.
# Every hanlde with a postfix of .config will be linked to the home diretory .config folder.

for cmd in {notify,ask,success,warn,fail}; do
        $cmd 'Yo';
done;
