From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [RFC] [Patch 2/2]  ACPI :EC cleanup : Delete the useless DMI check
	for some broken laptops
Date: Mon, 17 Nov 2008 14:49:10 +0800
Message-ID: <1226904550.4062.25.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52059 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752869AbYKQGlB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Nov 2008 01:41:01 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, astarikovskiy@suse.de

Subject: ACPI: EC cleanup : Delete the unused DMI check for some broken laptops
From: Zhao Yakui <yakui.zhao@intel.com>

If the EC device is still parsed in DSDT table when ECDT table exists, the DMI
check for some broken laptops are useless. The unused DMI check is deleted.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
cc: Alexey Starikovskiy <astarikovskiy@suse.de>
---
 drivers/acpi/ec.c |   33 ---------------------------------
 1 file changed, 33 deletions(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -121,30 +121,6 @@ static struct acpi_ec {
 	spinlock_t curr_lock;
 } *boot_ec, *first_ec;
 
-/* 
- * Some Asus system have exchanged ECDT data/command IO addresses.
- */
-static int print_ecdt_error(const struct dmi_system_id *id)
-{
-	printk(KERN_NOTICE PREFIX "%s detected - "
-		"ECDT has exchanged control/data I/O address\n",
-		id->ident);
-	return 0;
-}
-
-static struct dmi_system_id __cpuinitdata ec_dmi_table[] = {
-	{
-	print_ecdt_error, "Asus L4R", {
-	DMI_MATCH(DMI_BIOS_VERSION, "1008.006"),
-	DMI_MATCH(DMI_PRODUCT_NAME, "L4R"),
-	DMI_MATCH(DMI_BOARD_NAME, "L4R") }, NULL},
-	{
-	print_ecdt_error, "Asus M6R", {
-	DMI_MATCH(DMI_BIOS_VERSION, "0207"),
-	DMI_MATCH(DMI_PRODUCT_NAME, "M6R"),
-	DMI_MATCH(DMI_BOARD_NAME, "M6R") }, NULL},
-	{},
-};
 
 /* --------------------------------------------------------------------------
                              Transaction Management
@@ -994,15 +970,6 @@ int __init acpi_ec_ecdt_probe(void)
 		pr_info(PREFIX "EC description table is found, configuring boot EC\n");
 		boot_ec->command_addr = ecdt_ptr->control.address;
 		boot_ec->data_addr = ecdt_ptr->data.address;
-		if (dmi_check_system(ec_dmi_table)) {
-			/*
-			 * If the board falls into ec_dmi_table, it means
-			 * that ECDT table gives the incorrect command/status
-			 * & data I/O address. Just fix it.
-			 */
-			boot_ec->data_addr = ecdt_ptr->control.address;
-			boot_ec->command_addr = ecdt_ptr->data.address;
-		}
 		boot_ec->gpe = ecdt_ptr->gpe;
 		boot_ec->handle = ACPI_ROOT_OBJECT;
 		status = acpi_get_handle(ACPI_ROOT_OBJECT, ecdt_ptr->id,


