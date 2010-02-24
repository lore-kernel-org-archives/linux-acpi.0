From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2.6.30-32.stable] ACPI: Be in TS_POLLING state during mwait
 based C-state entry
Date: Tue, 23 Feb 2010 22:35:10 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002232229320.4087@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:24821 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549Ab0BXDf2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Feb 2010 22:35:28 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KYB0045QTYN6JX0@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 23 Feb 2010 21:35:17 -0600 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com>

upstream d306ebc28649b89877a22158fe0076f06cc46f60

ACPI deep C-state entry had a long standing bug/missing feature, wherein we were sending
resched IPIs when an idle CPU is in mwait based deep C-state. Only mwait based C1 was using
the write to the monitored address to wake up mwait'ing CPU.

This patch changes the code to retain TS_POLLING bit if we are entering an mwait based
deep C-state.

The patch has been verified to reduce the number of resched IPIs in general and also
improves the performance/power on workloads with low system utilization (i.e., when mwait based
deep C-states are being used).

Fixes "netperf ~50% regression with 2.6.33-rc1, bisect to 1b9508f"
http://marc.info/?l=linux-kernel&m=126441481427331&w=4

Reported-by: Lin Ming <ming.m.lin@intel.com>
Tested-by: Alex Shi <alex.shi@intel.com>
Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index e88e8ae..cc978a8 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -880,12 +880,14 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 		return(acpi_idle_enter_c1(dev, state));
 
 	local_irq_disable();
-	current_thread_info()->status &= ~TS_POLLING;
-	/*
-	 * TS_POLLING-cleared state must be visible before we test
-	 * NEED_RESCHED:
-	 */
-	smp_mb();
+	if (cx->entry_method != ACPI_CSTATE_FFH) {
+		current_thread_info()->status &= ~TS_POLLING;
+		/*
+		 * TS_POLLING-cleared state must be visible before we test
+		 * NEED_RESCHED:
+		 */
+		smp_mb();
+	}
 
 	if (unlikely(need_resched())) {
 		current_thread_info()->status |= TS_POLLING;
@@ -965,12 +967,14 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	}
 
 	local_irq_disable();
-	current_thread_info()->status &= ~TS_POLLING;
-	/*
-	 * TS_POLLING-cleared state must be visible before we test
-	 * NEED_RESCHED:
-	 */
-	smp_mb();
+	if (cx->entry_method != ACPI_CSTATE_FFH) {
+		current_thread_info()->status &= ~TS_POLLING;
+		/*
+		 * TS_POLLING-cleared state must be visible before we test
+		 * NEED_RESCHED:
+		 */
+		smp_mb();
+	}
 
 	if (unlikely(need_resched())) {
 		current_thread_info()->status |= TS_POLLING;
-- 
1.7.0.83.g241b9

