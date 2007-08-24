From: Len Brown <len.brown@intel.com>
Subject: [PATCH 13/25] ACPI: EC: revert fix for bugzilla 8709
Date: Fri, 24 Aug 2007 03:21:00 -0400
Message-ID: <11879400892741-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
 <11879400782033-git-send-email-len.brown@intel.com>
 <11879400793131-git-send-email-len.brown@intel.com>
 <11879400794174-git-send-email-len.brown@intel.com>
 <11879400802531-git-send-email-len.brown@intel.com>
 <11879400812208-git-send-email-len.brown@intel.com>
 <11879400823500-git-send-email-len.brown@intel.com>
 <11879400841550-git-send-email-len.brown@intel.com>
 <1187940085345-git-send-email-len.brown@intel.com>
 <1187940086685-git-send-email-len.brown@intel.com>
 <11879400872911-git-send-email-len.brown@intel.com>
 <11879400882727-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22482 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754792AbXHXHVb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:31 -0400
In-Reply-To: <11879400882727-git-send-email-len.brown@intel.com>
Message-Id: <f9319f903f898dd4b15dbc386499725ce6c59776.1187939442.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@novell.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@novell.com>

This is a manual revert of 7c010de7506954e973abfab5c5999c5a97f7a73e,
a fix that broke another ASUS in 8909 and 8919.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   47 +++++++++++++++++++++++++++++++----------------
 1 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 56bee9e..43749c8 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -696,14 +696,6 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 	return AE_CTRL_TERMINATE;
 }
 
-static void ec_remove_handlers(struct acpi_ec *ec)
-{
-	acpi_remove_address_space_handler(ec->handle,
-					  ACPI_ADR_SPACE_EC,
-					  &acpi_ec_space_handler);
-	acpi_remove_gpe_handler(NULL, ec->gpe, &acpi_ec_gpe_handler);
-}
-
 static int acpi_ec_add(struct acpi_device *device)
 {
 	struct acpi_ec *ec = NULL;
@@ -727,13 +719,16 @@ static int acpi_ec_add(struct acpi_device *device)
 	/* Check if we found the boot EC */
 	if (boot_ec) {
 		if (boot_ec->gpe == ec->gpe) {
-			ec_remove_handlers(boot_ec);
-			mutex_destroy(&boot_ec->lock);
-			kfree(boot_ec);
-			first_ec = boot_ec = NULL;
+			/* We might have incorrect info for GL at boot time */
+			mutex_lock(&boot_ec->lock);
+			boot_ec->global_lock = ec->global_lock;
+			/* Copy handlers from new ec into boot ec */
+			list_splice(&ec->list, &boot_ec->list);
+			mutex_unlock(&boot_ec->lock);
+			kfree(ec);
+			ec = boot_ec;
 		}
-	}
-	if (!first_ec)
+	} else
 		first_ec = ec;
 	ec->handle = device->handle;
 	acpi_driver_data(device) = ec;
@@ -762,6 +757,9 @@ static int acpi_ec_remove(struct acpi_device *device, int type)
 	if (ec == first_ec)
 		first_ec = NULL;
 
+	/* Don't touch boot EC */
+	if (boot_ec != ec)
+		kfree(ec);
 	return 0;
 }
 
@@ -825,7 +823,9 @@ static int acpi_ec_start(struct acpi_device *device)
 	if (!ec)
 		return -EINVAL;
 
-	ret = ec_install_handlers(ec);
+	/* Boot EC is already working */
+	if (ec != boot_ec)
+		ret = ec_install_handlers(ec);
 
 	/* EC is fully operational, allow queries */
 	atomic_set(&ec->query_pending, 0);
@@ -835,6 +835,7 @@ static int acpi_ec_start(struct acpi_device *device)
 
 static int acpi_ec_stop(struct acpi_device *device, int type)
 {
+	acpi_status status;
 	struct acpi_ec *ec;
 
 	if (!device)
@@ -843,7 +844,21 @@ static int acpi_ec_stop(struct acpi_device *device, int type)
 	ec = acpi_driver_data(device);
 	if (!ec)
 		return -EINVAL;
-	ec_remove_handlers(ec);
+
+	/* Don't touch boot EC */
+	if (ec == boot_ec)
+		return 0;
+
+	status = acpi_remove_address_space_handler(ec->handle,
+						   ACPI_ADR_SPACE_EC,
+						   &acpi_ec_space_handler);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	status = acpi_remove_gpe_handler(NULL, ec->gpe, &acpi_ec_gpe_handler);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
 	return 0;
 }
 
-- 
1.5.3.rc6.17.g1911
