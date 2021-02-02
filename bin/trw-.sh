#!/bin/bash

# Convert all whitespaces to "-"

echo "$*" | sed -e 's/[ ()]\+/-/g'
