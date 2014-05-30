From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/2] ACPICA: Tables: Add mechanism to control early table checksum verification.
Date: Fri, 30 May 2014 10:07:31 +0800
Message-ID: <e28682572e0736657b0120aeec5f64ac21159faf.1401415540.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8280 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbaE3CHp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 May 2014 22:07:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, lkp@vger.linux-kernel.cn, x86@kernel.org

The following regression is reported when the table length is very large:
 WARNING: CPU: 0 PID: 0 at mm/early_ioremap.c:136 __early_ioremap+0x11f/0x1f2()
 Modules linked in:
 CPU: 0 PID: 0 Comm: swapper Not tainted 3.15.0-rc1-00017-g86dfc6f3-dirty #298
 Hardware name: Intel Corporation S2600CP/S2600CP, BIOS SE5C600.86B.99.99.x036.091920111209 09/19/2011
  0000000000000009 ffffffff81b75c40 ffffffff817c627b 0000000000000000
  ffffffff81b75c78 ffffffff81067b5d 000000000000007b 8000000000000563
  00000000b96b20dc 0000000000000001 ffffffffff300e0c ffffffff81b75c88
 Call Trace:
  [<ffffffff817c627b>] dump_stack+0x45/0x56
  [<ffffffff81067b5d>] warn_slowpath_common+0x7d/0xa0
  [<ffffffff81067c3a>] warn_slowpath_null+0x1a/0x20
  [<ffffffff81d4b9d5>] __early_ioremap+0x11f/0x1f2
  [<ffffffff81d4bc5b>] early_ioremap+0x13/0x15
  [<ffffffff81d2b8f3>] __acpi_map_table+0x13/0x18
  [<ffffffff817b8d1a>] acpi_os_map_memory+0x26/0x14e
  [<ffffffff813ff018>] acpi_tb_acquire_table+0x42/0x70
  [<ffffffff813ff086>] acpi_tb_validate_table+0x27/0x37
  [<ffffffff813ff0e5>] acpi_tb_verify_table+0x22/0xd8
  [<ffffffff813ff6a8>] acpi_tb_install_non_fixed_table+0x60/0x1c9
  [<ffffffff81d61024>] acpi_tb_parse_root_table+0x218/0x26a
  [<ffffffff81d1b120>] ? early_idt_handlers+0x120/0x120
  [<ffffffff81d610cd>] acpi_initialize_tables+0x57/0x59
  [<ffffffff81d5f25d>] acpi_table_init+0x1b/0x99
  [<ffffffff81d2bca0>] acpi_boot_table_init+0x1e/0x85
  [<ffffffff81d23043>] setup_arch+0x99d/0xcc6
  [<ffffffff81d1b120>] ? early_idt_handlers+0x120/0x120
  [<ffffffff81d1bbbe>] start_kernel+0x8b/0x415
  [<ffffffff81d1b120>] ? early_idt_handlers+0x120/0x120
  [<ffffffff81d1b5ee>] x86_64_start_reservations+0x2a/0x2c
  [<ffffffff81d1b72e>] x86_64_start_kernel+0x13e/0x14d
 ---[ end trace 11ae599a1898f4e7 ]---
This is due to the size limitation of the x86 early IO mapping.
There is a large SSDT table on such platform that exceeds this limitation:
 ACPI: SSDT 0x00000000B9638018 07A0C4 (v02 INTEL  S2600CP  00004000 INTL 20100331)

It sounds strange that in the 64-bit virtual memory address space, we
cannot map a single ACPI table to do checksum verification. The root cause
is:
1. ACPICA doesn't split IO memory mapping and table mapping;
2. Linux x86 OSL implements acpi_os_map_memory() using a size limited fix-map
   mechanism during early boot stage, which is more suitable for only IO
   mappings.

ACPICA originally only mapped table header for signature validation, and
this header mapping is required by OSL override mechanism. There was no
checksum verification because we could not map the whole table using this
OSL. While the following ACPICA commit enforces checksum verification by
mapping the whole table during Linux boot stage and it finally triggers
this issue on some platforms:
  Commit: 86dfc6f339886559d80ee0d4bd20fe5ee90450f0
  Subject: ACPICA: Tables: Fix table checksums verification before installation.

Before doing further cleanups for the OSL table mapping and override
implementation, this patch introduces an option for such OSPMs to
temporarily discard the checksum verification feature. It then can be
re-enabled easily when the ACPICA and the underlying OSL is ready.

This patch also deletes a comment around the limitation of mappings because
it is not correct. The limitation is not how many times we can map in the
early stage, but the OSL mapping facility may not be suitable for mapping
the ACPI tables and thus may complain us the size limitation.

The acpi_tb_verify_table() is renamed to acpi_tb_verify_temp_table() due to the
work around added, it now only applies to the table descriptor that hasn't
been installed and cannot be used in other cases. Lv Zheng.

[zetalog: on top of linux-pm.git/linux-next]
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Reported-and-tested-by: Yuanhan Liu <yuanhan.liu@linux.intel.com>
Cc: <lkp@vger.linux-kernel.cn>
Cc: <x86@kernel.org>
---
 drivers/acpi/acpica/actables.h |    8 +++--
 drivers/acpi/acpica/tbdata.c   |   67 +++++++++++++++++++++++++++++++---------
 drivers/acpi/acpica/tbinstal.c |    8 ++---
 drivers/acpi/acpica/tbutils.c  |    4 ---
 include/acpi/acpixf.h          |    8 +++++
 5 files changed, 69 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index bda9a7e..f148827 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -69,6 +69,11 @@ acpi_tb_acquire_temp_table(struct acpi_table_desc *table_desc,
 
 void acpi_tb_release_temp_table(struct acpi_table_desc *table_desc);
 
+acpi_status acpi_tb_validate_temp_table(struct acpi_table_desc *table_desc);
+
+acpi_status
+acpi_tb_verify_temp_table(struct acpi_table_desc *table_desc, char *signature);
+
 u8 acpi_tb_is_table_loaded(u32 table_index);
 
 void acpi_tb_set_table_loaded_flag(u32 table_index, u8 is_loaded);
@@ -96,9 +101,6 @@ acpi_status acpi_tb_validate_table(struct acpi_table_desc *table_desc);
 
 void acpi_tb_invalidate_table(struct acpi_table_desc *table_desc);
 
-acpi_status
-acpi_tb_verify_table(struct acpi_table_desc *table_desc, char *signature);
-
 void acpi_tb_override_table(struct acpi_table_desc *old_table_desc);
 
 acpi_status
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index cbe2994..f499c10 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -322,7 +322,39 @@ void acpi_tb_invalidate_table(struct acpi_table_desc *table_desc)
 
 /******************************************************************************
  *
- * FUNCTION:    acpi_tb_verify_table
+ * FUNCTION:    acpi_tb_validate_temp_table
+ *
+ * PARAMETERS:  table_desc          - Table descriptor
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: This function is called to validate the table, the returned
+ *              table descriptor is in "VALIDATED" state.
+ *
+ *****************************************************************************/
+
+acpi_status acpi_tb_validate_temp_table(struct acpi_table_desc *table_desc)
+{
+
+	if (!table_desc->pointer && !acpi_gbl_verify_table_checksum) {
+		/*
+		 * Only validates the header of the table.
+		 * Note that Length contains the size of the mapping after invoking
+		 * this work around, this value is required by
+		 * acpi_tb_release_temp_table().
+		 * We can do this because in acpi_init_table_descriptor(), the Length
+		 * field of the installed descriptor is filled with the actual
+		 * table length obtaining from the table header.
+		 */
+		table_desc->length = sizeof(struct acpi_table_header);
+	}
+
+	return (acpi_tb_validate_table(table_desc));
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_verify_temp_table
  *
  * PARAMETERS:  table_desc          - Table descriptor
  *              signature           - Table signature to verify
@@ -335,15 +367,15 @@ void acpi_tb_invalidate_table(struct acpi_table_desc *table_desc)
  *****************************************************************************/
 
 acpi_status
-acpi_tb_verify_table(struct acpi_table_desc *table_desc, char *signature)
+acpi_tb_verify_temp_table(struct acpi_table_desc * table_desc, char *signature)
 {
 	acpi_status status = AE_OK;
 
-	ACPI_FUNCTION_TRACE(tb_verify_table);
+	ACPI_FUNCTION_TRACE(tb_verify_temp_table);
 
 	/* Validate the table */
 
-	status = acpi_tb_validate_table(table_desc);
+	status = acpi_tb_validate_temp_table(table_desc);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
@@ -360,17 +392,22 @@ acpi_tb_verify_table(struct acpi_table_desc *table_desc, char *signature)
 
 	/* Verify the checksum */
 
-	status =
-	    acpi_tb_verify_checksum(table_desc->pointer, table_desc->length);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, AE_NO_MEMORY,
-				"%4.4s " ACPI_PRINTF_UINT
-				" Attempted table install failed",
-				acpi_ut_valid_acpi_name(table_desc->signature.
-							ascii) ? table_desc->
-				signature.ascii : "????",
-				ACPI_FORMAT_TO_UINT(table_desc->address)));
-		goto invalidate_and_exit;
+	if (acpi_gbl_verify_table_checksum) {
+		status =
+		    acpi_tb_verify_checksum(table_desc->pointer,
+					    table_desc->length);
+		if (ACPI_FAILURE(status)) {
+			ACPI_EXCEPTION((AE_INFO, AE_NO_MEMORY,
+					"%4.4s " ACPI_PRINTF_UINT
+					" Attempted table install failed",
+					acpi_ut_valid_acpi_name(table_desc->
+								signature.
+								ascii) ?
+					table_desc->signature.ascii : "????",
+					ACPI_FORMAT_TO_UINT(table_desc->
+							    address)));
+			goto invalidate_and_exit;
+		}
 	}
 
 	return_ACPI_STATUS(AE_OK);
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index d4d6029..755b90c 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -194,7 +194,7 @@ acpi_tb_install_fixed_table(acpi_physical_address address,
 
 	/* Validate and verify a table before installation */
 
-	status = acpi_tb_verify_table(&new_table_desc, signature);
+	status = acpi_tb_verify_temp_table(&new_table_desc, signature);
 	if (ACPI_FAILURE(status)) {
 		goto release_and_exit;
 	}
@@ -266,7 +266,7 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 
 	/* Validate and verify a table before installation */
 
-	status = acpi_tb_verify_table(&new_table_desc, NULL);
+	status = acpi_tb_verify_temp_table(&new_table_desc, NULL);
 	if (ACPI_FAILURE(status)) {
 		goto release_and_exit;
 	}
@@ -424,7 +424,7 @@ finish_override:
 
 	/* Validate and verify a table before overriding */
 
-	status = acpi_tb_verify_table(&new_table_desc, NULL);
+	status = acpi_tb_verify_temp_table(&new_table_desc, NULL);
 	if (ACPI_FAILURE(status)) {
 		return;
 	}
@@ -446,7 +446,7 @@ finish_override:
 	acpi_tb_init_table_descriptor(old_table_desc, new_table_desc.address,
 				      new_table_desc.flags,
 				      new_table_desc.pointer);
-	acpi_tb_validate_table(old_table_desc);
+	acpi_tb_validate_temp_table(old_table_desc);
 
 	/* Release the temporary table descriptor */
 
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index e37a103..6b1ca99 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -395,10 +395,6 @@ next_table:
 		table_entry += table_entry_size;
 	}
 
-	/*
-	 * It is not possible to map more than one entry in some environments,
-	 * so unmap the root table here before mapping other tables
-	 */
 	acpi_os_unmap_memory(table, length);
 
 	return_ACPI_STATUS(AE_OK);
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index b5f7132..380828d 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -162,6 +162,14 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_create_osi_method, TRUE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_use_default_register_widths, TRUE);
 
 /*
+ * Optionally verify the table checksum before installation. Set this to
+ * TRUE to verify the table checksum before install it to the table
+ * manager. Note that some OSPMs cannot do large mappings during the
+ * certain stages. Default is behavior is to do such verification.
+ */
+ACPI_INIT_GLOBAL(u8, acpi_gbl_verify_table_checksum, TRUE);
+
+/*
  * Optionally enable output from the AML Debug Object.
  */
 ACPI_INIT_GLOBAL(u8, acpi_gbl_enable_aml_debug_object, FALSE);
-- 
1.7.10

