From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: cpuidle: delete access to ACPI_BITREG_BUS_MASTER_RLD
Date: Thu, 4 Oct 2007 01:08:35 -0400
Message-ID: <200710040108.35906.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59083 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbXJDFIu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Oct 2007 01:08:50 -0400
Received: from d975xbx2 (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id l9458f2W006635
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Thu, 4 Oct 2007 05:08:43 GMT
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI List <linux-acpi@vger.kernel.org>

From: Len Brown <len.brown@intel.com>

per 3ebcd8868cfd953cb95777cdfa65effa3756c941
(ACPI: idle: delete access to ACPI_BITREG_BUS_MASTER_RLD)

delete this code, and the port of it to cpuidle.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |   50 ----------------------
 include/acpi/processor.h      |    1
 2 files changed, 51 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 99da6a7..d924aa3 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -214,26 +214,6 @@ acpi_processor_power_activate(struct acpi_processor *pr,
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
@@ -1057,7 +1037,6 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 					  " for C3 to be enabled on SMP systems\n"));
 			return;
 		}
-		acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0);
 	}
 
 	/*
@@ -1327,25 +1306,6 @@ static int acpi_idle_bm_check(void)
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
  */
@@ -1382,9 +1342,6 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
 	if (unlikely(!pr))
 		return 0;
 
-	if (pr->flags.bm_check)
-		acpi_idle_update_bm_rld(pr, cx);
-
 	current_thread_info()->status &= ~TS_POLLING;
 	/*
 	 * TS_POLLING-cleared state must be visible before we test
@@ -1416,9 +1373,6 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	if (unlikely(!pr))
 		return 0;
 
-	if (pr->flags.bm_check)
-		acpi_idle_update_bm_rld(pr, cx);
-
 	local_irq_disable();
 	current_thread_info()->status &= ~TS_POLLING;
 	/*
@@ -1500,14 +1454,10 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	if (acpi_idle_bm_check()) {
 		cx = pr->power.bm_state;
 
-		acpi_idle_update_bm_rld(pr, cx);
-
 		t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 		acpi_idle_do_entry(cx);
 		t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 	} else {
-		acpi_idle_update_bm_rld(pr, cx);
-
 		spin_lock(&c3_lock);
 		c3_cpu_count++;
 		/* Disable bus master arbitration when all CPUs are in C3 */
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 71eccc5..c668d08 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -202,7 +202,6 @@ struct acpi_processor_flags {
 	u8 bm_check:1;
 	u8 has_cst:1;
 	u8 power_setup_done:1;
-	u8 bm_rld_set:1;
 };
 
 struct acpi_processor {
