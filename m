From: Len Brown <lenb@kernel.org>
Subject: [PATCH 34/41] ACPI: acpi_madt_entry_handler() is not MADT specific
Date: Tue, 13 Feb 2007 00:49:36 -0500
Message-ID: <11713458242872-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org> <11713458052158-git-send-email-lenb@kernel.org> <11713458062930-git-send-email-lenb@kernel.org> <11713458071963-git-send-email
 -lenb@kernel.org> <11713458083103-git-send-email-lenb@kernel.org> <11713458101527-git-send-email-lenb@kernel.org> <11713458113695-git-send-email-lenb@kernel.org> <11713458122380-git-send-email-lenb@kernel.org> <11713458132236-git-send-email-lenb@kernel.org> <11713458143449-git-send-email-lenb@kernel.org> <11713458152188-git-send-email-lenb@kernel.org> <11713458163685-git-send-email-lenb@kernel.org> <11713458171374-git-send-email-lenb@kernel.org> <11713458183917-git-send-email-lenb@kernel.org> <11713458191475-git-send-email-lenb@kernel.org> <11713458202747-git-send-email-lenb@kernel.org> <11713458211458-git-send-email-lenb@kernel.org> <11713458222751-git-send-email-lenb@kernel.org> <11713458233765-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:39554 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751095AbXBMFu3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:29 -0500
In-Reply-To: <11713458233765-git-send-email-lenb@kernel.org>
Message-Id: <87eca7b63a8090b0fa701afcb7eeb0786e4d27e7.1171345631.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

acpi_madt_entry_handler() is also used for the SRAT,
so re-name it acpi_table_entry_handler().

cosmetic only.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/numa.c   |    4 ++--
 drivers/acpi/tables.c |    4 ++--
 include/linux/acpi.h  |    6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index b33daf8..fd21e20 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -48,7 +48,7 @@ int __cpuinitdata node_to_pxm_map[MAX_NUMNODES]
 extern int __init acpi_table_parse_madt_family(char *id,
 					       unsigned long madt_size,
 					       int entry_id,
-					       acpi_madt_entry_handler handler,
+					       acpi_table_entry_handler handler,
 					       unsigned int max_entries);
 
 int __cpuinit pxm_to_node(int pxm)
@@ -208,7 +208,7 @@ static int __init acpi_parse_srat(struct acpi_table_header *table)
 
 int __init
 acpi_table_parse_srat(enum acpi_srat_type id,
-		      acpi_madt_entry_handler handler, unsigned int max_entries)
+		      acpi_table_entry_handler handler, unsigned int max_entries)
 {
 	return acpi_table_parse_madt_family(ACPI_SIG_SRAT,
 					    sizeof(struct acpi_table_srat), id,
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 2075ec7..f211fa3 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -173,7 +173,7 @@ int __init
 acpi_table_parse_madt_family(char *id,
 			     unsigned long madt_size,
 			     int entry_id,
-			     acpi_madt_entry_handler handler,
+			     acpi_table_entry_handler handler,
 			     unsigned int max_entries)
 {
 	struct acpi_table_header *madt = NULL;
@@ -219,7 +219,7 @@ acpi_table_parse_madt_family(char *id,
 
 int __init
 acpi_table_parse_madt(enum acpi_madt_type id,
-		      acpi_madt_entry_handler handler, unsigned int max_entries)
+		      acpi_table_entry_handler handler, unsigned int max_entries)
 {
 	return acpi_table_parse_madt_family(ACPI_SIG_MADT,
 					    sizeof(struct acpi_table_madt), id,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 815f1fb..15a23b6 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -75,7 +75,7 @@ enum acpi_address_range_id {
 
 typedef int (*acpi_table_handler) (struct acpi_table_header *table);
 
-typedef int (*acpi_madt_entry_handler) (struct acpi_subtable_header *header, const unsigned long end);
+typedef int (*acpi_table_entry_handler) (struct acpi_subtable_header *header, const unsigned long end);
 
 char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
 unsigned long acpi_find_rsdp (void);
@@ -85,8 +85,8 @@ int acpi_numa_init (void);
 
 int acpi_table_init (void);
 int acpi_table_parse (char *id, acpi_table_handler handler);
-int acpi_table_parse_madt (enum acpi_madt_type id, acpi_madt_entry_handler handler, unsigned int max_entries);
-int acpi_table_parse_srat (enum acpi_srat_type id, acpi_madt_entry_handler handler, unsigned int max_entries);
+int acpi_table_parse_madt (enum acpi_madt_type id, acpi_table_entry_handler handler, unsigned int max_entries);
+int acpi_table_parse_srat (enum acpi_srat_type id, acpi_table_entry_handler handler, unsigned int max_entries);
 int acpi_parse_mcfg (struct acpi_table_header *header);
 void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
 void acpi_table_print_srat_entry (struct acpi_subtable_header *srat);
-- 
1.5.0.rc4.345.gb4d2
