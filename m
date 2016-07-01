From: Al Stone <ahs3@redhat.com>
Subject: [PATCH 1/3] ACPI: fix incorrect counts returned by acpi_parse_entries_array()
Date: Fri,  1 Jul 2016 15:21:19 -0600
Message-ID: <1467408081-7418-2-git-send-email-ahs3@redhat.com>
References: <1467408081-7418-1-git-send-email-ahs3@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467408081-7418-1-git-send-email-ahs3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ahs3@redhat.com, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

The static function acpi_parse_entries_array() is provided an array of
type struct acpi_subtable_proc that has a callback function and a count.
The count should reflect how many times the callback has been successfully
called.  However, the current code only increments the 0th element of the
array, regardless of the number of entries in the array, or which callback
has been invoked.  The fix is to use the index into the array, instead of
a pointer to the beginning of the array.

Signed-off-by: Al Stone <ahs3@redhat.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/tables.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 9f0ad6e..3e167b4 100644
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
@@ -416,7 +416,7 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
 		return -ENODEV;
 }
 
-/* 
+/*
  * The BIOS is supposed to supply a single APIC/MADT,
  * but some report two.  Provide a knob to use either.
  * (don't you wish instance 0 and 1 were not the same?)
-- 
2.7.4
