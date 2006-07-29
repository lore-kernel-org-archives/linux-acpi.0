From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH -mm] ACPI: fix printk format warnings
Date: Sat, 29 Jul 2006 15:20:57 -0700
Message-ID: <20060729152057.01e13d4e.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:7836 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750700AbWG2WSP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 29 Jul 2006 18:18:15 -0400
Received: from midway.site ([71.117.253.75]) by xenotime.net for <linux-acpi@vger.kernel.org>; Sat, 29 Jul 2006 15:18:12 -0700
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, akpm <akpm@osdl.org>

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warnings in drivers/acpi:
drivers/acpi/tables/tbget.c:326: warning: format '%X' expects type 'unsigned int', but argument 5 has type 'long unsigned int'
drivers/acpi/tables/tbrsdt.c:189: warning: format '%X' expects type 'unsigned int', but argument 5 has type 'long unsigned int'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/acpi/tables/tbget.c  |    2 +-
 drivers/acpi/tables/tbrsdt.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2618-rc2mm1.orig/drivers/acpi/tables/tbget.c
+++ linux-2618-rc2mm1/drivers/acpi/tables/tbget.c
@@ -324,7 +324,7 @@ acpi_tb_get_this_table(struct acpi_point
 
 	if (header->length < sizeof(struct acpi_table_header)) {
 		ACPI_ERROR((AE_INFO,
-			    "Table length (%X) is smaller than minimum (%X)",
+			    "Table length (%X) is smaller than minimum (%ZX)",
 			    header->length, sizeof(struct acpi_table_header)));
 
 		return_ACPI_STATUS(AE_INVALID_TABLE_LENGTH);
--- linux-2618-rc2mm1.orig/drivers/acpi/tables/tbrsdt.c
+++ linux-2618-rc2mm1/drivers/acpi/tables/tbrsdt.c
@@ -187,7 +187,7 @@ acpi_status acpi_tb_validate_rsdt(struct
 
 	if (table_ptr->length < sizeof(struct acpi_table_header)) {
 		ACPI_ERROR((AE_INFO,
-			    "RSDT/XSDT length (%X) is smaller than minimum (%X)",
+			    "RSDT/XSDT length (%X) is smaller than minimum (%ZX)",
 			    table_ptr->length,
 			    sizeof(struct acpi_table_header)));
 


---
