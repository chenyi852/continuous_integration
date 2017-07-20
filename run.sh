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
	time=`date +%Y%m%d`
	log_file=~/ci/compile_test_$time.log
	./compile_dpdk.sh > $log_file 2>&1	
	;;
    add)
	cd $backup; 
	git add -u .; git commit -m "`date`"
        ;;
 
    *)
        ;;
esac
