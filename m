From: mochel@linux.intel.com
Subject: [PATCH 19/24] Remove unneeded debugging macros in drivers/acpi/processor_idle.c
Date: Mon, 17 Apr 2006 18:21:55 -0700
Message-ID: <11453233151054-git-send-email-mochel@linux.intel.com>
References: <11453233141934-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:60559 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932123AbWDRBZ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:26 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr002.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1PQBH025153
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:26 GMT
In-Reply-To: <11453233141934-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/processor_idle.c |   80 ++++++++++++++---------------------------
 1 files changed, 28 insertions(+), 52 deletions(-)

applies-to: a950fd29a26cf294c2e4de46d8d1f89d6feec874
c00c2a68335e667033330b863c256f3b90f3fb29
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 5b72cc9..5ccce5a 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -508,10 +508,8 @@ static int acpi_processor_set_power_poli
 	struct acpi_processor_cx *higher = NULL;
 	struct acpi_processor_cx *cx;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_set_power_policy");
-
 	if (!pr)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	/*
 	 * This function sets the default Cx state policy (OS idle handler).
@@ -535,7 +533,7 @@ static int acpi_processor_set_power_poli
 	}
 
 	if (!state_is_set)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	/* demotion */
 	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
@@ -574,18 +572,16 @@ static int acpi_processor_set_power_poli
 		higher = cx;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
 {
-	ACPI_FUNCTION_TRACE("acpi_processor_get_power_info_fadt");
-
 	if (!pr)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (!pr->pblk)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	/* if info is obtained from pblk/fadt, type equals state */
 	pr->power.states[ACPI_STATE_C2].type = ACPI_STATE_C2;
@@ -597,7 +593,7 @@ static int acpi_processor_get_power_info
 	 * an SMP system. 
 	 */
 	if ((num_online_cpus() > 1) && !acpi_fadt.plvl2_up)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 #endif
 
 	/* determine C2 and C3 address from pblk */
@@ -613,13 +609,11 @@ static int acpi_processor_get_power_info
 			  pr->power.states[ACPI_STATE_C2].address,
 			  pr->power.states[ACPI_STATE_C3].address));
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_processor_get_power_info_default_c1(struct acpi_processor *pr)
 {
-	ACPI_FUNCTION_TRACE("acpi_processor_get_power_info_default_c1");
-
 	/* Zero initialize all the C-states info. */
 	memset(pr->power.states, 0, sizeof(pr->power.states));
 
@@ -631,7 +625,7 @@ static int acpi_processor_get_power_info
 	pr->power.states[ACPI_STATE_C0].valid = 1;
 	pr->power.states[ACPI_STATE_C1].valid = 1;
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
@@ -643,10 +637,8 @@ static int acpi_processor_get_power_info
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *cst;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_get_power_info_cst");
-
 	if (nocst)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	current_count = 1;
 
@@ -658,7 +650,7 @@ static int acpi_processor_get_power_info
 	status = acpi_evaluate_object(pr->handle, "_CST", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No _CST, giving up\n"));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	cst = (union acpi_object *)buffer.pointer;
@@ -764,15 +756,13 @@ static int acpi_processor_get_power_info
       end:
 	acpi_os_free(buffer.pointer);
 
-	return_VALUE(status);
+	return status;
 }
 
 static void acpi_processor_power_verify_c2(struct acpi_processor_cx *cx)
 {
-	ACPI_FUNCTION_TRACE("acpi_processor_get_power_verify_c2");
-
 	if (!cx->address)
-		return_VOID;
+		return;
 
 	/*
 	 * C2 latency must be less than or equal to 100
@@ -781,7 +771,7 @@ static void acpi_processor_power_verify_
 	else if (cx->latency > ACPI_PROCESSOR_MAX_C2_LATENCY) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "latency too large [%d]\n", cx->latency));
-		return_VOID;
+		return;
 	}
 
 	/*
@@ -791,7 +781,6 @@ static void acpi_processor_power_verify_
 	cx->valid = 1;
 	cx->latency_ticks = US_TO_PM_TIMER_TICKS(cx->latency);
 
-	return_VOID;
 }
 
 static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
@@ -799,10 +788,8 @@ static void acpi_processor_power_verify_
 {
 	static int bm_check_flag;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_get_power_verify_c3");
-
 	if (!cx->address)
-		return_VOID;
+		return;
 
 	/*
 	 * C3 latency must be less than or equal to 1000
@@ -811,7 +798,7 @@ static void acpi_processor_power_verify_
 	else if (cx->latency > ACPI_PROCESSOR_MAX_C3_LATENCY) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "latency too large [%d]\n", cx->latency));
-		return_VOID;
+		return;
 	}
 
 	/*
@@ -824,7 +811,7 @@ static void acpi_processor_power_verify_
 	else if (errata.piix4.fdma) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "C3 not supported on PIIX4 with Type-F DMA\n"));
-		return_VOID;
+		return;
 	}
 
 	/* All the logic here assumes flags.bm_check is same across all CPUs */
@@ -841,7 +828,7 @@ static void acpi_processor_power_verify_
 		if (!pr->flags.bm_control) {
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					  "C3 support requires bus mastering control\n"));
-			return_VOID;
+			return;
 		}
 	} else {
 		/*
@@ -852,7 +839,7 @@ static void acpi_processor_power_verify_
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					  "Cache invalidation should work properly"
 					  " for C3 to be enabled on SMP systems\n"));
-			return_VOID;
+			return;
 		}
 		acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD,
 				  0, ACPI_MTX_DO_NOT_LOCK);
@@ -867,7 +854,6 @@ static void acpi_processor_power_verify_
 	cx->valid = 1;
 	cx->latency_ticks = US_TO_PM_TIMER_TICKS(cx->latency);
 
-	return_VOID;
 }
 
 static int acpi_processor_power_verify(struct acpi_processor *pr)
@@ -926,8 +912,6 @@ static int acpi_processor_get_power_info
 	unsigned int i;
 	int result;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_get_power_info");
-
 	/* NOTE: the idle thread may not be running while calling
 	 * this function */
 
@@ -949,7 +933,7 @@ static int acpi_processor_get_power_info
 	 */
 	result = acpi_processor_set_power_policy(pr);
 	if (result)
-		return_VALUE(result);
+		return result;
 
 	/*
 	 * if one state of type C2 or C3 is available, mark this
@@ -963,24 +947,22 @@ static int acpi_processor_get_power_info
 		}
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 int acpi_processor_cst_has_changed(struct acpi_processor *pr)
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_cst_has_changed");
-
 	if (!pr)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (nocst) {
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	if (!pr->flags.power_setup_done)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	/* Fall back to the default idle loop */
 	pm_idle = pm_idle_save;
@@ -991,7 +973,7 @@ int acpi_processor_cst_has_changed(struc
 	if ((pr->flags.power == 1) && (pr->flags.power_setup_done))
 		pm_idle = acpi_processor_idle;
 
-	return_VALUE(result);
+	return result;
 }
 
 /* proc interface */
@@ -1001,8 +983,6 @@ static int acpi_processor_power_seq_show
 	struct acpi_processor *pr = (struct acpi_processor *)seq->private;
 	unsigned int i;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_power_seq_show");
-
 	if (!pr)
 		goto end;
 
@@ -1059,7 +1039,7 @@ static int acpi_processor_power_seq_show
 	}
 
       end:
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_processor_power_open_fs(struct inode *inode, struct file *file)
@@ -1083,8 +1063,6 @@ int acpi_processor_power_init(struct acp
 	struct proc_dir_entry *entry = NULL;
 	unsigned int i;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_power_init");
-
 	if (!first_run) {
 		dmi_check_system(processor_power_dmi_table);
 		if (max_cstate < ACPI_C_STATES_MAX)
@@ -1095,7 +1073,7 @@ int acpi_processor_power_init(struct acp
 	}
 
 	if (!pr)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (acpi_fadt.cst_cnt && !nocst) {
 		status =
@@ -1140,14 +1118,12 @@ int acpi_processor_power_init(struct acp
 
 	pr->flags.power_setup_done = 1;
 
-	return_VALUE(0);
+	return 0;
 }
 
 int acpi_processor_power_exit(struct acpi_processor *pr,
 			      struct acpi_device *device)
 {
-	ACPI_FUNCTION_TRACE("acpi_processor_power_exit");
-
 	pr->flags.power_setup_done = 0;
 
 	if (acpi_device_dir(device))
@@ -1166,5 +1142,5 @@ int acpi_processor_power_exit(struct acp
 		cpu_idle_wait();
 	}
 
-	return_VALUE(0);
+	return 0;
 }
---
0.99.9.GIT


