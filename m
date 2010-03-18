From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPICA: Do memcpy of only allocated tables.
Date: Thu, 18 Mar 2010 17:20:44 +0300
Message-ID: <20100318142043.31211.11872.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:39920 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753804Ab0CROUm (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 18 Mar 2010 10:20:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/acpica/tbxface.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)


diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 5217a61..3cedfb3 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -194,7 +194,9 @@ acpi_status acpi_reallocate_root_table(void)
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
-	ACPI_MEMCPY(tables, acpi_gbl_root_table_list.tables, new_size);
+	ACPI_MEMCPY(tables, acpi_gbl_root_table_list.tables,
+			acpi_gbl_root_table_list.count *
+			sizeof(struct acpi_table_desc));
 
 	acpi_gbl_root_table_list.size = acpi_gbl_root_table_list.count;
 	acpi_gbl_root_table_list.tables = tables;

