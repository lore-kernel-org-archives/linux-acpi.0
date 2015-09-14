From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] ACPI: tables: simplify acpi_parse_entries
Date: Mon, 14 Sep 2015 16:14:46 +0100
Message-ID: <1442243686-15845-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46701 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755580AbbINPPG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Sep 2015 11:15:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

acpi_parse_entries passes the table end pointer to the sub-table entry
handler. acpi_parse_entries itself could validate the end of an entry
against the table end using the length in the sub-table entry.

This patch adds the validation of the sub-table entry end using the
length field.This will help to eliminate the need to pass the table end
to the handlers.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/tables.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 17a6fa01a338..145d4f6a1c54 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -217,16 +217,13 @@ acpi_parse_entries(char *id, unsigned long table_size,
 		int entry_id, unsigned int max_entries)
 {
 	struct acpi_subtable_header *entry;
+	void *entry_end, *table_end;
 	int count = 0;
-	unsigned long table_end;
 
 	if (acpi_disabled)
 		return -ENODEV;
 
-	if (!id || !handler)
-		return -EINVAL;
-
-	if (!table_size)
+	if (!id || !handler || !table_size)
 		return -EINVAL;
 
 	if (!table_header) {
@@ -234,34 +231,21 @@ acpi_parse_entries(char *id, unsigned long table_size,
 		return -ENODEV;
 	}
 
-	table_end = (unsigned long)table_header + table_header->length;
+	table_end = (void *)table_header + table_header->length;
 
 	/* Parse all entries looking for a match. */
+	entry = (void *)table_header + table_size;
+	entry_end = (void *)entry + entry->length;
 
-	entry = (struct acpi_subtable_header *)
-	    ((unsigned long)table_header + table_size);
-
-	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
-	       table_end) {
+	while (entry->length && entry_end <= table_end) {
 		if (entry->type == entry_id
 		    && (!max_entries || count < max_entries)) {
-			if (handler(entry, table_end))
+			if (handler(entry, (unsigned long)entry_end))
 				return -EINVAL;
-
 			count++;
 		}
-
-		/*
-		 * If entry->length is 0, break from this loop to avoid
-		 * infinite loop.
-		 */
-		if (entry->length == 0) {
-			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, entry_id);
-			return -EINVAL;
-		}
-
-		entry = (struct acpi_subtable_header *)
-		    ((unsigned long)entry + entry->length);
+		entry = entry_end;
+		entry_end = (void *)entry + entry->length;
 	}
 
 	if (max_entries && count > max_entries) {
-- 
1.9.1

