From: Al Stone <ahs3@redhat.com>
Subject: [PATCH v2 1/3] ACPI: fix incorrect counts returned by acpi_parse_entries_array()
Date: Fri, 19 Aug 2016 18:48:11 -0600
Message-ID: <1471654093-6962-2-git-send-email-ahs3@redhat.com>
References: <1471654093-6962-1-git-send-email-ahs3@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471654093-6962-1-git-send-email-ahs3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ahs3@redhat.com, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

The static function acpi_parse_entries_array() is provided an array of
type struct acpi_subtable_proc that has a callback function and a count.
The count should reflect how many times the callback has been called.
However, the current code only increments the 0th element of the array,
regardless of the number of entries in the array, or which callback has
been invoked.  The result is that we know the total number of callbacks
made but we cannot determine which callbacks were made, nor how often.
The fix is to index into the array of structs and increment the proper
counts.

There is one place in the x86 code for acpi_parse_madt_lapic_entries()
where the counts for each callback are used.  If no LAPICs *and* no
X2APICs are found, an ENODEV is supposed to be returned; as it stands,
the count of X2APICs will always be zero, regardless of what is in the
MADT.  Should there be no LAPICs, ENODEV will be returned in error, if
there are X2APICs in the MADT.

Otherwise, there are no other functional consequences of the count being
done as it currently is; all other uses simply check that the return value
from acpi_parse_entries_array() or passed back via its callers is either
non-zero, an error, or in one case just ignored.

In future patches, I will also need these counts to be correct; I need
to count the number of instances of subtables of certain types within
the MADT to determine whether or not an ACPI IORT is required or not,
and report when it is not present when it should be.

Signed-off-by: Al Stone <ahs3@redhat.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index fa6fd19..3e167b4 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -281,7 +281,7 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 			     proc[i].handler(entry, table_end))
 				return -EINVAL;
 
-			proc->count++;
+			proc[i].count++;
 			break;
 		}
 		if (i != proc_num)
-- 
2.7.4
