#!/bin/bash
exename=$(basename $0)
repo_dir=~/workspace/selfsrc/continuous_integration
backup=$prj_dir/
ci_dir=~/ci
export dpdk_dir=$ci_dir/dpdk

source compile_dpdk.sh

##check if the ci dir is exit.
chk_ci_dir()
{
	if [ ! -d $ci_dir ];  then
		mkdir -p $ci_dir
	fi
}

compile()
{
	echo "------------------------\n"
	echo "\tcompiling begain\n"
	echo "------------------------\n"
	
	compile_dpdk

	compile_dpdk_pool
}

run_test()
{
	time=`date +%Y%m%d`
	log_file=test_case_$time.log
	echo "------------------------\n"
	echo "\trun test case\n"
	echo "------------------------\n"

	run_dpdk_pool > $log_file 2>&1
	if [ $? != 0 ]; then
		tail -n 10 $log_file 
	fi

}


chk_ci_dir

echo $exename
case $1 in
    copy)
        ;;
    clone)
	cd $ci_dir
	git clone git@git.virtualopensystems.com:libos-uvm/dpdk.git 
	cd dpdk
	git checkout origin/slicing_dev -b slicing_dev
	
	;;
    run)
	compile
	run_test
	
	;;
    add)
	cd $backup; 
	git add -u .; git commit -m "`date`"
        ;;
 
    *)
        ;;
esac
