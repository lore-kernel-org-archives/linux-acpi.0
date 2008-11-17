From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [RFC] [Patch 1/2]  ACPI :Compare EC device in DSDT table with that
	in ECDT table
Date: Mon, 17 Nov 2008 14:45:00 +0800
Message-ID: <1226904300.4062.16.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30031 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656AbYKQGgw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Nov 2008 01:36:52 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernle.org, astarikovskiy@suse.de

Subject: ACPI: Compare EC device in DSDT table with that in ECDT table
From: Zhao Yakui <yakui.zhao@intel.com>

On some broken laptops the EC device defined in ECDT table is incorrect. For
example:
        The incorrect Command/Status I/O Port
        The incorrect Data I/O port
        Sometimes the GPE number is incorrect.
        Sometimes the EC namepath is also incorrect.
In such case the EC device can't be initialized correctly. Maybe it is
appropriate to compare the EC device in DSDT table with that in ECDT table.
If they mismatch, the BIOS bug will be reported and the EC device parsed
in DSDT table will be initialized instead of that defined in ECDT table.

http://bugzilla.kernel.org/show_bug.cgi?id=9399
http://bugzilla.kernel.org/show_bug.cgi?id=11880

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
cc: Alexey Starikovskiy <astarikovskiy@suse.de>
---
 drivers/acpi/ec.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -990,6 +990,7 @@ int __init acpi_ec_ecdt_probe(void)
 	status = acpi_get_table(ACPI_SIG_ECDT, 1,
 				(struct acpi_table_header **)&ecdt_ptr);
 	if (ACPI_SUCCESS(status)) {
+		struct acpi_ec *ec_dsdt;
 		pr_info(PREFIX "EC description table is found, configuring boot EC\n");
 		boot_ec->command_addr = ecdt_ptr->control.address;
 		boot_ec->data_addr = ecdt_ptr->data.address;
@@ -1004,7 +1005,63 @@ int __init acpi_ec_ecdt_probe(void)
 		}
 		boot_ec->gpe = ecdt_ptr->gpe;
 		boot_ec->handle = ACPI_ROOT_OBJECT;
-		acpi_get_handle(ACPI_ROOT_OBJECT, ecdt_ptr->id, &boot_ec->handle);
+		status = acpi_get_handle(ACPI_ROOT_OBJECT, ecdt_ptr->id,
+					&boot_ec->handle);
+		if (ACPI_FAILURE(status)) {
+			/*
+			 * If the failure is returned by the function of
+			 * acpi_get_handle, it indicates that the EC namepath
+			 * is given by ECDT table. Print the BIOS bug.
+			 */
+			printk(KERN_INFO PREFIX "BIOS bug. The incorrect "
+				"namepath is given in ECDT table\n");
+		}
+		/*
+		 * Don't trust the namepath given by ECDT table. So we should
+		 * walk ACPI namespace tree to get the EC device in DSDT table.
+		 */
+		ec_dsdt = NULL;
+		ec_dsdt = kzalloc(sizeof(struct acpi_ec), GFP_KERNEL);
+		status = acpi_get_devices(ec_device_ids[0].id,
+				ec_parse_device, ec_dsdt, NULL);
+		/* check that acpi_get_devices actually find something
+		 */
+		if (ACPI_FAILURE(status) || !ec_dsdt->handle) {
+			printk(KERN_INFO PREFIX "BIOS bug: Incorrect "
+				"EC device in DSDT table\n");
+			kfree(ec_dsdt);
+			ec_dsdt = NULL;
+		}
+		/*
+		 * When EC device is parsed successfully in DSDT table, compare
+		 * it with that in ECDT table. If they don't mismatch, the EC
+		 * device is initialized instead of that in ECDT table
+		 */
+		if (ACPI_SUCCESS(status) && ec_dsdt) {
+			/* Compare the Cmd/Status I/O port */
+			if (ec_dsdt->command_addr !=
+				boot_ec->command_addr) {
+				printk(KERN_INFO PREFIX "BIOS bug: Incorrect "
+				"EC cmd/status I/O port in ECDT table\n");
+				boot_ec->command_addr = ec_dsdt->
+							command_addr;
+			}
+			/* Compare the Data I/O port */
+			if (ec_dsdt->data_addr != boot_ec->data_addr) {
+				printk(KERN_INFO PREFIX "BIOS bug: "
+				"Incorrect EC Data I/O port in ECDT table\n");
+				boot_ec->data_addr = ec_dsdt->data_addr;
+			}
+			/* Compare the EC GPE number */
+			if (ec_dsdt->gpe != boot_ec->gpe) {
+				printk(KERN_INFO PREFIX "BIOS bug: "
+				"Incorrect EC GPE number in ECDT table\n");
+				boot_ec->gpe = ec_dsdt->gpe;
+			}
+			boot_ec->global_lock = ec_dsdt->global_lock;
+			kfree(ec_dsdt);
+			ec_dsdt = NULL;
+		}
 	} else {
 		/* This workaround is needed only on some broken machines,
 		 * which require early EC, but fail to provide ECDT */


