From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 7/8] ACPICA: Update acpi_get_timer for 64-bit interface to acpi_hw_read
Date: Fri, 17 Nov 2017 10:03:35 -0800
Message-ID: <20171117180336.15558-7-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117180336.15558-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32280 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161257AbdKQSIy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 13:08:54 -0500
In-Reply-To: <20171117180336.15558-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 1cdcf16447c15694faa564c0cd8e357b910344a0

Return value from acpi_hw_read is now 64 bits, but the ACPI PM
Timer is defined by the ACPI spec to be 32 bits.

Link: https://github.com/acpica/acpica/commit/1cdcf164
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/hwtimer.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
index b3c5d8c754bb..a2f4e25d45b1 100644
--- a/drivers/acpi/acpica/hwtimer.c
+++ b/drivers/acpi/acpica/hwtimer.c
@@ -94,6 +94,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_timer_resolution)
 acpi_status acpi_get_timer(u32 * ticks)
 {
 	acpi_status status;
+	u64 timer_value;
 
 	ACPI_FUNCTION_TRACE(acpi_get_timer);
 
@@ -107,7 +108,14 @@ acpi_status acpi_get_timer(u32 * ticks)
 		return_ACPI_STATUS(AE_SUPPORT);
 	}
 
-	status = acpi_hw_read(ticks, &acpi_gbl_FADT.xpm_timer_block);
+	status = acpi_hw_read(&timer_value, &acpi_gbl_FADT.xpm_timer_block);
+	if (ACPI_SUCCESS(status)) {
+
+		/* ACPI PM Timer is defined to be 32 bits (PM_TMR_LEN) */
+
+		*ticks = (u32)timer_value;
+	}
+
 	return_ACPI_STATUS(status);
 }
 
-- 
2.13.6

