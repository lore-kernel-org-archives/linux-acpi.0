From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/10] ACPICA: Deploy new 32/64 printf support for table override mechanism.
Date: Sat,  8 Feb 2014 09:42:07 +0800
Message-ID: <63f022828b11821159e907b7f332372489964d99.1390438466.git.lv.zheng@intel.com>
References: <cover.1390438466.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53331 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbaBHBmM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Feb 2014 20:42:12 -0500
In-Reply-To: <cover.1390438466.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

Similar to the earlier tbprint.c change.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbinstal.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 634357d..c1a8cf7 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -292,10 +292,11 @@ struct acpi_table_header *acpi_tb_table_override(struct acpi_table_header
 		new_table = acpi_os_map_memory(new_address, new_table_length);
 		if (!new_table) {
 			ACPI_EXCEPTION((AE_INFO, AE_NO_MEMORY,
-					"%4.4s %p Attempted physical table override failed",
+					"%4.4s " ACPI_PRINTF_UINT
+					" Attempted physical table override failed",
 					table_header->signature,
-					ACPI_CAST_PTR(void,
-						      table_desc->address)));
+					ACPI_FORMAT_TO_UINT(table_desc->
+							    address)));
 			return (NULL);
 		}
 
@@ -308,11 +309,11 @@ struct acpi_table_header *acpi_tb_table_override(struct acpi_table_header
 
 finish_override:
 
-	ACPI_INFO((AE_INFO,
-		   "%4.4s %p %s table override, new table: %p",
+	ACPI_INFO((AE_INFO, "%4.4s " ACPI_PRINTF_UINT
+		   " %s table override, new table: " ACPI_PRINTF_UINT,
 		   table_header->signature,
-		   ACPI_CAST_PTR(void, table_desc->address),
-		   override_type, new_table));
+		   ACPI_FORMAT_TO_UINT(table_desc->address),
+		   override_type, ACPI_FORMAT_TO_UINT(new_table)));
 
 	/* We can now unmap/delete the original table (if fully mapped) */
 
-- 
1.7.10

