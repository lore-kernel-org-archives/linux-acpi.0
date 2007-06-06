From: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Subject: [PATCH 3/8] cpuidle: reenable /proc/acpi/ power interface for the time being
Date: Wed, 6 Jun 2007 13:51:48 -0700
Message-ID: <20070606205148.GC23906@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30896 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934871AbXFFUz3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Jun 2007 16:55:29 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Adam Belay <abelay@novell.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Shaohua Li <shaohua.li@intel.com>, linux-acpi@vger.kernel.org



Keep /proc/acpi/processor/CPU*/power around for a while as powertop depends
on it. It will be marked deprecated and removed in future. powertop can use
cpuidle interfaces instead.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.22-rc-mm/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.22-rc-mm.orig/drivers/acpi/processor_idle.c	2007-06-01 16:17:40.000000000 -0700
+++ linux-2.6.22-rc-mm/drivers/acpi/processor_idle.c	2007-06-01 17:20:57.000000000 -0700
@@ -792,7 +792,7 @@
  * @t1: the start time
  * @t2: the end time
  */
-static inline u32 ticks_elapsed(u32 t1, u32 t2)
+static inline u32 ticks_elapsed_in_us(u32 t1, u32 t2)
 {
 	if (t2 >= t1)
 		return PM_TIMER_TICKS_TO_US(t2 - t1);
@@ -802,6 +802,16 @@
 		return PM_TIMER_TICKS_TO_US((0xFFFFFFFF - t1) + t2);
 }
 
+static inline u32 ticks_elapsed(u32 t1, u32 t2)
+{
+	if (t2 >= t1)
+		return (t2 - t1);
+	else if (!(acpi_gbl_FADT.flags & ACPI_FADT_32BIT_TIMER))
+		return (((0x00FFFFFF - t1) + t2) & 0x00FFFFFF);
+	else
+		return ((0xFFFFFFFF - t1) + t2);
+}
+
 /**
  * acpi_idle_update_bm_rld - updates the BM_RLD bit depending on target state
  * @pr: the processor
@@ -925,7 +935,8 @@
 	cx->usage++;
 
 	acpi_state_timer_broadcast(pr, cx, 0);
-	return ticks_elapsed(t1, t2);
+	cx->time += ticks_elapsed(t1, t2);
+	return ticks_elapsed_in_us(t1, t2);
 }
 
 static int c3_cpu_count;
@@ -1009,7 +1020,8 @@
 	cx->usage++;
 
 	acpi_state_timer_broadcast(pr, cx, 0);
-	return ticks_elapsed(t1, t2);
+	cx->time += ticks_elapsed(t1, t2);
+	return ticks_elapsed_in_us(t1, t2);
 }
 
 /**
