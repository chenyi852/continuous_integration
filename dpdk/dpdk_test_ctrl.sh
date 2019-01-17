#!/bin/bash

source common.sh
source run.rc

l2fwd_dir=$dpdk_dir/examples/l2fwd

function compile_l2_fwd()
{
	cd $l2fwd_dir
	RTE_SDK=$dpdk_dir make EXTRA_CFLAGS="-std=gnu99 \
-Wno-error=unused-but-set-variable -Wno-error=sign-compare"
}


function run_l2_fwd()
{
        cd $l2fwd_dir
        sudo ./build/l2fwd -l 0-3 -m 256 -- -q 2 -p ffff ||(echo "test fail!\n"; return 1)

}

