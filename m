From: Al Stone <ahs3@redhat.com>
Subject: [PATCH 1/3] ACPI: improve function documentation for acpi_parse_entries_array()
Date: Tue,  3 Apr 2018 18:42:09 -0600
Message-ID: <20180404004211.6141-2-ahs3@redhat.com>
References: <20180404004211.6141-1-ahs3@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180404004211.6141-1-ahs3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Al Stone <ahs3@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

I found the description of the table_size argument to the function
acpi_parse_entries_array() unclear and ambiguous.  This is a minor
documentation change to improve that description so I don't misuse
the argument again in the future, and it is hopefully clearer to
other future users.

Signed-off-by: Al Stone <ahs3@redhat.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/tables.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 6c5ee7e66842..b6ac8162a2c0 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -222,7 +222,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
  * acpi_parse_entries_array - for each proc_num find a suitable subtable
  *
  * @id: table id (for debugging purposes)
- * @table_size: single entry size
+ * @table_size: size of the root table; i.e., the offset from the very
+ *              first byte of the complete ACPI table, to the first byte
+ *              of the first subtable
  * @table_header: where does the table start?
  * @proc: array of acpi_subtable_proc struct containing entry id
  *        and associated handler with it
@@ -400,7 +402,7 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
 		return -ENODEV;
 }
 
-/* 
+/*
  * The BIOS is supposed to supply a single APIC/MADT,
  * but some report two.  Provide a knob to use either.
  * (don't you wish instance 0 and 1 were not the same?)
-- 
2.14.3
