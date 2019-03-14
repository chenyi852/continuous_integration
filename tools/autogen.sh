#!/bin/bash

TARGET_SH=test.sh

auto_gen(){
	cat >$TARGET_SH <<EOF
	#!/bin/bash

	ls
EOF
chmod +x $TARGET_SH 
}

auto_gen
