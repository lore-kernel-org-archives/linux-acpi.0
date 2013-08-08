From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 6/9] ACPICA: Make ACPI Power Management Timer (PM Timer) optional.
Date: Thu,  8 Aug 2013 15:29:51 +0800
Message-ID: <f33e6e1b2775191444ab54142d5094583b5a8cd5.1375946725.git.lv.zheng@intel.com>
References: <cover.1375946725.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35581 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933825Ab3HHHa3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Aug 2013 03:30:29 -0400
In-Reply-To: <cover.1375946725.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

PM Timer is now optional.
This support is already in Windows8 and "SHOULD" come out in ACPI 5.0A
(if all goes well).

The change doesn't affect Linux directly, because it has never relied
on the presence of the PM timer.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/hwtimer.c |   13 ++++++++++++-
 drivers/acpi/acpica/tbfadt.c  |    4 ++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
index 0c1a8bb..2d7d22e 100644
--- a/drivers/acpi/acpica/hwtimer.c
+++ b/drivers/acpi/acpica/hwtimer.c
@@ -100,8 +100,13 @@ acpi_status acpi_get_timer(u32 * ticks)
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	status = acpi_hw_read(ticks, &acpi_gbl_FADT.xpm_timer_block);
+	/* ACPI 5.0A: PM Timer is optional */
+
+	if (!acpi_gbl_FADT.xpm_timer_block.address) {
+		return_ACPI_STATUS(AE_SUPPORT);
+	}
 
+	status = acpi_hw_read(ticks, &acpi_gbl_FADT.xpm_timer_block);
 	return_ACPI_STATUS(status);
 }
 
@@ -148,6 +153,12 @@ acpi_get_timer_duration(u32 start_ticks, u32 end_ticks, u32 * time_elapsed)
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
+	/* ACPI 5.0A: PM Timer is optional */
+
+	if (!acpi_gbl_FADT.xpm_timer_block.address) {
+		return_ACPI_STATUS(AE_SUPPORT);
+	}
+
 	/*
 	 * Compute Tick Delta:
 	 * Handle (max one) timer rollovers on 24-bit versus 32-bit timers.
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 33b00d2..9d99f21 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -117,7 +117,7 @@ static struct acpi_fadt_info fadt_info_table[] = {
 	 ACPI_FADT_OFFSET(pm_timer_block),
 	 ACPI_FADT_OFFSET(pm_timer_length),
 	 ACPI_PM_TIMER_WIDTH,
-	 ACPI_FADT_REQUIRED},
+	 ACPI_FADT_SEPARATE_LENGTH},	/* ACPI 5.0A: Timer is optional */
 
 	{"Gpe0Block",
 	 ACPI_FADT_OFFSET(xgpe0_block),
@@ -574,7 +574,7 @@ static void acpi_tb_validate_fadt(void)
 
 		if (fadt_info_table[i].type & ACPI_FADT_REQUIRED) {
 			/*
-			 * Field is required (Pm1a_event, Pm1a_control, pm_timer).
+			 * Field is required (Pm1a_event, Pm1a_control).
 			 * Both the address and length must be non-zero.
 			 */
 			if (!address64->address || !length) {
-- 
1.7.10

