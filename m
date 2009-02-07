From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/30] ACPI: remove BM_RLD access from idle entry path
Date: Sat, 07 Feb 2009 01:41:24 -0500
Message-ID: <31878dd86b7df9a147f5e6cc6e07092b4308782b.1233988825.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:12159 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715AbZBGGl5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:41:57 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-2.01 (built Jun 13 2007; 32bit))
 with ESMTPA id <0KEO00JGJNXJ6Y92@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:41:44 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

It is true that BM_RLD needs to be set to enable
bus master activity to wake an older chipset (eg PIIX4) from C3.

This is contrary to the erroneous wording the ACPI 2.0, 3.0
specifications that suggests that BM_RLD is an indicator
rather than a control bit.

ACPI 1.0's correct wording should be restored in ACPI 4.0:
http://www.acpica.org/bugzilla/show_bug.cgi?id=689

But the kernel should not have to clear BM_RLD
when entering a non C3-type state just to set
it again when entering a C3-type C-state.

We should be able to set BM_RLD at boot time
and leave it alone -- removing the overhead of
accessing this IO register from the idle entry path.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |   57 ++++++----------------------------------
 1 files changed, 9 insertions(+), 48 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index ae00108..7eab733 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -241,26 +241,6 @@ acpi_processor_power_activate(struct acpi_processor *pr,
 		old->promotion.count = 0;
 	new->demotion.count = 0;
 
-	/* Cleanup from old state. */
-	if (old) {
-		switch (old->type) {
-		case ACPI_STATE_C3:
-			/* Disable bus master reload */
-			if (new->type != ACPI_STATE_C3 && pr->flags.bm_check)
-				acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0);
-			break;
-		}
-	}
-
-	/* Prepare to use new state. */
-	switch (new->type) {
-	case ACPI_STATE_C3:
-		/* Enable bus master reload */
-		if (old->type != ACPI_STATE_C3 && pr->flags.bm_check)
-			acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
-		break;
-	}
-
 	pr->power.state = new;
 
 	return;
@@ -1121,7 +1101,6 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 					  " for C3 to be enabled on SMP systems\n"));
 			return;
 		}
-		acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0);
 	}
 
 	/*
@@ -1137,6 +1116,15 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 #else
 	cx->latency_ticks = cx->latency;
 #endif
+	/*
+	 * On older chipsets, BM_RLD needs to be set
+	 * in order for Bus Master activity to wake the
+	 * system from C3.  Newer chipsets handle DMA
+	 * during C3 automatically and BM_RLD is a NOP.
+	 * In either case, the proper way to
+	 * handle BM_RLD is to set it and leave it set.
+	 */
+	acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
 
 	return;
 }
@@ -1400,25 +1388,6 @@ static int acpi_idle_bm_check(void)
 }
 
 /**
- * acpi_idle_update_bm_rld - updates the BM_RLD bit depending on target state
- * @pr: the processor
- * @target: the new target state
- */
-static inline void acpi_idle_update_bm_rld(struct acpi_processor *pr,
-					   struct acpi_processor_cx *target)
-{
-	if (pr->flags.bm_rld_set && target->type != ACPI_STATE_C3) {
-		acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0);
-		pr->flags.bm_rld_set = 0;
-	}
-
-	if (!pr->flags.bm_rld_set && target->type == ACPI_STATE_C3) {
-		acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
-		pr->flags.bm_rld_set = 1;
-	}
-}
-
-/**
  * acpi_idle_do_entry - a helper function that does C2 and C3 type entry
  * @cx: cstate data
  *
@@ -1473,9 +1442,6 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
 		return 0;
 	}
 
-	if (pr->flags.bm_check)
-		acpi_idle_update_bm_rld(pr, cx);
-
 	t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 	acpi_idle_do_entry(cx);
 	t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
@@ -1527,9 +1493,6 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	 */
 	acpi_state_timer_broadcast(pr, cx, 1);
 
-	if (pr->flags.bm_check)
-		acpi_idle_update_bm_rld(pr, cx);
-
 	if (cx->type == ACPI_STATE_C3)
 		ACPI_FLUSH_CPU_CACHE();
 
@@ -1621,8 +1584,6 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	 */
 	acpi_state_timer_broadcast(pr, cx, 1);
 
-	acpi_idle_update_bm_rld(pr, cx);
-
 	/*
 	 * disable bus master
 	 * bm_check implies we need ARB_DIS
-- 
1.5.6.6

