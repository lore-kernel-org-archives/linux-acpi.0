From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/22] ACPI: add boot option acpi=copy_dsdt to fix corrupt DSDT
Date: Thu, 20 May 2010 01:18:40 -0400
Message-ID: <aa2110cb1a7510f9b834adfb39b05d4843a35d35.1274332657.git.len.brown@intel.com>
References: <1274332730-27370-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:36044 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734Ab0ETGPb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 02:15:31 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P007GDG0X9AM5@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 20 May 2010 01:14:58 -0500 (CDT)
In-reply-to: <1274332730-27370-1-git-send-email-lenb@kernel.org>
In-reply-to: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
References: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Some BIOS on Toshiba machines corrupt the DSDT, so add a new
boot option acpi=copy_dsdt to workaround it.
Add warning message to ask users to use this option if corrupt DSDT detected.

Also build a DMI blacklist to check it and automatically copy DSDT.

https://bugzilla.kernel.org/show_bug.cgi?id=14679

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    1 +
 arch/x86/kernel/acpi/boot.c         |    4 +++
 drivers/acpi/acpica/tbutils.c       |    4 +++
 drivers/acpi/bus.c                  |   37 +++++++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index e2202e9..93f113a 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -151,6 +151,7 @@ and is between 256 and 4096 characters. It is defined in the file
 			strict -- Be less tolerant of platforms that are not
 				strictly ACPI specification compliant.
 			rsdt -- prefer RSDT over (default) XSDT
+			copy_dsdt -- copy DSDT to memory
 
 			See also Documentation/power/pm.txt, pci=noacpi
 
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index cd40aba..b962938 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1576,6 +1576,10 @@ static int __init parse_acpi(char *arg)
 	/* "acpi=noirq" disables ACPI interrupt routing */
 	else if (strcmp(arg, "noirq") == 0) {
 		acpi_noirq_set();
+	}
+	/* "acpi=copy_dsdt" copys DSDT */
+	else if (strcmp(arg, "copy_dsdt") == 0) {
+		acpi_gbl_copy_dsdt_locally = 1;
 	} else {
 		/* Core will printk when we return error. */
 		return -EINVAL;
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 54a8712..a9b105f 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -373,6 +373,10 @@ void acpi_tb_check_dsdt_header(void)
 		acpi_tb_print_table_header(0, &acpi_gbl_original_dsdt_header);
 		acpi_tb_print_table_header(0, acpi_gbl_DSDT);
 
+		ACPI_ERROR((AE_INFO,
+			    "Please send DMI info to linux-acpi@vger.kernel.org\n"
+			    "If system does not work as expected, please boot with acpi=copy_dsdt"));
+
 		/* Disable further error messages */
 
 		acpi_gbl_original_dsdt_header.length = acpi_gbl_DSDT->length;
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 37132dc..49af19b 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -69,6 +69,37 @@ static struct dmi_system_id __cpuinitdata power_nocheck_dmi_table[] = {
 };
 
 
+static int set_copy_dsdt(const struct dmi_system_id *id)
+{
+	printk(KERN_NOTICE "%s detected - "
+		"force copy of DSDT to local memory\n", id->ident);
+	acpi_gbl_copy_dsdt_locally = 1;
+	return 0;
+}
+
+static struct dmi_system_id dsdt_dmi_table[] __initdata = {
+	/*
+	 * Insyde BIOS on some TOSHIBA machines corrupt the DSDT.
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=14679
+	 */
+	{
+	 .callback = set_copy_dsdt,
+	 .ident = "TOSHIBA Satellite A505",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite A505"),
+		},
+	},
+	{
+	 .callback = set_copy_dsdt,
+	 .ident = "TOSHIBA Satellite L505D",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite L505D"),
+		},
+	}
+};
+
 /* --------------------------------------------------------------------------
                                 Device Management
    -------------------------------------------------------------------------- */
@@ -813,6 +844,12 @@ void __init acpi_early_init(void)
 
 	acpi_gbl_permanent_mmap = 1;
 
+	/*
+	 * If the machine falls into the DMI check table,
+	 * DSDT will be copied to memory
+	 */
+	dmi_check_system(dsdt_dmi_table);
+
 	status = acpi_reallocate_root_table();
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX
-- 
1.6.0.6

