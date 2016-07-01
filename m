From: Al Stone <ahs3@redhat.com>
Subject: [PATCH 2/3] ACPI: fix acpi_parse_entries_array() so it traverses all subtables
Date: Fri,  1 Jul 2016 15:21:20 -0600
Message-ID: <1467408081-7418-3-git-send-email-ahs3@redhat.com>
References: <1467408081-7418-1-git-send-email-ahs3@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467408081-7418-1-git-send-email-ahs3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ahs3@redhat.com, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Without this patch, the acpi_parse_entries_array() function will return
the very first time there is any error found in either the array of
callback functions or if one of the callbacks returns an non-zero value.
However, the array of callbacks could still have valid entries further
on in the array, or the callbacks may be able to process subsequent
subtables without error.  The change here makes the function consistent
with its description so that it will properly return the sum of all
matching entries for all proc handlers, instead of stopping abruptly
as it does today.

Signed-off-by: Al Stone <ahs3@redhat.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/tables.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 3e167b4..76c07ed 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -246,6 +246,7 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 	struct acpi_subtable_header *entry;
 	unsigned long table_end;
 	int count = 0;
+	int errs_found = 0;
 	int i;
 
 	if (acpi_disabled)
@@ -278,8 +279,10 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 			if (entry->type != proc[i].id)
 				continue;
 			if (!proc[i].handler ||
-			     proc[i].handler(entry, table_end))
-				return -EINVAL;
+			     proc[i].handler(entry, table_end)) {
+				errs_found++;
+				continue;
+			}
 
 			proc[i].count++;
 			break;
@@ -305,7 +308,7 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 			id, proc->id, count - max_entries, count);
 	}
 
-	return count;
+	return (errs_found) ? -EINVAL : count;
 }
 
 int __init
-- 
2.7.4
