#!/bin/bash

source run.rc
source $dpdk_test_case_dir/dpdk_test_ctrl.sh
source init.sh


init_log_dir


## ./mctrl -c l2_fwd
while getopts "c:r:" arg
do
	case $arg in 
		c)

			compile_test_log=$log_dir/`get_log_name "$OPTARG"`
			compile_$OPTARG >> $compile_test_log 2>&1
		;;
		r)
			run_test_log=$log_dir/`get_log_name "$OPTARG"`
			run_$OPTARG 
		;;
		?)
			echo "unkown arg $OPTARG"
			exit 1
		;;
	esac
done
