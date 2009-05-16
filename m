From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/19] ACPI: idle: fix init-time TSC check regression
Date: Sat, 16 May 2009 02:02:15 -0400
Message-ID: <520daf7217bc1806c02eb4cfa7805447a3da2f66.1242453625.git.len.brown@intel.com>
References: <1242453736-20763-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:57099 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbZEPGC1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 May 2009 02:02:27 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJQ008JX3G3CQ7S@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 May 2009 01:02:27 -0500 (CDT)
In-reply-to: <1242453736-20763-1-git-send-email-lenb@kernel.org>
In-reply-to: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

A previous 2.6.30 patch, a71e4917dc0ebbcb5a0ecb7ca3486643c1c9a6e2,
(ACPI: idle: mark_tsc_unstable() at init-time, not run-time)
erroneously disabled the TSC on systems that did not actually
have valid deep C-states.

Move the check after the deep-C-states are validated,
via new helper, tsc_check_state(), hich replaces tsc_halts_in_c().

Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Frans Pop <elendil@planet.nl>
---
 drivers/acpi/processor_idle.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f7ca8c5..e39a40a 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -216,7 +216,7 @@ int acpi_processor_resume(struct acpi_device * device)
 }
 
 #if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86)
-static int tsc_halts_in_c(int state)
+static void tsc_check_state(int state)
 {
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
@@ -226,13 +226,17 @@ static int tsc_halts_in_c(int state)
 		 * C/P/S0/S1 states when this bit is set.
 		 */
 		if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
-			return 0;
+			return;
 
 		/*FALL THROUGH*/
 	default:
-		return state > ACPI_STATE_C1;
+		/* TSC could halt in idle, so notify users */
+		if (state > ACPI_STATE_C1)
+			mark_tsc_unstable("TSC halts in idle");
 	}
 }
+#else
+static void tsc_check_state(int state) { return; }
 #endif
 
 static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
@@ -581,11 +585,6 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
 		struct acpi_processor_cx *cx = &pr->power.states[i];
 
-#if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86)
-		/* TSC could halt in idle, so notify users */
-		if (tsc_halts_in_c(cx->type))
-			mark_tsc_unstable("TSC halts in idle");;
-#endif
 		switch (cx->type) {
 		case ACPI_STATE_C1:
 			cx->valid = 1;
@@ -603,6 +602,8 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 				acpi_timer_check_state(i, pr, cx);
 			break;
 		}
+		if (cx->valid)
+			tsc_check_state(cx->type);
 
 		if (cx->valid)
 			working++;
-- 
1.6.0.6

