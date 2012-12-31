From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/27] ACPICA: Add time macros for various timer/time manipulation.
Date: Mon, 31 Dec 2012 08:05:46 +0800
Message-ID: <65728f987162fdbc774bf42d76019533e5be0dc8.1356668533.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:31962 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab2LaAF4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:05:56 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Constants for time manipulation, including constants for the 100
nanosecond timers. Chao Guan, Bob Moore, Lv Zheng.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/hwsleep.c   |    2 +-
 drivers/acpi/acpica/hwtimer.c   |    7 ++++---
 drivers/acpi/acpica/hwxfsleep.c |    2 +-
 include/acpi/actypes.h          |   17 ++++++++++++++++-
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 691a5fb..675a8f8 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -177,7 +177,7 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
 		 * to still read the right value. Ideally, this block would go
 		 * away entirely.
 		 */
-		acpi_os_stall(10000000);
+		acpi_os_stall(10 * ACPI_USEC_PER_SEC);
 
 		status = acpi_hw_register_write(ACPI_REGISTER_PM1_CONTROL,
 						sleep_enable_reg_info->
diff --git a/drivers/acpi/acpica/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
index bfdce22..4e741d8 100644
--- a/drivers/acpi/acpica/hwtimer.c
+++ b/drivers/acpi/acpica/hwtimer.c
@@ -176,10 +176,11 @@ acpi_get_timer_duration(u32 start_ticks, u32 end_ticks, u32 * time_elapsed)
 	/*
 	 * Compute Duration (Requires a 64-bit multiply and divide):
 	 *
-	 * time_elapsed = (delta_ticks * 1000000) / PM_TIMER_FREQUENCY;
+	 * time_elapsed (microseconds) =
+	 *  (delta_ticks * ACPI_USEC_PER_SEC) / ACPI_PM_TIMER_FREQUENCY;
 	 */
-	status = acpi_ut_short_divide(((u64) delta_ticks) * 1000000,
-				      PM_TIMER_FREQUENCY, &quotient, NULL);
+	status = acpi_ut_short_divide(((u64)delta_ticks) * ACPI_USEC_PER_SEC,
+				      ACPI_PM_TIMER_FREQUENCY, &quotient, NULL);
 
 	*time_elapsed = (u32) quotient;
 	return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 6fcee00..ca4df0f 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -207,7 +207,7 @@ acpi_status asmlinkage acpi_enter_sleep_state_s4bios(void)
 				    (u32)acpi_gbl_FADT.s4_bios_request, 8);
 
 	do {
-		acpi_os_stall(1000);
+		acpi_os_stall(ACPI_USEC_PER_MSEC);
 		status =
 		    acpi_read_bit_register(ACPI_BITREG_WAKE_STATUS, &in_value);
 		if (ACPI_FAILURE(status)) {
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 3de70ed..796a63e 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -341,7 +341,7 @@ typedef u32 acpi_physical_address;
 
 /* PM Timer ticks per second (HZ) */
 
-#define PM_TIMER_FREQUENCY              3579545
+#define ACPI_PM_TIMER_FREQUENCY         3579545
 
 /*******************************************************************************
  *
@@ -373,6 +373,21 @@ typedef u32 acpi_name;		/* 4-byte ACPI name */
 typedef char *acpi_string;	/* Null terminated ASCII string */
 typedef void *acpi_handle;	/* Actually a ptr to a NS Node */
 
+/* Time constants for timer calculations */
+
+#define ACPI_MSEC_PER_SEC               1000L
+
+#define ACPI_USEC_PER_MSEC              1000L
+#define ACPI_USEC_PER_SEC               1000000L
+
+#define ACPI_100NSEC_PER_USEC           10L
+#define ACPI_100NSEC_PER_MSEC           10000L
+#define ACPI_100NSEC_PER_SEC            10000000L
+
+#define ACPI_NSEC_PER_USEC              1000L
+#define ACPI_NSEC_PER_MSEC              1000000L
+#define ACPI_NSEC_PER_SEC               1000000000L
+
 /* Owner IDs are used to track namespace nodes for selective deletion */
 
 typedef u8 acpi_owner_id;
-- 
1.7.10

