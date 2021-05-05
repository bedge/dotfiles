#!/bin/bash

# For use with screencaprn to rename mac Screenshots

[ "${DEBUG}" ] && set -x
p="$*"
PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
d=$(dirname "$p")
f="$(basename "$p")"
echo "file=$f"
t1="$(echo "$f" | sed -e "s/\(Screen Shot \)//g")"
t2="$(echo "$t1" | sed -e "s/\( at \)/ /g")"
t3="$(echo "$t2" | sed -e "s/\(.png\)//g")"
t4="$(echo "$t3" | sed -e "s/\( AM\\)//g")"
stamp="$(echo $t4 | tr - / | tr . :)"
echo "stamp=$stamp"
new=$(echo "$stamp" |  date "+%Y-%M-%d_%H.%M.%S" -f -)
if [ "$new" ] ; then
    new=$(date "+%Y-%M-%d_%H.%M.%S" -f <(echo $stamp))
    mv "$d/$f" "$d/ss-$new.png"
fi
