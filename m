From: Len Brown <lenb@kernel.org>
Subject: [PATCH 29/65] ACPICA: Update Load() to use operation region interfaces
Date: Fri, 29 May 2009 21:42:07 -0400
Message-ID: <3c59f96081259358d9d5d677f4839c36391806b6.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:40281 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755617AbZE3Bmy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:54 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00COKORH7TQ3@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:54 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Replace memory mapping with region access calls. Now, all region
accesses go through the region handler as they should.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exconfig.c |   96 ++++++++++++++++++++++++++++++++-------
 1 files changed, 78 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 0731fd6..eca6f63 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -47,6 +47,7 @@
 #include "acnamesp.h"
 #include "actables.h"
 #include "acdispat.h"
+#include "acevents.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exconfig")
@@ -57,6 +58,10 @@ acpi_ex_add_table(u32 table_index,
 		  struct acpi_namespace_node *parent_node,
 		  union acpi_operand_object **ddb_handle);
 
+static acpi_status
+acpi_ex_region_read(union acpi_operand_object *obj_desc,
+		    u32 length, u8 *buffer);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ex_add_table
@@ -257,6 +262,48 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ex_region_read
+ *
+ * PARAMETERS:  obj_desc        - Region descriptor
+ *              Length          - Number of bytes to read
+ *              Buffer          - Pointer to where to put the data
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Read data from an operation region. The read starts from the
+ *              beginning of the region.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_ex_region_read(union acpi_operand_object *obj_desc, u32 length, u8 *buffer)
+{
+	acpi_status status;
+	acpi_integer value;
+	acpi_physical_address address;
+	u32 i;
+
+	address = obj_desc->region.address;
+
+	/* Bytewise reads */
+
+	for (i = 0; i < length; i++) {
+		status = acpi_ev_address_space_dispatch(obj_desc, ACPI_READ,
+							address, 8, &value);
+		if (ACPI_FAILURE(status)) {
+			return status;
+		}
+
+		*buffer = (u8)value;
+		buffer++;
+		address++;
+	}
+
+	return AE_OK;
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ex_load_op
  *
  * PARAMETERS:  obj_desc        - Region or Buffer/Field where the table will be
@@ -317,18 +364,23 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 			}
 		}
 
-		/*
-		 * Map the table header and get the actual table length. The region
-		 * length is not guaranteed to be the same as the table length.
-		 */
-		table = acpi_os_map_memory(obj_desc->region.address,
-					   sizeof(struct acpi_table_header));
+		/* Get the table header first so we can get the table length */
+
+		table = ACPI_ALLOCATE(sizeof(struct acpi_table_header));
 		if (!table) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 
+		status =
+		    acpi_ex_region_read(obj_desc,
+					sizeof(struct acpi_table_header),
+					ACPI_CAST_PTR(u8, table));
 		length = table->length;
-		acpi_os_unmap_memory(table, sizeof(struct acpi_table_header));
+		ACPI_FREE(table);
+
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
 
 		/* Must have at least an ACPI table header */
 
@@ -337,10 +389,19 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 		}
 
 		/*
-		 * The memory region is not guaranteed to remain stable and we must
-		 * copy the table to a local buffer. For example, the memory region
-		 * is corrupted after suspend on some machines. Dynamically loaded
-		 * tables are usually small, so this overhead is minimal.
+		 * The original implementation simply mapped the table, with no copy.
+		 * However, the memory region is not guaranteed to remain stable and
+		 * we must copy the table to a local buffer. For example, the memory
+		 * region is corrupted after suspend on some machines. Dynamically
+		 * loaded tables are usually small, so this overhead is minimal.
+		 *
+		 * The latest implementation (5/2009) does not use a mapping at all.
+		 * We use the low-level operation region interface to read the table
+		 * instead of the obvious optimization of using a direct mapping.
+		 * This maintains a consistent use of operation regions across the
+		 * entire subsystem. This is important if additional processing must
+		 * be performed in the (possibly user-installed) operation region
+		 * handler. For example, acpi_exec and ASLTS depend on this.
 		 */
 
 		/* Allocate a buffer for the table */
@@ -350,17 +411,16 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 
-		/* Map the entire table and copy it */
+		/* Read the entire table */
 
-		table = acpi_os_map_memory(obj_desc->region.address, length);
-		if (!table) {
+		status = acpi_ex_region_read(obj_desc, length,
+					     ACPI_CAST_PTR(u8,
+							   table_desc.pointer));
+		if (ACPI_FAILURE(status)) {
 			ACPI_FREE(table_desc.pointer);
-			return_ACPI_STATUS(AE_NO_MEMORY);
+			return_ACPI_STATUS(status);
 		}
 
-		ACPI_MEMCPY(table_desc.pointer, table, length);
-		acpi_os_unmap_memory(table, length);
-
 		table_desc.address = obj_desc->region.address;
 		break;
 
-- 
1.6.0.6

