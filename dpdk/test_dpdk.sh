#!/bin/bash
source common.sh
source run.rc
RTE_SDK=$dpdk_dir

dpdk_pool_dir=$dpdk_dir/examples/mempool_coloring

run_dpdk_pool()
{
	cd $dpdk_pool_dir
	sudo ./build/mempool_coloring -l 0-3 ||(echo "test fail!\n"; return 1)

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

run_test
