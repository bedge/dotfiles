#!/bin/bash
[ "${DEBUG}" ] && set -x
grep Domain -v $1 | cut -d, -f2 | xargs -I {} bash -c "echo -n '{}=' &&  dig +short  {} && echo"
