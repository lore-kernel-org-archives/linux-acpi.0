From: akpm@osdl.org
Subject: [patch 02/12] ACPI: fix printk format warnings
Date: Tue, 10 Oct 2006 14:20:32 -0700
Message-ID: <200610102120.k9ALKWWE024269@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:405 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030419AbWJJVVy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Oct 2006 17:21:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, rdunlap@xenotime.net

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warnings in drivers/acpi:
drivers/acpi/tables/tbget.c:326: warning: format '%X' expects type 'unsigned int', but argument 5 has type 'long unsigned int'
drivers/acpi/tables/tbrsdt.c:189: warning: format '%X' expects type 'unsigned int', but argument 5 has type 'long unsigned int'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/tables/tbget.c  |    2 +-
 drivers/acpi/tables/tbrsdt.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/acpi/tables/tbget.c~acpi-fix-printk-format-warnings drivers/acpi/tables/tbget.c
--- a/drivers/acpi/tables/tbget.c~acpi-fix-printk-format-warnings
+++ a/drivers/acpi/tables/tbget.c
@@ -324,7 +324,7 @@ acpi_tb_get_this_table(struct acpi_point
 
 	if (header->length < sizeof(struct acpi_table_header)) {
 		ACPI_ERROR((AE_INFO,
-			    "Table length (%X) is smaller than minimum (%X)",
+			    "Table length (%X) is smaller than minimum (%zX)",
 			    header->length, sizeof(struct acpi_table_header)));
 
 		return_ACPI_STATUS(AE_INVALID_TABLE_LENGTH);
diff -puN drivers/acpi/tables/tbrsdt.c~acpi-fix-printk-format-warnings drivers/acpi/tables/tbrsdt.c
--- a/drivers/acpi/tables/tbrsdt.c~acpi-fix-printk-format-warnings
+++ a/drivers/acpi/tables/tbrsdt.c
@@ -187,7 +187,7 @@ acpi_status acpi_tb_validate_rsdt(struct
 
 	if (table_ptr->length < sizeof(struct acpi_table_header)) {
 		ACPI_ERROR((AE_INFO,
-			    "RSDT/XSDT length (%X) is smaller than minimum (%X)",
+			    "RSDT/XSDT length (%X) is smaller than minimum (%zX)",
 			    table_ptr->length,
 			    sizeof(struct acpi_table_header)));
 
_
