From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/23] ACPI: EC: Don't trust ECDT tables from ASUS
Date: Fri, 16 Jan 2009 15:25:04 -0500
Message-ID: <c6cb0e878446c79f42e7833d7bb69ed6bfbb381f.1232137452.git.len.brown@intel.com>
References: <1232137512-17327-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:50288 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757235AbZAPUZX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 15:25:23 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KDK005R0ZE8OYZ5@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 16 Jan 2009 14:25:20 -0600 (CST)
In-reply-to: <1232137512-17327-1-git-send-email-lenb@kernel.org>
In-reply-to: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
References: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

http://bugzilla.kernel.org/show_bug.cgi?id=9399
http://bugzilla.kernel.org/show_bug.cgi?id=11880

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   74 +++++++++++++++++++++-------------------------------
 1 files changed, 30 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e079426..a2b82c9 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -120,31 +120,6 @@ static struct acpi_ec {
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
-
 /* --------------------------------------------------------------------------
                              Transaction Management
    -------------------------------------------------------------------------- */
@@ -983,8 +958,8 @@ static const struct acpi_device_id ec_device_ids[] = {
 int __init acpi_ec_ecdt_probe(void)
 {
 	acpi_status status;
+	struct acpi_ec *saved_ec = NULL;
 	struct acpi_table_ecdt *ecdt_ptr;
-	acpi_handle dummy;
 
 	boot_ec = make_acpi_ec();
 	if (!boot_ec)
@@ -998,21 +973,16 @@ int __init acpi_ec_ecdt_probe(void)
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
 		acpi_get_handle(ACPI_ROOT_OBJECT, ecdt_ptr->id, &boot_ec->handle);
-		/* Add some basic check against completely broken table */
-		if (boot_ec->data_addr != boot_ec->command_addr)
+		/* Don't trust ECDT, which comes from ASUSTek */
+		if (!dmi_name_in_vendors("ASUS"))
 			goto install;
+		saved_ec = kmalloc(sizeof(struct acpi_ec), GFP_KERNEL);
+		if (!saved_ec)
+			return -ENOMEM;
+		memcpy(&saved_ec, boot_ec, sizeof(saved_ec));
 	/* fall through */
 	}
 	/* This workaround is needed only on some broken machines,
@@ -1023,13 +993,29 @@ int __init acpi_ec_ecdt_probe(void)
 	/* Check that acpi_get_devices actually find something */
 	if (ACPI_FAILURE(status) || !boot_ec->handle)
 		goto error;
-	/* We really need to limit this workaround, the only ASUS,
-	 * which needs it, has fake EC._INI method, so use it as flag.
-	 * Keep boot_ec struct as it will be needed soon.
-	 */
-	if (!dmi_name_in_vendors("ASUS") ||
-	    ACPI_FAILURE(acpi_get_handle(boot_ec->handle, "_INI", &dummy)))
-		return -ENODEV;
+	if (saved_ec) {
+		/* try to find good ECDT from ASUSTek */
+		if (saved_ec->command_addr != boot_ec->command_addr ||
+		    saved_ec->data_addr != boot_ec->data_addr ||
+		    saved_ec->gpe != boot_ec->gpe ||
+		    saved_ec->handle != boot_ec->handle)
+			pr_info(PREFIX "ASUSTek keeps feeding us with broken "
+			"ECDT tables, which are very hard to workaround. "
+			"Trying to use DSDT EC info instead. Please send "
+			"output of acpidump to linux-acpi@vger.kernel.org\n");
+		kfree(saved_ec);
+		saved_ec = NULL;
+	} else {
+		/* We really need to limit this workaround, the only ASUS,
+		* which needs it, has fake EC._INI method, so use it as flag.
+		* Keep boot_ec struct as it will be needed soon.
+		*/
+		acpi_handle dummy;
+		if (!dmi_name_in_vendors("ASUS") ||
+		    ACPI_FAILURE(acpi_get_handle(boot_ec->handle, "_INI",
+							&dummy)))
+			return -ENODEV;
+	}
 install:
 	if (!ec_install_handlers(boot_ec)) {
 		first_ec = boot_ec;
-- 
1.5.6.6

