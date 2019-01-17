#!/bin/bash
source common.sh
source run.rc
RTE_SDK=$dpdk_dir

dpdk_pool_dir=$dpdk_dir/examples/mempool_coloring
l2fwd_dir=l2fwd

#$1 - dpdk_dir
compile_dpdk()
{
	output_dir=$dpdk_dir/x86_64-native-linuxapp-gcc
	cd $dpdk_dir
	make config T=x86_64-native-linuxapp-gcc O=x86_64-native-linuxapp-gcc

	cd $output_dir 

	make -j8 EXTRA_CFLAGS="-std=gnu99 -Wno-error=unused-result"
}


compile_dpdk_pool()
{
	cd $dpdk_pool_dir
	RTE_SDK=$dpdk_dir make EXTRA_CFLAGS="-std=gnu99 \
-Wno-error=unused-but-set-variable -Wno-error=sign-compare"
}


compile_l2_fwd()
{
	cd $l2fwd_dir 
	RTE_SDK=$dpdk_dir make EXTRA_CFLAGS="-std=gnu99 \
-Wno-error=unused-but-set-variable -Wno-error=sign-compare"
}

run_dpdk_pool()
{
	cd $dpdk_pool_dir
	sudo ./build/mempool_coloring -l 0-3 ||(echo "test fail!\n"; return 1)

}

compile_all()
{
        echo "------------------------"
        echo "compiling"
        echo "------------------------"

	local compile_dpdk_log=`get_log_name "compile_dpdk"`
	
	local compile_dpdk_test_log=`get_log_name "compile_dpdk_test"`
        
	compile_dpdk > $ci_dir/$compile_dpdk_log 2>&1

        compile_dpdk_pool > $ci_dir/$compile_dpdk_test_log 2>&1
}

run_test()
{
        echo "------------------------"
        echo "run test case"
        echo "------------------------"
	local log_name=`get_log_name "test_dpdk_pool"`
	
        run_dpdk_pool > $ci_dir/$log_name 2>&1

	return $?
}


compile_all
