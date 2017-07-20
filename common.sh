#!/bin/bash

### $1 prefix of log file
function get_log_name()
{	
	local  result=$1_`date +%F-%H-%M`.log
	
	echo $result
}

