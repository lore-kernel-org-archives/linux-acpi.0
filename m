From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [RFC] ACPI: Add new function to get table entries
Date: Wed, 19 Mar 2014 19:09:28 -0400
Message-ID: <1395270568-30021-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:48771 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbaCSXJt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Mar 2014 19:09:49 -0400
Received: by mail-qa0-f49.google.com with SMTP id j7so38918qaq.22
        for <linux-acpi@vger.kernel.org>; Wed, 19 Mar 2014 16:09:48 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

The acpi_table_parse() function has a callback that
passes a pointer to a table_header. Add a new function
which takes this pointer and parses its entries. This
eliminates the need to re-traverse all the tables for
each call. e.g. as in acpi_table_parse_madt() which is
normally called after acpi_table_parse().

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/acpi/tables.c | 69 +++++++++++++++++++++++++++++++++++----------------
 include/linux/acpi.h  |  4 +++
 2 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 5837f85..b7bd6a3 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -199,19 +199,15 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 	}
 }
 
-
 int __init
-acpi_table_parse_entries(char *id,
-			     unsigned long table_size,
-			     int entry_id,
-			     acpi_tbl_entry_handler handler,
-			     unsigned int max_entries)
+acpi_parse_entries(unsigned long table_size,
+		acpi_tbl_entry_handler handler,
+		struct acpi_table_header *table_header,
+		int entry_id, unsigned int max_entries)
 {
-	struct acpi_table_header *table_header = NULL;
 	struct acpi_subtable_header *entry;
 	unsigned int count = 0;
 	unsigned long table_end;
-	acpi_size tbl_size;
 
 	if (acpi_disabled)
 		return -ENODEV;
@@ -219,16 +215,14 @@ acpi_table_parse_entries(char *id,
 	if (!handler)
 		return -EINVAL;
 
-	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
-		acpi_get_table_with_size(id, acpi_apic_instance, &table_header, &tbl_size);
-	else
-		acpi_get_table_with_size(id, 0, &table_header, &tbl_size);
-
 	if (!table_header) {
-		printk(KERN_WARNING PREFIX "%4.4s not present\n", id);
+		pr_warn(PREFIX "Table header not present\n");
 		return -ENODEV;
 	}
 
+	if (!table_size)
+		table_size = table_header->length;
+
 	table_end = (unsigned long)table_header + table_header->length;
 
 	/* Parse all entries looking for a match. */
@@ -240,15 +234,18 @@ acpi_table_parse_entries(char *id,
 	       table_end) {
 		if (entry->type == entry_id
 		    && (!max_entries || count++ < max_entries))
-			if (handler(entry, table_end))
+			if (handler(entry, table_end)) {
+				count = -EINVAL;
 				goto err;
+			}
 
 		/*
 		 * If entry->length is 0, break from this loop to avoid
 		 * infinite loop.
 		 */
 		if (entry->length == 0) {
-			pr_err(PREFIX "[%4.4s:0x%02x] Invalid zero length\n", id, entry_id);
+			pr_err(PREFIX "[0x%02x] Invalid zero length\n", entry_id);
+			count = -EINVAL;
 			goto err;
 		}
 
@@ -256,15 +253,43 @@ acpi_table_parse_entries(char *id,
 		    ((unsigned long)entry + entry->length);
 	}
 	if (max_entries && count > max_entries) {
-		printk(KERN_WARNING PREFIX "[%4.4s:0x%02x] ignored %i entries of "
-		       "%i found\n", id, entry_id, count - max_entries, count);
+		printk(KERN_WARNING PREFIX "[0x%02x] ignored %i entries of "
+		       "%i found\n", entry_id, count - max_entries, count);
 	}
 
-	early_acpi_os_unmap_memory((char *)table_header, tbl_size);
-	return count;
 err:
-	early_acpi_os_unmap_memory((char *)table_header, tbl_size);
-	return -EINVAL;
+	early_acpi_os_unmap_memory((char *)table_header, (acpi_size)table_size);
+	return count;
+}
+
+int __init
+acpi_table_parse_entries(char *id,
+			     unsigned long table_size,
+			     int entry_id,
+			     acpi_tbl_entry_handler handler,
+			     unsigned int max_entries)
+{
+	struct acpi_table_header *table_header = NULL;
+	acpi_size tbl_size;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	if (!handler)
+		return -EINVAL;
+
+	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
+		acpi_get_table_with_size(id, acpi_apic_instance, &table_header, &tbl_size);
+	else
+		acpi_get_table_with_size(id, 0, &table_header, &tbl_size);
+
+	if (!table_header) {
+		pr_warn("%4.4s not present\n", id);
+		return -ENODEV;
+	}
+
+	return acpi_parse_entries(table_header->length, handler, table_header,
+			entry_id, max_entries);
 }
 
 int __init
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 1151a1d..da959fd 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -118,6 +118,10 @@ int acpi_numa_init (void);
 
 int acpi_table_init (void);
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
+int __init acpi_parse_entries(unsigned long table_size,
+		acpi_tbl_entry_handler handler,
+		struct acpi_table_header *table_header,
+		int entry_id, unsigned int max_entries);
 int __init acpi_table_parse_entries(char *id, unsigned long table_size,
 				    int entry_id,
 				    acpi_tbl_entry_handler handler,
-- 
1.8.3.2

