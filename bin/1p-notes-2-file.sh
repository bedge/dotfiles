#!/bin/bash

# Read vault $1 searching for $2 matching items from 1p 
# and save details.notesPlain into $4/overview.title files

vault_match=$1
match=$2
dest=$3

[ "${DEBUG}" ] && set -x

vault=$(op list vaults | jq '.[].name' \
    | grep -i "${vault_match}")

# shellcheck disable=SC2046
IFS=$'\n' read -r matches <<< $(op list items --vault  "${vault}" \
    | jq '.[].overview.title' | grep $(echo ${match//\"/}))

printf "matches=%s\n" "${matches[*]}"

for item in ${matches[*]} ; do
    item=$()
    # echo XX${item}XX
    # continue
    # shellcheck disable=SC2001
    filename="$dest/$(echo "${item}" \
        | sed -e 's/[ ()]\+\"/-/g')"
    op get item "${item//\"/}" \
        | jq '.details.notesPlain' \
        > "${filename}"
done