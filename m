From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/20] ACPICA: Table print header function: Increase default width for table length.
Date: Tue, 29 Oct 2013 09:28:56 +0800
Message-ID: <ee9e6e2a521becc315bf5e68dc5a1f5f810f14da.1383009405.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39696 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757069Ab3J2B3I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:29:08 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

This change increases the default width for the length from 5 to 6,
to improve alignment/readability on systems with large tables. These
are being seen more frequently, especially large DSDTs (greater than
1 MB).

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbprint.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index 9a47715..6866e76 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -135,7 +135,7 @@ acpi_tb_print_table_header(acpi_physical_address address,
 
 		/* FACS only has signature and length fields */
 
-		ACPI_INFO((AE_INFO, "%4.4s %p %05X",
+		ACPI_INFO((AE_INFO, "%4.4s %p %06X",
 			   header->signature, ACPI_CAST_PTR(void, address),
 			   header->length));
 	} else if (ACPI_VALIDATE_RSDP_SIG(header->signature)) {
@@ -147,7 +147,7 @@ acpi_tb_print_table_header(acpi_physical_address address,
 					  header)->oem_id, ACPI_OEM_ID_SIZE);
 		acpi_tb_fix_string(local_header.oem_id, ACPI_OEM_ID_SIZE);
 
-		ACPI_INFO((AE_INFO, "RSDP %p %05X (v%.2d %6.6s)",
+		ACPI_INFO((AE_INFO, "RSDP %p %06X (v%.2d %6.6s)",
 			   ACPI_CAST_PTR(void, address),
 			   (ACPI_CAST_PTR(struct acpi_table_rsdp, header)->
 			    revision >
@@ -162,7 +162,7 @@ acpi_tb_print_table_header(acpi_physical_address address,
 		acpi_tb_cleanup_table_header(&local_header, header);
 
 		ACPI_INFO((AE_INFO,
-			   "%4.4s %p %05X (v%.2d %6.6s %8.8s %08X %4.4s %08X)",
+			   "%4.4s %p %06X (v%.2d %6.6s %8.8s %08X %4.4s %08X)",
 			   local_header.signature, ACPI_CAST_PTR(void, address),
 			   local_header.length, local_header.revision,
 			   local_header.oem_id, local_header.oem_table_id,
-- 
1.7.10

