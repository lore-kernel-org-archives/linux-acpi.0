From: Len Brown <len.brown@intel.com>
Subject: [PATCH 23/77] ACPI EC: drop usage of ACPI_DEBUG_PRINT as too heavy weight
Date: Sun, 22 Jul 2007 05:14:08 -0400
Message-ID: <11850957262869-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44346 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762169AbXGVJP1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:27 -0400
In-Reply-To: <11850957252722-git-send-email-len.brown@intel.com>
Message-Id: <4350933a7447591041b51157a6b307be1816415f.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   20 ++++++--------------
 1 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 5534b23..ffb8361 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -39,20 +39,19 @@
 #include <acpi/acpi_drivers.h>
 #include <acpi/actypes.h>
 
-#define _COMPONENT		ACPI_EC_COMPONENT
-ACPI_MODULE_NAME("ec");
-#define ACPI_EC_COMPONENT		0x00100000
 #define ACPI_EC_CLASS			"embedded_controller"
 #define ACPI_EC_HID			"PNP0C09"
 #define ACPI_EC_DEVICE_NAME		"Embedded Controller"
 #define ACPI_EC_FILE_INFO		"info"
 #undef PREFIX
 #define PREFIX				"ACPI: EC: "
+
 /* EC status register */
 #define ACPI_EC_FLAG_OBF	0x01	/* Output buffer full */
 #define ACPI_EC_FLAG_IBF	0x02	/* Input buffer full */
 #define ACPI_EC_FLAG_BURST	0x10	/* burst mode */
 #define ACPI_EC_FLAG_SCI	0x20	/* EC-SCI occurred */
+
 /* EC commands */
 enum ec_command {
 	ACPI_EC_COMMAND_READ = 0x80,
@@ -245,7 +244,7 @@ static int acpi_ec_transaction(struct acpi_ec *ec, u8 command,
 
 	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, 0, 0);
 	if (status) {
-		printk(KERN_DEBUG PREFIX
+		printk(KERN_ERR PREFIX
 		       "input buffer is not empty, aborting transaction\n");
 		goto end;
 	}
@@ -630,10 +629,6 @@ static int acpi_ec_add(struct acpi_device *device)
 
 	acpi_ec_add_fs(device);
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "%s [%s] (gpe %d) interrupt mode.",
-			  acpi_device_name(device), acpi_device_bid(device),
-			  (u32) ec->gpe));
-
 	return 0;
 }
 
@@ -718,9 +713,6 @@ static int acpi_ec_start(struct acpi_device *device)
 	if (!ec)
 		return -EINVAL;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "gpe=0x%02lx, ports=0x%2lx,0x%2lx",
-			  ec->gpe, ec->command_addr, ec->data_addr));
-
 	/* Boot EC is already working */
 	if (ec == boot_ec)
 		return 0;
@@ -779,8 +771,8 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 
 	ec->handle = handle;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "GPE=0x%02lx, ports=0x%2lx, 0x%2lx",
-			  ec->gpe, ec->command_addr, ec->data_addr));
+	printk(KERN_INFO PREFIX "GPE = 0x%lx, I/O: command/status = 0x%lx, data = 0x%lx",
+			  ec->gpe, ec->command_addr, ec->data_addr);
 
 	return AE_CTRL_TERMINATE;
 }
@@ -803,7 +795,7 @@ int __init acpi_ec_ecdt_probe(void)
 	if (ACPI_FAILURE(status))
 		goto error;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found ECDT"));
+	printk(KERN_INFO PREFIX "EC description table is found, configuring boot EC\n");
 
 	boot_ec->command_addr = ecdt_ptr->control.address;
 	boot_ec->data_addr = ecdt_ptr->data.address;
-- 
1.5.3.rc2.22.g69a9b
