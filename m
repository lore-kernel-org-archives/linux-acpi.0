From: Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH] ACPI / tables: Return error from table parse handler
Date: Thu, 19 May 2016 18:51:07 +0200
Message-ID: <1463676667-17945-1-git-send-email-mbrugger@suse.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:47785 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208AbcESQvl (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
	Thu, 19 May 2016 12:51:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>

The handler called in acpi_table_parse may return an error.
This patch returns this error instead of ignoring it.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/acpi/tables.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index a372f9e..fb5cd80 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -394,6 +394,7 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
 {
 	struct acpi_table_header *table = NULL;
 	acpi_size tbl_size;
+	int ret;
 
 	if (acpi_disabled)
 		return -ENODEV;
@@ -407,9 +408,9 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
 		acpi_get_table_with_size(id, 0, &table, &tbl_size);
 
 	if (table) {
-		handler(table);
+		ret = handler(table);
 		early_acpi_os_unmap_memory(table, tbl_size);
-		return 0;
+		return ret;
 	} else
 		return -ENODEV;
 }
-- 
2.6.6

