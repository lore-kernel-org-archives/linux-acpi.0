From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/21] ACPICA: Update RASF table definition
Date: Fri,  8 Mar 2013 17:20:21 +0800
Message-ID: <173aefa9898430a4e17ea8ea46e372c5daf4d917.1361292877.git.lv.zheng@intel.com>
References: <cover.1361292877.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17381 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756027Ab3CHJUg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Mar 2013 04:20:36 -0500
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

Update to reflect final ACPI 5.0 changes.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/actbl3.h |   51 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 332b17e..9f27890 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -505,26 +505,59 @@ struct acpi_rasf_shared_memory {
 	u32 signature;
 	u16 command;
 	u16 status;
-	u64 requested_address;
-	u64 requested_length;
-	u64 actual_address;
-	u64 actual_length;
+	u16 version;
+	u8 capabilities[16];
+	u8 set_capabilities[16];
+	u16 num_parameter_blocks;
+	u32 set_capabilities_status;
+};
+
+/* RASF Parameter Block Structure Header */
+
+struct acpi_rasf_parameter_block {
+	u16 type;
+	u16 version;
+	u16 length;
+};
+
+/* RASF Parameter Block Structure for PATROL_SCRUB */
+
+struct acpi_rasf_patrol_scrub_parameter {
+	struct acpi_rasf_parameter_block header;
+	u16 patrol_scrub_command;
+	u64 requested_address_range[2];
+	u64 actual_address_range[2];
 	u16 flags;
-	u8 speed;
+	u8 requested_speed;
 };
 
 /* Masks for Flags and Speed fields above */
 
 #define ACPI_RASF_SCRUBBER_RUNNING      1
 #define ACPI_RASF_SPEED                 (7<<1)
+#define ACPI_RASF_SPEED_SLOW            (0<<1)
+#define ACPI_RASF_SPEED_MEDIUM          (4<<1)
+#define ACPI_RASF_SPEED_FAST            (7<<1)
 
 /* Channel Commands */
 
 enum acpi_rasf_commands {
-	ACPI_RASF_GET_RAS_CAPABILITIES = 1,
-	ACPI_RASF_GET_PATROL_PARAMETERS = 2,
-	ACPI_RASF_START_PATROL_SCRUBBER = 3,
-	ACPI_RASF_STOP_PATROL_SCRUBBER = 4
+	ACPI_RASF_EXECUTE_RASF_COMMAND = 1
+};
+
+/* Platform RAS Capabilities */
+
+enum acpi_rasf_capabiliities {
+	ACPI_HW_PATROL_SCRUB_SUPPORTED = 0,
+	ACPI_SW_PATROL_SCRUB_EXPOSED = 1
+};
+
+/* Patrol Scrub Commands */
+
+enum acpi_rasf_patrol_scrub_commands {
+	ACPI_RASF_GET_PATROL_PARAMETERS = 1,
+	ACPI_RASF_START_PATROL_SCRUBBER = 2,
+	ACPI_RASF_STOP_PATROL_SCRUBBER = 3
 };
 
 /* Channel Command flags */
-- 
1.7.10

