From: Thomas Renninger <trenn@suse.de>
Subject: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Sun, 19 Oct 2008 23:50:55 +0200
Message-ID: <200810192350.57993.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:32774 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789AbYJSVux (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 19 Oct 2008 17:50:53 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "devel@acpica.org" <devel@acpica.org>

Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt

References: http://bugzilla.kernel.org/show_bug.cgi?id=8246

Blacklist R40e, R51e and T40, T40p, T41, T41p, T42, T42p, R50 and R50p
ThinkPads to use the RSDT instead of the XSDT.

R40e (c-states freeze machine) and R51e (slow booting) have known problems.
The rest share one BIOS and have been added in hope that this bug gets solved,
but this is not proven:
  T41p shutting down due to "temperature critical"
  https://bugzilla.novell.com/show_bug.cgi?id=378327
I saw a kind of fixed temperature offset with the exact same machine models
and exact same BIOS. Short after cold boot the one machine showed about 15
degree C more than the other. This looked like wrong, too high temperature
values read from EC on the one machine. I never found out why, this could
explain and fix it, but I did not double check.

It does not matter to have this BIOS also use 32 bit addresses, XP and 
OpenSUSE 11.0 does that and it works fine.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Tested-by: Mark Doughty <me@markdoughty.co.uk>
CC: Yakui Zhao <yakui.zhao@intel.com>

---
 Documentation/kernel-parameters.txt |    5 ++++
 drivers/acpi/tables.c               |   37 ++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -237,6 +237,11 @@ and is between 256 and 4096 characters.
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
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -32,6 +32,7 @@
 #include <linux/errno.h>
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
+#include <linux/dmi.h>
 
 #define PREFIX			"ACPI: "
 
@@ -282,6 +283,37 @@ static void __init check_multiple_madt(v
 	return;
 }
 
+static struct dmi_system_id __initdata acpi_rsdt_dmi_table[] = {
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
