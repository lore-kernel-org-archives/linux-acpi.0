From: Len Brown <len.brown@intel.com>
Subject: [PATCH 010/105] ACPI: EC: first_ec is better to be acpi_ec than acpi_device.
Date: Sun, 29 Apr 2007 00:50:10 -0400
Message-ID: <11778223143898-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57052 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754593AbXD2Evz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:51:55 -0400
In-Reply-To: <11778223131932-git-send-email-len.brown@intel.com>
Message-Id: <d033879c9838b960014e861d0eb3bdf11d3b9d9d.1177822058.git.len.brown@intel.com>
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
 drivers/acpi/ec.c |   41 +++++++++++++----------------------------
 1 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 1250468..187981a 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -91,6 +91,7 @@ static struct acpi_driver acpi_ec_driver = {
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
+/* External interfaces use first EC only, so remember */
 static struct acpi_ec {
 	acpi_handle handle;
 	unsigned long uid;
@@ -102,10 +103,7 @@ static struct acpi_ec {
 	atomic_t query_pending;
 	atomic_t event_count;
 	wait_queue_head_t wait;
-} *boot_ec;
-
-/* External interfaces use first EC only, so remember */
-static struct acpi_device *first_ec;
+} *boot_ec, *first_ec;
 
 /* --------------------------------------------------------------------------
                              Transaction Management
@@ -299,38 +297,31 @@ static int acpi_ec_write(struct acpi_ec *ec, u8 address, u8 data)
  */
 int ec_burst_enable(void)
 {
-	struct acpi_ec *ec;
 	if (!first_ec)
 		return -ENODEV;
-	ec = acpi_driver_data(first_ec);
-	return acpi_ec_burst_enable(ec);
+	return acpi_ec_burst_enable(first_ec);
 }
 
 EXPORT_SYMBOL(ec_burst_enable);
 
 int ec_burst_disable(void)
 {
-	struct acpi_ec *ec;
 	if (!first_ec)
 		return -ENODEV;
-	ec = acpi_driver_data(first_ec);
-	return acpi_ec_burst_disable(ec);
+	return acpi_ec_burst_disable(first_ec);
 }
 
 EXPORT_SYMBOL(ec_burst_disable);
 
 int ec_read(u8 addr, u8 * val)
 {
-	struct acpi_ec *ec;
 	int err;
 	u8 temp_data;
 
 	if (!first_ec)
 		return -ENODEV;
 
-	ec = acpi_driver_data(first_ec);
-
-	err = acpi_ec_read(ec, addr, &temp_data);
+	err = acpi_ec_read(first_ec, addr, &temp_data);
 
 	if (!err) {
 		*val = temp_data;
@@ -343,15 +334,12 @@ EXPORT_SYMBOL(ec_read);
 
 int ec_write(u8 addr, u8 val)
 {
-	struct acpi_ec *ec;
 	int err;
 
 	if (!first_ec)
 		return -ENODEV;
 
-	ec = acpi_driver_data(first_ec);
-
-	err = acpi_ec_write(ec, addr, val);
+	err = acpi_ec_write(first_ec, addr, val);
 
 	return err;
 }
@@ -362,14 +350,10 @@ int ec_transaction(u8 command,
 		   const u8 * wdata, unsigned wdata_len,
 		   u8 * rdata, unsigned rdata_len)
 {
-	struct acpi_ec *ec;
-
 	if (!first_ec)
 		return -ENODEV;
 
-	ec = acpi_driver_data(first_ec);
-
-	return acpi_ec_transaction(ec, command, wdata,
+	return acpi_ec_transaction(first_ec, command, wdata,
 				   wdata_len, rdata, rdata_len);
 }
 
@@ -655,11 +639,10 @@ static int acpi_ec_add(struct acpi_device *device)
 			kfree(ec);
 			ec = boot_ec;
 		}
-	}
+	} else
+		first_ec = ec;
 	ec->handle = device->handle;
 	acpi_driver_data(device) = ec;
-	if (!first_ec)
-		first_ec = device;
 
 	acpi_ec_add_fs(device);
 
@@ -682,7 +665,7 @@ static int acpi_ec_remove(struct acpi_device *device, int type)
 	acpi_ec_remove_fs(device);
 
 	acpi_driver_data(device) = NULL;
-	if (device == first_ec)
+	if (ec == first_ec)
 		first_ec = NULL;
 
 	/* Don't touch boot EC */
@@ -846,8 +829,10 @@ int __init acpi_ec_ecdt_probe(void)
 	boot_ec->handle = ACPI_ROOT_OBJECT;
 
 	ret = ec_install_handlers(boot_ec);
-	if (!ret)
+	if (!ret) {
+		first_ec = boot_ec;
 		return 0;
+	}
       error:
 	kfree(boot_ec);
 	boot_ec = NULL;
-- 
1.5.2.rc0.34.gda94
