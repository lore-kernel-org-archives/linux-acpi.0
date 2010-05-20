From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/22] ACPICA: Add subsystem option to force copy of DSDT to
 local memory
Date: Thu, 20 May 2010 01:18:38 -0400
Message-ID: <69ec87efa815d69140423014bb5f91e034faac22.1274332657.git.len.brown@intel.com>
References: <1274332730-27370-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:36044 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057Ab0ETGPd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 02:15:33 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P007GDG0X9AM5@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 20 May 2010 01:15:01 -0500 (CDT)
In-reply-to: <1274332730-27370-1-git-send-email-lenb@kernel.org>
In-reply-to: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
References: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Optionally copy the entire DSDT to local memory (instead of
simply mapping it.) There are some BIOSs that corrupt or replace
the original DSDT, creating the need for this option. Default is
FALSE, do not copy the DSDT.

https://bugzilla.kernel.org/show_bug.cgi?id=14679

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
-- 
1.6.0.6

