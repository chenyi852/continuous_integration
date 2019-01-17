#!/bin/bash

DEBUGFS_DIR=/sys/kernel/debug
FTRACE_DIR=$DEBUGFS_DIR/tracing/
SCHED_EVENT_DIR=$FTRACE_DIR/events/sched
## log path
LOG_PATH=/tmp/
## per cpu buffer size
BUF_SIZE=96000

source common.sh

function debugfs_mount()
{

	if [ ! -d $DEBUGFS_DIR ] ; then
		mount -t debugfs nodev /sys/kernel/debug/
	fi
}

function ftrace_clear()
{
	echo nop > $FTRACE_DIR/current_tracer
}

function ftrace_tracing_off()
{
	echo 0 > $FTRACE_DIR/tracing_on
}

function ftrace_tracing_on()
{
	echo 1 > $FTRACE_DIR/tracing_on
}

function ftrace_trace_clr()
{
	echo 0 > $FTRACE_DIR/trace
}

function ftrace_dump()
{
	cat $FTRACE_DIR/trace > $1
}

function ftrace_show()
{
	cat $FTRACE_DIR/trace
}

# $1 buffer size
function ftrace_set_buf_size()
{
	echo $1 > $FTRACE_DIR/buffer_size_kb
}

function ftrace_sched_enable()
{
	echo 1 > $SCHED_EVENT_DIR/sched_switch/enable
	echo 1 > $SCHED_EVENT_DIR/sched_wakeup/enable
	echo 1 > $SCHED_EVENT_DIR/sched_wakeup_new/enable
}

function ftrace_sched_disable()
{
	echo 0 > $SCHED_EVENT_DIR/sched_switch/enable
	echo 0 > $SCHED_EVENT_DIR/sched_wakeup/enable
	echo 0 > $SCHED_EVENT_DIR/sched_wakeup_new/enable
}



function ftrace_init()
{
	debugfs_mount

	ftrace_clear

	ftrace_tracing_off

	ftrace_trace_clr

	ftrace_set_buf_size $BUF_SIZE

	ftrace_sched_enable

	ftrace_tracing_on
}

function ftrace_exit()
{
	ftrace_tracing_off
	
	ftrace_sched_disable
}

# ftrace_init ./ftrace.sh -i
# ftrace_exit ./ftrace.sh -e
# ftrace_show ./ftrace.sh -s
# frrace_dump ./ftrace.sh -d output_path
while getopts "deis" arg
do
	case $arg in
		## dump tracing data
		d)
			ftrace_dump $LOG_PATH/`get_log_name "ftrace"`
		;;
		i)
			ftrace_init
		;;
		e)
			ftrace_exit
		;;
		s)
			ftrace_show
		;;
		?)
			echo "unknown arg $arg"
			exit 1
		;;
	esac
done

