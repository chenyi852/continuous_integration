#!/bin/bash

DEBUGFS_DIR=/sys/kernel/debug
FTRACE_DIR=$DEBUGFS_DIR/tracing/
SCHED_EVENT_DIR=$FTRACE_DIR/events/sched

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

	ftrace_set_buf_size 128

	ftrace_sched_enable

	ftrace_tracing_on
}

function ftrace_exit()
{
	ftrace_tracing_off
	
	ftrace_sched_disable
}

# ./ftrace.sh -i ftrace_init
# ./ftrace.sh -e ftrace_exit
# ./ftrace.sh -s ftrace_show
while getopts "ies" arg
do
	case $arg in
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

