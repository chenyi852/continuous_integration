#!/bin/bash
exename=$(basename $0)


source run.rc
source common.sh
#source compile_dpdk.sh

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
	update)
	cd $ci_dir/dpdk
	git pull
	;;
	run)
	log_file=$ci_dir/`get_log_name "compile_test"`
	./compile_dpdk.sh > $log_file 2>&1
	if [ $? == 0 ]; then
		echo "CI success!"
	else
		echo "CI fail!"
	fi
 
	;;
	clean)
	rm $ci_dir/*.log
	;; 
	add)
	cd $backup; 
	git add -u .; git commit -m "`date`"
        ;;
 
	*)
        ;;
esac
