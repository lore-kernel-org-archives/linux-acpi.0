From: akpm@linux-foundation.org
Subject: [patch 7/8] acpi: suppress uninitialized var warning
Date: Tue, 02 Oct 2007 13:24:10 -0700
Message-ID: <200710022024.l92KOAvt020471@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39488 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753067AbXJBUZM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Oct 2007 16:25:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, uwe.bugla@gmx.de

From: Andrew Morton <akpm@linux-foundation.org>

drivers/acpi/tables/tbutils.c: In function `acpi_tb_parse_root_table':
drivers/acpi/tables/tbutils.c:403: warning: `rsdt_address' may be used uninitialized in this function

Reported-by: Uwe Bugla <uwe.bugla@gmx.de>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/tables/tbutils.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/tables/tbutils.c~acpi-suppress-uninitialized-var-warning drivers/acpi/tables/tbutils.c
--- a/drivers/acpi/tables/tbutils.c~acpi-suppress-uninitialized-var-warning
+++ a/drivers/acpi/tables/tbutils.c
@@ -400,7 +400,7 @@ acpi_tb_parse_root_table(acpi_physical_a
 	u32 table_count;
 	struct acpi_table_header *table;
 	acpi_physical_address address;
-	acpi_physical_address rsdt_address;
+	acpi_physical_address uninitialized_var(rsdt_address);
 	u32 length;
 	u8 *table_entry;
 	acpi_status status;
_
