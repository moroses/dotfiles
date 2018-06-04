#!/bin/bash

function loadFolder() {
        folder=$1;
        cd $folder;
        [ -e 'pre.sh' ] && ./pre.sh;
        for lnk in $( ls *.symb ); do
                ln -s $lnk ~/.${lnk%%.symb};
        done;
        [ -e 'post.sh' ] && ./post.sh;
        cd ..;
}

for item in $(ls); do
        if [ -d $item ]; then
                loadFolder $item;
        fi
done

