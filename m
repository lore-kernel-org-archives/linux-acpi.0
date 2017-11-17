From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 01/11] ACPICA: Fix an off-by-one error in acpi_get_timer_duration().
Date: Fri, 17 Nov 2017 15:40:14 -0800
Message-ID: <20171117234024.833-2-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234024.833-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49402 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161767AbdKQXpM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:45:12 -0500
In-Reply-To: <20171117234024.833-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jung-uk Kim <jkim@free_BSD.org>, Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Jung-uk Kim <jkim@free_BSD.org>

ACPICA commit b4fd33f3c2af014aeec978d46392d286fd7f52b3

Delta calculation has an off-by-one error when there is a rollover.
For example, when start_ticks is 0x00FFFFFF and end_ticks is 0x00000000
(for 24-bit timer), delta_ticks should be 1 (one) but it was 0 (zero).

Link: https://github.com/acpica/acpica/commit/b4fd33f3
Signed-off-by: Jung-uk Kim <jkim@free_BSD.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/hwtimer.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/acpica/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
index a2f4e25d45b1..5b4282902a83 100644
--- a/drivers/acpi/acpica/hwtimer.c
+++ b/drivers/acpi/acpica/hwtimer.c
@@ -150,10 +150,10 @@ ACPI_EXPORT_SYMBOL(acpi_get_timer)
  *
  ******************************************************************************/
 acpi_status
-acpi_get_timer_duration(u32 start_ticks, u32 end_ticks, u32 * time_elapsed)
+acpi_get_timer_duration(u32 start_ticks, u32 end_ticks, u32 *time_elapsed)
 {
 	acpi_status status;
-	u32 delta_ticks;
+	u64 delta_ticks;
 	u64 quotient;
 
 	ACPI_FUNCTION_TRACE(acpi_get_timer_duration);
@@ -168,30 +168,29 @@ acpi_get_timer_duration(u32 start_ticks, u32 end_ticks, u32 * time_elapsed)
 		return_ACPI_STATUS(AE_SUPPORT);
 	}
 
+	if (start_ticks == end_ticks) {
+		*time_elapsed = 0;
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/*
 	 * Compute Tick Delta:
 	 * Handle (max one) timer rollovers on 24-bit versus 32-bit timers.
 	 */
-	if (start_ticks < end_ticks) {
-		delta_ticks = end_ticks - start_ticks;
-	} else if (start_ticks > end_ticks) {
+	delta_ticks = end_ticks;
+	if (start_ticks > end_ticks) {
 		if ((acpi_gbl_FADT.flags & ACPI_FADT_32BIT_TIMER) == 0) {
 
 			/* 24-bit Timer */
 
-			delta_ticks =
-			    (((0x00FFFFFF - start_ticks) +
-			      end_ticks) & 0x00FFFFFF);
+			delta_ticks |= (u64)1 << 24;
 		} else {
 			/* 32-bit Timer */
 
-			delta_ticks = (0xFFFFFFFF - start_ticks) + end_ticks;
+			delta_ticks |= (u64)1 << 32;
 		}
-	} else {		/* start_ticks == end_ticks */
-
-		*time_elapsed = 0;
-		return_ACPI_STATUS(AE_OK);
 	}
+	delta_ticks -= start_ticks;
 
 	/*
 	 * Compute Duration (Requires a 64-bit multiply and divide):
@@ -199,10 +198,10 @@ acpi_get_timer_duration(u32 start_ticks, u32 end_ticks, u32 * time_elapsed)
 	 * time_elapsed (microseconds) =
 	 *  (delta_ticks * ACPI_USEC_PER_SEC) / ACPI_PM_TIMER_FREQUENCY;
 	 */
-	status = acpi_ut_short_divide(((u64)delta_ticks) * ACPI_USEC_PER_SEC,
+	status = acpi_ut_short_divide(delta_ticks * ACPI_USEC_PER_SEC,
 				      ACPI_PM_TIMER_FREQUENCY, &quotient, NULL);
 
-	*time_elapsed = (u32) quotient;
+	*time_elapsed = (u32)quotient;
 	return_ACPI_STATUS(status);
 }
 
-- 
2.13.6

