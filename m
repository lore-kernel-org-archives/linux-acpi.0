From: Al Stone <ahs3@redhat.com>
Subject: [PATCH 3/3] ACPI: fix acpi_parse_entries_array() so it reports overflow correctly
Date: Fri,  1 Jul 2016 15:21:21 -0600
Message-ID: <1467408081-7418-4-git-send-email-ahs3@redhat.com>
References: <1467408081-7418-1-git-send-email-ahs3@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467408081-7418-1-git-send-email-ahs3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ahs3@redhat.com, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

The function acpi_parse_entries_array() has a limiting parameter,
max_entries, which tells the function to stop looking at subtables
once that limit has been reached.  Further, if the limit is reached,
it is reported.  However, the logic is incorrect in that the loop
to examine all subtables will always stop when exactly max_entries
have been found, regardless of whether or not there are still subtables
to examine, and it will always report that zero subtables have been
ignored.  This change allows the loop to continue to look at all
subtables and count all the ones of interest; if we have already
reached the number of max_entries, though, we will not invoke the
callback functions.  If the max_entries limit has been exceeded,
report on that, as before, but more accurately, listing how many
subtables of interest there are in total (as was meant), and how
many entries each subtable type occupied.

Signed-off-by: Al Stone <ahs3@redhat.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/tables.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 76c07ed..227312d 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -272,12 +272,11 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 
 	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
 	       table_end) {
-		if (max_entries && count >= max_entries)
-			break;
-
 		for (i = 0; i < proc_num; i++) {
 			if (entry->type != proc[i].id)
 				continue;
+			if (max_entries && count >= max_entries)
+				break;
 			if (!proc[i].handler ||
 			     proc[i].handler(entry, table_end)) {
 				errs_found++;
@@ -304,8 +303,11 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 	}
 
 	if (max_entries && count > max_entries) {
-		pr_warn("[%4.4s:0x%02x] ignored %i entries of %i found\n",
-			id, proc->id, count - max_entries, count);
+		pr_warn("[%4.4s] ignored %i entries of %i found\n",
+			id, count - max_entries, count);
+		for (i = 0; i < proc_num; i++)
+			pr_warn("[%4.4s] subtable 0x%02x used %i entries\n",
+				id, proc[i].id, proc[i].count);
 	}
 
 	return (errs_found) ? -EINVAL: count;
-- 
2.7.4
