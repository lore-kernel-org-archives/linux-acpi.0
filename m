From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/16] ACPICA: Expand initialization counters to 32 bits
Date: Fri, 04 Jun 2010 15:51:35 -0400
Message-ID: <3dfc3dc8e9f0803d634e07ba89ae766e17dfd9b2.1275680880.git.len.brown@intel.com>
References: <1275681106-8450-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:51797 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498Ab0FDTv7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 15:51:59 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3I002A29UDO0A3@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 04 Jun 2010 14:51:50 -0500 (CDT)
In-reply-to: <1275681106-8450-1-git-send-email-lenb@kernel.org>
In-reply-to: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
References: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Expand the various initialization counters from 16-bit to 32-bit.
Allows for very large namespaces.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acstruct.h |   26 +++++++++++++-------------
 drivers/acpi/acpica/dsinit.c   |   14 +++++++-------
 drivers/acpi/acpica/nsinit.c   |    8 ++++----
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index 161bc0e..0e2c66a 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -127,22 +127,22 @@ struct acpi_walk_state {
 	acpi_parse_upwards ascending_callback;
 };
 
-/* Info used by acpi_ps_init_objects */
+/* Info used by acpi_ns_initialize_objects and acpi_ds_initialize_objects */
 
 struct acpi_init_walk_info {
-	u16 method_count;
-	u16 device_count;
-	u16 op_region_count;
-	u16 field_count;
-	u16 buffer_count;
-	u16 package_count;
-	u16 op_region_init;
-	u16 field_init;
-	u16 buffer_init;
-	u16 package_init;
-	u16 object_count;
-	acpi_owner_id owner_id;
 	u32 table_index;
+	u32 object_count;
+	u32 method_count;
+	u32 device_count;
+	u32 op_region_count;
+	u32 field_count;
+	u32 buffer_count;
+	u32 package_count;
+	u32 op_region_init;
+	u32 field_init;
+	u32 buffer_init;
+	u32 package_init;
+	acpi_owner_id owner_id;
 };
 
 struct acpi_get_devices_info {
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index abe1403..cc4a38c 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -171,12 +171,12 @@ acpi_ds_initialize_objects(u32 table_index,
 			  "**** Starting initialization of namespace objects ****\n"));
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT, "Parsing all Control Methods:"));
 
-	info.method_count = 0;
-	info.op_region_count = 0;
-	info.object_count = 0;
-	info.device_count = 0;
-	info.table_index = table_index;
+	/* Set all init info to zero */
+
+	ACPI_MEMSET(&info, 0, sizeof(struct acpi_init_walk_info));
+
 	info.owner_id = owner_id;
+	info.table_index = table_index;
 
 	/* Walk entire namespace from the supplied root */
 
@@ -204,13 +204,13 @@ acpi_ds_initialize_objects(u32 table_index,
 	}
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "\nTable [%4.4s](id %4.4X) - %hd Objects with %hd Devices %hd Methods %hd Regions\n",
+			      "\nTable [%4.4s](id %4.4X) - %u Objects with %u Devices %u Methods %u Regions\n",
 			      table->signature, owner_id, info.object_count,
 			      info.device_count, info.method_count,
 			      info.op_region_count));
 
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-			  "%hd Methods, %hd Regions\n", info.method_count,
+			  "%u Methods, %u Regions\n", info.method_count,
 			  info.op_region_count));
 
 	return_ACPI_STATUS(AE_OK);
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 9bd6f05..b3d88d8 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -103,8 +103,8 @@ acpi_status acpi_ns_initialize_objects(void)
 	}
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "\nInitialized %hd/%hd Regions %hd/%hd Fields %hd/%hd "
-			      "Buffers %hd/%hd Packages (%hd nodes)\n",
+			      "\nInitialized %u/%u Regions %u/%u Fields %u/%u "
+			      "Buffers %u/%u Packages (%u nodes)\n",
 			      info.op_region_init, info.op_region_count,
 			      info.field_init, info.field_count,
 			      info.buffer_init, info.buffer_count,
@@ -112,9 +112,9 @@ acpi_status acpi_ns_initialize_objects(void)
 			      info.object_count));
 
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-			  "%hd Control Methods found\n", info.method_count));
+			  "%u Control Methods found\n", info.method_count));
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-			  "%hd Op Regions found\n", info.op_region_count));
+			  "%u Op Regions found\n", info.op_region_count));
 
 	return_ACPI_STATUS(AE_OK);
 }
-- 
1.6.0.6

