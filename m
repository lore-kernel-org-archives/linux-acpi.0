From: Len Brown <len.brown@intel.com>
Subject: [PATCH 01/12] ACPI: add "acpi_no_auto_ssdt" bootparam
Date: Fri,  3 Aug 2007 18:33:34 -0400
Message-ID: <11861804261706-git-send-email-len.brown@intel.com>
References: <11861804251625-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12458 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763660AbXHCWdr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Aug 2007 18:33:47 -0400
In-Reply-To: <11861804251625-git-send-email-len.brown@intel.com>
Message-Id: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

"acpi_no_auto_ssdt" prevents Linux from automatically loading
all the SSDTs listed in the RSDT/XSDT.

This is needed for debugging.  In particular,
it allows a DSDT override to optionally be a DSDT+SSDT override.

http://bugzilla.kernel.org/show_bug.cgi?id=3774

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    2 ++
 drivers/acpi/tables/tbxface.c       |   23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index fb80e9f..379931e 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -166,6 +166,8 @@ and is between 256 and 4096 characters. It is defined in the file
 	acpi_irq_isa=	[HW,ACPI] If irq_balance, mark listed IRQs used by ISA
 			Format: <irq>,<irq>...
 
+	acpi_no_auto_ssdt	[HW,ACPI] Disable automatic loading of SSDT
+
 	acpi_os_name=	[HW,ACPI] Tell ACPI BIOS the name of the OS
 			Format: To spoof as Windows 98: ="Microsoft Windows"
 
diff --git a/drivers/acpi/tables/tbxface.c b/drivers/acpi/tables/tbxface.c
index 5b302c4..a9e3331 100644
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
@@ -622,3 +633,15 @@ acpi_status acpi_load_tables(void)
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
-- 
1.5.3.rc3.7.gd58e
