From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/22] ACPI: EC: first_ec is better to be acpi_ec than acpi_device.
Date: Fri,  9 Mar 2007 23:00:56 -0500
Message-ID: <11734992762317-git-send-email-lenb@kernel.org>
References: <11734992592550-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:16104 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S2993177AbXCJEBS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Mar 2007 23:01:18 -0500
In-Reply-To: <11734992592550-git-send-email-lenb@kernel.org>
Message-Id: <4f53bd846f964c9c3c590b3bc8eb2bfe1d392b5d.1173498657.git.len.brown@intel.com>
In-Reply-To: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
References: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
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
1.5.0.3.310.g05ef5
