From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH] ACPI : Add the EC dmi table to fix the incorrect ECDT table
Date: Tue, 12 Aug 2008 10:40:10 +0800
Message-ID: <1218508810.3998.17.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32188 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087AbYHLC0K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Aug 2008 22:26:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

SUBJECT: ACPI : Add the EC dmi table to fix the incorrect ECDT table
>From : Zhao Yakui <yakui.zhao@intel.com>

On some ASUS laptops the ECDT gives the incorrect command/status & Data I/O
register address. In such case it will cause that EC device can't be 
initialized correctly.
To add the EC dmi table is to fix this issue. If the laptop falls into the 
EC dmi table, the EC command/data I/O address will be fixed.

http://bugzilla.kernel.org/show_bug.cgi?id=9399

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
tested-by    : Jan Kasprzak  <kas@fi.muni.cz>
---
 drivers/acpi/ec.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -110,6 +110,27 @@ static struct acpi_ec {
 	u8 handlers_installed;
 } *boot_ec, *first_ec;
 
+static int print_ecdt_error(const struct dmi_system_id *id)
+{
+	printk(KERN_NOTICE PREFIX "%s detected - "
+		"ECDT gives the incorrect command/data I/O address\n",
+		id->ident);
+	return 0;
+}
+static struct dmi_system_id __cpuinitdata ec_dmi_table[] = {
+	{
+	print_ecdt_error, "Asus L4R", {
+	DMI_MATCH(DMI_BIOS_VERSION, "1008.006"),
+	DMI_MATCH(DMI_PRODUCT_NAME, "L4R"),
+	DMI_MATCH(DMI_BOARD_NAME, "L4R") }, NULL},
+	{
+	print_ecdt_error, "Asus M6R", {
+	DMI_MATCH(DMI_BIOS_VERSION, "0207"),
+	DMI_MATCH(DMI_PRODUCT_NAME, "M6R"),
+	DMI_MATCH(DMI_BOARD_NAME, "M6R") }, NULL},
+	{},
+};
+
 /* --------------------------------------------------------------------------
                              Transaction Management
    -------------------------------------------------------------------------- */
@@ -911,6 +932,15 @@ int __init acpi_ec_ecdt_probe(void)
 		pr_info(PREFIX "EC description table is found, configuring boot EC\n");
 		boot_ec->command_addr = ecdt_ptr->control.address;
 		boot_ec->data_addr = ecdt_ptr->data.address;
+		if (dmi_check_system(ec_dmi_table)) {
+			/*
+			 * If the board falls into ec_dmi_table, it means
+			 * that ECDT table gives the incorrect command/status
+			 * & data I/O address. Just fix it.
+			 */
+			boot_ec->data_addr = ecdt_ptr->control.address;
+			boot_ec->command_addr = ecdt_ptr->data.address;
+		}
 		boot_ec->gpe = ecdt_ptr->gpe;
 		boot_ec->handle = ACPI_ROOT_OBJECT;
 		acpi_get_handle(ACPI_ROOT_OBJECT, ecdt_ptr->id, &boot_ec->handle);


