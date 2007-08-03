From: Len Brown <len.brown@intel.com>
Subject: [PATCH 10/12] ACPI: EC: If ECDT is not found, look up EC in DSDT.
Date: Fri,  3 Aug 2007 18:33:43 -0400
Message-ID: <11861804352132-git-send-email-len.brown@intel.com>
References: <11861804251625-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28479 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763859AbXHCWd4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Aug 2007 18:33:56 -0400
In-Reply-To: <11861804251625-git-send-email-len.brown@intel.com>
Message-Id: <cd8c93a4e04dce8f00d1ef3a476aac8bd65ae40b.1186180370.git.len.brown@intel.com>
In-Reply-To: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
References: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Some ASUS laptops access EC space from device _INI methods, but do not
provide ECDT for early EC setup. In order to make them function properly,
there is a need to find EC is DSDT before any _INI is called.

Similar functionality was turned on by acpi_fake_ecdt=1 command line
before. Now it is on all the time.

http://bugzilla.kernel.org/show_bug.cgi?id=8598

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   50 ++++++++++++++++++++++++++++----------------------
 1 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index dd384ec..4d7fe82 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -664,30 +664,32 @@ acpi_ec_register_query_methods(acpi_handle handle, u32 level,
 	return AE_OK;
 }
 
-static int ec_parse_device(struct acpi_ec *ec, acpi_handle handle)
+static acpi_status
+ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 {
-	if (ACPI_FAILURE(acpi_walk_resources(handle, METHOD_NAME__CRS,
-				     ec_parse_io_ports, ec)))
-		return -EINVAL;
+	acpi_status status;
+
+	struct acpi_ec *ec = context;
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
+				     ec_parse_io_ports, ec);
+	if (ACPI_FAILURE(status))
+		return status;
 
 	/* Get GPE bit assignment (EC events). */
 	/* TODO: Add support for _GPE returning a package */
-	if (ACPI_FAILURE(acpi_evaluate_integer(handle, "_GPE", NULL, &ec->gpe)))
-		return -EINVAL;
+	status = acpi_evaluate_integer(handle, "_GPE", NULL, &ec->gpe);
+	if (ACPI_FAILURE(status))
+		return status;
 
 	/* Use the global lock for all EC transactions? */
 	acpi_evaluate_integer(handle, "_GLK", NULL, &ec->global_lock);
 
-	/* Find and register all query methods */
-	acpi_walk_namespace(ACPI_TYPE_METHOD, handle, 1,
-			    acpi_ec_register_query_methods, ec, NULL);
-
 	ec->handle = handle;
 
 	printk(KERN_INFO PREFIX "GPE = 0x%lx, I/O: command/status = 0x%lx, data = 0x%lx",
 			  ec->gpe, ec->command_addr, ec->data_addr);
 
-	return 0;
+	return AE_CTRL_TERMINATE;
 }
 
 static int acpi_ec_add(struct acpi_device *device)
@@ -704,7 +706,8 @@ static int acpi_ec_add(struct acpi_device *device)
 	if (!ec)
 		return -ENOMEM;
 
-	if (ec_parse_device(ec, device->handle)) {
+	if (ec_parse_device(device->handle, 0, ec, NULL) !=
+	    AE_CTRL_TERMINATE) {
 		kfree(ec);
 		return -EINVAL;
 	}
@@ -867,18 +870,21 @@ int __init acpi_ec_ecdt_probe(void)
 	/*
 	 * Generate a boot ec context
 	 */
-
 	status = acpi_get_table(ACPI_SIG_ECDT, 1,
 				(struct acpi_table_header **)&ecdt_ptr);
-	if (ACPI_FAILURE(status))
-		goto error;
-
-	printk(KERN_INFO PREFIX "EC description table is found, configuring boot EC\n");
-
-	boot_ec->command_addr = ecdt_ptr->control.address;
-	boot_ec->data_addr = ecdt_ptr->data.address;
-	boot_ec->gpe = ecdt_ptr->gpe;
-	boot_ec->handle = ACPI_ROOT_OBJECT;
+	if (ACPI_SUCCESS(status)) {
+		printk(KERN_INFO PREFIX "EC description table is found, configuring boot EC\n\n");
+		boot_ec->command_addr = ecdt_ptr->control.address;
+		boot_ec->data_addr = ecdt_ptr->data.address;
+		boot_ec->gpe = ecdt_ptr->gpe;
+		boot_ec->handle = ACPI_ROOT_OBJECT;
+	} else {
+		printk(KERN_DEBUG PREFIX "Look up EC in DSDT\n");
+		status = acpi_get_devices(ec_device_ids[0].id, ec_parse_device,
+						boot_ec, NULL);
+		if (ACPI_FAILURE(status))
+			goto error;
+	}
 
 	ret = ec_install_handlers(boot_ec);
 	if (!ret) {
-- 
1.5.3.rc3.7.gd58e
