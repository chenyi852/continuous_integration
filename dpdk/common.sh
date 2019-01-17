#!/bin/bash

#
# author : chen yi <johnny.chenyi@huawei.com>
# 2018-7-12
#

# define CI_DIR, CONFIG_DIR, LOG_DIR
export_ci_dir() {
	local log_dir_name=log_`date +%F-%H`
	local bin_dir_name=bin_`date +%F-%H`
	CI_DIR=$(realpath .)


	export CI_DIR
	export CONFIG_DIR=$CI_DIR/configs
	export LOG_DIR=$CI_SPACE/log/$log_dir_name
	export BIN_DIR=$CI_SPACE/bin/$bin_dir_name
}

export_source_dir() {
    SOURCE_DIR=$(realpath ..)
    export SOURCE_DIR

	export HMK_BIN_DIR=$SOURCE_DIR/images
}

top_dir() {
    local self test_dir

    self=$(realpath "$0")
    test_dir=${self%/*}
    if [[ -d "$test_dir" ]] ; then
	cd "$test_dir"
    fi
}

### $1 prefix of log file
get_log_name(){
    local  result=$1_`date +%F-%H-%M`.log

	echo $result
}

mk_dir() {
	if [ ! -d "$1" ]; then
		mkdir -p $1
	fi
}
