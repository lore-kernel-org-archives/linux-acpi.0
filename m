From: Len Brown <lenb@kernel.org>
Subject: [PATCH 41/84] ACPICA: Update DMAR and SRAT table definitions
Date: Sat, 28 Jun 2008 01:43:45 -0400
Message-ID: <fd64eb6efd9807558121409771dc1db1b61dd4c4.1214631214.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:34533 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbYF1FpS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:18 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3500DAXRNYVC73@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:38:23 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Synchronized tables with current specifications.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/srat_32.c |    3 +--
 drivers/acpi/numa.c       |    4 ++--
 include/acpi/actbl1.h     |   19 +++++++++++++++++--
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/srat_32.c b/arch/x86/kernel/srat_32.c
index a29192f..0142476 100644
--- a/arch/x86/kernel/srat_32.c
+++ b/arch/x86/kernel/srat_32.c
@@ -126,9 +126,8 @@ static void __init parse_memory_affinity_structure (char *sratp)
 
 	num_memory_chunks++;
 
-	printk("Memory range 0x%lX to 0x%lX (type 0x%X) in proximity domain 0x%02X %s\n",
+	printk("Memory range 0x%lX to 0x%lX in proximity domain 0x%02X %s\n",
 		start_pfn, end_pfn,
-		memory_affinity->memory_type,
 		pxm,
 		((memory_affinity->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) ?
 		 "enabled and removable" : "enabled" ) );
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 658e5f3..cb9864e 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -120,10 +120,10 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 			struct acpi_srat_mem_affinity *p =
 			    (struct acpi_srat_mem_affinity *)header;
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "SRAT Memory (0x%lx length 0x%lx type 0x%x) in proximity domain %d %s%s\n",
+					  "SRAT Memory (0x%lx length 0x%lx) in proximity domain %d %s%s\n",
 					  (unsigned long)p->base_address,
 					  (unsigned long)p->length,
-					  p->memory_type, p->proximity_domain,
+					  p->proximity_domain,
 					  (p->flags & ACPI_SRAT_MEM_ENABLED)?
 					  "enabled" : "disabled",
 					  (p->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)?
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 9af239b..715a489 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -300,6 +300,7 @@ struct acpi_table_dbgp {
 /*******************************************************************************
  *
  * DMAR - DMA Remapping table
+ *        From "Intel Virtualization Technology for Directed I/O", Sept. 2007
  *
  ******************************************************************************/
 
@@ -382,6 +383,20 @@ struct acpi_dmar_reserved_memory {
 
 #define ACPI_DMAR_ALLOW_ALL         (1)
 
+
+/* 2: Root Port ATS Capability Reporting Structure */
+
+struct acpi_dmar_atsr {
+       struct acpi_dmar_header header;
+       u8 flags;
+       u8 reserved;
+       u16 segment;
+};
+
+/* Flags */
+
+#define ACPI_DMAR_ALL_PORTS         (1)
+
 /*******************************************************************************
  *
  * ECDT - Embedded Controller Boot Resources Table
@@ -1156,9 +1171,9 @@ struct acpi_srat_mem_affinity {
 	u16 reserved;		/* Reserved, must be zero */
 	u64 base_address;
 	u64 length;
-	u32 memory_type;	/* See acpi_address_range_id */
+       u32 reserved1;
 	u32 flags;
-	u64 reserved1;		/* Reserved, must be zero */
+       u64 reserved2;          /* Reserved, must be zero */
 };
 
 /* Flags */
-- 
1.5.6.1.89.gd544

