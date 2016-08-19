From: Al Stone <ahs3@redhat.com>
Subject: [PATCH 2/2] ACPI: remove duplicate declaration for acpi_table_parse_entries()
Date: Fri, 19 Aug 2016 17:16:35 -0600
Message-ID: <1471648595-7365-3-git-send-email-ahs3@redhat.com>
References: <1471648595-7365-1-git-send-email-ahs3@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755137AbcHSXQp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 Aug 2016 19:16:45 -0400
In-Reply-To: <1471648595-7365-1-git-send-email-ahs3@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ahs3@redhat.com

Commit 9b3fedde27d3 ("ACPI / tables: Add acpi_subtable_proc to ACPI
table parsers") added a second identical declaration for the function
acpi_table_parse_entries() to include/linux/acpi.h.

Remove the redundant one.

Signed-off-by: Al Stone <ahs3@redhat.com>
---
 include/linux/acpi.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4d8452c..cd8dc0e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -218,10 +218,6 @@ int __init acpi_table_parse_entries(char *id, unsigned long table_size,
 			      int entry_id,
 			      acpi_tbl_entry_handler handler,
 			      unsigned int max_entries);
-int __init acpi_table_parse_entries(char *id, unsigned long table_size,
-			      int entry_id,
-			      acpi_tbl_entry_handler handler,
-			      unsigned int max_entries);
 int __init acpi_table_parse_entries_array(char *id, unsigned long table_size,
 			      struct acpi_subtable_proc *proc, int proc_num,
 			      unsigned int max_entries);
-- 
2.7.4

