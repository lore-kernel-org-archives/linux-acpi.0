From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2 1/2] ACPI / tables: simplify acpi_parse_entries
Date: Wed, 16 Sep 2015 13:58:06 +0100
Message-ID: <1442408287-10410-1-git-send-email-sudeep.holla@arm.com>
References: <1442243686-15845-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442243686-15845-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-acpi@vger.kernel.org

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

Hi Rafael,

As I mentioned earlier, this needs to be applied after Al's MADT changes
are merged. You might get simple conflicts in acpi_parse_entries.

Regards,
Sudeep

v1->v2:
	- Incorporated Rafael's review comments
	- Moved zero length entry check early
	- Added a patch to remove the unused table_end parameter

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index d0716bb6359d..69b9d05f5b96 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -459,7 +459,7 @@ acpi_parse_entries(char *id, unsigned long table_size,
 {
 	struct acpi_subtable_header *entry;
 	int count = 0;
-	unsigned long table_end;
+	unsigned long table_end, entry_end;

 	if (acpi_disabled)
 		return -ENODEV;
@@ -478,12 +478,20 @@ acpi_parse_entries(char *id, unsigned long table_size,
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
+			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, entry_id);
+			return -EINVAL;
+		}

-	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
-	       table_end) {
 		if (entry->type == entry_id
 		    && (!max_entries || count < max_entries)) {
 			if (!strncmp(id, ACPI_SIG_MADT, 4) &&
@@ -495,17 +503,8 @@ acpi_parse_entries(char *id, unsigned long table_size,
 			count++;
 		}

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
+		entry = (struct acpi_subtable_header *)entry_end;
+		entry_end += entry->length;
 	}

 	if (max_entries && count > max_entries) {
--
1.9.1
