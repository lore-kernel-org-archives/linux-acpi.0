From: Len Brown <len.brown@intel.com>
Subject: [PATCH 004/105] ACPI: EC: "Fake ECDT" workaround is not needed any longer.
Date: Sun, 29 Apr 2007 00:50:04 -0400
Message-ID: <11778223081771-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62745 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754587AbXD2Evu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:51:50 -0400
In-Reply-To: <11778223083747-git-send-email-len.brown@intel.com>
Message-Id: <33c7a0738c5f753a7d94fd3b2ec7d84e79a141a8.1177822058.git.len.brown@intel.com>
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
 drivers/acpi/ec.c |   81 -----------------------------------------------------
 1 files changed, 0 insertions(+), 81 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 7828ac5..5999abd 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -805,74 +805,6 @@ static int acpi_ec_stop(struct acpi_device *device, int type)
 	return 0;
 }
 
-static acpi_status __init
-acpi_fake_ecdt_callback(acpi_handle handle,
-			u32 Level, void *context, void **retval)
-{
-	acpi_status status;
-
-	mutex_init(&ec_ecdt->lock);
-	atomic_set(&ec_ecdt->event_count, 1);
-	if (acpi_ec_mode == EC_INTR) {
-		init_waitqueue_head(&ec_ecdt->wait);
-	}
-	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
-				     acpi_ec_io_ports, ec_ecdt);
-	if (ACPI_FAILURE(status))
-		return status;
-
-	ec_ecdt->uid = -1;
-	acpi_evaluate_integer(handle, "_UID", NULL, &ec_ecdt->uid);
-
-	status = acpi_evaluate_integer(handle, "_GPE", NULL, &ec_ecdt->gpe);
-	if (ACPI_FAILURE(status))
-		return status;
-	ec_ecdt->handle = handle;
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "GPE=0x%02lx, ports=0x%2lx, 0x%2lx",
-			  ec_ecdt->gpe, ec_ecdt->command_addr,
-			  ec_ecdt->data_addr));
-
-	return AE_CTRL_TERMINATE;
-}
-
-/*
- * Some BIOS (such as some from Gateway laptops) access EC region very early
- * such as in BAT0._INI or EC._INI before an EC device is found and
- * do not provide an ECDT. According to ACPI spec, ECDT isn't mandatorily
- * required, but if EC regison is accessed early, it is required.
- * The routine tries to workaround the BIOS bug by pre-scan EC device
- * It assumes that _CRS, _HID, _GPE, _UID methods of EC don't touch any
- * op region (since _REG isn't invoked yet). The assumption is true for
- * all systems found.
- */
-static int __init acpi_ec_fake_ecdt(void)
-{
-	acpi_status status;
-	int ret = 0;
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Try to make an fake ECDT"));
-
-	ec_ecdt = kzalloc(sizeof(struct acpi_ec), GFP_KERNEL);
-	if (!ec_ecdt) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	status = acpi_get_devices(ACPI_EC_HID,
-				  acpi_fake_ecdt_callback, NULL, NULL);
-	if (ACPI_FAILURE(status)) {
-		kfree(ec_ecdt);
-		ec_ecdt = NULL;
-		ret = -ENODEV;
-		ACPI_EXCEPTION((AE_INFO, status, "Can't make an fake ECDT"));
-		goto error;
-	}
-	return 0;
-      error:
-	return ret;
-}
-
 static int __init acpi_ec_get_real_ecdt(void)
 {
 	acpi_status status;
@@ -916,18 +848,12 @@ static int __init acpi_ec_get_real_ecdt(void)
 	return -ENODEV;
 }
 
-static int __initdata acpi_fake_ecdt_enabled;
 int __init acpi_ec_ecdt_probe(void)
 {
 	acpi_status status;
 	int ret;
 
 	ret = acpi_ec_get_real_ecdt();
-	/* Try to make a fake ECDT */
-	if (ret && acpi_fake_ecdt_enabled) {
-		ret = acpi_ec_fake_ecdt();
-	}
-
 	if (ret)
 		return 0;
 
@@ -1000,13 +926,6 @@ static void __exit acpi_ec_exit(void)
 }
 #endif				/* 0 */
 
-static int __init acpi_fake_ecdt_setup(char *str)
-{
-	acpi_fake_ecdt_enabled = 1;
-	return 1;
-}
-
-__setup("acpi_fake_ecdt", acpi_fake_ecdt_setup);
 static int __init acpi_ec_set_intr_mode(char *str)
 {
 	int intr;
-- 
1.5.2.rc0.34.gda94
