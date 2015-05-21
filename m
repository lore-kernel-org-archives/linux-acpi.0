From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/19] ACPICA: ACPI 6.0: Add support for STAO table.
Date: Thu, 21 May 2015 10:30:11 +0800
Message-ID: <09a19b5771617fd85ae5baafcd014d1d159013eb.1432175162.git.lv.zheng@intel.com>
References: <cover.1432175162.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1432175162.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 532bf402a503061afd9d80a23e1d3c8fd99b052c

_STA override table.

Link: https://github.com/acpica/acpica/commit/532bf402
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl3.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 440ca81..eb994e9 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -68,6 +68,7 @@
 #define ACPI_SIG_PCCT           "PCCT"	/* Platform Communications Channel Table */
 #define ACPI_SIG_PMTT           "PMTT"	/* Platform Memory Topology Table */
 #define ACPI_SIG_RASF           "RASF"	/* RAS Feature table */
+#define ACPI_SIG_STAO           "STAO"	/* Status Override table */
 #define ACPI_SIG_TPM2           "TPM2"	/* Trusted Platform Module 2.0 H/W interface table */
 
 #define ACPI_SIG_S3PT           "S3PT"	/* S3 Performance (sub)Table */
@@ -685,6 +686,21 @@ enum acpi_rasf_status {
 
 /*******************************************************************************
  *
+ * STAO - Status Override Table (_STA override) - ACPI 6.0
+ *        Version 1
+ *
+ * Conforms to "ACPI Specification for Status Override Table"
+ * 6 January 2015
+ *
+ ******************************************************************************/
+
+struct acpi_table_stao {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u8 ignore_uart;
+};
+
+/*******************************************************************************
+ *
  * TPM2 - Trusted Platform Module (TPM) 2.0 Hardware Interface Table
  *        Version 3
  *
-- 
1.7.10
