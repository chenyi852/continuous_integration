#!/bin/bash

RTE_SDK=$dpdk_dir

dpdk_pool_dir=$dpdk_dir/examples/mempool_coloring

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

run_dpdk_pool()
{
	cd $dpdk_pool_dir
	./build/mempool_coloring -l 12-13 ||(echo "test fail!\n"; return 1)

}

compile_all()
{
        echo "------------------------\n"
        echo "\tcompiling begain\n"
        echo "------------------------\n"

        compile_dpdk

        compile_dpdk_pool
}

run_test()
{
        echo "------------------------\n"
        echo "\trun test case\n"
        echo "------------------------\n"

        run_dpdk_pool 

	return $?
}

compile_all
run_test
