From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 4/6] ACPICA: Remove restriction of 256 maximum GPEs in any GPE block
Date: Wed, 17 Jul 2013 09:48:50 +0800
Message-ID: <b5f54393747a6a063c843fdd63c3e340ea0e0cee.1374025121.git.lv.zheng@intel.com>
References: <cover.1374025121.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5770 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179Ab3GQBtp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jul 2013 21:49:45 -0400
In-Reply-To: <cover.1374025121.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

The FADT can support over 1000 GPEs, so remove any restriction
on the GPE numbers.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Acked-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/evgpeinit.c |   11 -----------
 include/acpi/actypes.h          |    7 -------
 2 files changed, 18 deletions(-)

diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index 9037f17..7842700 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -125,7 +125,6 @@ acpi_status acpi_ev_gpe_initialize(void)
 		/* GPE block 0 exists (has both length and address > 0) */
 
 		register_count0 = (u16)(acpi_gbl_FADT.gpe0_block_length / 2);
-
 		gpe_number_max =
 		    (register_count0 * ACPI_GPE_REGISTER_WIDTH) - 1;
 
@@ -204,16 +203,6 @@ acpi_status acpi_ev_gpe_initialize(void)
 		goto cleanup;
 	}
 
-	/* Check for Max GPE number out-of-range */
-
-	if (gpe_number_max > ACPI_GPE_MAX) {
-		ACPI_ERROR((AE_INFO,
-			    "Maximum GPE number from FADT is too large: 0x%X",
-			    gpe_number_max));
-		status = AE_BAD_VALUE;
-		goto cleanup;
-	}
-
       cleanup:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(AE_OK);
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index a64adcc..3433d2c 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -668,13 +668,6 @@ typedef u32 acpi_event_status;
 #define ACPI_EVENT_FLAG_SET             (acpi_event_status) 0x04
 #define ACPI_EVENT_FLAG_HANDLE		(acpi_event_status) 0x08
 
-/*
- * General Purpose Events (GPE)
- */
-#define ACPI_GPE_INVALID                0xFF
-#define ACPI_GPE_MAX                    0xFF
-#define ACPI_NUM_GPE                    256
-
 /* Actions for acpi_set_gpe, acpi_gpe_wakeup, acpi_hw_low_set_gpe */
 
 #define ACPI_GPE_ENABLE                 0
-- 
1.7.10

