From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH 3/4]  ACPI: Add DMI check to disable power state check in
	power transition
Date: Mon, 14 Jul 2008 15:41:40 +0800
Message-ID: <1216021300.32159.26.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62350 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756855AbYGNHaV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2008 03:30:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

From: Zhao Yakui <yakui.zhao@intel.com>

Add the DMI check to disable power state check in the course of device 
power transition.

http://bugzilla.kernel.org/show_bug.cgi?id=11000

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/bus.c |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -48,6 +48,23 @@ EXPORT_SYMBOL(acpi_root_dir);
 
 #define STRUCT_TO_INT(s)	(*((int*)&s))
 
+static int set_power_nocheck(const struct dmi_system_id *id)
+{
+	printk(KERN_NOTICE PREFIX "%s detected - "
+		"disable power check in power transistion\n", id->ident);
+	acpi_power_nocheck = 1;
+	return 0;
+}
+static struct dmi_system_id __cpuinitdata power_nocheck_dmi_table[] = {
+	{
+	set_power_nocheck, "HP Pavilion 05", {
+	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+	DMI_MATCH(DMI_SYS_VENDOR, "HP Pavilion 05"),
+	DMI_MATCH(DMI_PRODUCT_VERSION, "2001211RE101GLEND") }, NULL},
+	{},
+};
+
+
 /* --------------------------------------------------------------------------
                                 Device Management
    -------------------------------------------------------------------------- */
@@ -808,7 +825,11 @@ static int __init acpi_init(void)
 		}
 	} else
 		disable_acpi();
-
+	/*
+	 * If the laptop falls into the DMI check table, the power state check
+	 * will be disabled in the course of device power transistion.
+	 */
+	dmi_check_system(power_nocheck_dmi_table);
 	return result;
 }
 


