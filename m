From: Len Brown <len.brown@intel.com>
Subject: [PATCH 40/77] ACPI: Enable C3 even when PM2_control is zero
Date: Sun, 22 Jul 2007 05:14:25 -0400
Message-ID: <11850957443711-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22481 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763128AbXGVJPs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:48 -0400
In-Reply-To: <11850957432095-git-send-email-len.brown@intel.com>
Message-Id: <18eab8550397f1f3d4b8b2c5257c88dae25d58ed.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

On systems that do not have pm2_control_block, we cannot really use
ARB_DISABLE before C3. We used to disable C3 totally on such systems.

To be compatible with Windows, we need to enable C3 on such systems now.
We just skip ARB_DISABLE step before entering the C3-state and assume
hardware is handling things correctly. Also, ACPI spec is not clear
about pm2_control is _needed_ for C3 or not.

We have atleast one system that need this to enable C3.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index ee5759b..36dc1d2 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -488,7 +488,17 @@ static void acpi_processor_idle(void)
 
 	case ACPI_STATE_C3:
 
-		if (pr->flags.bm_check) {
+		/*
+		 * disable bus master
+		 * bm_check implies we need ARB_DIS
+		 * !bm_check implies we need cache flush
+		 * bm_control implies whether we can do ARB_DIS
+		 *
+		 * That leaves a case where bm_check is set and bm_control is
+		 * not set. In that case we cannot do much, we enter C3
+		 * without doing anything.
+		 */
+		if (pr->flags.bm_check && pr->flags.bm_control) {
 			if (atomic_inc_return(&c3_cpu_count) ==
 			    num_online_cpus()) {
 				/*
@@ -497,7 +507,7 @@ static void acpi_processor_idle(void)
 				 */
 				acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1);
 			}
-		} else {
+		} else if (!pr->flags.bm_check) {
 			/* SMP with no shared cache... Invalidate cache  */
 			ACPI_FLUSH_CPU_CACHE();
 		}
@@ -509,7 +519,7 @@ static void acpi_processor_idle(void)
 		acpi_cstate_enter(cx);
 		/* Get end time (ticks) */
 		t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
-		if (pr->flags.bm_check) {
+		if (pr->flags.bm_check && pr->flags.bm_control) {
 			/* Enable bus master arbitration */
 			atomic_dec(&c3_cpu_count);
 			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0);
@@ -959,9 +969,9 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 	if (pr->flags.bm_check) {
 		/* bus mastering control is necessary */
 		if (!pr->flags.bm_control) {
+			/* In this case we enter C3 without bus mastering */
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "C3 support requires bus mastering control\n"));
-			return;
+				"C3 support without bus mastering control\n"));
 		}
 	} else {
 		/*
-- 
1.5.3.rc2.22.g69a9b
