From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v3 1/2] ACPI / tables: simplify acpi_parse_entries
Date: Thu,  1 Oct 2015 16:11:51 +0100
Message-ID: <1443712312-9176-1-git-send-email-sudeep.holla@arm.com>
References: <1442408287-10410-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36591 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbbJAPME (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Oct 2015 11:12:04 -0400
In-Reply-To: <1442408287-10410-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

acpi_parse_entries passes the table end pointer to the sub-table entry
handler. acpi_parse_entries itself could validate the end of an entry
against the table end using the length in the sub-table entry.

This patch adds the validation of the sub-table entry end using the
length field.This will help to eliminate the need to pass the table end
to the handlers.

It also moves the check for zero length entry early so that execution of
the handler can be avoided.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/tables.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

v2->v3:
	- Rebased on Rafael's linux-pm/bleeding-edge branch to avoid
	  conflicts
v1->v2:
        - Incorporated Rafael's review comments
        - Moved zero length entry check early
        - Added a patch to remove the unused table_end parameter

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index a2ed38a20e7e..24b867e26191 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -476,7 +476,7 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 		unsigned int max_entries)
 {
 	struct acpi_subtable_header *entry;
-	unsigned long table_end;
+	unsigned long table_end, entry_end;
 	int count = 0;
 	int i;
 
@@ -497,12 +497,20 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 	table_end = (unsigned long)table_header + table_header->length;
 
 	/* Parse all entries looking for a match. */
+	entry_end = (unsigned long)table_header + table_size;
+	entry = (struct acpi_subtable_header *)entry_end;
+	entry_end += entry->length;
 
-	entry = (struct acpi_subtable_header *)
-	    ((unsigned long)table_header + table_size);
+	while (entry_end <= table_end) {
+		/*
+		 * If entry->length is 0, break from this loop to avoid
+		 * infinite loop.
+		 */
+		if (entry->length == 0) {
+			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, proc->id);
+			return -EINVAL;
+		}
 
-	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
-	       table_end) {
 		if (max_entries && count >= max_entries)
 			break;
 
@@ -523,17 +531,8 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 		if (i != proc_num)
 			count++;
 
-		/*
-		 * If entry->length is 0, break from this loop to avoid
-		 * infinite loop.
-		 */
-		if (entry->length == 0) {
-			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, proc->id);
-			return -EINVAL;
-		}
-
-		entry = (struct acpi_subtable_header *)
-		    ((unsigned long)entry + entry->length);
+		entry = (struct acpi_subtable_header *)entry_end;
+		entry_end += entry->length;
 	}
 
 	if (max_entries && count > max_entries) {
-- 
1.9.1

