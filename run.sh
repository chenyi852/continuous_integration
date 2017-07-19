#!/bin/bash
exename=$(basename $0)
prj_dir=~/workspace/selfsrc/continuous_integration
backup=$prj_dir/
echo $exename
case $1 in
    copy)
        ;;
    clone)
        ;;
    add)
	cd $backup; 
	git add -u .; git commit -m "`date`"
        ;;
 
    *)
        ;;
esac
