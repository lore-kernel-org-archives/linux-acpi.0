From: Len Brown <lenb@kernel.org>
Subject: [PATCH 094/112] ACPI: enable MWAIT for C1 idle
Date: Thu,  7 Feb 2008 04:34:56 -0500
Message-ID: <bc71bec91f9875ef825d12104acf3bf4ca215fa4.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:9414 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758423AbYBGJgx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:53 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "venkatesh.pallipadi@intel.com" <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: venkatesh.pallipadi@intel.com <venkatesh.pallipadi@intel.com>

Add MWAIT idle for C1 state instead of halt, on platforms that support
C1 state with MWAIT.

Renames cx->space_id to something more appropriate.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |   20 ++++++++++++--------
 include/acpi/processor.h      |    3 ++-
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 106a229..4ba3a9a 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -265,7 +265,7 @@ static atomic_t c3_cpu_count;
 /* Common C-state entry for C2, C3, .. */
 static void acpi_cstate_enter(struct acpi_processor_cx *cstate)
 {
-	if (cstate->space_id == ACPI_CSTATE_FFH) {
+	if (cstate->entry_method == ACPI_CSTATE_FFH) {
 		/* Call into architectural FFH based C-state */
 		acpi_processor_ffh_cstate_enter(cstate);
 	} else {
@@ -929,20 +929,20 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 		cx.address = reg->address;
 		cx.index = current_count + 1;
 
-		cx.space_id = ACPI_CSTATE_SYSTEMIO;
+		cx.entry_method = ACPI_CSTATE_SYSTEMIO;
 		if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
 			if (acpi_processor_ffh_cstate_probe
 					(pr->id, &cx, reg) == 0) {
-				cx.space_id = ACPI_CSTATE_FFH;
-			} else if (cx.type != ACPI_STATE_C1) {
+				cx.entry_method = ACPI_CSTATE_FFH;
+			} else if (cx.type == ACPI_STATE_C1) {
 				/*
 				 * C1 is a special case where FIXED_HARDWARE
 				 * can be handled in non-MWAIT way as well.
 				 * In that case, save this _CST entry info.
-				 * That is, we retain space_id of SYSTEM_IO for
-				 * halt based C1.
 				 * Otherwise, ignore this info and continue.
 				 */
+				cx.entry_method = ACPI_CSTATE_HALT;
+			} else {
 				continue;
 			}
 		}
@@ -1376,12 +1376,16 @@ static inline void acpi_idle_update_bm_rld(struct acpi_processor *pr,
 /**
  * acpi_idle_do_entry - a helper function that does C2 and C3 type entry
  * @cx: cstate data
+ *
+ * Caller disables interrupt before call and enables interrupt after return.
  */
 static inline void acpi_idle_do_entry(struct acpi_processor_cx *cx)
 {
-	if (cx->space_id == ACPI_CSTATE_FFH) {
+	if (cx->entry_method == ACPI_CSTATE_FFH) {
 		/* Call into architectural FFH based C-state */
 		acpi_processor_ffh_cstate_enter(cx);
+	} else if (cx->entry_method == ACPI_CSTATE_HALT) {
+		acpi_safe_halt();
 	} else {
 		int unused;
 		/* IO port based C-state */
@@ -1414,7 +1418,7 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
 	if (pr->flags.bm_check)
 		acpi_idle_update_bm_rld(pr, cx);
 
-	acpi_safe_halt();
+	acpi_idle_do_entry(cx);
 
 	local_irq_enable();
 	cx->usage++;
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 6e253b5..f6d7c50 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -34,6 +34,7 @@
 
 #define ACPI_CSTATE_SYSTEMIO	(0)
 #define ACPI_CSTATE_FFH		(1)
+#define ACPI_CSTATE_HALT	(2)
 
 /* Power Management */
 
@@ -64,7 +65,7 @@ struct acpi_processor_cx {
 	u8 valid;
 	u8 type;
 	u32 address;
-	u8 space_id;
+	u8 entry_method;
 	u8 index;
 	u32 latency;
 	u32 latency_ticks;
-- 
1.5.4.23.gef5b9

