From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list
	to force rsdt
Date: Thu, 08 May 2008 17:10:16 +0200
Message-ID: <1210259416.6710.13.camel@hammer1.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:42010 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753553AbYEHPKS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 May 2008 11:10:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk

Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt

Signed-off-by: Thomas Renninger <trenn@suse.de>
Tested-by: Mark Doughty <me@markdoughty.co.uk>


---
 Documentation/kernel-parameters.txt |    5 +++++
 drivers/acpi/tables.c               |   23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+)

Index: linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/tables.c
===================================================================
--- linux-acpi-2.6_video_native_vs_vendor.orig/drivers/acpi/tables.c
+++ linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/tables.c
@@ -32,6 +32,7 @@
 #include <linux/errno.h>
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
+#include <linux/dmi.h>
 
 #define PREFIX			"ACPI: "
 
@@ -282,6 +283,23 @@ static void __init check_multiple_madt(v
 	return;
 }
 
+static struct dmi_system_id acpi_rsdt_dmi_table[] = {
+	{
+	    .ident = "ThinkPad ",
+	    .matches = {
+		DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
+		DMI_MATCH(DMI_BIOS_VERSION, "1SET")},
+	},
+};
+
+static int __init acpi_force_rsdt(char *opt)
+{
+	if (!strcmp(opt, "rsdt"))
+		acpi_gbl_force_rsdt = 1;
+	return 0;
+}
+early_param("acpi_root_table", acpi_force_rsdt);
+
 /*
  * acpi_table_init()
  *
@@ -293,6 +311,11 @@ static void __init check_multiple_madt(v
 
 int __init acpi_table_init(void)
 {
+	if (dmi_check_system(acpi_rsdt_dmi_table))
+		acpi_gbl_force_rsdt = 1;
+	if (acpi_gbl_force_rsdt)
+		printk(KERN_INFO "Using RSDT as ACPI root table\n");
+
 	acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
 	check_multiple_madt();
 	return 0;
Index: linux-acpi-2.6_video_native_vs_vendor/Documentation/kernel-parameters.txt
===================================================================
--- linux-acpi-2.6_video_native_vs_vendor.orig/Documentation/kernel-parameters.txt
+++ linux-acpi-2.6_video_native_vs_vendor/Documentation/kernel-parameters.txt
@@ -230,6 +230,11 @@ and is between 256 and 4096 characters.
 			to assume that this machine's pmtimer latches its value
 			and always returns good values.
 
+	acpi_root_table=	[X86,ACPI]
+			{ rsdt }
+			rsdt: If RSDP contains a non-NULL RSDT address, take it
+			      for fetching ACPI tables (instead of XSDT)
+
 	agp=		[AGP]
 			{ off | try_unsupported }
 			off: disable AGP support


