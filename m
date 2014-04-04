From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/28] ACPICA: Disassembler: Add support to decode _HID and _CID values.
Date: Fri,  4 Apr 2014 12:37:35 +0800
Message-ID: <5f8f55fca826849d41feb8c3ef860747a6e3dd18.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27544 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbaDDEhj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:37:39 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

For _HID and _CID, the disassembler will emit a string that describes
the device if the _HID/_CID value is recognized. acpihelp updated also.
acpihelp will now search for a specific ID as well as displaying
the list of "known" (to ACPICA) IDs.

This patch does not affect Linux kernel behavior as the disassembler
and the acpihelp are not shipped in Linux kernel.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    1 +
 drivers/acpi/acpica/aclocal.h  |    8 +++++++-
 drivers/acpi/acpica/acutils.h  |    7 +++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 11ce629..71bb5b5 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -509,5 +509,6 @@ ACPI_INIT_GLOBAL(ACPI_FILE, acpi_gbl_debug_file, NULL);
  ****************************************************************************/
 
 extern const struct ah_predefined_name asl_predefined_info[];
+extern const AH_DEVICE_ID asl_device_ids[];
 
 #endif				/* __ACGLOBAL_H__ */
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 52a21da..f68cb60 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -733,7 +733,8 @@ union acpi_parse_value {
 #define ACPI_DASM_MATCHOP               0x06	/* Parent opcode is a Match() operator */
 #define ACPI_DASM_LNOT_PREFIX           0x07	/* Start of a Lnot_equal (etc.) pair of opcodes */
 #define ACPI_DASM_LNOT_SUFFIX           0x08	/* End  of a Lnot_equal (etc.) pair of opcodes */
-#define ACPI_DASM_IGNORE                0x09	/* Not used at this time */
+#define ACPI_DASM_HID_STRING            0x09	/* String is a _HID or _CID */
+#define ACPI_DASM_IGNORE                0x0A	/* Not used at this time */
 
 /*
  * Generic operation (for example:  If, While, Store)
@@ -1147,4 +1148,9 @@ struct ah_predefined_name {
 #endif
 };
 
+struct ah_device_id {
+	char *name;
+	char *description;
+};
+
 #endif				/* __ACLOCAL_H__ */
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index ceeec0b..5328610 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -737,4 +737,11 @@ acpi_ut_method_error(const char *module_name,
 		     struct acpi_namespace_node *node,
 		     const char *path, acpi_status lookup_status);
 
+/*
+ * Utility functions for ACPI names and IDs
+ */
+const struct ah_predefined_name *acpi_ah_match_predefined_name(char *nameseg);
+
+const AH_DEVICE_ID *acpi_ah_match_hardware_id(char *hid);
+
 #endif				/* _ACUTILS_H */
-- 
1.7.10

