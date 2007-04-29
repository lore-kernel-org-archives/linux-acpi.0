From: Len Brown <len.brown@intel.com>
Subject: [PATCH 009/105] ACPI: EC: Rename ec_ecdt to more informative boot_ec
Date: Sun, 29 Apr 2007 00:50:09 -0400
Message-ID: <11778223131932-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57052 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754592AbXD2Evy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:51:54 -0400
In-Reply-To: <11778223122850-git-send-email-len.brown@intel.com>
Message-Id: <d66d969df88c742494736ed06eeaf3229d3a7259.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   43 ++++++++++++++++++++-----------------------
 1 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index c9dcf9a..1250468 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -102,7 +102,7 @@ static struct acpi_ec {
 	atomic_t query_pending;
 	atomic_t event_count;
 	wait_queue_head_t wait;
-} *ec_ecdt;
+} *boot_ec;
 
 /* External interfaces use first EC only, so remember */
 static struct acpi_device *first_ec;
@@ -646,21 +646,18 @@ static int acpi_ec_add(struct acpi_device *device)
 	}
 
 	/* Check if we found the boot EC */
-	if (ec_ecdt) {
-		if (ec_ecdt->gpe == ec->gpe) {
+	if (boot_ec) {
+		if (boot_ec->gpe == ec->gpe) {
 			/* We might have incorrect info for GL at boot time */
-			mutex_lock(&ec_ecdt->lock);
-			ec_ecdt->global_lock = ec->global_lock;
-			mutex_unlock(&ec_ecdt->lock);
+			mutex_lock(&boot_ec->lock);
+			boot_ec->global_lock = ec->global_lock;
+			mutex_unlock(&boot_ec->lock);
 			kfree(ec);
-			ec = ec_ecdt;
+			ec = boot_ec;
 		}
 	}
-
 	ec->handle = device->handle;
-
 	acpi_driver_data(device) = ec;
-
 	if (!first_ec)
 		first_ec = device;
 
@@ -689,7 +686,7 @@ static int acpi_ec_remove(struct acpi_device *device, int type)
 		first_ec = NULL;
 
 	/* Don't touch boot EC */
-	if (ec_ecdt != ec)
+	if (boot_ec != ec)
 		kfree(ec);
 
 	return 0;
@@ -759,7 +756,7 @@ static int acpi_ec_start(struct acpi_device *device)
 			  ec->gpe, ec->command_addr, ec->data_addr));
 
 	/* Boot EC is already working */
-	if (ec == ec_ecdt)
+	if (ec == boot_ec)
 		return 0;
 
 	return ec_install_handlers(ec);
@@ -778,7 +775,7 @@ static int acpi_ec_stop(struct acpi_device *device, int type)
 		return -EINVAL;
 
 	/* Don't touch boot EC */
-	if (ec == ec_ecdt)
+	if (ec == boot_ec)
 		return 0;
 
 	status = acpi_remove_address_space_handler(ec->handle,
@@ -828,8 +825,8 @@ int __init acpi_ec_ecdt_probe(void)
 	acpi_status status;
 	struct acpi_table_ecdt *ecdt_ptr;
 
-	ec_ecdt = make_acpi_ec();
-	if (!ec_ecdt)
+	boot_ec = make_acpi_ec();
+	if (!boot_ec)
 		return -ENOMEM;
 	/*
 	 * Generate a boot ec context
@@ -842,18 +839,18 @@ int __init acpi_ec_ecdt_probe(void)
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found ECDT"));
 
-	ec_ecdt->command_addr = ecdt_ptr->control.address;
-	ec_ecdt->data_addr = ecdt_ptr->data.address;
-	ec_ecdt->gpe = ecdt_ptr->gpe;
-	ec_ecdt->uid = ecdt_ptr->uid;
-	ec_ecdt->handle = ACPI_ROOT_OBJECT;
+	boot_ec->command_addr = ecdt_ptr->control.address;
+	boot_ec->data_addr = ecdt_ptr->data.address;
+	boot_ec->gpe = ecdt_ptr->gpe;
+	boot_ec->uid = ecdt_ptr->uid;
+	boot_ec->handle = ACPI_ROOT_OBJECT;
 
-	ret = ec_install_handlers(ec_ecdt);
+	ret = ec_install_handlers(boot_ec);
 	if (!ret)
 		return 0;
       error:
-	kfree(ec_ecdt);
-	ec_ecdt = NULL;
+	kfree(boot_ec);
+	boot_ec = NULL;
 
 	return -ENODEV;
 }
-- 
1.5.2.rc0.34.gda94
