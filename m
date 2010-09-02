From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH] acpi: numa: fixed white space and line length issue
Date: Thu,  2 Sep 2010 22:27:47 +0200
Message-ID: <1283459267-6171-1-git-send-email-ralf.thielow@googlemail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rientjes@google.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Ralf Thielow <ralf.thielow@googlemail.com>
List-Id: linux-acpi@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 drivers/acpi/numa.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 5718566..9864c5b 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -102,7 +102,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 					  "SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
 					  p->apic_id, p->local_sapic_eid,
 					  p->proximity_domain_lo,
-					  (p->flags & ACPI_SRAT_CPU_ENABLED)?
+					  (p->flags & ACPI_SRAT_CPU_ENABLED) ?
 					  "enabled" : "disabled"));
 		}
 #endif				/* ACPI_DEBUG_OUTPUT */
@@ -118,9 +118,10 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 					  (unsigned long)p->base_address,
 					  (unsigned long)p->length,
 					  p->proximity_domain,
-					  (p->flags & ACPI_SRAT_MEM_ENABLED)?
+					  (p->flags & ACPI_SRAT_MEM_ENABLED) ?
 					  "enabled" : "disabled",
-					  (p->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)?
+					  (p->flags &
+						ACPI_SRAT_MEM_HOT_PLUGGABLE) ?
 					  " hot-pluggable" : ""));
 		}
 #endif				/* ACPI_DEBUG_OUTPUT */
@@ -236,7 +237,7 @@ acpi_parse_processor_affinity(struct acpi_subtable_header *header,
 }
 
 static int __init
-acpi_parse_memory_affinity(struct acpi_subtable_header * header,
+acpi_parse_memory_affinity(struct acpi_subtable_header *header,
 			   const unsigned long end)
 {
 	struct acpi_srat_mem_affinity *memory_affinity;
@@ -265,7 +266,8 @@ static int __init acpi_parse_srat(struct acpi_table_header *table)
 
 static int __init
 acpi_table_parse_srat(enum acpi_srat_type id,
-		      acpi_table_entry_handler handler, unsigned int max_entries)
+		      acpi_table_entry_handler handler,
+		      unsigned int max_entries)
 {
 	return acpi_table_parse_entries(ACPI_SIG_SRAT,
 					    sizeof(struct acpi_table_srat), id,
-- 
1.7.0.4
