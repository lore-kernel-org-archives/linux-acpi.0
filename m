From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] tools/power/acpi: Add multi-threading test facility
Date: Thu,  7 Sep 2017 14:59:54 +0800
Message-ID: <1504767594-2390-1-git-send-email-lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24280 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753996AbdIGG77 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Sep 2017 02:59:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This script extends testability of the Linux ACPI subsystem.

It is reported by QA teams that using the known validation tools, there are
still modules in the ACPI subsystem have low test coverage.

We confirmed that the coverage can be increased by doing more following
tests:
1. dynamic module load/unload, and
2. sysfs/proc_fs file accesses, and
3. etc.
Actually, performing such stuffs once or single-threaded won't prove
quality status to us, multi-threading testability is needed for these
validations.

This patch adds a test facility so that validators can use it to
launch multi-threading ACPI transactions to test Linux ACPI subsystem
viability under a stressed multi-threading environment.

The following commands demonstrate possible multi-threading tests:
1. Test dynamic load of button driver:
  sudo tools/power/acpi/acpimt.sh \
	-t 10 \
	-d tools/power/acpi/acpidbg \
	-e _SB.PCI0.SBRG.LID0._LID \
	-f /proc/acpi/button/lid/LID0/state \
	-m button
2. Test method customization:
  sudo tools/power/acpi/acpimt.sh \
	-t 10 \
	-d tools/power/acpi/acpidbg \
	-e _SB.PCI0.SBRG.LID0._LID \
	-c oem1.aml
3. Stress ACPI EC loads:
  sudo tools/power/acpi/acpimt.sh \
	-t 10 \
	-d tools/power/acpi/acpidbg \
	-f /proc/acpi/button/lid/LID0/state \
	-f /sys/class/power_supply/AC0/online \
	-f /sys/class/power_supply/BAT0/status

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 tools/power/acpi/acpimt.sh | 337 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 337 insertions(+)
 create mode 100755 tools/power/acpi/acpimt.sh

diff --git a/tools/power/acpi/acpimt.sh b/tools/power/acpi/acpimt.sh
new file mode 100755
index 0000000..3491dd7
--- /dev/null
+++ b/tools/power/acpi/acpimt.sh
@@ -0,0 +1,337 @@
+#!/bin/bash
+#
+# Copyright (C) 2017 Intel Corporation
+# Author: 2017 Lv Zheng <lv.zheng@intel.com>
+#
+# NAME:
+#         acpimt.sh - launch multi-threads running Linux kernel ACPI
+#                     transactions
+#
+# SYNOPSIS:
+#         acpimt.sh [-c amlfile]
+#                   [-e acpiname]
+#                   [-f acpifile]
+#                   [-m kernel_module]
+#                   [-d acpidbg] [-t seconds]
+#
+# DESCRIPTION:
+#         This program is used as a test facility validating multi-thread
+#         support in Linux ACPI subsystem. It can launch ACPI transactions
+#         as test cases using child processes and executes them in parallel
+#         endlessly. Test processes can be terminated by Ctrl-C.
+#
+#         The launchable tests can be:
+#          -c: Use /sys/kernel/debug/acpi/custom_method to customize
+#              control methods (CONFIG_ACPI_CUSTOM_METHOD) repeatedly.
+#          -e: Use acpidbg to evaluate a named object w/o arguments
+#              (CONFIG_ACPI_DEBUGGER_USER) repeatedly.
+#          -f: Use cat to read a sysfs/procfs file repeatedly.
+#          -m: Use modprobe to load/unload a module repeatedly.
+#
+#         Options:
+#          -d: Full path to acpidbg (in case it cannot be reached via
+#              %PATH%.
+#          -t: Seconds to sleep between test operations.
+
+########################################################################
+# Global Settings
+########################################################################
+SLEEPSEC=10
+TEMPFILE=`mktemp`
+ACPIDBG=acpidbg
+ACPINAMES=
+ACPIFILES=
+AMLFILES=
+KERNMODS=
+
+########################################################################
+# Usages
+########################################################################
+usage() {
+	echo "Usage: `basename $0` [-d acpidbg] [-t second]"
+	echo "                     [-c amlfile]"
+	echo "                     [-e acpiname]"
+	echo "                     [-f acpifile]"
+	echo "                     [-m kernel_module]"
+	echo ""
+	echo "This program is used as a test facility validating multi-thread"
+	echo "support in Linux ACPI subsystem. It can launch ACPI transactions"
+	echo "as test cases using child processes and executes them in parallel"
+	echo "endlessly. Test processes can be terminated by Ctrl-C."
+	echo ""
+	echo "Test cases are:"
+	echo "-c: Use /sys/kernel/debug/acpi/custom_method to customize"
+	echo "    control methods (CONFIG_ACPI_CUSTOM_METHOD) repeatedly."
+	echo "-e: Use acpidbg to evaluate a named object w/o arguments"
+	echo "    (CONFIG_ACPI_DEBUGGER_USER) repeatedly."
+	echo "-f: Use cat to read a sysfs/procfs file repeatedly."
+	echo "-m: Use modprobe to load/unload a module repeatedly."
+	echo ""
+	echo "Options are:"
+	echo "-d: Full path to acpidbg (in case it cannot be reached via"
+	echo "    %PATH%."
+	echo "-t: Seconds to sleep between test operations."
+}
+
+fatal_usage() {
+	usage
+	exit 1
+}
+
+########################################################################
+# Loadable Module
+########################################################################
+find_module() {
+	curr_modules=`lsmod | cut -d " " -f1`
+
+	for m in $curr_modules; do
+		if [ "x$m" = "x$1" ]; then
+			return 0
+		fi
+	done
+	return 1
+}
+
+remove_module() {
+	find_module $1
+	if [ $? -eq 0 ]; then
+		echo "Removing $1 ..."
+		modprobe -r $1
+		if [ $? -ne 0 ]; then
+			echo "Failed to rmmod $1."
+			return 1
+		fi
+	fi
+	return 0
+}
+
+insert_module() {
+	find_module $1
+	if [ $? -ne 0 ]; then
+		echo "Inserting $1 ..."
+		modprobe $1
+		if [ $? -ne 0 ]; then
+			echo "Failed to insmod $1."
+			return 1
+		fi
+	fi
+	return 0
+}
+
+########################################################################
+# Endless Test Control
+########################################################################
+endless_term1() {
+	echo "Terminating parent process..."
+	echo "stop" > $TEMPFILE
+}
+
+endless_term2() {
+	echo "stopped" > $TEMPFILE
+}
+
+endless_stop1() {
+	if [ ! -f $TEMPFILE ]; then
+		return 0
+	fi
+	cat $TEMPFILE | grep "stop" > /dev/null
+}
+
+endless_stop2() {
+	if [ ! -f $TEMPFILE ]; then
+		return 0
+	fi
+	cat $TEMPFILE | grep "stopped" > /dev/null
+}
+
+endless_exit() {
+	wait
+	remove_module acpi_dbg
+	rm -f $TEMPFILE
+}
+
+endless_init() {
+	echo > $TEMPFILE
+	if [ ! -d /sys/kernel/debug/acpi ]; then
+		mount -t debugfs none /sys/kernel/debug
+	fi
+	if [ ! -x $ACPIDBG ]; then
+		echo "$ACPIDBG is not executable."
+		return 1
+	fi
+	if [ ! -f /sys/kernel/debug/acpi/custom_method ]; then
+		echo "ACPI_CUSTOM_METHOD is not configured."
+		return 1
+	fi
+	insert_module acpi_dbg || return 1
+	trap endless_term1 2 3 15
+}
+
+########################################################################
+# Test Facility - Namespace Object Evaluation
+########################################################################
+acpieval() {
+	while :
+	do
+		endless_stop1
+		if [ $? -eq 0 ]; then
+			echo "Terminating child process - acpieval $1..."
+			break
+		fi
+		echo "-----------------------------------"
+		echo "evaluate $1"
+		$ACPIDBG -b "ex $1"
+		echo "-----------------------------------"
+		sleep $SLEEPSEC
+	done
+	endless_term2
+}
+
+########################################################################
+# Test Facility - Method Customization
+########################################################################
+acpicust() {
+	while :
+	do
+		endless_stop1
+		if [ $? -eq 0 ]; then
+			echo "Terminating child process - acpicust $1..."
+			break
+		fi
+		echo "==================================="
+		echo "customize $1"
+		cat $1 > /sys/kernel/debug/acpi/custom_method
+		echo "==================================="
+		sleep $SLEEPSEC
+	done
+	endless_term2
+}
+
+########################################################################
+# Test Facility - Kernel Exported Files
+########################################################################
+acpicat() {
+	while :
+	do
+		endless_stop1
+		if [ $? -eq 0 ]; then
+			echo "Terminating child process - acpicat $1..."
+			break
+		fi
+		echo "+++++++++++++++++++++++++++++++++++"
+		echo "concatenate $1"
+		cat $1
+		echo "+++++++++++++++++++++++++++++++++++"
+		sleep $SLEEPSEC
+	done
+	endless_term2
+}
+
+########################################################################
+# Test Facility - Dynamic Module Load/Unload
+########################################################################
+acpimod() {
+	res=0
+	while :
+	do
+		endless_stop1
+		if [ $? -eq 0 ]; then
+			echo "Terminating child process - acpimod $1..."
+			break
+		fi
+		find_module $1
+		if [ $? -eq 0 ]; then
+			echo "***********************************"
+			echo "remove $1"
+	 		remove_module $1
+			res=$?
+			echo "***********************************"
+			if [ $res -ne 0 ]; then
+				echo "Terminated child process - acpimod $1 (rmmod)."
+				exit
+			fi
+		else
+			echo "***********************************"
+			echo "insert $1"
+			insert_module $1
+			res=$?
+			echo "***********************************"
+			if [ $res -ne 0 ]; then
+				echo "Terminated child process - acpimod $1 (insmod)."
+				exit
+			fi
+		fi
+		sleep $SLEEPSEC
+	done
+	endless_term2
+}
+
+########################################################################
+# Script Entry Point
+########################################################################
+while getopts "c:d:e:f:hm:t:" opt
+do
+	case $opt in
+	c) AMLFILES="$AMLFILES '$OPTARG'";;
+	e) ACPINAMES="$ACPINAMES $OPTARG";;
+	d) ACPIDBG=$OPTARG;;
+	f) ACPIFILES="$ACPIFILES '$OPTARG'";;
+	m) KERNMODS="$KERNMODS '$OPTARG'";;
+	t) SLEEPSEC=$OPTARG;;
+	h) usage;;
+	?) fatal_usage;;
+	esac
+done
+shift $(($OPTIND - 1))
+
+# Startup
+endless_init || exit 2
+
+# Perform sanity checks
+for amlfile in $AMLFILES; do
+	if [ ! -f $amlfile ]; then
+		echo "$amlfile is missing."
+		exit 1
+	fi
+done
+for acpifile in $ACPIFILES; do
+	if [ ! -f $acpifile ]; then
+		echo "$acpifile is missing."
+		exit 1
+	fi
+done
+
+# Lauch test cases
+for amlfile in $AMLFILES; do
+	acpicust $amlfile &
+done
+for acpiname in $ACPINAMES; do
+	acpieval $acpiname &
+done
+for acpifile in $ACPIFILES; do
+	acpicat $acpifile &
+done
+for kmod in $KERNMODS; do
+	acpimod $kmod &
+done
+
+# Wait children
+while :
+do
+	endless_stop2
+	if [ $? -eq 0 ]; then
+		echo "Terminated parent process."
+		break
+	fi
+	endless_stop1
+	if [ $? -eq 0 ]; then
+		sleep $SLEEPSEC
+		echo "Force terminating parent process..."
+		endless_term2
+	else
+		sleep $SLEEPSEC
+	fi
+done
+
+# Cleanup
+endless_exit
-- 
2.7.4

