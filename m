From: Len Brown <lenb@kernel.org>
Subject: [PATCH 093/112] ACPI: idle: Fix acpi_safe_halt usages and interrupt enabling/disabling
Date: Thu,  7 Feb 2008 04:34:55 -0500
Message-ID: <2e906655baf1c6f6fccd212fc9e6499dc6928b80.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:48010 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758407AbYBGJgx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:53 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "venkatesh.pallipadi@intel.com" <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: venkatesh.pallipadi@intel.com <venkatesh.pallipadi@intel.com>

acpi_safe_halt() needs interrupts to be disabled for atomic
need_resched check and safe halt. Otherwise we may miss an
interrupt and go into halt.

acpi_safe_halt() also does not enable interrupts on all return paths.

So the callers should handle enable and disable interrupts around it.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 199ea21..106a229 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -201,6 +201,10 @@ static inline u32 ticks_elapsed_in_us(u32 t1, u32 t2)
 		return PM_TIMER_TICKS_TO_US((0xFFFFFFFF - t1) + t2);
 }
 
+/*
+ * Callers should disable interrupts before the call and enable
+ * interrupts after return.
+ */
 static void acpi_safe_halt(void)
 {
 	current_thread_info()->status &= ~TS_POLLING;
@@ -413,6 +417,8 @@ static void acpi_processor_idle(void)
 			pm_idle_save();
 		else
 			acpi_safe_halt();
+
+		local_irq_enable();
 		return;
 	}
 
@@ -521,6 +527,7 @@ static void acpi_processor_idle(void)
 		 *       skew otherwise.
 		 */
 		sleep_ticks = 0xFFFFFFFF;
+		local_irq_enable();
 		break;
 
 	case ACPI_STATE_C2:
@@ -1403,11 +1410,13 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
 	if (unlikely(!pr))
 		return 0;
 
+	local_irq_disable();
 	if (pr->flags.bm_check)
 		acpi_idle_update_bm_rld(pr, cx);
 
 	acpi_safe_halt();
 
+	local_irq_enable();
 	cx->usage++;
 
 	return 0;
@@ -1517,7 +1526,9 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
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
1.5.4.23.gef5b9

