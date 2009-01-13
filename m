From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 3/3] ACPI: EC: Don't trust ECDT tables from ASUS
Date: Wed, 14 Jan 2009 02:57:53 +0300
Message-ID: <20090113235753.10548.54917.stgit@thinkpad>
References: <20090113235739.10548.20626.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:35208 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755652AbZAMX5v (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 13 Jan 2009 18:57:51 -0500
In-Reply-To: <20090113235739.10548.20626.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

References: http://bugzilla.kernel.org/show_bug.cgi?id=9399
	    http://bugzilla.kernel.org/show_bug.cgi?id=11880

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |   74 +++++++++++++++++++++--------------------------------
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

