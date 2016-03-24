From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/30] ACPICA: iASL/Headers: Fix incorrect definition of FPDT table
Date: Thu, 24 Mar 2016 09:39:44 +0800
Message-ID: <84d9ab851afb9bdb89b847f3f2b43d54524c12c2.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit f30ba83711bcb860f9b17dd36d0bcc5242a4ef91

ACPICA BZ 1249.

Link: https://github.com/acpica/acpica/commit/f30ba837
Link: https://bugs.acpica.org/show_bug.cgi?id=1249
Reported-by: Greg Elkin <greg.elkin@ericsson.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl3.h |   43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index ddf5e66..f12f4bb 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -184,7 +184,7 @@ struct acpi_table_fpdt {
 	struct acpi_table_header header;	/* Common ACPI table header */
 };
 
-/* FPDT subtable header */
+/* FPDT subtable header (Performance Record Structure) */
 
 struct acpi_fpdt_header {
 	u16 type;
@@ -205,19 +205,15 @@ enum acpi_fpdt_type {
 
 /* 0: Firmware Basic Boot Performance Record */
 
-struct acpi_fpdt_boot {
+struct acpi_fpdt_boot_pointer {
 	struct acpi_fpdt_header header;
 	u8 reserved[4];
-	u64 reset_end;
-	u64 load_start;
-	u64 startup_start;
-	u64 exit_services_entry;
-	u64 exit_services_exit;
+	u64 address;
 };
 
 /* 1: S3 Performance Table Pointer Record */
 
-struct acpi_fpdt_s3pt_ptr {
+struct acpi_fpdt_s3pt_pointer {
 	struct acpi_fpdt_header header;
 	u8 reserved[4];
 	u64 address;
@@ -225,7 +221,7 @@ struct acpi_fpdt_s3pt_ptr {
 
 /*
  * S3PT - S3 Performance Table. This table is pointed to by the
- * FPDT S3 Pointer Record above.
+ * S3 Pointer Record above.
  */
 struct acpi_table_s3pt {
 	u8 signature[4];	/* "S3PT" */
@@ -233,34 +229,43 @@ struct acpi_table_s3pt {
 };
 
 /*
- * S3PT Subtables
+ * S3PT Subtables (Not part of the actual FPDT)
  */
-struct acpi_s3pt_header {
-	u16 type;
-	u8 length;
-	u8 revision;
-};
 
-/* Values for Type field above */
+/* Values for Type field in S3PT header */
 
 enum acpi_s3pt_type {
 	ACPI_S3PT_TYPE_RESUME = 0,
-	ACPI_S3PT_TYPE_SUSPEND = 1
+	ACPI_S3PT_TYPE_SUSPEND = 1,
+	ACPI_FPDT_BOOT_PERFORMANCE = 2
 };
 
 struct acpi_s3pt_resume {
-	struct acpi_s3pt_header header;
+	struct acpi_fpdt_header header;
 	u32 resume_count;
 	u64 full_resume;
 	u64 average_resume;
 };
 
 struct acpi_s3pt_suspend {
-	struct acpi_s3pt_header header;
+	struct acpi_fpdt_header header;
 	u64 suspend_start;
 	u64 suspend_end;
 };
 
+/*
+ * FPDT Boot Performance Record (Not part of the actual FPDT)
+ */
+struct acpi_fpdt_boot {
+	struct acpi_fpdt_header header;
+	u8 reserved[4];
+	u64 reset_end;
+	u64 load_start;
+	u64 startup_start;
+	u64 exit_services_entry;
+	u64 exit_services_exit;
+};
+
 /*******************************************************************************
  *
  * GTDT - Generic Timer Description Table (ACPI 5.1)
-- 
1.7.10
