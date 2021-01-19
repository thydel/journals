#!/usr/bin/env bash

grep -B2 '"github.com.* repo"' ${1:-$(ls *.md | tail -1)} | grep https | sed -e 's/h/- "h/' -e 's/$/"/'
