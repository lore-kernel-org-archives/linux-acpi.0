From: Len Brown <len.brown@intel.com>
Subject: [PATCH 12/12] ACPI: EC: Switch from boot_ec as soon as we find its desc in DSDT.
Date: Fri,  3 Aug 2007 18:33:45 -0400
Message-ID: <1186180437438-git-send-email-len.brown@intel.com>
References: <11861804251625-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28479 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763860AbXHCWd6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Aug 2007 18:33:58 -0400
In-Reply-To: <11861804251625-git-send-email-len.brown@intel.com>
Message-Id: <7c010de7506954e973abfab5c5999c5a97f7a73e.1186180370.git.len.brown@intel.com>
In-Reply-To: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
References: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikivskiy@suse.de>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikivskiy@suse.de>

Some ASUS laptops fail to use boot time EC
and need to eventually switch to one described in DSDT.

http://bugzilla.kernel.org/show_bug.cgi?id=8709

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   45 ++++++++++++++++-----------------------------
 1 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 6292890..71caa7d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -679,6 +679,14 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 	return AE_CTRL_TERMINATE;
 }
 
+static void ec_remove_handlers(struct acpi_ec *ec)
+{
+	acpi_remove_address_space_handler(ec->handle,
+					  ACPI_ADR_SPACE_EC,
+					  &acpi_ec_space_handler);
+	acpi_remove_gpe_handler(NULL, ec->gpe, &acpi_ec_gpe_handler);
+}
+
 static int acpi_ec_add(struct acpi_device *device)
 {
 	struct acpi_ec *ec = NULL;
@@ -702,16 +710,15 @@ static int acpi_ec_add(struct acpi_device *device)
 	/* Check if we found the boot EC */
 	if (boot_ec) {
 		if (boot_ec->gpe == ec->gpe) {
-			/* We might have incorrect info for GL at boot time */
 			mutex_lock(&boot_ec->lock);
-			boot_ec->global_lock = ec->global_lock;
-			/* Copy handlers from new ec into boot ec */
-			list_splice(&ec->list, &boot_ec->list);
+			ec_remove_handlers(boot_ec);
 			mutex_unlock(&boot_ec->lock);
-			kfree(ec);
-			ec = boot_ec;
+			mutex_destroy(&boot_ec->lock);
+			kfree(boot_ec);
+			first_ec = boot_ec = NULL;
 		}
-	} else
+	}
+	if (!first_ec)
 		first_ec = ec;
 	ec->handle = device->handle;
 	acpi_driver_data(device) = ec;
@@ -740,9 +747,6 @@ static int acpi_ec_remove(struct acpi_device *device, int type)
 	if (ec == first_ec)
 		first_ec = NULL;
 
-	/* Don't touch boot EC */
-	if (boot_ec != ec)
-		kfree(ec);
 	return 0;
 }
 
@@ -806,9 +810,7 @@ static int acpi_ec_start(struct acpi_device *device)
 	if (!ec)
 		return -EINVAL;
 
-	/* Boot EC is already working */
-	if (ec != boot_ec)
-		ret = ec_install_handlers(ec);
+	ret = ec_install_handlers(ec);
 
 	/* EC is fully operational, allow queries */
 	atomic_set(&ec->query_pending, 0);
@@ -818,7 +820,6 @@ static int acpi_ec_start(struct acpi_device *device)
 
 static int acpi_ec_stop(struct acpi_device *device, int type)
 {
-	acpi_status status;
 	struct acpi_ec *ec;
 
 	if (!device)
@@ -827,21 +828,7 @@ static int acpi_ec_stop(struct acpi_device *device, int type)
 	ec = acpi_driver_data(device);
 	if (!ec)
 		return -EINVAL;
-
-	/* Don't touch boot EC */
-	if (ec == boot_ec)
-		return 0;
-
-	status = acpi_remove_address_space_handler(ec->handle,
-						   ACPI_ADR_SPACE_EC,
-						   &acpi_ec_space_handler);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	status = acpi_remove_gpe_handler(NULL, ec->gpe, &acpi_ec_gpe_handler);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
+	ec_remove_handlers(ec);
 	return 0;
 }
 
-- 
1.5.3.rc3.7.gd58e
