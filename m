From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/19] ACPICA: ACPI 6.0: Add support for XENV table.
Date: Thu, 21 May 2015 10:30:24 +0800
Message-ID: <6b764bb02815a429a650d4013cf85e74389497e4.1432175162.git.lv.zheng@intel.com>
References: <cover.1432175162.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1432175162.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 08c4197cf4ddd45f0c961078220b0fc19c10745c

Xen Environment table.

Link: https://github.com/acpica/acpica/commit/08c4197c
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl3.h |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index eb994e9..3eed4c8 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -70,6 +70,7 @@
 #define ACPI_SIG_RASF           "RASF"	/* RAS Feature table */
 #define ACPI_SIG_STAO           "STAO"	/* Status Override table */
 #define ACPI_SIG_TPM2           "TPM2"	/* Trusted Platform Module 2.0 H/W interface table */
+#define ACPI_SIG_XENV           "XENV"	/* Xen Environment table */
 
 #define ACPI_SIG_S3PT           "S3PT"	/* S3 Performance (sub)Table */
 #define ACPI_SIG_PCCS           "PCC"	/* PCC Shared Memory Region */
@@ -729,6 +730,23 @@ struct acpi_tpm2_control {
 	u64 response_address;
 };
 
+/*******************************************************************************
+ *
+ * XENV - Xen Environment Table (ACPI 6.0)
+ *        Version 1
+ *
+ * Conforms to "ACPI Specification for Xen Environment Table" 4 January 2015
+ *
+ ******************************************************************************/
+
+struct acpi_table_xenv {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u64 grant_table_address;
+	u64 grant_table_size;
+	u32 event_interrupt;
+	u8 event_flags;
+};
+
 /* Reset to default packing */
 
 #pragma pack()
-- 
1.7.10
