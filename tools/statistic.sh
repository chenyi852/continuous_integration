#!/bin/bash
#$1 author

FILE_NAME=

#git log --author="$1" --pretty=tformat: --numstat | \
#awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s, \
#removed lines: %s, total lines: %s\n", add, subs, loc }'

grc[0]="DmitryVoytik"
grc[1]="Eduard Shishkin"
grc[2]="Shiqing Fan"
grc[3]="Antonios Motakis"
grc[4]="Veaceslav Falico"
grc[5]="Pradeep Jagadeesh"


for var in "${grc[@]}";
do
	echo "static $var's source code"

	git log --author="$var" --pretty=tformat: --numstat |\
awk '{ add += $1; subs += $2; loc += $1 - $2 } \
END { printf "added lines: %s, removed lines: %s, \
total lines: %s\n", add, subs, loc }'

done

