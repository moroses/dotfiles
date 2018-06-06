#!/bin/bash

# TODO: Add diretory change

## Output functions modeled on @holman design

function norm() {
        printf "\r [ \033[00;34m..\033[0m ] $1\n";
}

function quest() {
        printf "\r [ \033[00;33m??\033[0m ] $1\n";
}

function err() {
        printf "\r\033[2K [\033[00;31mFAIL\033[0m] $1\n";
        echo '';
        exit;
}

function win() {
        printf "\r\033[2K [ \033[00;32mOK\033[0m ] $1\n";
}

# Every handle with a postfix of .symb will be linked to the home diretory with a ``.'' prefix.
# Every hanlde with a postfix of .config will be linked to the home diretory .config folder.


norm "Test";
quest "Yo?";
win "Yay!";
err "Damn :\\ ";

