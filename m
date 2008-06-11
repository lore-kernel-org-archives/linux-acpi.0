From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/23] ACPI: handle invalid ACPI SLIT table
Date: Wed, 11 Jun 2008 03:59:15 -0400
Message-ID: <55ec3d0614760d54f489cb9a8f5c6b3746e86238.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:59179 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489AbYFKH7f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:35 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2A00GR2GK6Y2Q8@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:52:55 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
In-reply-to: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Fenghua Yu <fenghua.yu@intel.com>

This is a SLIT sanity checking patch.  It moves slit_valid() function to
generic ACPI code and does sanity checking for both x86 and ia64.  It sets up
node_distance with LOCAL_DISTANCE and REMOTE_DISTANCE when hitting invalid
SLIT table on ia64.  It also cleans up unused variable localities in
acpi_parse_slit() on x86.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/kernel/acpi.c |    9 +++++++--
 arch/x86/mm/srat_64.c   |   27 ---------------------------
 drivers/acpi/numa.c     |   31 +++++++++++++++++++++++++++----
 3 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index 853d1f1..43687cc 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -465,7 +465,6 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
 		printk(KERN_ERR
 		       "ACPI 2.0 SLIT: size mismatch: %d expected, %d actual\n",
 		       len, slit->header.length);
-		memset(numa_slit, 10, sizeof(numa_slit));
 		return;
 	}
 	slit_table = slit;
@@ -574,8 +573,14 @@ void __init acpi_numa_arch_fixup(void)
 	printk(KERN_INFO "Number of memory chunks in system = %d\n",
 	       num_node_memblks);
 
-	if (!slit_table)
+	if (!slit_table) {
+		for (i = 0; i < MAX_NUMNODES; i++)
+			for (j = 0; j < MAX_NUMNODES; j++)
+				node_distance(i, j) = i == j ? LOCAL_DISTANCE :
+							REMOTE_DISTANCE;
 		return;
+	}
+
 	memset(numa_slit, -1, sizeof(numa_slit));
 	for (i = 0; i < slit_table->locality_count; i++) {
 		if (!pxm_bit_test(i))
diff --git a/arch/x86/mm/srat_64.c b/arch/x86/mm/srat_64.c
index 3890234..99649dc 100644
--- a/arch/x86/mm/srat_64.c
+++ b/arch/x86/mm/srat_64.c
@@ -97,36 +97,9 @@ static __init inline int srat_disabled(void)
 	return numa_off || acpi_numa < 0;
 }
 
-/*
- * A lot of BIOS fill in 10 (= no distance) everywhere. This messes
- * up the NUMA heuristics which wants the local node to have a smaller
- * distance than the others.
- * Do some quick checks here and only use the SLIT if it passes.
- */
-static __init int slit_valid(struct acpi_table_slit *slit)
-{
-	int i, j;
-	int d = slit->locality_count;
-	for (i = 0; i < d; i++) {
-		for (j = 0; j < d; j++)  {
-			u8 val = slit->entry[d*i + j];
-			if (i == j) {
-				if (val != LOCAL_DISTANCE)
-					return 0;
-			} else if (val <= LOCAL_DISTANCE)
-				return 0;
-		}
-	}
-	return 1;
-}
-
 /* Callback for SLIT parsing */
 void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
 {
-	if (!slit_valid(slit)) {
-		printk(KERN_INFO "ACPI: SLIT table looks invalid. Not used.\n");
-		return;
-	}
 	acpi_slit = slit;
 }
 
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 5d59cb3..658e5f3 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -140,19 +140,42 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 	}
 }
 
+/*
+ * A lot of BIOS fill in 10 (= no distance) everywhere. This messes
+ * up the NUMA heuristics which wants the local node to have a smaller
+ * distance than the others.
+ * Do some quick checks here and only use the SLIT if it passes.
+ */
+static __init int slit_valid(struct acpi_table_slit *slit)
+{
+	int i, j;
+	int d = slit->locality_count;
+	for (i = 0; i < d; i++) {
+		for (j = 0; j < d; j++)  {
+			u8 val = slit->entry[d*i + j];
+			if (i == j) {
+				if (val != LOCAL_DISTANCE)
+					return 0;
+			} else if (val <= LOCAL_DISTANCE)
+				return 0;
+		}
+	}
+	return 1;
+}
+
 static int __init acpi_parse_slit(struct acpi_table_header *table)
 {
 	struct acpi_table_slit *slit;
-	u32 localities;
 
 	if (!table)
 		return -EINVAL;
 
 	slit = (struct acpi_table_slit *)table;
 
-	/* downcast just for %llu vs %lu for i386/ia64  */
-	localities = (u32) slit->locality_count;
-
+	if (!slit_valid(slit)) {
+		printk(KERN_INFO "ACPI: SLIT table looks invalid. Not used.\n");
+		return -EINVAL;
+	}
 	acpi_numa_slit_init(slit);
 
 	return 0;
-- 
1.5.6.rc2.23.gea81e

