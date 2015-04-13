From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 27/31] ACPICA: Update for SLIC ACPI table.
Date: Mon, 13 Apr 2015 11:51:02 +0800
Message-ID: <8ef6e63fe3c935751666d058f559652b50099794.1428893938.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit c73195e13d6ad53dd7f03f86cea03c7dec72ffd3

Update to latest table definition, which contains major changes.

SLIC table is not used in the Linux kernel.

Link: https://github.com/acpica/acpica/commit/c73195e1
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl2.h |   52 +++----------------------------------------------
 1 file changed, 3 insertions(+), 49 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index f06d75e..df729bf 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -959,10 +959,10 @@ struct acpi_mtmr_entry {
 /*******************************************************************************
  *
  * SLIC - Software Licensing Description Table
- *        Version 1
  *
- * Conforms to "OEM Activation 2.0 for Windows Vista Operating Systems",
- * Copyright 2006
+ * Conforms to "Microsoft Software Licensing Tables (SLIC and MSDM)",
+ * November 29, 2011
+ * Copyright 2011 Microsoft
  *
  ******************************************************************************/
 
@@ -972,52 +972,6 @@ struct acpi_table_slic {
 	struct acpi_table_header header;	/* Common ACPI table header */
 };
 
-/* Common SLIC subtable header */
-
-struct acpi_slic_header {
-	u32 type;
-	u32 length;
-};
-
-/* Values for Type field above */
-
-enum acpi_slic_type {
-	ACPI_SLIC_TYPE_PUBLIC_KEY = 0,
-	ACPI_SLIC_TYPE_WINDOWS_MARKER = 1,
-	ACPI_SLIC_TYPE_RESERVED = 2	/* 2 and greater are reserved */
-};
-
-/*
- * SLIC Subtables, correspond to Type in struct acpi_slic_header
- */
-
-/* 0: Public Key Structure */
-
-struct acpi_slic_key {
-	struct acpi_slic_header header;
-	u8 key_type;
-	u8 version;
-	u16 reserved;
-	u32 algorithm;
-	char magic[4];
-	u32 bit_length;
-	u32 exponent;
-	u8 modulus[128];
-};
-
-/* 1: Windows Marker Structure */
-
-struct acpi_slic_marker {
-	struct acpi_slic_header header;
-	u32 version;
-	char oem_id[ACPI_OEM_ID_SIZE];	/* ASCII OEM identification */
-	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];	/* ASCII OEM table identification */
-	char windows_flag[8];
-	u32 slic_version;
-	u8 reserved[16];
-	u8 signature[128];
-};
-
 /*******************************************************************************
  *
  * SPCR - Serial Port Console Redirection table
-- 
1.7.10
