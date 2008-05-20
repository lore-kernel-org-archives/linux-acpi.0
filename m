From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi
	list to force rsdt
Date: Tue, 20 May 2008 21:54:43 +0200
Message-ID: <1211313283.14684.2.camel@hammer6.suse.de>
References: <1210259416.6710.13.camel@hammer1.suse.de>
	 <1210346444.29724.49.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32964 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754719AbYETRyq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 May 2008 13:54:46 -0400
In-Reply-To: <1210346444.29724.49.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>

Another update, I forgot to terminate the dmi list.
Thanks to Jan Beulich for finding this.

    Thomas

--------

Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt

Signed-off-by: Thomas Renninger <trenn@suse.de>
Tested-by: Mark Doughty <me@markdoughty.co.uk>
CC: Yakui Zhao <yakui.zhao@intel.com>


---
 Documentation/kernel-parameters.txt |    5 ++++
 drivers/acpi/tables.c               |   37 ++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

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
 
@@ -282,6 +283,37 @@ static void __init check_multiple_madt(v
 	return;
 }
 
+static struct dmi_system_id acpi_rsdt_dmi_table[] = {
+	{
+	    .ident = "ThinkPad ", /* R40e, broken C-states */
+	    .matches = {
+		DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
+		DMI_MATCH(DMI_BIOS_VERSION, "1SET")},
+	},
+	{
+	    .ident = "ThinkPad ", /* R50e, slow booting */
+	    .matches = {
+		DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
+		DMI_MATCH(DMI_BIOS_VERSION, "1WET")},
+	},
+	{
+	    .ident = "ThinkPad ", /* T40, T40p, T41, T41p, T42, T42p
+				     R50, R50p */
+	    .matches = {
+		DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
+		DMI_MATCH(DMI_BIOS_VERSION, "1RET")},
+	},
+	{}
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
@@ -293,6 +325,11 @@ static void __init check_multiple_madt(v
 
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
 
+	acpi_root_table= [X86,ACPI]
+			{ rsdt }
+			rsdt: Take RSDT address for fetching
+			ACPI tables (instead of XSDT)
+
 	agp=		[AGP]
 			{ off | try_unsupported }
 			off: disable AGP support


