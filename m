From: Len Brown <lenb@kernel.org>
Subject: [PATCH 35/41] ACPI: acpi_table_parse_madt_family() is not MADT specific
Date: Tue, 13 Feb 2007 00:49:37 -0500
Message-ID: <11713458251648-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org> <11713458052158-git-send-email-lenb@kernel.org> <11713458062930-git-send-email-lenb@kernel.org> <11713458071963-git-send-email
 -lenb@kernel.org> <11713458083103-git-send-email-lenb@kernel.org> <11713458101527-git-send-email-lenb@kernel.org> <11713458113695-git-send-email-lenb@kernel.org> <11713458122380-git-send-email-lenb@kernel.org> <11713458132236-git-send-email-lenb@kernel.org> <11713458143449-git-send-email-lenb@kernel.org> <11713458152188-git-send-email-lenb@kernel.org> <11713458163685-git-send-email-lenb@kernel.org> <11713458171374-git-send-email-lenb@kernel.org> <11713458183917-git-send-email-lenb@kernel.org> <11713458191475-git-send-email-lenb@kernel.org> <11713458202747-git-send-email-lenb@kernel.org> <11713458211458-git-send-email-lenb@kernel.org> <11713458222751-git-send-email-lenb@kernel.org> <11713458233765-git-send-email-lenb@kernel.org> <11713458242872-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:19853 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751096AbXBMFu3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:29 -0500
In-Reply-To: <11713458242872-git-send-email-lenb@kernel.org>
Message-Id: <efc1b941936bb4b211bdba45616196efbd186fa7.1171345631.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

acpi_table_parse_madt_family() is also used to parse SRAT entries.
So re-name it to acpi_table_parse_entries(), and re-name the
madt-specific variables within it accordingly.

cosmetic only.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/numa.c   |    8 +-------
 drivers/acpi/tables.c |   24 ++++++++++++------------
 include/linux/acpi.h  |    2 ++
 3 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index fd21e20..a651139 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -45,12 +45,6 @@ int __cpuinitdata pxm_to_node_map[MAX_PXM_DOMAINS]
 int __cpuinitdata node_to_pxm_map[MAX_NUMNODES]
 				= { [0 ... MAX_NUMNODES - 1] = PXM_INVAL };
 
-extern int __init acpi_table_parse_madt_family(char *id,
-					       unsigned long madt_size,
-					       int entry_id,
-					       acpi_table_entry_handler handler,
-					       unsigned int max_entries);
-
 int __cpuinit pxm_to_node(int pxm)
 {
 	if (pxm < 0)
@@ -210,7 +204,7 @@ int __init
 acpi_table_parse_srat(enum acpi_srat_type id,
 		      acpi_table_entry_handler handler, unsigned int max_entries)
 {
-	return acpi_table_parse_madt_family(ACPI_SIG_SRAT,
+	return acpi_table_parse_entries(ACPI_SIG_SRAT,
 					    sizeof(struct acpi_table_srat), id,
 					    handler, max_entries);
 }
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index f211fa3..4ed6400 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -170,40 +170,40 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header * header)
 
 
 int __init
-acpi_table_parse_madt_family(char *id,
-			     unsigned long madt_size,
+acpi_table_parse_entries(char *id,
+			     unsigned long table_size,
 			     int entry_id,
 			     acpi_table_entry_handler handler,
 			     unsigned int max_entries)
 {
-	struct acpi_table_header *madt = NULL;
+	struct acpi_table_header *table_header = NULL;
 	struct acpi_subtable_header *entry;
 	unsigned int count = 0;
-	unsigned long madt_end;
+	unsigned long table_end;
 
 	if (!handler)
 		return -EINVAL;
 
-	/* Locate the MADT (if exists). There should only be one. */
-	acpi_get_table(id, 0, &madt);
+	/* Locate the table (if exists). There should only be one. */
+	acpi_get_table(id, 0, &table_header);
 
-	if (!madt) {
+	if (!table_header) {
 		printk(KERN_WARNING PREFIX "%4.4s not present\n", id);
 		return -ENODEV;
 	}
 
-	madt_end = (unsigned long)madt + madt->length;
+	table_end = (unsigned long)table_header + table_header->length;
 
 	/* Parse all entries looking for a match. */
 
 	entry = (struct acpi_subtable_header *)
-	    ((unsigned long)madt + madt_size);
+	    ((unsigned long)table_header + table_size);
 
 	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
-	       madt_end) {
+	       table_end) {
 		if (entry->type == entry_id
 		    && (!max_entries || count++ < max_entries))
-			if (handler(entry, madt_end))
+			if (handler(entry, table_end))
 				return -EINVAL;
 
 		entry = (struct acpi_subtable_header *)
@@ -221,7 +221,7 @@ int __init
 acpi_table_parse_madt(enum acpi_madt_type id,
 		      acpi_table_entry_handler handler, unsigned int max_entries)
 {
-	return acpi_table_parse_madt_family(ACPI_SIG_MADT,
+	return acpi_table_parse_entries(ACPI_SIG_MADT,
 					    sizeof(struct acpi_table_madt), id,
 					    handler, max_entries);
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 15a23b6..8bcfaa4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -85,6 +85,8 @@ int acpi_numa_init (void);
 
 int acpi_table_init (void);
 int acpi_table_parse (char *id, acpi_table_handler handler);
+int __init acpi_table_parse_entries(char *id, unsigned long table_size,
+	int entry_id, acpi_table_entry_handler handler, unsigned int max_entries);
 int acpi_table_parse_madt (enum acpi_madt_type id, acpi_table_entry_handler handler, unsigned int max_entries);
 int acpi_table_parse_srat (enum acpi_srat_type id, acpi_table_entry_handler handler, unsigned int max_entries);
 int acpi_parse_mcfg (struct acpi_table_header *header);
-- 
1.5.0.rc4.345.gb4d2
