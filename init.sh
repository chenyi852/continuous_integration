#!/bin/bash

source run.rc

function init_log_dir()
{
	if [ ! -d $log_dir ] ; then
		mkdir -p $log_dir
	fi
}
