From: Baoquan He <bhe@redhat.com>
Subject: [PATCH] ACPI / tables: Cleanup the obsolete acpi_parse_entries
Date: Fri,  7 Apr 2017 16:22:47 +0800
Message-ID: <1491553367-17847-1-git-send-email-bhe@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754473AbdDGIWy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 7 Apr 2017 04:22:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>

Function acpi_parse_entries is not used any more. And the being used
function, acpi_table_parse_entries can substitute it if really needed.

So clean it up in this patch.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/acpi/tables.c | 16 ----------------
 include/linux/acpi.h  |  4 ----
 2 files changed, 20 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 2604189..0dae722 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -311,22 +311,6 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 }
 
 int __init
-acpi_parse_entries(char *id,
-			unsigned long table_size,
-			acpi_tbl_entry_handler handler,
-			struct acpi_table_header *table_header,
-			int entry_id, unsigned int max_entries)
-{
-	struct acpi_subtable_proc proc = {
-		.id		= entry_id,
-		.handler	= handler,
-	};
-
-	return acpi_parse_entries_array(id, table_size, table_header,
-			&proc, 1, max_entries);
-}
-
-int __init
 acpi_table_parse_entries_array(char *id,
 			 unsigned long table_size,
 			 struct acpi_subtable_proc *proc, int proc_num,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9b05886..83abbfc 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -233,10 +233,6 @@ int acpi_numa_init (void);
 
 int acpi_table_init (void);
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
-int __init acpi_parse_entries(char *id, unsigned long table_size,
-			      acpi_tbl_entry_handler handler,
-			      struct acpi_table_header *table_header,
-			      int entry_id, unsigned int max_entries);
 int __init acpi_table_parse_entries(char *id, unsigned long table_size,
 			      int entry_id,
 			      acpi_tbl_entry_handler handler,
-- 
2.5.5

