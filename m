From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/28] ACPICA: Disassembler: Add decoding of Notify() values.
Date: Fri,  4 Apr 2014 12:37:44 +0800
Message-ID: <1df6a00760c5da6fc93cf7bb083500503b570483.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22179 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbaDDEhr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:37:47 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

For Notify operators, displays a comment that describe the meaning
of the notify value.

This patch updates the debugging information that is enabled for
CONFIG_ACPI_DEBUG builds.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acutils.h  |    3 +-
 drivers/acpi/acpica/evmisc.c   |    3 +-
 drivers/acpi/acpica/utdecode.c |   74 ++++++++++++++++++++++++++++++++++------
 3 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 5328610..2cf8d2c 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -176,8 +176,7 @@ acpi_status acpi_ut_init_globals(void);
 
 char *acpi_ut_get_mutex_name(u32 mutex_id);
 
-const char *acpi_ut_get_notify_name(u32 notify_value);
-
+const char *acpi_ut_get_notify_name(u32 notify_value, acpi_object_type type);
 #endif
 
 char *acpi_ut_get_type_name(acpi_object_type type);
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index 5d594eb..24ea342 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -167,7 +167,8 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
 			  "Dispatching Notify on [%4.4s] (%s) Value 0x%2.2X (%s) Node %p\n",
 			  acpi_ut_get_node_name(node),
 			  acpi_ut_get_type_name(node->type), notify_value,
-			  acpi_ut_get_notify_name(notify_value), node));
+			  acpi_ut_get_notify_name(notify_value, ACPI_TYPE_ANY),
+			  node));
 
 	status = acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_ev_notify_dispatch,
 				 info);
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index fbfa9ec..90ec37c 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -462,7 +462,7 @@ char *acpi_ut_get_mutex_name(u32 mutex_id)
 
 /* Names for Notify() values, used for debug output */
 
-static const char *acpi_gbl_notify_value_names[ACPI_NOTIFY_MAX + 1] = {
+static const char *acpi_gbl_generic_notify[ACPI_NOTIFY_MAX + 1] = {
 	/* 00 */ "Bus Check",
 	/* 01 */ "Device Check",
 	/* 02 */ "Device Wake",
@@ -473,23 +473,75 @@ static const char *acpi_gbl_notify_value_names[ACPI_NOTIFY_MAX + 1] = {
 	/* 07 */ "Power Fault",
 	/* 08 */ "Capabilities Check",
 	/* 09 */ "Device PLD Check",
-	/* 10 */ "Reserved",
-	/* 11 */ "System Locality Update",
-	/* 12 */ "Shutdown Request"
+	/* 0A */ "Reserved",
+	/* 0B */ "System Locality Update",
+	/* 0C */ "Shutdown Request"
 };
 
-const char *acpi_ut_get_notify_name(u32 notify_value)
+static const char *acpi_gbl_device_notify[4] = {
+	/* 80 */ "Status Change",
+	/* 81 */ "Information Change",
+	/* 82 */ "Device-Specific Change",
+	/* 83 */ "Device-Specific Change"
+};
+
+static const char *acpi_gbl_processor_notify[4] = {
+	/* 80 */ "Performance Capability Change",
+	/* 81 */ "C-State Change",
+	/* 82 */ "Throttling Capability Change",
+	/* 83 */ "Device-Specific Change"
+};
+
+static const char *acpi_gbl_thermal_notify[4] = {
+	/* 80 */ "Thermal Status Change",
+	/* 81 */ "Thermal Trip Point Change",
+	/* 82 */ "Thermal Device List Change",
+	/* 83 */ "Thermal Relationship Change"
+};
+
+const char *acpi_ut_get_notify_name(u32 notify_value, acpi_object_type type)
 {
 
+	/* 00 - 0C are common to all object types */
+
 	if (notify_value <= ACPI_NOTIFY_MAX) {
-		return (acpi_gbl_notify_value_names[notify_value]);
-	} else if (notify_value <= ACPI_MAX_SYS_NOTIFY) {
+		return (acpi_gbl_generic_notify[notify_value]);
+	}
+
+	/* 0D - 7F are reserved */
+
+	if (notify_value <= ACPI_MAX_SYS_NOTIFY) {
 		return ("Reserved");
-	} else if (notify_value <= ACPI_MAX_DEVICE_SPECIFIC_NOTIFY) {
-		return ("Device Specific");
-	} else {
-		return ("Hardware Specific");
 	}
+
+	/* 80 - 83 are per-object-type */
+
+	if (notify_value <= 0x83) {
+		switch (type) {
+		case ACPI_TYPE_ANY:
+		case ACPI_TYPE_DEVICE:
+			return (acpi_gbl_device_notify[notify_value - 0x80]);
+
+		case ACPI_TYPE_PROCESSOR:
+			return (acpi_gbl_processor_notify[notify_value - 0x80]);
+
+		case ACPI_TYPE_THERMAL:
+			return (acpi_gbl_thermal_notify[notify_value - 0x80]);
+
+		default:
+			return ("Target object type does not support notifies");
+		}
+	}
+
+	/* 84 - BF are device-specific */
+
+	if (notify_value <= ACPI_MAX_DEVICE_SPECIFIC_NOTIFY) {
+		return ("Device-Specific");
+	}
+
+	/* C0 and above are hardware-specific */
+
+	return ("Hardware-Specific");
 }
 #endif
 
-- 
1.7.10

