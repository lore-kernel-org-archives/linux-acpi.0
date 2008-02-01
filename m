From: venkatesh.pallipadi@intel.com
Subject: [patch 1/4] ACPI: Fix acpi_safe_halt usages and interrupt enabling/disabling
Date: Thu, 31 Jan 2008 17:35:03 -0800
Message-ID: <20080201013629.115986000@intel.com>
References: <20080201013502.750627000@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43160 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201AbYBABgc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jan 2008 20:36:32 -0500
Content-Disposition: inline; filename=acpi_fix_safe_halt.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

acpi_safe_halt() needs interrupts to be disabled for atomic
need_resched check and safe halt. Otherwise we may miss an
interrupt and go into halt.

acpi_safe_halt() also does not enable interrupts on all return paths.

So the callers should handle enable and disable interrupts around it.

There were multiple places where this was not happening. Below is the fix.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.25-rc/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.25-rc.orig/drivers/acpi/processor_idle.c
+++ linux-2.6.25-rc/drivers/acpi/processor_idle.c
@@ -201,6 +201,10 @@ static inline u32 ticks_elapsed_in_us(u3
 		return PM_TIMER_TICKS_TO_US((0xFFFFFFFF - t1) + t2);
 }
 
+/*
+ * Callers should disable interrupts before the call and enable
+ * interrupts after return.
+ */
 static void acpi_safe_halt(void)
 {
 	current_thread_info()->status &= ~TS_POLLING;
@@ -393,6 +397,8 @@ static void acpi_processor_idle(void)
 			pm_idle_save();
 		else
 			acpi_safe_halt();
+
+		local_irq_enable();
 		return;
 	}
 
@@ -501,6 +507,7 @@ static void acpi_processor_idle(void)
 		 *       skew otherwise.
 		 */
 		sleep_ticks = 0xFFFFFFFF;
+		local_irq_enable();
 		break;
 
 	case ACPI_STATE_C2:
@@ -1378,11 +1385,13 @@ static int acpi_idle_enter_c1(struct cpu
 	if (unlikely(!pr))
 		return 0;
 
+	local_irq_disable();
 	if (pr->flags.bm_check)
 		acpi_idle_update_bm_rld(pr, cx);
 
 	acpi_safe_halt();
 
+	local_irq_enable();
 	cx->usage++;
 
 	return 0;
@@ -1490,7 +1499,9 @@ static int acpi_idle_enter_bm(struct cpu
 		if (dev->safe_state) {
 			return dev->safe_state->enter(dev, dev->safe_state);
 		} else {
+			local_irq_disable();
 			acpi_safe_halt();
+			local_irq_enable();
 			return 0;
 		}
 	}

-- 
