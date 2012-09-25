From: "Fenghua Yu" <fenghua.yu@intel.com>
Subject: [PATCH] acpi/tables.c: Harden acpi_table_parse_entries
Date: Tue, 25 Sep 2012 11:11:43 -0700
Message-ID: <1348596703-6178-1-git-send-email-fenghua.yu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4211 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187Ab2IYS10 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Sep 2012 14:27:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Andi Kleen <andi@firstfloor.org>, linux-acpi <linux-acpi@vger.kernel.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>

From: Fenghua Yu <fenghua.yu@intel.com>

Parsing acpi table entries may fall into an infinite loop on a buggy BIOS
which has entry length=0 in acpi table.

Instead of kernel hang with few failure clue which leads to heavy lifting debug
effort, this patch hardens kernel boot by booting into non NUMA mode. The debug
info left in log buffer helps people identify the issue.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/acpi/tables.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index f336bca7..2572d97 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -240,10 +240,17 @@ acpi_table_parse_entries(char *id,
 	       table_end) {
 		if (entry->type == entry_id
 		    && (!max_entries || count++ < max_entries))
-			if (handler(entry, table_end)) {
-				early_acpi_os_unmap_memory((char *)table_header, tbl_size);
-				return -EINVAL;
-			}
+			if (handler(entry, table_end))
+				goto err;
+
+		/*
+		 * If entry->length is 0, break from this loop to avoid
+		 * infinite loop.
+		 */
+		if (entry->length == 0) {
+			pr_err(PREFIX "[%4.4s:0x%02x] Invalid zero length\n", id, entry_id);
+			goto err;
+		}
 
 		entry = (struct acpi_subtable_header *)
 		    ((unsigned long)entry + entry->length);
@@ -255,6 +262,9 @@ acpi_table_parse_entries(char *id,
 
 	early_acpi_os_unmap_memory((char *)table_header, tbl_size);
 	return count;
+err:
+	early_acpi_os_unmap_memory((char *)table_header, tbl_size);
+	return -EINVAL;
 }
 
 int __init
-- 
1.7.2

