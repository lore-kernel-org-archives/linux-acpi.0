From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/30] ACPICA: Tables: Update FADT handling
Date: Thu, 24 Mar 2016 09:39:28 +0800
Message-ID: <c8bf7944504c44a03948c5beda52832c90c32291.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit bca0c4cb063ee488c543e6f160fe89679a2338d6

Update a warning message
simplify versioning for "table too big" case.

Link: https://github.com/acpica/acpica/commit/bca0c4cb
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbfadt.c |   18 +++++++++++-------
 include/acpi/actbl.h         |    4 +++-
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index a79e4f3..f63f3fd 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -385,14 +385,15 @@ void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
 {
 	/*
 	 * Check if the FADT is larger than the largest table that we expect
-	 * (the ACPI 5.0 version). If so, truncate the table, and issue
-	 * a warning.
+	 * (typically the current ACPI specification version). If so, truncate
+	 * the table, and issue a warning.
 	 */
 	if (length > sizeof(struct acpi_table_fadt)) {
 		ACPI_BIOS_WARNING((AE_INFO,
-				   "FADT (revision %u) is longer than ACPI 5.0 version, "
+				   "FADT (revision %u) is longer than %s length, "
 				   "truncating length %u to %u",
-				   table->revision, length,
+				   table->revision, ACPI_FADT_CONFORMANCE,
+				   length,
 				   (u32)sizeof(struct acpi_table_fadt)));
 	}
 
@@ -646,9 +647,12 @@ static void acpi_tb_convert_fadt(void)
 			if ((address64->address && !length) ||
 			    (!address64->address && length)) {
 				ACPI_BIOS_WARNING((AE_INFO,
-						   "Optional FADT field %s has zero address or length: "
-						   "0x%8.8X%8.8X/0x%X",
-						   name,
+						   "Optional FADT field %s has valid %s but zero %s: "
+						   "0x%8.8X%8.8X/0x%X", name,
+						   (length ? "Length" :
+						    "Address"),
+						   (length ? "Address" :
+						    "Length"),
 						   ACPI_FORMAT_UINT64
 						   (address64->address),
 						   length));
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 0cb1a00..c19700e 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -223,7 +223,7 @@ struct acpi_table_facs {
 /*******************************************************************************
  *
  * FADT - Fixed ACPI Description Table (Signature "FACP")
- *        Version 4
+ *        Version 6
  *
  ******************************************************************************/
 
@@ -413,4 +413,6 @@ struct acpi_table_desc {
 #define ACPI_FADT_V5_SIZE       (u32) (ACPI_FADT_OFFSET (hypervisor_id))
 #define ACPI_FADT_V6_SIZE       (u32) (sizeof (struct acpi_table_fadt))
 
+#define ACPI_FADT_CONFORMANCE   "ACPI 6.1 (FADT version 6)"
+
 #endif				/* __ACTBL_H__ */
-- 
1.7.10
