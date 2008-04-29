From: Len Brown <lenb@kernel.org>
Subject: [PATCH 009/171] ACPI: EC: Don't delete boot EC
Date: Tue, 29 Apr 2008 04:44:00 -0400
Message-ID: <ce52ddf58cbc2c40f5f08d37d2217945e4d5adf3.1209457069.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:43301 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760042AbYD2Ios (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:44:48 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   43 +++++++++++++++++++------------------------
 1 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 167af37..3d93621 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -708,9 +708,6 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 	status = acpi_evaluate_integer(handle, "_GPE", NULL, &ec->gpe);
 	if (ACPI_FAILURE(status))
 		return status;
-	/* Find and register all query methods */
-	acpi_walk_namespace(ACPI_TYPE_METHOD, handle, 1,
-			    acpi_ec_register_query_methods, ec, NULL);
 	/* Use the global lock for all EC transactions? */
 	acpi_evaluate_integer(handle, "_GLK", NULL, &ec->global_lock);
 	ec->handle = handle;
@@ -745,31 +742,28 @@ static int acpi_ec_add(struct acpi_device *device)
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 
 	/* Check for boot EC */
-	if (boot_ec) {
-		if (boot_ec->handle == device->handle) {
-			/* Pre-loaded EC from DSDT, just move pointer */
-			ec = boot_ec;
-			boot_ec = NULL;
-			goto end;
-		} else if (boot_ec->handle == ACPI_ROOT_OBJECT) {
-			/* ECDT-based EC, time to shut it down */
-			ec_remove_handlers(boot_ec);
-			kfree(boot_ec);
-			first_ec = boot_ec = NULL;
+	if (boot_ec &&
+	    (boot_ec->handle == device->handle ||
+	     boot_ec->handle == ACPI_ROOT_OBJECT)) {
+		ec = boot_ec;
+		boot_ec = NULL;
+	} else {
+		ec = make_acpi_ec();
+		if (!ec)
+			return -ENOMEM;
+		if (ec_parse_device(device->handle, 0, ec, NULL) !=
+		    AE_CTRL_TERMINATE) {
+			kfree(ec);
+			return -EINVAL;
 		}
 	}
 
-	ec = make_acpi_ec();
-	if (!ec)
-		return -ENOMEM;
-
-	if (ec_parse_device(device->handle, 0, ec, NULL) !=
-	    AE_CTRL_TERMINATE) {
-		kfree(ec);
-		return -EINVAL;
-	}
 	ec->handle = device->handle;
-      end:
+
+	/* Find and register all query methods */
+	acpi_walk_namespace(ACPI_TYPE_METHOD, ec->handle, 1,
+			    acpi_ec_register_query_methods, ec, NULL);
+
 	if (!first_ec)
 		first_ec = ec;
 	acpi_driver_data(device) = ec;
@@ -924,6 +918,7 @@ int __init acpi_ec_ecdt_probe(void)
 		boot_ec->data_addr = ecdt_ptr->data.address;
 		boot_ec->gpe = ecdt_ptr->gpe;
 		boot_ec->handle = ACPI_ROOT_OBJECT;
+		acpi_get_handle(ACPI_ROOT_OBJECT, ecdt_ptr->id, &boot_ec->handle);
 	} else {
 		/* This workaround is needed only on some broken machines,
 		 * which require early EC, but fail to provide ECDT */
-- 
1.5.5.1.99.gf0ec4

