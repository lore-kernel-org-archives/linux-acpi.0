From: Len Brown <len.brown@intel.com>
Subject: [PATCH 008/105] ACPI: EC: Clean ECDT and namespace parsing.
Date: Sun, 29 Apr 2007 00:50:08 -0400
Message-ID: <11778223122850-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57052 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754591AbXD2Evx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:51:53 -0400
In-Reply-To: <11778223112050-git-send-email-len.brown@intel.com>
Message-Id: <c0900c3512dc8fd0b37f8fbcebc7853ed9efff10.1177822058.git.len.brown@intel.com>
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
 drivers/acpi/ec.c |  205 ++++++++++++++++++++++++++++-------------------------
 1 files changed, 109 insertions(+), 96 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 399cedf..c9dcf9a 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -604,74 +604,73 @@ static int acpi_ec_remove_fs(struct acpi_device *device)
 /* --------------------------------------------------------------------------
                                Driver Interface
    -------------------------------------------------------------------------- */
+static acpi_status
+ec_parse_io_ports(struct acpi_resource *resource, void *context);
+
+static acpi_status
+ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval);
+
+static struct acpi_ec *make_acpi_ec(void)
+{
+	struct acpi_ec *ec = kzalloc(sizeof(struct acpi_ec), GFP_KERNEL);
+	if (!ec)
+		return NULL;
+
+	atomic_set(&ec->query_pending, 0);
+	atomic_set(&ec->event_count, 1);
+	mutex_init(&ec->lock);
+	init_waitqueue_head(&ec->wait);
+
+	return ec;
+}
 
 static int acpi_ec_add(struct acpi_device *device)
 {
-	int result = 0;
 	acpi_status status = AE_OK;
 	struct acpi_ec *ec = NULL;
 
 	if (!device)
 		return -EINVAL;
 
-	ec = kzalloc(sizeof(struct acpi_ec), GFP_KERNEL);
+	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
+
+	ec = make_acpi_ec();
 	if (!ec)
 		return -ENOMEM;
 
-	ec->handle = device->handle;
-	ec->uid = -1;
-	mutex_init(&ec->lock);
-	atomic_set(&ec->query_pending, 0);
-	atomic_set(&ec->event_count, 1);
-	if (acpi_ec_mode == EC_INTR) {
-		init_waitqueue_head(&ec->wait);
+	status = ec_parse_device(device->handle, 0, ec, NULL);
+	if (status != AE_CTRL_TERMINATE) {
+		kfree(ec);
+		return -EINVAL;
 	}
-	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
-	acpi_driver_data(device) = ec;
 
-	/* Use the global lock for all EC transactions? */
-	acpi_evaluate_integer(ec->handle, "_GLK", NULL, &ec->global_lock);
-
-	/* XXX we don't test uids, because on some boxes ecdt uid = 0, see:
-	   http://bugzilla.kernel.org/show_bug.cgi?id=6111 */
+	/* Check if we found the boot EC */
 	if (ec_ecdt) {
-		acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
-						  ACPI_ADR_SPACE_EC,
-						  &acpi_ec_space_handler);
+		if (ec_ecdt->gpe == ec->gpe) {
+			/* We might have incorrect info for GL at boot time */
+			mutex_lock(&ec_ecdt->lock);
+			ec_ecdt->global_lock = ec->global_lock;
+			mutex_unlock(&ec_ecdt->lock);
+			kfree(ec);
+			ec = ec_ecdt;
+		}
+	}
 
-		acpi_remove_gpe_handler(NULL, ec_ecdt->gpe,
-					&acpi_ec_gpe_handler);
+	ec->handle = device->handle;
 
-		kfree(ec_ecdt);
-	}
+	acpi_driver_data(device) = ec;
 
-	/* Get GPE bit assignment (EC events). */
-	/* TODO: Add support for _GPE returning a package */
-	status = acpi_evaluate_integer(ec->handle, "_GPE", NULL, &ec->gpe);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status,
-				"Obtaining GPE bit assignment"));
-		result = -ENODEV;
-		goto end;
-	}
+	if (!first_ec)
+		first_ec = device;
 
-	result = acpi_ec_add_fs(device);
-	if (result)
-		goto end;
+	acpi_ec_add_fs(device);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "%s [%s] (gpe %d) interrupt mode.",
 			  acpi_device_name(device), acpi_device_bid(device),
 			  (u32) ec->gpe));
 
-	if (!first_ec)
-		first_ec = device;
-
-      end:
-	if (result)
-		kfree(ec);
-
-	return result;
+	return 0;
 }
 
 static int acpi_ec_remove(struct acpi_device *device, int type)
@@ -685,13 +684,19 @@ static int acpi_ec_remove(struct acpi_device *device, int type)
 
 	acpi_ec_remove_fs(device);
 
-	kfree(ec);
+	acpi_driver_data(device) = NULL;
+	if (device == first_ec)
+		first_ec = NULL;
+
+	/* Don't touch boot EC */
+	if (ec_ecdt != ec)
+		kfree(ec);
 
 	return 0;
 }
 
 static acpi_status
-acpi_ec_io_ports(struct acpi_resource *resource, void *context)
+ec_parse_io_ports(struct acpi_resource *resource, void *context)
 {
 	struct acpi_ec *ec = context;
 
@@ -717,9 +722,10 @@ acpi_ec_io_ports(struct acpi_resource *resource, void *context)
 
 static int ec_install_handlers(struct acpi_ec *ec)
 {
-	acpi_status status = acpi_install_gpe_handler(NULL, ec->gpe,
-						      ACPI_GPE_EDGE_TRIGGERED,
-						      &acpi_ec_gpe_handler, ec);
+	acpi_status status;
+	status = acpi_install_gpe_handler(NULL, ec->gpe,
+					  ACPI_GPE_EDGE_TRIGGERED,
+					  &acpi_ec_gpe_handler, ec);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 	acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
@@ -739,8 +745,7 @@ static int ec_install_handlers(struct acpi_ec *ec)
 
 static int acpi_ec_start(struct acpi_device *device)
 {
-	acpi_status status = AE_OK;
-	struct acpi_ec *ec = NULL;
+	struct acpi_ec *ec;
 
 	if (!device)
 		return -EINVAL;
@@ -750,32 +755,31 @@ static int acpi_ec_start(struct acpi_device *device)
 	if (!ec)
 		return -EINVAL;
 
-	/*
-	 * Get I/O port addresses. Convert to GAS format.
-	 */
-	status = acpi_walk_resources(ec->handle, METHOD_NAME__CRS,
-				     acpi_ec_io_ports, ec);
-	if (ACPI_FAILURE(status) || ec->command_addr == 0) {
-		ACPI_EXCEPTION((AE_INFO, status,
-				"Error getting I/O port addresses"));
-		return -ENODEV;
-	}
-
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "gpe=0x%02lx, ports=0x%2lx,0x%2lx",
 			  ec->gpe, ec->command_addr, ec->data_addr));
 
+	/* Boot EC is already working */
+	if (ec == ec_ecdt)
+		return 0;
+
 	return ec_install_handlers(ec);
 }
 
 static int acpi_ec_stop(struct acpi_device *device, int type)
 {
-	acpi_status status = AE_OK;
-	struct acpi_ec *ec = NULL;
+	acpi_status status;
+	struct acpi_ec *ec;
 
 	if (!device)
 		return -EINVAL;
 
 	ec = acpi_driver_data(device);
+	if (!ec)
+		return -EINVAL;
+
+	/* Don't touch boot EC */
+	if (ec == ec_ecdt)
+		return 0;
 
 	status = acpi_remove_address_space_handler(ec->handle,
 						   ACPI_ADR_SPACE_EC,
@@ -790,51 +794,64 @@ static int acpi_ec_stop(struct acpi_device *device, int type)
 	return 0;
 }
 
-static int __init acpi_ec_get_real_ecdt(void)
+static acpi_status
+ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 {
 	acpi_status status;
+
+	struct acpi_ec *ec = context;
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
+				     ec_parse_io_ports, ec);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	/* Get GPE bit assignment (EC events). */
+	/* TODO: Add support for _GPE returning a package */
+	status = acpi_evaluate_integer(handle, "_GPE", NULL, &ec->gpe);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	/* Use the global lock for all EC transactions? */
+	acpi_evaluate_integer(handle, "_GLK", NULL, &ec->global_lock);
+
+	ec->handle = handle;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "GPE=0x%02lx, ports=0x%2lx, 0x%2lx",
+			  ec->gpe, ec->command_addr, ec->data_addr));
+
+	return AE_CTRL_TERMINATE;
+}
+
+int __init acpi_ec_ecdt_probe(void)
+{
+	int ret;
+	acpi_status status;
 	struct acpi_table_ecdt *ecdt_ptr;
 
+	ec_ecdt = make_acpi_ec();
+	if (!ec_ecdt)
+		return -ENOMEM;
+	/*
+	 * Generate a boot ec context
+	 */
+
 	status = acpi_get_table(ACPI_SIG_ECDT, 1,
 				(struct acpi_table_header **)&ecdt_ptr);
 	if (ACPI_FAILURE(status))
-		return -ENODEV;
+		goto error;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found ECDT"));
 
-	/*
-	 * Generate a temporary ec context to use until the namespace is scanned
-	 */
-	ec_ecdt = kzalloc(sizeof(struct acpi_ec), GFP_KERNEL);
-	if (!ec_ecdt)
-		return -ENOMEM;
-
-	mutex_init(&ec_ecdt->lock);
-	atomic_set(&ec_ecdt->event_count, 1);
-	if (acpi_ec_mode == EC_INTR) {
-		init_waitqueue_head(&ec_ecdt->wait);
-	}
 	ec_ecdt->command_addr = ecdt_ptr->control.address;
 	ec_ecdt->data_addr = ecdt_ptr->data.address;
 	ec_ecdt->gpe = ecdt_ptr->gpe;
 	ec_ecdt->uid = ecdt_ptr->uid;
-
 	ec_ecdt->handle = ACPI_ROOT_OBJECT;
-	return 0;
-}
-
-int __init acpi_ec_ecdt_probe(void)
-{
-	int ret;
-
-	ret = acpi_ec_get_real_ecdt();
-	if (ret)
-		return 0;
 
 	ret = ec_install_handlers(ec_ecdt);
 	if (!ret)
 		return 0;
-
+      error:
 	kfree(ec_ecdt);
 	ec_ecdt = NULL;
 
@@ -884,12 +901,8 @@ static int __init acpi_ec_set_intr_mode(char *str)
 	if (!get_option(&str, &intr))
 		return 0;
 
-	if (intr) {
-		acpi_ec_mode = EC_INTR;
-	} else {
-		acpi_ec_mode = EC_POLL;
-	}
-	acpi_ec_driver.ops.add = acpi_ec_add;
+	acpi_ec_mode = (intr) ? EC_INTR : EC_POLL;
+
 	printk(KERN_NOTICE PREFIX "%s mode.\n", intr ? "interrupt" : "polling");
 
 	return 1;
-- 
1.5.2.rc0.34.gda94
