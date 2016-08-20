From: Al Stone <ahs3@redhat.com>
Subject: [PATCH v2 2/3] ACPI: fix acpi_parse_entries_array() so it traverses all subtables
Date: Fri, 19 Aug 2016 18:48:12 -0600
Message-ID: <1471654093-6962-3-git-send-email-ahs3@redhat.com>
References: <1471654093-6962-1-git-send-email-ahs3@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471654093-6962-1-git-send-email-ahs3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ahs3@redhat.com, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

The acpi_parse_entries_array() function currently returns the very first
time there is any error found by one of the callback functions, or if one
of the callbacks returns a non-zero value.  However, the ACPI subtables
being traversed could still have valid entries that could be used by one
of the callback functions.  And, if the comments are correct, that is
what should happen -- always traverse all of the subtables, calling as
many of the callbacks as possible.

This patch makes the function consistent with its description so that it
will properly invoke all callbacks for all matching entries, for all
subtables, instead of stopping abruptly as it does today.

This does change the semantics of using acpi_parse_entries_array().  In
examining all users of the function, none of them rely on the current
behavior; that is, there appears to be no assumption that either all
subtables are traversed and all callbacks invoked, or that the function
will return immediately on any error from a callback.  Each callback
operates independently.  Hence, there should be no functional change
due to this change in semantics.

Future patches being prepared will rely on this new behavior; indeed,
they were written assuming the acpi_parse_entries_array() function
operated as its comments describe.  For example, a callback that
counts the number of subtables of a specific type can now be assured
that as many subtables as possible have been enumerated.

Signed-off-by: Al Stone <ahs3@redhat.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/tables.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 3e167b4..0d5d17f 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -246,6 +246,7 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 	struct acpi_subtable_header *entry;
 	unsigned long table_end;
 	int count = 0;
+	int errs = 0;
 	int i;
 
 	if (acpi_disabled)
@@ -278,8 +279,10 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 			if (entry->type != proc[i].id)
 				continue;
 			if (!proc[i].handler ||
-			     proc[i].handler(entry, table_end))
-				return -EINVAL;
+			     (!errs && proc[i].handler(entry, table_end))) {
+				errs++;
+				continue;
+			}
 
 			proc[i].count++;
 			break;
@@ -305,7 +308,7 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 			id, proc->id, count - max_entries, count);
 	}
 
-	return count;
+	return errs ? -EINVAL : count;
 }
 
 int __init
-- 
2.7.4
