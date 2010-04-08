From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA Release 20100331 linuxized patches
Date: Thu, 08 Apr 2010 15:12:10 +0800
Message-ID: <1270710730.3473.34.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Nhb8sZ8towgswlRkuPB+"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:55255 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758338Ab0DHHai (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Apr 2010 03:30:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>


--=-Nhb8sZ8towgswlRkuPB+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi, Len

This patch series applied cleanly on top of your acpi/test branch.
Build and test on my machine and it works well.

[PATCH 1/9] ACPICA: Update comments/headers, no functional change
[PATCH 2/9] ACPICA: Fix for acpi_reallocate_root_table for incorrect root table copy
[PATCH 3/9] ACPICA: Add write support for DataTable operation regions
[PATCH 4/9] ACPICA: Add detection of corrupted/replaced DSDT
[PATCH 5/9] ACPICA: Add subsystem option to force copy of DSDT to local memory
[PATCH 6/9] ACPICA: Update DSDT copy/detection.
[PATCH 7/9] ACPI: add boot option acpi=copy_dsdt to fix corrupt DSDT
[PATCH 8/9] ACPICA: Minimize the differences between linux GPE code and ACPICA code base
[PATCH 9/9] ACPICA: Update version to 20100331.

Patch 7 includes the acpi=copy_dsdt option, DMI backlist and customized
ACPICA warning message for corrupt DSDT workaround (bug 14679).

Lin Ming


--=-Nhb8sZ8towgswlRkuPB+
Content-Disposition: attachment; filename="acpica-v20100331.patch"
Content-Type: text/x-patch; name="acpica-v20100331.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From d900de0dfc3822022aa68ad1f9d33fe99c75b86a Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 1 Apr 2010 11:04:54 +0800
Subject: [PATCH 1/9] ACPICA: Update comments/headers, no functional change

Also split some long lines.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/exmutex.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index bb2efcf..f73be97 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -85,10 +85,10 @@ void acpi_ex_unlink_mutex(union acpi_operand_object *obj_desc)
 		(obj_desc->mutex.prev)->mutex.next = obj_desc->mutex.next;
 
 		/*
-		 * Migrate the previous sync level associated with this mutex to the
-		 * previous mutex on the list so that it may be preserved. This handles
-		 * the case where several mutexes have been acquired at the same level,
-		 * but are not released in opposite order.
+		 * Migrate the previous sync level associated with this mutex to
+		 * the previous mutex on the list so that it may be preserved.
+		 * This handles the case where several mutexes have been acquired
+		 * at the same level, but are not released in opposite order.
 		 */
 		(obj_desc->mutex.prev)->mutex.original_sync_level =
 		    obj_desc->mutex.original_sync_level;
@@ -101,8 +101,8 @@ void acpi_ex_unlink_mutex(union acpi_operand_object *obj_desc)
  *
  * FUNCTION:    acpi_ex_link_mutex
  *
- * PARAMETERS:  obj_desc        - The mutex to be linked
- *              Thread          - Current executing thread object
+ * PARAMETERS:  obj_desc            - The mutex to be linked
+ *              Thread              - Current executing thread object
  *
  * RETURN:      None
  *
@@ -138,9 +138,9 @@ acpi_ex_link_mutex(union acpi_operand_object *obj_desc,
  *
  * FUNCTION:    acpi_ex_acquire_mutex_object
  *
- * PARAMETERS:  time_desc           - Timeout in milliseconds
+ * PARAMETERS:  Timeout             - Timeout in milliseconds
  *              obj_desc            - Mutex object
- *              Thread              - Current thread state
+ *              thread_id           - Current thread state
  *
  * RETURN:      Status
  *
@@ -234,7 +234,7 @@ acpi_ex_acquire_mutex(union acpi_operand_object *time_desc,
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Must have a valid thread ID */
+	/* Must have a valid thread state struct */
 
 	if (!walk_state->thread) {
 		ACPI_ERROR((AE_INFO,
@@ -435,6 +435,7 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 
 		owner_thread->current_sync_level = previous_sync_level;
 	}
+
 	return_ACPI_STATUS(status);
 }
 
@@ -442,7 +443,7 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
  *
  * FUNCTION:    acpi_ex_release_all_mutexes
  *
- * PARAMETERS:  Thread          - Current executing thread object
+ * PARAMETERS:  Thread              - Current executing thread object
  *
  * RETURN:      Status
  *

>From 50ec566ee569d9890b47de5bf17b27f208eaa647 Mon Sep 17 00:00:00 2001
From: Alexey Starikovskiy <astarikovskiy@suse.de>
Date: Thu, 1 Apr 2010 11:06:34 +0800
Subject: [PATCH 2/9] ACPICA: Fix for acpi_reallocate_root_table for incorrect root table copy

When copying the root table to the new allocation, the length
used was incorrect. The new size was used instead of the current
table size, meaning too much data was copied.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/tbxface.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 5217a61..684614d 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -172,6 +172,7 @@ acpi_status acpi_reallocate_root_table(void)
 {
 	struct acpi_table_desc *tables;
 	acpi_size new_size;
+	acpi_size current_size;
 
 	ACPI_FUNCTION_TRACE(acpi_reallocate_root_table);
 
@@ -183,9 +184,15 @@ acpi_status acpi_reallocate_root_table(void)
 		return_ACPI_STATUS(AE_SUPPORT);
 	}
 
-	new_size = ((acpi_size) acpi_gbl_root_table_list.count +
-		    ACPI_ROOT_TABLE_SIZE_INCREMENT) *
-	    sizeof(struct acpi_table_desc);
+	/*
+	 * Get the current size of the root table and add the default
+	 * increment to create the new table size.
+	 */
+	current_size = (acpi_size)
+	    acpi_gbl_root_table_list.count * sizeof(struct acpi_table_desc);
+
+	new_size = current_size +
+	    (ACPI_ROOT_TABLE_SIZE_INCREMENT * sizeof(struct acpi_table_desc));
 
 	/* Create new array and copy the old array */
 
@@ -194,10 +201,16 @@ acpi_status acpi_reallocate_root_table(void)
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
-	ACPI_MEMCPY(tables, acpi_gbl_root_table_list.tables, new_size);
+	ACPI_MEMCPY(tables, acpi_gbl_root_table_list.tables, current_size);
 
-	acpi_gbl_root_table_list.size = acpi_gbl_root_table_list.count;
+	/*
+	 * Update the root table descriptor. The new size will be the current
+	 * number of tables plus the increment, independent of the reserved
+	 * size of the original table list.
+	 */
 	acpi_gbl_root_table_list.tables = tables;
+	acpi_gbl_root_table_list.size =
+	    acpi_gbl_root_table_list.count + ACPI_ROOT_TABLE_SIZE_INCREMENT;
 	acpi_gbl_root_table_list.flags =
 	    ACPI_ROOT_ORIGIN_ALLOCATED | ACPI_ROOT_ALLOW_RESIZE;
 

>From 0b13a3dbf1d38e4d4cb2b5b6a3073db0059302bd Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 1 Apr 2010 11:09:00 +0800
Subject: [PATCH 3/9] ACPICA: Add write support for DataTable operation regions

The original implementation only supported reading from a DataTable
region. However, some machines have been seen that actually write
to the ACPI table contained in such a region. This change adds
support for writing to a DataTable region.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/exregion.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index a8703cc..531000f 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -491,8 +491,10 @@ acpi_ex_data_table_space_handler(u32 function,
 {
 	ACPI_FUNCTION_TRACE(ex_data_table_space_handler);
 
-	/* Perform the memory read or write */
-
+	/*
+	 * Perform the memory read or write. The bit_width was already
+	 * validated.
+	 */
 	switch (function) {
 	case ACPI_READ:
 
@@ -502,9 +504,14 @@ acpi_ex_data_table_space_handler(u32 function,
 		break;
 
 	case ACPI_WRITE:
+
+		ACPI_MEMCPY(ACPI_PHYSADDR_TO_PTR(address),
+			    ACPI_CAST_PTR(char, value), ACPI_DIV_8(bit_width));
+		break;
+
 	default:
 
-		return_ACPI_STATUS(AE_SUPPORT);
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
 	return_ACPI_STATUS(AE_OK);

>From b435982a224b79470f05348d7e8f59f1c277e828 Mon Sep 17 00:00:00 2001
From: Lin Ming <ming.m.lin@intel.com>
Date: Thu, 1 Apr 2010 10:47:56 +0800
Subject: [PATCH 4/9] ACPICA: Add detection of corrupted/replaced DSDT

This change adds support to detect a DSDT that has been corrupted
and/or replaced from outside the OS (by firmware). This is
typically catastrophic for the system, but has been seen on
some machines.

https://bugzilla.kernel.org/show_bug.cgi?id=14679

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    5 +++++
 drivers/acpi/acpica/actables.h |    2 ++
 drivers/acpi/acpica/psxface.c  |    4 ++++
 drivers/acpi/acpica/tbutils.c  |   38 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/tbxface.c  |   32 ++++++++++++--------------------
 5 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 2b2e61e..a419fe9 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -165,6 +165,11 @@ ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1a_enable;
 ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1b_status;
 ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1b_enable;
 
+/* DSDT information. Used to check for DSDT corruption */
+
+ACPI_EXTERN struct acpi_table_desc *acpi_gbl_DSDT;
+ACPI_EXTERN struct acpi_table_header acpi_gbl_original_dsdt_header;
+
 /*
  * Handle both ACPI 1.0 and ACPI 2.0 Integer widths. The integer width is
  * determined by the revision of the DSDT: If the DSDT revision is less than
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 8ff3b74..fc52b6f 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -107,6 +107,8 @@ u8 acpi_tb_checksum(u8 *buffer, u32 length);
 acpi_status
 acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length);
 
+void acpi_tb_check_dsdt_header(void);
+
 void
 acpi_tb_install_table(acpi_physical_address address,
 		      char *signature, u32 table_index);
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index 6064dd4..67e7ad5 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -220,6 +220,10 @@ acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 
 	ACPI_FUNCTION_TRACE(ps_execute_method);
 
+	/* Quick validation of DSDT header */
+
+	acpi_tb_check_dsdt_header();
+
 	/* Validate the Info and method Node */
 
 	if (!info || !info->resolved_node) {
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index f47a70e..07bc743 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -349,6 +349,44 @@ u8 acpi_tb_checksum(u8 *buffer, u32 length)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_tb_check_dsdt_header
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Quick compare to check validity of the DSDT. This will detect
+ *              if the DSDT has been replaced from outside the OS and/or if
+ *              the DSDT header has been corrupted.
+ *
+ ******************************************************************************/
+
+void acpi_tb_check_dsdt_header(void)
+{
+
+	/* Compare original length and checksum to current values */
+
+	if (acpi_gbl_original_dsdt_header.length !=
+	    acpi_gbl_DSDT->pointer->length
+	    || acpi_gbl_original_dsdt_header.checksum !=
+	    acpi_gbl_DSDT->pointer->checksum) {
+		ACPI_ERROR((AE_INFO,
+			    "The DSDT has been corrupted or replaced - old, new headers below"));
+		acpi_tb_print_table_header(0, &acpi_gbl_original_dsdt_header);
+		acpi_tb_print_table_header(acpi_gbl_DSDT->address,
+					   acpi_gbl_DSDT->pointer);
+
+		/* Disable further error messages */
+
+		acpi_gbl_original_dsdt_header.length =
+		    acpi_gbl_DSDT->pointer->length;
+		acpi_gbl_original_dsdt_header.checksum =
+		    acpi_gbl_DSDT->pointer->checksum;
+	}
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_tb_install_table
  *
  * PARAMETERS:  Address                 - Physical address of DSDT or FACS
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 684614d..3056510 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -518,33 +518,25 @@ static acpi_status acpi_tb_load_namespace(void)
 
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 
+	acpi_gbl_DSDT = &acpi_gbl_root_table_list.tables[ACPI_TABLE_INDEX_DSDT];
+
 	/*
-	 * Load the namespace. The DSDT is required, but any SSDT and PSDT tables
-	 * are optional.
+	 * Load the namespace. The DSDT is required, but any SSDT and
+	 * PSDT tables are optional. Verify the DSDT.
 	 */
 	if (!acpi_gbl_root_table_list.count ||
-	    !ACPI_COMPARE_NAME(&
-			       (acpi_gbl_root_table_list.
-				tables[ACPI_TABLE_INDEX_DSDT].signature),
-			       ACPI_SIG_DSDT)
-	    ||
-	    ACPI_FAILURE(acpi_tb_verify_table
-			 (&acpi_gbl_root_table_list.
-			  tables[ACPI_TABLE_INDEX_DSDT]))) {
+	    !ACPI_COMPARE_NAME(&acpi_gbl_DSDT->signature, ACPI_SIG_DSDT) ||
+	    ACPI_FAILURE(acpi_tb_verify_table(acpi_gbl_DSDT))) {
 		status = AE_NO_ACPI_TABLES;
 		goto unlock_and_exit;
 	}
 
-	/* A valid DSDT is required */
-
-	status =
-	    acpi_tb_verify_table(&acpi_gbl_root_table_list.
-				 tables[ACPI_TABLE_INDEX_DSDT]);
-	if (ACPI_FAILURE(status)) {
-
-		status = AE_NO_ACPI_TABLES;
-		goto unlock_and_exit;
-	}
+	/*
+	 * Save the original DSDT header for detection of table corruption
+	 * and/or replacement of the DSDT from outside the OS.
+	 */
+	ACPI_MEMCPY(&acpi_gbl_original_dsdt_header, acpi_gbl_DSDT->pointer,
+		    sizeof(struct acpi_table_header));
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 

>From 0412c9ab3d792c0c6c5ab641c811e45acfe61cd2 Mon Sep 17 00:00:00 2001
From: Lin Ming <ming.m.lin@intel.com>
Date: Thu, 1 Apr 2010 11:14:12 +0800
Subject: [PATCH 5/9] ACPICA: Add subsystem option to force copy of DSDT to local memory

Optionally copy the entire DSDT to local memory (instead of
simply mapping it.) There are some BIOSs that corrupt or replace
the original DSDT, creating the need for this option. Default is
FALSE, do not copy the DSDT.

https://bugzilla.kernel.org/show_bug.cgi?id=14679

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    8 ++++++++
 drivers/acpi/acpica/actables.h |    2 ++
 drivers/acpi/acpica/psxface.c  |    1 +
 drivers/acpi/acpica/tbutils.c  |   35 +++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/tbxface.c  |   10 ++++++++++
 include/acpi/acpixf.h          |    1 +
 6 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index a419fe9..e3813d2 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -117,6 +117,14 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_use_default_register_widths, TRUE);
  */
 u8 ACPI_INIT_GLOBAL(acpi_gbl_enable_aml_debug_object, FALSE);
 
+/*
+ * Optionally copy the entire DSDT to local memory (instead of simply
+ * mapping it.) There are some BIOSs that corrupt or replace the original
+ * DSDT, creating the need for this option. Default is FALSE, do not copy
+ * the DSDT.
+ */
+u8 ACPI_INIT_GLOBAL(acpi_gbl_copy_dsdt_locally, FALSE);
+
 /* acpi_gbl_FADT is a local copy of the FADT, converted to a common format. */
 
 struct acpi_table_fadt acpi_gbl_FADT;
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index fc52b6f..b7197bf 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -109,6 +109,8 @@ acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length);
 
 void acpi_tb_check_dsdt_header(void);
 
+void acpi_tb_copy_dsdt(struct acpi_table_desc *table_desc);
+
 void
 acpi_tb_install_table(acpi_physical_address address,
 		      char *signature, u32 table_index);
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index 67e7ad5..c42f067 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -46,6 +46,7 @@
 #include "acparser.h"
 #include "acdispat.h"
 #include "acinterp.h"
+#include "actables.h"
 #include "amlcode.h"
 
 #define _COMPONENT          ACPI_PARSER
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 07bc743..1efb094 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -387,6 +387,41 @@ void acpi_tb_check_dsdt_header(void)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_tb_copy_dsdt
+ *
+ * PARAMETERS:  table_desc          - Installed table to copy
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Implements a subsystem option to copy the DSDT to local memory.
+ *              Some very bad BIOSs are known to either corrupt the DSDT or
+ *              install a new, bad DSDT. This copy works around the problem.
+ *
+ ******************************************************************************/
+
+void acpi_tb_copy_dsdt(struct acpi_table_desc *table_desc)
+{
+	struct acpi_table_header *new_table;
+
+	new_table = ACPI_ALLOCATE(table_desc->length);
+	if (!new_table) {
+		ACPI_ERROR((AE_INFO, "Could not copy DSDT of length 0x%X",
+			    table_desc->length));
+		return;
+	}
+
+	ACPI_MEMCPY(new_table, table_desc->pointer, table_desc->length);
+	acpi_tb_delete_table(table_desc);
+	table_desc->pointer = new_table;
+	table_desc->flags = ACPI_TABLE_ORIGIN_ALLOCATED;
+
+	ACPI_INFO((AE_INFO,
+		   "Forced DSDT copy: length 0x%05X copied locally, original unmapped",
+		   new_table->length));
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_tb_install_table
  *
  * PARAMETERS:  Address                 - Physical address of DSDT or FACS
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 3056510..f5378fc 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -532,6 +532,16 @@ static acpi_status acpi_tb_load_namespace(void)
 	}
 
 	/*
+	 * Optionally copy the entire DSDT to local memory (instead of simply
+	 * mapping it.) There are some BIOSs that corrupt or replace the original
+	 * DSDT, creating the need for this option. Default is FALSE, do not copy
+	 * the DSDT.
+	 */
+	if (acpi_gbl_copy_dsdt_locally) {
+		acpi_tb_copy_dsdt(acpi_gbl_DSDT);
+	}
+
+	/*
 	 * Save the original DSDT header for detection of table corruption
 	 * and/or replacement of the DSDT from outside the OS.
 	 */
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index f753222..fd815f6 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -68,6 +68,7 @@ extern u8 acpi_gbl_use_default_register_widths;
 extern acpi_name acpi_gbl_trace_method_name;
 extern u32 acpi_gbl_trace_flags;
 extern u8 acpi_gbl_enable_aml_debug_object;
+extern u8 acpi_gbl_copy_dsdt_locally;
 
 extern u32 acpi_current_gpe_count;
 extern struct acpi_table_fadt acpi_gbl_FADT;

>From 39de59b737a3cc09e125f5a11decc08fc5f0884e Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 7 Apr 2010 11:05:11 +0800
Subject: [PATCH 6/9] ACPICA: Update DSDT copy/detection.

Move initialization of DSDT pointer. Emit address of DSDT
in the dump of both table headers (good/bad DSDT).
Now handles the case where the root table can be reallocated,
which would invalidate the original pointer.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    2 +-
 drivers/acpi/acpica/actables.h |    2 +-
 drivers/acpi/acpica/tbutils.c  |   23 ++++++++++++-----------
 drivers/acpi/acpica/tbxface.c  |   29 +++++++++++++++++++++++------
 drivers/acpi/acpica/utglobal.c |    1 +
 5 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index e3813d2..87f21d9 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -175,7 +175,7 @@ ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1b_enable;
 
 /* DSDT information. Used to check for DSDT corruption */
 
-ACPI_EXTERN struct acpi_table_desc *acpi_gbl_DSDT;
+ACPI_EXTERN struct acpi_table_header *acpi_gbl_DSDT;
 ACPI_EXTERN struct acpi_table_header acpi_gbl_original_dsdt_header;
 
 /*
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index b7197bf..62a576e 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -109,7 +109,7 @@ acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length);
 
 void acpi_tb_check_dsdt_header(void);
 
-void acpi_tb_copy_dsdt(struct acpi_table_desc *table_desc);
+struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index);
 
 void
 acpi_tb_install_table(acpi_physical_address address,
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 1efb094..54a8712 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -366,22 +366,18 @@ void acpi_tb_check_dsdt_header(void)
 
 	/* Compare original length and checksum to current values */
 
-	if (acpi_gbl_original_dsdt_header.length !=
-	    acpi_gbl_DSDT->pointer->length
-	    || acpi_gbl_original_dsdt_header.checksum !=
-	    acpi_gbl_DSDT->pointer->checksum) {
+	if (acpi_gbl_original_dsdt_header.length != acpi_gbl_DSDT->length ||
+	    acpi_gbl_original_dsdt_header.checksum != acpi_gbl_DSDT->checksum) {
 		ACPI_ERROR((AE_INFO,
 			    "The DSDT has been corrupted or replaced - old, new headers below"));
 		acpi_tb_print_table_header(0, &acpi_gbl_original_dsdt_header);
-		acpi_tb_print_table_header(acpi_gbl_DSDT->address,
-					   acpi_gbl_DSDT->pointer);
+		acpi_tb_print_table_header(0, acpi_gbl_DSDT);
 
 		/* Disable further error messages */
 
-		acpi_gbl_original_dsdt_header.length =
-		    acpi_gbl_DSDT->pointer->length;
+		acpi_gbl_original_dsdt_header.length = acpi_gbl_DSDT->length;
 		acpi_gbl_original_dsdt_header.checksum =
-		    acpi_gbl_DSDT->pointer->checksum;
+		    acpi_gbl_DSDT->checksum;
 	}
 }
 
@@ -399,15 +395,18 @@ void acpi_tb_check_dsdt_header(void)
  *
  ******************************************************************************/
 
-void acpi_tb_copy_dsdt(struct acpi_table_desc *table_desc)
+struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index)
 {
 	struct acpi_table_header *new_table;
+	struct acpi_table_desc *table_desc;
+
+	table_desc = &acpi_gbl_root_table_list.tables[table_index];
 
 	new_table = ACPI_ALLOCATE(table_desc->length);
 	if (!new_table) {
 		ACPI_ERROR((AE_INFO, "Could not copy DSDT of length 0x%X",
 			    table_desc->length));
-		return;
+		return (NULL);
 	}
 
 	ACPI_MEMCPY(new_table, table_desc->pointer, table_desc->length);
@@ -418,6 +417,8 @@ void acpi_tb_copy_dsdt(struct acpi_table_desc *table_desc)
 	ACPI_INFO((AE_INFO,
 		   "Forced DSDT copy: length 0x%05X copied locally, original unmapped",
 		   new_table->length));
+
+	return (new_table);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index f5378fc..adb7f56 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -513,39 +513,56 @@ static acpi_status acpi_tb_load_namespace(void)
 {
 	acpi_status status;
 	u32 i;
+	struct acpi_table_header *new_dsdt;
 
 	ACPI_FUNCTION_TRACE(tb_load_namespace);
 
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 
-	acpi_gbl_DSDT = &acpi_gbl_root_table_list.tables[ACPI_TABLE_INDEX_DSDT];
-
 	/*
 	 * Load the namespace. The DSDT is required, but any SSDT and
 	 * PSDT tables are optional. Verify the DSDT.
 	 */
 	if (!acpi_gbl_root_table_list.count ||
-	    !ACPI_COMPARE_NAME(&acpi_gbl_DSDT->signature, ACPI_SIG_DSDT) ||
-	    ACPI_FAILURE(acpi_tb_verify_table(acpi_gbl_DSDT))) {
+	    !ACPI_COMPARE_NAME(&
+			       (acpi_gbl_root_table_list.
+				tables[ACPI_TABLE_INDEX_DSDT].signature),
+			       ACPI_SIG_DSDT)
+	    ||
+	    ACPI_FAILURE(acpi_tb_verify_table
+			 (&acpi_gbl_root_table_list.
+			  tables[ACPI_TABLE_INDEX_DSDT]))) {
 		status = AE_NO_ACPI_TABLES;
 		goto unlock_and_exit;
 	}
 
 	/*
+	 * Save the DSDT pointer for simple access. This is the mapped memory
+	 * address. We must take care here because the address of the .Tables
+	 * array can change dynamically as tables are loaded at run-time. Note:
+	 * .Pointer field is not validated until after call to acpi_tb_verify_table.
+	 */
+	acpi_gbl_DSDT =
+	    acpi_gbl_root_table_list.tables[ACPI_TABLE_INDEX_DSDT].pointer;
+
+	/*
 	 * Optionally copy the entire DSDT to local memory (instead of simply
 	 * mapping it.) There are some BIOSs that corrupt or replace the original
 	 * DSDT, creating the need for this option. Default is FALSE, do not copy
 	 * the DSDT.
 	 */
 	if (acpi_gbl_copy_dsdt_locally) {
-		acpi_tb_copy_dsdt(acpi_gbl_DSDT);
+		new_dsdt = acpi_tb_copy_dsdt(ACPI_TABLE_INDEX_DSDT);
+		if (new_dsdt) {
+			acpi_gbl_DSDT = new_dsdt;
+		}
 	}
 
 	/*
 	 * Save the original DSDT header for detection of table corruption
 	 * and/or replacement of the DSDT from outside the OS.
 	 */
-	ACPI_MEMCPY(&acpi_gbl_original_dsdt_header, acpi_gbl_DSDT->pointer,
+	ACPI_MEMCPY(&acpi_gbl_original_dsdt_header, acpi_gbl_DSDT,
 		    sizeof(struct acpi_table_header));
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index eda3e65..6611675 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -785,6 +785,7 @@ acpi_status acpi_ut_init_globals(void)
 
 	/* Miscellaneous variables */
 
+	acpi_gbl_DSDT = NULL;
 	acpi_gbl_cm_single_step = FALSE;
 	acpi_gbl_db_terminate_threads = FALSE;
 	acpi_gbl_shutdown = FALSE;

>From 7e8098683e5b7375862d454fa05687270e509683 Mon Sep 17 00:00:00 2001
From: Lin Ming <ming.m.lin@intel.com>
Date: Thu, 8 Apr 2010 14:34:27 +0800
Subject: [PATCH 7/9] ACPI: add boot option acpi=copy_dsdt to fix corrupt DSDT

Some BIOS on Toshiba machines corrupt the DSDT, so add a new
boot option acpi=copy_dsdt to workaround it.
Add warning message to ask users to use this option if corrupt DSDT detected.

Also build a DMI blacklist to check it and automatically copy DSDT.

https://bugzilla.kernel.org/show_bug.cgi?id=14679

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 Documentation/kernel-parameters.txt |    1 +
 arch/x86/kernel/acpi/boot.c         |    4 +++
 drivers/acpi/acpica/tbutils.c       |    4 +++
 drivers/acpi/bus.c                  |   37 +++++++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 8d9b809..5f613b4 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -150,6 +150,7 @@ and is between 256 and 4096 characters. It is defined in the file
 			strict -- Be less tolerant of platforms that are not
 				strictly ACPI specification compliant.
 			rsdt -- prefer RSDT over (default) XSDT
+			copy_dsdt -- copy DSDT to memory
 
 			See also Documentation/power/pm.txt, pci=noacpi
 
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index b702343..601ed05 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1563,6 +1563,10 @@ static int __init parse_acpi(char *arg)
 	/* "acpi=noirq" disables ACPI interrupt routing */
 	else if (strcmp(arg, "noirq") == 0) {
 		acpi_noirq_set();
+	}
+	/* "acpi=copy_dsdt" copys DSDT */
+	else if (strcmp(arg, "copy_dsdt") == 0) {
+		acpi_gbl_copy_dsdt_locally = 1;
 	} else {
 		/* Core will printk when we return error. */
 		return -EINVAL;
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 54a8712..a9b105f 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -373,6 +373,10 @@ void acpi_tb_check_dsdt_header(void)
 		acpi_tb_print_table_header(0, &acpi_gbl_original_dsdt_header);
 		acpi_tb_print_table_header(0, acpi_gbl_DSDT);
 
+		ACPI_ERROR((AE_INFO,
+			    "Please send DMI info to linux-acpi@vger.kernel.org\n"
+			    "If system does not work as expected, please boot with acpi=copy_dsdt"));
+
 		/* Disable further error messages */
 
 		acpi_gbl_original_dsdt_header.length = acpi_gbl_DSDT->length;
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 37132dc..49af19b 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -69,6 +69,37 @@ static struct dmi_system_id __cpuinitdata power_nocheck_dmi_table[] = {
 };
 
 
+static int set_copy_dsdt(const struct dmi_system_id *id)
+{
+	printk(KERN_NOTICE "%s detected - "
+		"force copy of DSDT to local memory\n", id->ident);
+	acpi_gbl_copy_dsdt_locally = 1;
+	return 0;
+}
+
+static struct dmi_system_id dsdt_dmi_table[] __initdata = {
+	/*
+	 * Insyde BIOS on some TOSHIBA machines corrupt the DSDT.
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=14679
+	 */
+	{
+	 .callback = set_copy_dsdt,
+	 .ident = "TOSHIBA Satellite A505",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite A505"),
+		},
+	},
+	{
+	 .callback = set_copy_dsdt,
+	 .ident = "TOSHIBA Satellite L505D",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite L505D"),
+		},
+	}
+};
+
 /* --------------------------------------------------------------------------
                                 Device Management
    -------------------------------------------------------------------------- */
@@ -813,6 +844,12 @@ void __init acpi_early_init(void)
 
 	acpi_gbl_permanent_mmap = 1;
 
+	/*
+	 * If the machine falls into the DMI check table,
+	 * DSDT will be copied to memory
+	 */
+	dmi_check_system(dsdt_dmi_table);
+
 	status = acpi_reallocate_root_table();
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX

>From a3a65368d88237d7c45bc6578b9cf7a07caa56fc Mon Sep 17 00:00:00 2001
From: Lin Ming <ming.m.lin@intel.com>
Date: Tue, 6 Apr 2010 14:52:37 +0800
Subject: [PATCH 8/9] ACPICA: Minimize the differences between linux GPE code and ACPICA code base

We have ported Rafael's major GPE changes
(ACPI: Use GPE reference counting to support shared GPEs) into ACPICA code base.
But the port and Rafael's original patch have some differences, so we made
below patch to make linux GPE code consistent with ACPICA code base.

Most changes are about comments and coding styles.
Other noticeable changes are based on:

Rafael: Reduce code duplication related to GPE lookup
https://patchwork.kernel.org/patch/86237/

Rafeal: Always use the same lock for GPE locking
https://patchwork.kernel.org/patch/90471/

A new field gpe_count in struct acpi_gpe_block_info to record the number
of individual GPEs in block.

Rename acpi_ev_save_method_info to acpi_ev_match_gpe_method.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Robert Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acevents.h |    7 +-
 drivers/acpi/acpica/aclocal.h  |    5 +-
 drivers/acpi/acpica/evgpe.c    |  153 +++++++++++++++++++++++---------
 drivers/acpi/acpica/evgpeblk.c |  143 ++++++++++++++++--------------
 drivers/acpi/acpica/evxface.c  |   20 +++--
 drivers/acpi/acpica/evxfevnt.c |  191 +++++++++++++++++++++++----------------
 drivers/acpi/acpica/exoparg2.c |   27 ------
 drivers/acpi/scan.c            |    2 +-
 drivers/acpi/system.c          |    5 +-
 include/acpi/acexcep.h         |    2 +-
 include/acpi/acpixf.h          |   11 ++-
 include/acpi/actypes.h         |   42 ++++-----
 12 files changed, 346 insertions(+), 262 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 3e6ba99..5e094a2 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -85,6 +85,10 @@ acpi_status acpi_ev_disable_gpe(struct acpi_gpe_event_info *gpe_event_info);
 struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
 						       u32 gpe_number);
 
+struct acpi_gpe_event_info *acpi_ev_low_get_gpe_info(u32 gpe_number,
+						     struct acpi_gpe_block_info
+						     *gpe_block);
+
 /*
  * evgpeblk
  */
@@ -118,9 +122,6 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info,
 
 u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info *gpe_xrupt_list);
 
-acpi_status
-acpi_ev_check_for_wake_only_gpe(struct acpi_gpe_event_info *gpe_event_info);
-
 acpi_status acpi_ev_gpe_initialize(void);
 
 /*
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 24b8faa..5a6203a 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -427,8 +427,8 @@ struct acpi_gpe_event_info {
 	struct acpi_gpe_register_info *register_info;	/* Backpointer to register info */
 	u8 flags;		/* Misc info about this GPE */
 	u8 gpe_number;		/* This GPE */
-	u8 runtime_count;
-	u8 wakeup_count;
+	u8 runtime_count;	/* References to a run GPE */
+	u8 wakeup_count;	/* References to a wake GPE */
 };
 
 /* Information about a GPE register pair, one per each status/enable pair in an array */
@@ -454,6 +454,7 @@ struct acpi_gpe_block_info {
 	struct acpi_gpe_event_info *event_info;	/* One for each GPE */
 	struct acpi_generic_address block_address;	/* Base address of the block */
 	u32 register_count;	/* Number of register pairs in block */
+	u16 gpe_count;		/* Number of individual GPEs in block */
 	u8 block_base_number;	/* Base GPE number for this block */
 };
 
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index b9d50ef..deb26f4 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -60,7 +60,8 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context);
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Updates GPE register enable masks based on the GPE type
+ * DESCRIPTION: Updates GPE register enable masks based upon whether there are
+ *              references (either wake or run) to this GPE
  *
  ******************************************************************************/
 
@@ -81,14 +82,20 @@ acpi_ev_update_gpe_enable_masks(struct acpi_gpe_event_info *gpe_event_info)
 	    (1 <<
 	     (gpe_event_info->gpe_number - gpe_register_info->base_gpe_number));
 
+	/* Clear the wake/run bits up front */
+
 	ACPI_CLEAR_BIT(gpe_register_info->enable_for_wake, register_bit);
 	ACPI_CLEAR_BIT(gpe_register_info->enable_for_run, register_bit);
 
-	if (gpe_event_info->runtime_count)
+	/* Set the mask bits only if there are references to this GPE */
+
+	if (gpe_event_info->runtime_count) {
 		ACPI_SET_BIT(gpe_register_info->enable_for_run, register_bit);
+	}
 
-	if (gpe_event_info->wakeup_count)
+	if (gpe_event_info->wakeup_count) {
 		ACPI_SET_BIT(gpe_register_info->enable_for_wake, register_bit);
+	}
 
 	return_ACPI_STATUS(AE_OK);
 }
@@ -101,7 +108,10 @@ acpi_ev_update_gpe_enable_masks(struct acpi_gpe_event_info *gpe_event_info)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Enable a GPE based on the GPE type
+ * DESCRIPTION: Hardware-enable a GPE. Always enables the GPE, regardless
+ *              of type or number of references.
+ *
+ * Note: The GPE lock should be already acquired when this function is called.
  *
  ******************************************************************************/
 
@@ -109,20 +119,36 @@ acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 {
 	acpi_status status;
 
+
 	ACPI_FUNCTION_TRACE(ev_enable_gpe);
 
-	/* Make sure HW enable masks are updated */
+
+	/*
+	 * We will only allow a GPE to be enabled if it has either an
+	 * associated method (_Lxx/_Exx) or a handler. Otherwise, the
+	 * GPE will be immediately disabled by acpi_ev_gpe_dispatch the
+	 * first time it fires.
+	 */
+	if (!(gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK)) {
+		return_ACPI_STATUS(AE_NO_HANDLER);
+	}
+
+	/* Ensure the HW enable masks are current */
 
 	status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
+	}
+
+	/* Clear the GPE (of stale events) */
 
-	/* Clear the GPE (of stale events), then enable it */
 	status = acpi_hw_clear_gpe(gpe_event_info);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
+	}
 
 	/* Enable the requested GPE */
+
 	status = acpi_hw_write_gpe_enable_reg(gpe_event_info);
 	return_ACPI_STATUS(status);
 }
@@ -135,7 +161,10 @@ acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Disable a GPE based on the GPE type
+ * DESCRIPTION: Hardware-disable a GPE. Always disables the requested GPE,
+ *              regardless of the type or number of references.
+ *
+ * Note: The GPE lock should be already acquired when this function is called.
  *
  ******************************************************************************/
 
@@ -145,24 +174,71 @@ acpi_status acpi_ev_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 
 	ACPI_FUNCTION_TRACE(ev_disable_gpe);
 
-	/* Make sure HW enable masks are updated */
+
+	/*
+	 * Note: Always disable the GPE, even if we think that that it is already
+	 * disabled. It is possible that the AML or some other code has enabled
+	 * the GPE behind our back.
+	 */
+
+	/* Ensure the HW enable masks are current */
 
 	status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
+	}
 
 	/*
-	 * Even if we don't know the GPE type, make sure that we always
-	 * disable it. low_disable_gpe will just clear the enable bit for this
-	 * GPE and write it. It will not write out the current GPE enable mask,
-	 * since this may inadvertently enable GPEs too early, if a rogue GPE has
-	 * come in during ACPICA initialization - possibly as a result of AML or
-	 * other code that has enabled the GPE.
+	 * Always H/W disable this GPE, even if we don't know the GPE type.
+	 * Simply clear the enable bit for this particular GPE, but do not
+	 * write out the current GPE enable mask since this may inadvertently
+	 * enable GPEs too early. An example is a rogue GPE that has arrived
+	 * during ACPICA initialization - possibly because AML or other code
+	 * has enabled the GPE.
 	 */
 	status = acpi_hw_low_disable_gpe(gpe_event_info);
 	return_ACPI_STATUS(status);
 }
 
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_low_get_gpe_info
+ *
+ * PARAMETERS:  gpe_number          - Raw GPE number
+ *              gpe_block           - A GPE info block
+ *
+ * RETURN:      A GPE event_info struct. NULL if not a valid GPE (The gpe_number
+ *              is not within the specified GPE block)
+ *
+ * DESCRIPTION: Returns the event_info struct associated with this GPE. This is
+ *              the low-level implementation of ev_get_gpe_event_info.
+ *
+ ******************************************************************************/
+
+struct acpi_gpe_event_info *acpi_ev_low_get_gpe_info(u32 gpe_number,
+						     struct acpi_gpe_block_info
+						     *gpe_block)
+{
+	u32 gpe_index;
+
+	/*
+	 * Validate that the gpe_number is within the specified gpe_block.
+	 * (Two steps)
+	 */
+	if (!gpe_block || (gpe_number < gpe_block->block_base_number)) {
+		return (NULL);
+	}
+
+	gpe_index = gpe_number - gpe_block->block_base_number;
+	if (gpe_index >= gpe_block->gpe_count) {
+		return (NULL);
+	}
+
+	return (&gpe_block->event_info[gpe_index]);
+}
+
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_get_gpe_event_info
@@ -184,7 +260,7 @@ struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
 						       u32 gpe_number)
 {
 	union acpi_operand_object *obj_desc;
-	struct acpi_gpe_block_info *gpe_block;
+	struct acpi_gpe_event_info *gpe_info;
 	u32 i;
 
 	ACPI_FUNCTION_ENTRY();
@@ -196,17 +272,11 @@ struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
 		/* Examine GPE Block 0 and 1 (These blocks are permanent) */
 
 		for (i = 0; i < ACPI_MAX_GPE_BLOCKS; i++) {
-			gpe_block = acpi_gbl_gpe_fadt_blocks[i];
-			if (gpe_block) {
-				if ((gpe_number >= gpe_block->block_base_number)
-				    && (gpe_number <
-					gpe_block->block_base_number +
-					(gpe_block->register_count * 8))) {
-					return (&gpe_block->
-						event_info[gpe_number -
-							   gpe_block->
-							   block_base_number]);
-				}
+			gpe_info = acpi_ev_low_get_gpe_info(gpe_number,
+							    acpi_gbl_gpe_fadt_blocks
+							    [i]);
+			if (gpe_info) {
+				return (gpe_info);
 			}
 		}
 
@@ -223,16 +293,8 @@ struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
 		return (NULL);
 	}
 
-	gpe_block = obj_desc->device.gpe_block;
-
-	if ((gpe_number >= gpe_block->block_base_number) &&
-	    (gpe_number <
-	     gpe_block->block_base_number + (gpe_block->register_count * 8))) {
-		return (&gpe_block->
-			event_info[gpe_number - gpe_block->block_base_number]);
-	}
-
-	return (NULL);
+	return (acpi_ev_low_get_gpe_info
+		(gpe_number, obj_desc->device.gpe_block));
 }
 
 /*******************************************************************************
@@ -389,7 +451,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 		return_VOID;
 	}
 
-	/* Set the GPE flags for return to enabled state */
+	/* Update the GPE register masks for return to enabled state */
 
 	(void)acpi_ev_update_gpe_enable_masks(gpe_event_info);
 
@@ -569,15 +631,18 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 
 	default:
 
-		/* No handler or method to run! */
-
+		/*
+		 * No handler or method to run!
+		 * 03/2010: This case should no longer be possible. We will not allow
+		 * a GPE to be enabled if it has no handler or method.
+		 */
 		ACPI_ERROR((AE_INFO,
 			    "No handler or method for GPE[0x%2X], disabling event",
 			    gpe_number));
 
 		/*
-		 * Disable the GPE. The GPE will remain disabled until the ACPICA
-		 * Core Subsystem is restarted, or a handler is installed.
+		 * Disable the GPE. The GPE will remain disabled a handler
+		 * is installed or ACPICA is restarted.
 		 */
 		status = acpi_ev_disable_gpe(gpe_event_info);
 		if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index fa47e35..85ded1f 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -51,7 +51,7 @@ ACPI_MODULE_NAME("evgpeblk")
 
 /* Local prototypes */
 static acpi_status
-acpi_ev_save_method_info(acpi_handle obj_handle,
+acpi_ev_match_gpe_method(acpi_handle obj_handle,
 			 u32 level, void *obj_desc, void **return_value);
 
 static acpi_status
@@ -104,9 +104,7 @@ u8 acpi_ev_valid_gpe_event(struct acpi_gpe_event_info *gpe_event_info)
 
 		while (gpe_block) {
 			if ((&gpe_block->event_info[0] <= gpe_event_info) &&
-			    (&gpe_block->event_info[((acpi_size)
-						     gpe_block->
-						     register_count) * 8] >
+			    (&gpe_block->event_info[gpe_block->gpe_count] >
 			     gpe_event_info)) {
 				return (TRUE);
 			}
@@ -229,7 +227,7 @@ acpi_ev_delete_gpe_handlers(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ev_save_method_info
+ * FUNCTION:    acpi_ev_match_gpe_method
  *
  * PARAMETERS:  Callback from walk_namespace
  *
@@ -241,8 +239,7 @@ acpi_ev_delete_gpe_handlers(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
  *              information for quick lookup during GPE dispatch
  *
  *              The name of each GPE control method is of the form:
- *              "_Lxx" or "_Exx"
- *              Where:
+ *              "_Lxx" or "_Exx", where:
  *                  L      - means that the GPE is level triggered
  *                  E      - means that the GPE is edge triggered
  *                  xx     - is the GPE number [in HEX]
@@ -250,9 +247,11 @@ acpi_ev_delete_gpe_handlers(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
  ******************************************************************************/
 
 static acpi_status
-acpi_ev_save_method_info(acpi_handle obj_handle,
+acpi_ev_match_gpe_method(acpi_handle obj_handle,
 			 u32 level, void *obj_desc, void **return_value)
 {
+	struct acpi_namespace_node *method_node =
+	    ACPI_CAST_PTR(struct acpi_namespace_node, obj_handle);
 	struct acpi_gpe_block_info *gpe_block = (void *)obj_desc;
 	struct acpi_gpe_event_info *gpe_event_info;
 	u32 gpe_number;
@@ -262,21 +261,25 @@ acpi_ev_save_method_info(acpi_handle obj_handle,
 	ACPI_FUNCTION_TRACE(ev_save_method_info);
 
 	/*
-	 * _Lxx and _Exx GPE method support
+	 * Match and decode the _Lxx and _Exx GPE method names
 	 *
-	 * 1) Extract the name from the object and convert to a string
+	 * 1) Extract the method name and null terminate it
 	 */
-	ACPI_MOVE_32_TO_32(name,
-			   &((struct acpi_namespace_node *)obj_handle)->name.
-			   integer);
+	ACPI_MOVE_32_TO_32(name, &method_node->name.integer);
 	name[ACPI_NAME_SIZE] = 0;
 
+	/* 2) Name must begin with an underscore */
+
+	if (name[0] != '_') {
+		return_ACPI_STATUS(AE_OK);	/* Ignore this method */
+	}
+
 	/*
-	 * 2) Edge/Level determination is based on the 2nd character
+	 * 3) Edge/Level determination is based on the 2nd character
 	 *    of the method name
 	 *
-	 * NOTE: Default GPE type is RUNTIME. May be changed later to WAKE
-	 * if a _PRW object is found that points to this GPE.
+	 * NOTE: Default GPE type is RUNTIME only. Later, if a _PRW object is
+	 * found that points to this GPE, the ACPI_GPE_CAN_WAKE flag is set.
 	 */
 	switch (name[1]) {
 	case 'L':
@@ -288,7 +291,7 @@ acpi_ev_save_method_info(acpi_handle obj_handle,
 		break;
 
 	default:
-		/* Unknown method type, just ignore it! */
+		/* Unknown method type, just ignore it */
 
 		ACPI_DEBUG_PRINT((ACPI_DB_LOAD,
 				  "Ignoring unknown GPE method type: %s "
@@ -296,7 +299,7 @@ acpi_ev_save_method_info(acpi_handle obj_handle,
 		return_ACPI_STATUS(AE_OK);
 	}
 
-	/* Convert the last two characters of the name to the GPE Number */
+	/* 4) The last two characters of the name are the hex GPE Number */
 
 	gpe_number = ACPI_STRTOUL(&name[2], NULL, 16);
 	if (gpe_number == ACPI_UINT32_MAX) {
@@ -311,28 +314,22 @@ acpi_ev_save_method_info(acpi_handle obj_handle,
 
 	/* Ensure that we have a valid GPE number for this GPE block */
 
-	if ((gpe_number < gpe_block->block_base_number) ||
-	    (gpe_number >= (gpe_block->block_base_number +
-			    (gpe_block->register_count * 8)))) {
+	gpe_event_info = acpi_ev_low_get_gpe_info(gpe_number, gpe_block);
+	if (!gpe_event_info) {
 		/*
-		 * Not valid for this GPE block, just ignore it. However, it may be
-		 * valid for a different GPE block, since GPE0 and GPE1 methods both
-		 * appear under \_GPE.
+		 * This gpe_number is not valid for this GPE block, just ignore it.
+		 * However, it may be valid for a different GPE block, since GPE0
+		 * and GPE1 methods both appear under \_GPE.
 		 */
 		return_ACPI_STATUS(AE_OK);
 	}
 
 	/*
-	 * Now we can add this information to the gpe_event_info block for use
-	 * during dispatch of this GPE.
+	 * Add the GPE information from above to the gpe_event_info block for
+	 * use during dispatch of this GPE.
 	 */
-	gpe_event_info =
-	    &gpe_block->event_info[gpe_number - gpe_block->block_base_number];
-
-	gpe_event_info->flags = (u8) (type | ACPI_GPE_DISPATCH_METHOD);
-
-	gpe_event_info->dispatch.method_node =
-	    (struct acpi_namespace_node *)obj_handle;
+	gpe_event_info->flags = (u8)(type | ACPI_GPE_DISPATCH_METHOD);
+	gpe_event_info->dispatch.method_node = method_node;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_LOAD,
 			  "Registered GPE method %s as GPE number 0x%.2X\n",
@@ -351,7 +348,7 @@ acpi_ev_save_method_info(acpi_handle obj_handle,
  *
  * DESCRIPTION: Called from acpi_walk_namespace. Expects each object to be a
  *              Device. Run the _PRW method. If present, extract the GPE
- *              number and mark the GPE as a WAKE GPE.
+ *              number and mark the GPE as a CAN_WAKE GPE.
  *
  ******************************************************************************/
 
@@ -377,7 +374,7 @@ acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
 					 ACPI_BTYPE_PACKAGE, &pkg_desc);
 	if (ACPI_FAILURE(status)) {
 
-		/* Ignore all errors from _PRW, we don't want to abort the subsystem */
+		/* Ignore all errors from _PRW, we don't want to abort the walk */
 
 		return_ACPI_STATUS(AE_OK);
 	}
@@ -439,13 +436,13 @@ acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
 	 *     2) The GPE index(number) is within the range of the Gpe Block
 	 *          associated with the GPE device.
 	 */
-	if ((gpe_device == target_gpe_device) &&
-	    (gpe_number >= gpe_block->block_base_number) &&
-	    (gpe_number < gpe_block->block_base_number +
-	     (gpe_block->register_count * 8))) {
-		gpe_event_info = &gpe_block->event_info[gpe_number -
-							gpe_block->
-							block_base_number];
+	if (gpe_device != target_gpe_device) {
+		goto cleanup;
+	}
+
+	gpe_event_info = acpi_ev_low_get_gpe_info(gpe_number, gpe_block);
+	if (gpe_event_info) {
+		/* This GPE can wake the system */
 
 		gpe_event_info->flags |= ACPI_GPE_CAN_WAKE;
 	}
@@ -705,8 +702,7 @@ acpi_status acpi_ev_delete_gpe_block(struct acpi_gpe_block_info *gpe_block)
 		acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	}
 
-	acpi_current_gpe_count -=
-	    gpe_block->register_count * ACPI_GPE_REGISTER_WIDTH;
+	acpi_current_gpe_count -= gpe_block->gpe_count;
 
 	/* Free the gpe_block */
 
@@ -760,9 +756,7 @@ acpi_ev_create_gpe_info_blocks(struct acpi_gpe_block_info *gpe_block)
 	 * Allocate the GPE event_info block. There are eight distinct GPEs
 	 * per register. Initialization to zeros is sufficient.
 	 */
-	gpe_event_info = ACPI_ALLOCATE_ZEROED(((acpi_size) gpe_block->
-					       register_count *
-					       ACPI_GPE_REGISTER_WIDTH) *
+	gpe_event_info = ACPI_ALLOCATE_ZEROED((acpi_size) gpe_block->gpe_count *
 					      sizeof(struct
 						     acpi_gpe_event_info));
 	if (!gpe_event_info) {
@@ -897,6 +891,7 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
 	/* Initialize the new GPE block */
 
 	gpe_block->node = gpe_device;
+	gpe_block->gpe_count = (u16)(register_count * ACPI_GPE_REGISTER_WIDTH);
 	gpe_block->register_count = register_count;
 	gpe_block->block_base_number = gpe_block_base_number;
 
@@ -925,7 +920,7 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
 
 	status = acpi_ns_walk_namespace(ACPI_TYPE_METHOD, gpe_device,
 					ACPI_UINT32_MAX, ACPI_NS_WALK_NO_UNLOCK,
-					acpi_ev_save_method_info, NULL,
+					acpi_ev_match_gpe_method, NULL,
 					gpe_block, NULL);
 
 	/* Return the new block */
@@ -938,14 +933,13 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
 			  "GPE %02X to %02X [%4.4s] %u regs on int 0x%X\n",
 			  (u32) gpe_block->block_base_number,
 			  (u32) (gpe_block->block_base_number +
-				 ((gpe_block->register_count *
-				   ACPI_GPE_REGISTER_WIDTH) - 1)),
+				(gpe_block->gpe_count - 1)),
 			  gpe_device->name.ascii, gpe_block->register_count,
 			  interrupt_number));
 
 	/* Update global count of currently available GPEs */
 
-	acpi_current_gpe_count += register_count * ACPI_GPE_REGISTER_WIDTH;
+	acpi_current_gpe_count += gpe_block->gpe_count;
 	return_ACPI_STATUS(AE_OK);
 }
 
@@ -969,10 +963,13 @@ acpi_status
 acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
 			     struct acpi_gpe_block_info *gpe_block)
 {
+	acpi_status status;
 	struct acpi_gpe_event_info *gpe_event_info;
 	struct acpi_gpe_walk_info gpe_info;
 	u32 wake_gpe_count;
 	u32 gpe_enabled_count;
+	u32 gpe_index;
+	u32 gpe_number;
 	u32 i;
 	u32 j;
 
@@ -998,50 +995,62 @@ acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
 		gpe_info.gpe_block = gpe_block;
 		gpe_info.gpe_device = gpe_device;
 
-		acpi_ns_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+		status = acpi_ns_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 					   ACPI_UINT32_MAX, ACPI_NS_WALK_UNLOCK,
 					   acpi_ev_match_prw_and_gpe, NULL,
 					   &gpe_info, NULL);
+		if (ACPI_FAILURE(status)) {
+			ACPI_EXCEPTION((AE_INFO, status,
+					"While executing _PRW methods"));
+		}
 	}
 
 	/*
-	 * Enable all GPEs that have a corresponding method and aren't
+	 * Enable all GPEs that have a corresponding method and are not
 	 * capable of generating wakeups. Any other GPEs within this block
-	 * must be enabled via the acpi_enable_gpe() interface.
+	 * must be enabled via the acpi_enable_gpe interface.
 	 */
 	wake_gpe_count = 0;
 	gpe_enabled_count = 0;
-	if (gpe_device == acpi_gbl_fadt_gpe_device)
+
+	if (gpe_device == acpi_gbl_fadt_gpe_device) {
 		gpe_device = NULL;
+	}
 
 	for (i = 0; i < gpe_block->register_count; i++) {
 		for (j = 0; j < ACPI_GPE_REGISTER_WIDTH; j++) {
-			acpi_status status;
-			acpi_size gpe_index;
-			int gpe_number;
 
 			/* Get the info block for this particular GPE */
-			gpe_index = (acpi_size)i * ACPI_GPE_REGISTER_WIDTH + j;
+
+			gpe_index = (i * ACPI_GPE_REGISTER_WIDTH) + j;
 			gpe_event_info = &gpe_block->event_info[gpe_index];
 
 			if (gpe_event_info->flags & ACPI_GPE_CAN_WAKE) {
 				wake_gpe_count++;
-				if (acpi_gbl_leave_wake_gpes_disabled)
+				if (acpi_gbl_leave_wake_gpes_disabled) {
 					continue;
+				}
 			}
 
-			if (!(gpe_event_info->flags & ACPI_GPE_DISPATCH_METHOD))
+			/* Ignore GPEs that have no corresponding _Lxx/_Exx method */
+
+			if (!(gpe_event_info->flags & ACPI_GPE_DISPATCH_METHOD)) {
 				continue;
+			}
+
+			/* Enable this GPE */
 
 			gpe_number = gpe_index + gpe_block->block_base_number;
 			status = acpi_enable_gpe(gpe_device, gpe_number,
-						ACPI_GPE_TYPE_RUNTIME);
-			if (ACPI_FAILURE(status))
-				ACPI_ERROR((AE_INFO,
-						"Failed to enable GPE %02X\n",
+						 ACPI_GPE_TYPE_RUNTIME);
+			if (ACPI_FAILURE(status)) {
+				ACPI_EXCEPTION((AE_INFO, status,
+						"Could not enable GPE 0x%02X",
 						gpe_number));
-			else
-				gpe_enabled_count++;
+				continue;
+			}
+
+			gpe_enabled_count++;
 		}
 	}
 
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index ca04823..cc82502 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -682,14 +682,13 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 
 	/* Parameter validation */
 
-	if ((!address) || (type > ACPI_GPE_XRUPT_TYPE_MASK)) {
-		status = AE_BAD_PARAMETER;
-		goto exit;
+	if ((!address) || (type & ~ACPI_GPE_XRUPT_TYPE_MASK)) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
 	if (ACPI_FAILURE(status)) {
-		goto exit;
+		return_ACPI_STATUS(status);
 	}
 
 	/* Ensure that we have a valid GPE number */
@@ -720,6 +719,13 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 	handler->context = context;
 	handler->method_node = gpe_event_info->dispatch.method_node;
 
+	/* Disable the GPE before installing the handler */
+
+	status = acpi_ev_disable_gpe(gpe_event_info);
+	if (ACPI_FAILURE (status)) {
+		goto unlock_and_exit;
+	}
+
 	/* Install the handler */
 
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
@@ -733,12 +739,8 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 
-      unlock_and_exit:
+unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
-      exit:
-	if (ACPI_FAILURE(status))
-		ACPI_EXCEPTION((AE_INFO, status,
-				"Installing notify handler failed"));
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index 5ff32c7..7c7bbb4 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -203,21 +203,26 @@ ACPI_EXPORT_SYMBOL(acpi_enable_event)
  *
  * FUNCTION:    acpi_set_gpe
  *
- * PARAMETERS:  gpe_device      - Parent GPE Device
+ * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
  *              gpe_number      - GPE level within the GPE block
- *              action          - Enable or disable
- *                                Called from ISR or not
+ *              action          - ACPI_GPE_ENABLE or ACPI_GPE_DISABLE
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Enable or disable an ACPI event (general purpose)
+ * DESCRIPTION: Enable or disable an individual GPE. This function bypasses
+ *              the reference count mechanism used in the acpi_enable_gpe and
+ *              acpi_disable_gpe interfaces -- and should be used with care.
+ *
+ * Note: Typically used to disable a runtime GPE for short period of time,
+ * then re-enable it, without disturbing the existing reference counts. This
+ * is useful, for example, in the Embedded Controller (EC) driver.
  *
  ******************************************************************************/
 acpi_status acpi_set_gpe(acpi_handle gpe_device, u32 gpe_number, u8 action)
 {
-	acpi_status status = AE_OK;
-	acpi_cpu_flags flags;
 	struct acpi_gpe_event_info *gpe_event_info;
+	acpi_status status;
+	acpi_cpu_flags flags;
 
 	ACPI_FUNCTION_TRACE(acpi_set_gpe);
 
@@ -243,7 +248,6 @@ acpi_status acpi_set_gpe(acpi_handle gpe_device, u32 gpe_number, u8 action)
 		break;
 
 	default:
-		ACPI_ERROR((AE_INFO, "Invalid action\n"));
 		status = AE_BAD_PARAMETER;
 		break;
 	}
@@ -259,25 +263,31 @@ ACPI_EXPORT_SYMBOL(acpi_set_gpe)
  *
  * FUNCTION:    acpi_enable_gpe
  *
- * PARAMETERS:  gpe_device      - Parent GPE Device
+ * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
  *              gpe_number      - GPE level within the GPE block
- *              type            - Purpose the GPE will be used for
+ *              gpe_type        - ACPI_GPE_TYPE_RUNTIME or ACPI_GPE_TYPE_WAKE
+ *                                or both
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Take a reference to a GPE and enable it if necessary
+ * DESCRIPTION: Add a reference to a GPE. On the first reference, the GPE is
+ *              hardware-enabled (for runtime GPEs), or the GPE register mask
+ *              is updated (for wake GPEs).
  *
  ******************************************************************************/
-acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 type)
+acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 gpe_type)
 {
 	acpi_status status = AE_OK;
-	acpi_cpu_flags flags;
 	struct acpi_gpe_event_info *gpe_event_info;
+	acpi_cpu_flags flags;
 
 	ACPI_FUNCTION_TRACE(acpi_enable_gpe);
 
-	if (type & ~ACPI_GPE_TYPE_WAKE_RUN)
+	/* Parameter validation */
+
+	if (!gpe_type || (gpe_type & ~ACPI_GPE_TYPE_WAKE_RUN)) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
 
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
@@ -289,26 +299,43 @@ acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 type)
 		goto unlock_and_exit;
 	}
 
-	if (type & ACPI_GPE_TYPE_RUNTIME) {
-		if (++gpe_event_info->runtime_count == 1) {
+	if (gpe_type & ACPI_GPE_TYPE_RUNTIME) {
+		if (gpe_event_info->runtime_count == ACPI_UINT8_MAX) {
+			status = AE_LIMIT;	/* Too many references */
+			goto unlock_and_exit;
+		}
+
+		gpe_event_info->runtime_count++;
+		if (gpe_event_info->runtime_count == 1) {
 			status = acpi_ev_enable_gpe(gpe_event_info);
-			if (ACPI_FAILURE(status))
+			if (ACPI_FAILURE(status)) {
 				gpe_event_info->runtime_count--;
+				goto unlock_and_exit;
+			}
 		}
 	}
 
-	if (type & ACPI_GPE_TYPE_WAKE) {
+	if (gpe_type & ACPI_GPE_TYPE_WAKE) {
+		/* The GPE must have the ability to wake the system */
+
 		if (!(gpe_event_info->flags & ACPI_GPE_CAN_WAKE)) {
-			status = AE_BAD_PARAMETER;
+			status = AE_TYPE;
+			goto unlock_and_exit;
+		}
+
+		if (gpe_event_info->wakeup_count == ACPI_UINT8_MAX) {
+			status = AE_LIMIT;	/* Too many references */
 			goto unlock_and_exit;
 		}
 
 		/*
-		 * Wake-up GPEs are only enabled right prior to putting the
-		 * system into a sleep state.
+		 * Update the enable mask on the first wakeup reference. Wake GPEs
+		 * are only hardware-enabled just before sleeping.
 		 */
-		if (++gpe_event_info->wakeup_count == 1)
-			acpi_ev_update_gpe_enable_masks(gpe_event_info);
+		gpe_event_info->wakeup_count++;
+		if (gpe_event_info->wakeup_count == 1) {
+			(void)acpi_ev_update_gpe_enable_masks(gpe_event_info);
+		}
 	}
 
 unlock_and_exit:
@@ -321,27 +348,34 @@ ACPI_EXPORT_SYMBOL(acpi_enable_gpe)
  *
  * FUNCTION:    acpi_disable_gpe
  *
- * PARAMETERS:  gpe_device      - Parent GPE Device
+ * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
  *              gpe_number      - GPE level within the GPE block
- *              type            - Purpose the GPE won't be used for any more
+ *              gpe_type        - ACPI_GPE_TYPE_RUNTIME or ACPI_GPE_TYPE_WAKE
+ *                                or both
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Release a reference to a GPE and disable it if necessary
+ * DESCRIPTION: Remove a reference to a GPE. When the last reference is
+ *              removed, only then is the GPE disabled (for runtime GPEs), or
+ *              the GPE mask bit disabled (for wake GPEs)
  *
  ******************************************************************************/
-acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 type)
+acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 gpe_type)
 {
 	acpi_status status = AE_OK;
-	acpi_cpu_flags flags;
 	struct acpi_gpe_event_info *gpe_event_info;
+	acpi_cpu_flags flags;
 
 	ACPI_FUNCTION_TRACE(acpi_disable_gpe);
 
-	if (type & ~ACPI_GPE_TYPE_WAKE_RUN)
+	/* Parameter validation */
+
+	if (!gpe_type || (gpe_type & ~ACPI_GPE_TYPE_WAKE_RUN)) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
 
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
 	/* Ensure that we have a valid GPE number */
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
@@ -350,18 +384,39 @@ acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 type)
 		goto unlock_and_exit;
 	}
 
-	if ((type & ACPI_GPE_TYPE_RUNTIME) && gpe_event_info->runtime_count) {
-		if (--gpe_event_info->runtime_count == 0)
+	/* Hardware-disable a runtime GPE on removal of the last reference */
+
+	if (gpe_type & ACPI_GPE_TYPE_RUNTIME) {
+		if (!gpe_event_info->runtime_count) {
+			status = AE_LIMIT;	/* There are no references to remove */
+			goto unlock_and_exit;
+		}
+
+		gpe_event_info->runtime_count--;
+		if (!gpe_event_info->runtime_count) {
 			status = acpi_ev_disable_gpe(gpe_event_info);
+			if (ACPI_FAILURE(status)) {
+				gpe_event_info->runtime_count++;
+				goto unlock_and_exit;
+			}
+		}
 	}
 
-	if ((type & ACPI_GPE_TYPE_WAKE) && gpe_event_info->wakeup_count) {
-		/*
-		 * Wake-up GPEs are not enabled after leaving system sleep
-		 * states, so we don't need to disable them here.
-		 */
-		if (--gpe_event_info->wakeup_count == 0)
-			acpi_ev_update_gpe_enable_masks(gpe_event_info);
+	/*
+	 * Update masks for wake GPE on removal of the last reference.
+	 * No need to hardware-disable wake GPEs here, they are not currently
+	 * enabled.
+	 */
+	if (gpe_type & ACPI_GPE_TYPE_WAKE) {
+		if (!gpe_event_info->wakeup_count) {
+			status = AE_LIMIT;	/* There are no references to remove */
+			goto unlock_and_exit;
+		}
+
+		gpe_event_info->wakeup_count--;
+		if (!gpe_event_info->wakeup_count) {
+			(void)acpi_ev_update_gpe_enable_masks(gpe_event_info);
+		}
 	}
 
 unlock_and_exit:
@@ -465,30 +520,23 @@ ACPI_EXPORT_SYMBOL(acpi_clear_event)
  *
  * FUNCTION:    acpi_clear_gpe
  *
- * PARAMETERS:  gpe_device      - Parent GPE Device
+ * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
  *              gpe_number      - GPE level within the GPE block
- *              Flags           - Called from an ISR or not
  *
  * RETURN:      Status
  *
  * DESCRIPTION: Clear an ACPI event (general purpose)
  *
  ******************************************************************************/
-acpi_status acpi_clear_gpe(acpi_handle gpe_device, u32 gpe_number, u32 flags)
+acpi_status acpi_clear_gpe(acpi_handle gpe_device, u32 gpe_number)
 {
 	acpi_status status = AE_OK;
 	struct acpi_gpe_event_info *gpe_event_info;
+	acpi_cpu_flags flags;
 
 	ACPI_FUNCTION_TRACE(acpi_clear_gpe);
 
-	/* Use semaphore lock if not executing at interrupt level */
-
-	if (flags & ACPI_NOT_ISR) {
-		status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
-		}
-	}
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
 	/* Ensure that we have a valid GPE number */
 
@@ -501,9 +549,7 @@ acpi_status acpi_clear_gpe(acpi_handle gpe_device, u32 gpe_number, u32 flags)
 	status = acpi_hw_clear_gpe(gpe_event_info);
 
       unlock_and_exit:
-	if (flags & ACPI_NOT_ISR) {
-		(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
-	}
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
 }
 
@@ -569,9 +615,8 @@ ACPI_EXPORT_SYMBOL(acpi_get_event_status)
  *
  * FUNCTION:    acpi_get_gpe_status
  *
- * PARAMETERS:  gpe_device      - Parent GPE Device
+ * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
  *              gpe_number      - GPE level within the GPE block
- *              Flags           - Called from an ISR or not
  *              event_status    - Where the current status of the event will
  *                                be returned
  *
@@ -582,21 +627,15 @@ ACPI_EXPORT_SYMBOL(acpi_get_event_status)
  ******************************************************************************/
 acpi_status
 acpi_get_gpe_status(acpi_handle gpe_device,
-		    u32 gpe_number, u32 flags, acpi_event_status * event_status)
+		    u32 gpe_number, acpi_event_status *event_status)
 {
 	acpi_status status = AE_OK;
 	struct acpi_gpe_event_info *gpe_event_info;
+	acpi_cpu_flags flags;
 
 	ACPI_FUNCTION_TRACE(acpi_get_gpe_status);
 
-	/* Use semaphore lock if not executing at interrupt level */
-
-	if (flags & ACPI_NOT_ISR) {
-		status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
-		}
-	}
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
 	/* Ensure that we have a valid GPE number */
 
@@ -614,9 +653,7 @@ acpi_get_gpe_status(acpi_handle gpe_device,
 		*event_status |= ACPI_EVENT_FLAG_HANDLE;
 
       unlock_and_exit:
-	if (flags & ACPI_NOT_ISR) {
-		(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
-	}
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
 }
 
@@ -673,20 +710,15 @@ acpi_install_gpe_block(acpi_handle gpe_device,
 		goto unlock_and_exit;
 	}
 
-	/* Run the _PRW methods and enable the GPEs */
-
-	status = acpi_ev_initialize_gpe_block(node, gpe_block);
-	if (ACPI_FAILURE(status)) {
-		goto unlock_and_exit;
-	}
-
-	/* Get the device_object attached to the node */
+	/* Install block in the device_object attached to the node */
 
 	obj_desc = acpi_ns_get_attached_object(node);
 	if (!obj_desc) {
 
-		/* No object, create a new one */
-
+		/*
+		 * No object, create a new one (Device nodes do not always have
+		 * an attached object)
+		 */
 		obj_desc = acpi_ut_create_internal_object(ACPI_TYPE_DEVICE);
 		if (!obj_desc) {
 			status = AE_NO_MEMORY;
@@ -705,10 +737,14 @@ acpi_install_gpe_block(acpi_handle gpe_device,
 		}
 	}
 
-	/* Install the GPE block in the device_object */
+	/* Now install the GPE block in the device_object */
 
 	obj_desc->device.gpe_block = gpe_block;
 
+	/* Run the _PRW methods and enable the runtime GPEs in the new block */
+
+	status = acpi_ev_initialize_gpe_block(node, gpe_block);
+
       unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
@@ -839,8 +875,7 @@ acpi_ev_get_gpe_device(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 
 	/* Increment Index by the number of GPEs in this block */
 
-	info->next_block_base_index +=
-	    (gpe_block->register_count * ACPI_GPE_REGISTER_WIDTH);
+	info->next_block_base_index += gpe_block->gpe_count;
 
 	if (info->index < info->next_block_base_index) {
 		/*
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index 3f3f48b..10e104c 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -119,33 +119,6 @@ acpi_status acpi_ex_opcode_2A_0T_0R(struct acpi_walk_state *walk_state)
 			status = AE_AML_OPERAND_TYPE;
 			break;
 		}
-#ifdef ACPI_GPE_NOTIFY_CHECK
-		/*
-		 * GPE method wake/notify check.  Here, we want to ensure that we
-		 * don't receive any "DeviceWake" Notifies from a GPE _Lxx or _Exx
-		 * GPE method during system runtime.  If we do, the GPE is marked
-		 * as "wake-only" and disabled.
-		 *
-		 * 1) Is the Notify() value == device_wake?
-		 * 2) Is this a GPE deferred method?  (An _Lxx or _Exx method)
-		 * 3) Did the original GPE happen at system runtime?
-		 *    (versus during wake)
-		 *
-		 * If all three cases are true, this is a wake-only GPE that should
-		 * be disabled at runtime.
-		 */
-		if (value == 2) {	/* device_wake */
-			status =
-			    acpi_ev_check_for_wake_only_gpe(walk_state->
-							    gpe_event_info);
-			if (ACPI_FAILURE(status)) {
-
-				/* AE_WAKE_ONLY_GPE only error, means ignore this notify */
-
-				return_ACPI_STATUS(AE_OK)
-			}
-		}
-#endif
 
 		/*
 		 * Dispatch the notify to the appropriate handler
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0338f51..7f2e051 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -765,7 +765,7 @@ static void acpi_bus_set_run_wake_flags(struct acpi_device *device)
 	}
 
 	status = acpi_get_gpe_status(NULL, device->wakeup.gpe_number,
-					ACPI_NOT_ISR, &event_status);
+					&event_status);
 	if (status == AE_OK)
 		device->wakeup.flags.run_wake =
 				!!(event_status & ACPI_EVENT_FLAG_HANDLE);
diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index 4aaf249..e35525b 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -303,8 +303,7 @@ static int get_status(u32 index, acpi_event_status *status, acpi_handle *handle)
 				"Invalid GPE 0x%x\n", index));
 			goto end;
 		}
-		result = acpi_get_gpe_status(*handle, index,
-						ACPI_NOT_ISR, status);
+		result = acpi_get_gpe_status(*handle, index, status);
 	} else if (index < (num_gpes + ACPI_NUM_FIXED_EVENTS))
 		result = acpi_get_event_status(index - num_gpes, status);
 
@@ -395,7 +394,7 @@ static ssize_t counter_set(struct kobject *kobj,
 			result = acpi_set_gpe(handle, index, ACPI_GPE_ENABLE);
 		else if (!strcmp(buf, "clear\n") &&
 				(status & ACPI_EVENT_FLAG_SET))
-			result = acpi_clear_gpe(handle, index, ACPI_NOT_ISR);
+			result = acpi_clear_gpe(handle, index);
 		else
 			all_counters[index].count = strtoul(buf, NULL, 0);
 	} else if (index < num_gpes + ACPI_NUM_FIXED_EVENTS) {
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 5b2e5e8..5958d78 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -87,7 +87,7 @@
 #define AE_NO_GLOBAL_LOCK               (acpi_status) (0x0017 | AE_CODE_ENVIRONMENTAL)
 #define AE_ABORT_METHOD                 (acpi_status) (0x0018 | AE_CODE_ENVIRONMENTAL)
 #define AE_SAME_HANDLER                 (acpi_status) (0x0019 | AE_CODE_ENVIRONMENTAL)
-#define AE_WAKE_ONLY_GPE                (acpi_status) (0x001A | AE_CODE_ENVIRONMENTAL)
+#define AE_NO_HANDLER                   (acpi_status) (0x001A | AE_CODE_ENVIRONMENTAL)
 #define AE_OWNER_ID_LIMIT               (acpi_status) (0x001B | AE_CODE_ENVIRONMENTAL)
 
 #define AE_CODE_ENV_MAX                 0x001B
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index fd815f6..be16f97 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -285,16 +285,17 @@ acpi_status acpi_get_event_status(u32 event, acpi_event_status * event_status);
  */
 acpi_status acpi_set_gpe(acpi_handle gpe_device, u32 gpe_number, u8 action);
 
-acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 type);
+acpi_status
+acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 gpe_type);
 
-acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 type);
+acpi_status
+acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 gpe_type);
 
-acpi_status acpi_clear_gpe(acpi_handle gpe_device, u32 gpe_number, u32 flags);
+acpi_status acpi_clear_gpe(acpi_handle gpe_device, u32 gpe_number);
 
 acpi_status
 acpi_get_gpe_status(acpi_handle gpe_device,
-		    u32 gpe_number,
-		    u32 flags, acpi_event_status * event_status);
+		    u32 gpe_number, acpi_event_status *event_status);
 
 acpi_status acpi_disable_all_gpes(void);
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 3f08e64..de5e99a 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -663,44 +663,42 @@ typedef u32 acpi_event_status;
 #define ACPI_GPE_MAX                    0xFF
 #define ACPI_NUM_GPE                    256
 
+/* Actions for acpi_set_gpe */
+
 #define ACPI_GPE_ENABLE                 0
 #define ACPI_GPE_DISABLE                1
 
+/* gpe_types for acpi_enable_gpe and acpi_disable_gpe */
+
+#define ACPI_GPE_TYPE_WAKE              (u8) 0x01
+#define ACPI_GPE_TYPE_RUNTIME           (u8) 0x02
+#define ACPI_GPE_TYPE_WAKE_RUN          (u8) 0x03
+
 /*
  * GPE info flags - Per GPE
- * +-+-+-+---+-+-+-+
- * |7|6|5|4:3|2|1|0|
- * +-+-+-+---+-+-+-+
- *  | | |  |  | | |
- *  | | |  |  | | +--- Interrupt type: Edge or Level Triggered
- *  | | |  |  | +--- GPE can wake the system
- *  | | |  |  +--- Unused
- *  | | |  +--- Type of dispatch -- to method, handler, or none
- *  | | +--- Unused
- *  | +--- Unused
- *  +--- Unused
+ * +-------+---+-+-+
+ * |  7:4  |3:2|1|0|
+ * +-------+---+-+-+
+ *     |     |  | |
+ *     |     |  | +--- Interrupt type: edge or level triggered
+ *     |     |  +----- GPE can wake the system
+ *     |     +-------- Type of dispatch:to method, handler, or none
+ *     +-------------- <Reserved>
  */
 #define ACPI_GPE_XRUPT_TYPE_MASK        (u8) 0x01
 #define ACPI_GPE_LEVEL_TRIGGERED        (u8) 0x01
 #define ACPI_GPE_EDGE_TRIGGERED         (u8) 0x00
 
-#define ACPI_GPE_TYPE_MASK              (u8) 0x06
-#define ACPI_GPE_TYPE_WAKE_RUN          (u8) 0x06
-#define ACPI_GPE_TYPE_WAKE              (u8) 0x02
-#define ACPI_GPE_TYPE_RUNTIME           (u8) 0x04	/* Default */
 #define ACPI_GPE_CAN_WAKE		(u8) 0x02
 
-#define ACPI_GPE_DISPATCH_MASK          (u8) 0x18
-#define ACPI_GPE_DISPATCH_HANDLER       (u8) 0x08
-#define ACPI_GPE_DISPATCH_METHOD        (u8) 0x10
-#define ACPI_GPE_DISPATCH_NOT_USED      (u8) 0x00	/* Default */
+#define ACPI_GPE_DISPATCH_MASK          (u8) 0x0C
+#define ACPI_GPE_DISPATCH_HANDLER       (u8) 0x04
+#define ACPI_GPE_DISPATCH_METHOD        (u8) 0x08
+#define ACPI_GPE_DISPATCH_NOT_USED      (u8) 0x00
 
 /*
  * Flags for GPE and Lock interfaces
  */
-#define ACPI_EVENT_WAKE_ENABLE          0x2	/* acpi_gpe_enable */
-#define ACPI_EVENT_WAKE_DISABLE         0x2	/* acpi_gpe_disable */
-
 #define ACPI_NOT_ISR                    0x1
 #define ACPI_ISR                        0x0
 

>From 881a682a278c7b9d956c3dc36581210880d109f5 Mon Sep 17 00:00:00 2001
From: Robert Moore <robert.moore@intel.com>
Date: Thu, 8 Apr 2010 14:57:43 +0800
Subject: [PATCH 9/9] ACPICA: Update version to 20100331.

Version 20100331.

Signed-off-by: Robert Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index be16f97..e5bce4c 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20100304
+#define ACPI_CA_VERSION                 0x20100331
 
 #include "actypes.h"
 #include "actbl.h"


--=-Nhb8sZ8towgswlRkuPB+--

