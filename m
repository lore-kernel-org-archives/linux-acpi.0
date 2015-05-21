From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/19] ACPICA: ACPI 6.0: Add support for WPBT table.
Date: Thu, 21 May 2015 10:30:44 +0800
Message-ID: <5424cd968228b82495238c6ce4b46874a632bd4b.1432175162.git.lv.zheng@intel.com>
References: <cover.1432175162.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1432175162.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit a6ccb4033b49f7aa33a17ddc41dd69d57e799fbd

Windows Platform Binary Table.

Link: https://github.com/acpica/acpica/commit/a6ccb403
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl3.h |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 3eed4c8..e1aac82 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -70,6 +70,7 @@
 #define ACPI_SIG_RASF           "RASF"	/* RAS Feature table */
 #define ACPI_SIG_STAO           "STAO"	/* Status Override table */
 #define ACPI_SIG_TPM2           "TPM2"	/* Trusted Platform Module 2.0 H/W interface table */
+#define ACPI_SIG_WPBT           "WPBT"	/* Windows Platform Binary Table */
 #define ACPI_SIG_XENV           "XENV"	/* Xen Environment table */
 
 #define ACPI_SIG_S3PT           "S3PT"	/* S3 Performance (sub)Table */
@@ -79,7 +80,6 @@
 
 #define ACPI_SIG_MATR           "MATR"	/* Memory Address Translation Table */
 #define ACPI_SIG_MSDM           "MSDM"	/* Microsoft Data Management Table */
-#define ACPI_SIG_WPBT           "WPBT"	/* Windows Platform Binary Table */
 
 /*
  * All tables must be byte-packed to match the ACPI specification, since
@@ -732,6 +732,24 @@ struct acpi_tpm2_control {
 
 /*******************************************************************************
  *
+ * WPBT - Windows Platform Environment Table (ACPI 6.0)
+ *        Version 1
+ *
+ * Conforms to "Windows Platform Binary Table (WPBT)" 29 November 2011
+ *
+ ******************************************************************************/
+
+struct acpi_table_wpbt {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 handoff_size;
+	u64 handoff_address;
+	u8 layout;
+	u8 type;
+	u16 arguments_length;
+};
+
+/*******************************************************************************
+ *
  * XENV - Xen Environment Table (ACPI 6.0)
  *        Version 1
  *
-- 
1.7.10
