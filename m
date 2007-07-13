From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: add "acpi_no_auto_ssdt" bootparam
Date: Fri, 13 Jul 2007 16:04:16 -0400
Message-ID: <200707131604.16618.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35531 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758996AbXGMUET (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Jul 2007 16:04:19 -0400
Received: from d975xbx2 (WPIS-64-140-212-33.worldpath.net [64.140.212.33])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id l6DK4Hnq025757
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Fri, 13 Jul 2007 20:04:18 GMT
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Subject: ACPI: add "acpi_no_auto_ssdt" bootparam
From: Len Brown <len.brown@intel.com>

"acpi_no_auto_ssdt" prevents Linux from automatically loading
all the SSDTs listed in the RSDT/XSDT.

This is needed for debugging.  In particular,
it allows a DSDT override to optionally be a DSDT+SSDT override.

http://bugzilla.kernel.org/show_bug.cgi?id=3774

Signed-off-by: Len Brown <len.brown@intel.com>
----
 tbxface.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/acpi/tables/tbxface.c b/drivers/acpi/tables/tbxface.c
index 5b302c4..e9ae591 100644
--- a/drivers/acpi/tables/tbxface.c
+++ b/drivers/acpi/tables/tbxface.c
@@ -52,6 +52,8 @@ ACPI_MODULE_NAME("tbxface")
 /* Local prototypes */
 static acpi_status acpi_tb_load_namespace(void);
 
+static int no_auto_ssdt;
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_allocate_root_table
@@ -536,6 +538,10 @@ static acpi_status acpi_tb_load_namespace(void)
 
 		ACPI_INFO((AE_INFO, "Table DSDT replaced by host OS"));
 		acpi_tb_print_table_header(0, table);
+
+		if (no_auto_ssdt == 0) {
+			printk(KERN_WARNING "ACPI: DSDT override uses original SSDTs unless \"acpi_no_auto_ssdt\"");
+		}
 	}
 
 	status =
@@ -577,6 +583,11 @@ static acpi_status acpi_tb_load_namespace(void)
 			continue;
 		}
 
+		if (no_auto_ssdt) {
+			printk(KERN_WARNING "ACPI: SSDT ignored due to \"acpi_no_auto_ssdt\"\n");
+			continue;
+		}
+
 		/* Ignore errors while loading tables, get as many as possible */
 
 		(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
@@ -622,3 +633,16 @@ acpi_status acpi_load_tables(void)
 }
 
 ACPI_EXPORT_SYMBOL(acpi_load_tables)
+
+
+static int __init acpi_no_auto_ssdt_setup(char *s) {
+
+        printk(KERN_NOTICE "ACPI: SSDT auto-load disabled\n");
+
+        no_auto_ssdt = 1;
+
+        return 1;
+}
+
+__setup("acpi_no_auto_ssdt", acpi_no_auto_ssdt_setup);
+
