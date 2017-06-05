From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/53] ACPICA: Tables: Add WSMT support
Date: Mon,  5 Jun 2017 16:15:34 +0800
Message-ID: <8ce05d42a5a8ae5382d02cb13f8de54c7a88ad35.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:22836 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751423AbdFEIPv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:15:51 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 4f12387029c6a561e7792f53caf2e7f1f0ab2bbe

This patch adds WSMT support, the table can be found at Line [#1].
The support includes table structure definitions (ACPICA tables) and
assembly/disassembly (iasl) support. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/4f123870
Link: https://msdn.microsoft.com/windows/hardware/drivers/bringup/acpi-system-description-tables#wsmt [1]
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/actbl2.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index faa9f2c..724d9fc 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -87,6 +87,7 @@
 #define ACPI_SIG_WDAT           "WDAT"	/* Watchdog Action Table */
 #define ACPI_SIG_WDDT           "WDDT"	/* Watchdog Timer Description Table */
 #define ACPI_SIG_WDRT           "WDRT"	/* Watchdog Resource Table */
+#define ACPI_SIG_WSMT           "WSMT"	/* Windows SMM Security Migrations Table */
 #define ACPI_SIG_XXXX           "XXXX"	/* Intermediate AML header for ASL/ASL+ converter */
 
 #ifdef ACPI_UNDEFINED_TABLES
@@ -1498,6 +1499,27 @@ struct acpi_table_wdrt {
 	u8 units;
 };
 
+/*******************************************************************************
+ *
+ * WSMT - Windows SMM Security Migrations Table
+ *        Version 1
+ *
+ * Conforms to "Windows SMM Security Migrations Table",
+ * Version 1.0, April 18, 2016
+ *
+ ******************************************************************************/
+
+struct acpi_table_wsmt {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 protection_flags;
+};
+
+/* Flags for protection_flags field above */
+
+#define ACPI_WSMT_FIXED_COMM_BUFFERS                (1)
+#define ACPI_WSMT_COMM_BUFFER_NESTED_PTR_PROTECTION (2)
+#define ACPI_WSMT_SYSTEM_RESOURCE_PROTECTION        (4)
+
 /* Reset to default packing */
 
 #pragma pack()
-- 
2.7.4

