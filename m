From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 5/9] ACPICA: Fix divergences of the commit - ACPICA: Expose OSI version.
Date: Thu,  8 Aug 2013 15:29:46 +0800
Message-ID: <d0a80bba5aff802467c2430565fe210c0a3232b0.1375946725.git.lv.zheng@intel.com>
References: <cover.1375946725.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29434 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933825Ab3HHH37 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Aug 2013 03:29:59 -0400
In-Reply-To: <cover.1375946725.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>

The original commit 242b2287cd7f27521c8b54a4101d569e53e7a0ca "ACPICA:
expose OSI version" triggers build errors in ACPICA when it is back
ported.  The patch removes the divergences between Linux and upstream
ACPICA resulting from that.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Cc: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    7 ++++++-
 drivers/acpi/acpica/utglobal.c |    1 -
 include/acpi/actypes.h         |   28 +++++++++++++---------------
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index b8d3811..90e846f 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -138,6 +138,12 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_disable_auto_repair, FALSE);
  */
 u8 ACPI_INIT_GLOBAL(acpi_gbl_disable_ssdt_table_load, FALSE);
 
+/*
+ * We keep track of the latest version of Windows that has been requested by
+ * the BIOS.
+ */
+u8 ACPI_INIT_GLOBAL(acpi_gbl_osi_data, 0);
+
 /* acpi_gbl_FADT is a local copy of the FADT, converted to a common format. */
 
 struct acpi_table_fadt acpi_gbl_FADT;
@@ -285,7 +291,6 @@ ACPI_EXTERN u8 acpi_gbl_debugger_configuration;
 ACPI_EXTERN u8 acpi_gbl_step_to_next_call;
 ACPI_EXTERN u8 acpi_gbl_acpi_hardware_present;
 ACPI_EXTERN u8 acpi_gbl_events_initialized;
-ACPI_EXTERN u8 acpi_gbl_osi_data;
 ACPI_EXTERN struct acpi_interface_info *acpi_gbl_supported_interfaces;
 ACPI_EXTERN struct acpi_address_range
     *acpi_gbl_address_range_list[ACPI_ADDRESS_RANGE_MAX];
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index f736448..d6f26bf 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -336,7 +336,6 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_trace_dbg_layer = 0;
 	acpi_gbl_debugger_configuration = DEBUGGER_THREADING;
 	acpi_gbl_db_output_flags = ACPI_DB_CONSOLE_OUTPUT;
-	acpi_gbl_osi_data = 0;
 	acpi_gbl_osi_mutex = NULL;
 	acpi_gbl_reg_methods_executed = FALSE;
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index eae55fb..b748aef 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1137,7 +1137,19 @@ struct acpi_memory_list {
 #endif
 };
 
-/* Definitions for _OSI support */
+/* Definitions of _OSI support */
+
+#define ACPI_VENDOR_STRINGS                 0x01
+#define ACPI_FEATURE_STRINGS                0x02
+#define ACPI_ENABLE_INTERFACES              0x00
+#define ACPI_DISABLE_INTERFACES             0x04
+
+#define ACPI_DISABLE_ALL_VENDOR_STRINGS     (ACPI_DISABLE_INTERFACES | ACPI_VENDOR_STRINGS)
+#define ACPI_DISABLE_ALL_FEATURE_STRINGS    (ACPI_DISABLE_INTERFACES | ACPI_FEATURE_STRINGS)
+#define ACPI_DISABLE_ALL_STRINGS            (ACPI_DISABLE_INTERFACES | ACPI_VENDOR_STRINGS | ACPI_FEATURE_STRINGS)
+#define ACPI_ENABLE_ALL_VENDOR_STRINGS      (ACPI_ENABLE_INTERFACES | ACPI_VENDOR_STRINGS)
+#define ACPI_ENABLE_ALL_FEATURE_STRINGS     (ACPI_ENABLE_INTERFACES | ACPI_FEATURE_STRINGS)
+#define ACPI_ENABLE_ALL_STRINGS             (ACPI_ENABLE_INTERFACES | ACPI_VENDOR_STRINGS | ACPI_FEATURE_STRINGS)
 
 #define ACPI_OSI_WIN_2000               0x01
 #define ACPI_OSI_WIN_XP                 0x02
@@ -1152,18 +1164,4 @@ struct acpi_memory_list {
 #define ACPI_OSI_WIN_7                  0x0B
 #define ACPI_OSI_WIN_8                  0x0C
 
-/* _OSI update actions */
-
-#define ACPI_VENDOR_STRINGS                 0x01
-#define ACPI_FEATURE_STRINGS                0x02
-#define ACPI_ENABLE_INTERFACES              0x00
-#define ACPI_DISABLE_INTERFACES             0x04
-
-#define ACPI_DISABLE_ALL_VENDOR_STRINGS     (ACPI_DISABLE_INTERFACES | ACPI_VENDOR_STRINGS)
-#define ACPI_DISABLE_ALL_FEATURE_STRINGS    (ACPI_DISABLE_INTERFACES | ACPI_FEATURE_STRINGS)
-#define ACPI_DISABLE_ALL_STRINGS            (ACPI_DISABLE_INTERFACES | ACPI_VENDOR_STRINGS | ACPI_FEATURE_STRINGS)
-#define ACPI_ENABLE_ALL_VENDOR_STRINGS      (ACPI_ENABLE_INTERFACES | ACPI_VENDOR_STRINGS)
-#define ACPI_ENABLE_ALL_FEATURE_STRINGS     (ACPI_ENABLE_INTERFACES | ACPI_FEATURE_STRINGS)
-#define ACPI_ENABLE_ALL_STRINGS             (ACPI_ENABLE_INTERFACES | ACPI_VENDOR_STRINGS | ACPI_FEATURE_STRINGS)
-
 #endif				/* __ACTYPES_H__ */
-- 
1.7.10

