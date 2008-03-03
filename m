From: youquan_song@linux.intel.com
Subject: [PATCH 2.6.25-rc3] processor_idle: fixed CPU 'active state' stably
          remain C0 by cat /proc
Date: Mon, 3 Mar 2008 00:53:02 -0800 (PST)
Message-ID: <1467.172.16.116.56.1204534382.squirrel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:23994 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753255AbYCCIyq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Mar 2008 03:54:46 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: venkatesh.pallipadi@intel.com, youquan.song@intel.com

If cpuidle module is enabled by CONFIG_CPU_IDEL=y,user can check CPU idle
information by both /proc and /sys. The /proc information keep consistent
with the old kernel without cpuidle modules except the 'active state'.
Because If we enable cpuidle, kernel will not record CPU active state, so
if we run 'cat /proc/acpi/processor/CPU*/power', we will get the 'active
state' stably remain C0. This is different from user experience which when
run 'cat /proc', the "active state" change as the cpu real work.

This patch will fix the bug by record the specail C state when CPU is
going to enter to C state. we run 'cat /proc/acpi/processor/CPU*/power'
and we will watch the CPU 'active state' change keeping the same with the
cpu real work.

Signed-off-by: Youquan Song <youquan.song@intel.com>
---
 processor_idle.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff -urNa linux-2.6.25-rc3-orginal/drivers/acpi/processor_idle.c
linux-2.6.25-rc3/drivers/acpi/processor_idle.c
--- linux-2.6.25-rc3-orginal/drivers/acpi/processor_idle.c	2008-02-29
07:58:51.000000000 -0500
+++ linux-2.6.25-rc3/drivers/acpi/processor_idle.c	2008-02-29
11:56:39.000000000 -0500
@@ -1425,6 +1425,8 @@
 		return 0;

 	local_irq_disable();
+	/* Record the active C state */
+	pr->power.state = cx;

 	/* Do not access any ACPI IO ports in suspend path */
 	if (acpi_idle_suspend) {
@@ -1468,6 +1470,8 @@
 		return(acpi_idle_enter_c1(dev, state));

 	local_irq_disable();
+	/* Record the active C state */
+	pr->power.state = cx;
 	current_thread_info()->status &= ~TS_POLLING;
 	/*
 	 * TS_POLLING-cleared state must be visible before we test
@@ -1558,6 +1562,8 @@
 	}

 	local_irq_disable();
+	/* Record the active C state */
+	pr->power.state = cx;
 	current_thread_info()->status &= ~TS_POLLING;
 	/*
 	 * TS_POLLING-cleared state must be visible before we test


