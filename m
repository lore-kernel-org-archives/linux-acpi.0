From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 2/2] Don't delete boot ec
Date: Mon, 24 Mar 2008 23:22:36 +0300
Message-ID: <20080324202236.5055.10573.stgit@thinkpad.local>
References: <20080324202228.5055.11326.stgit@thinkpad.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:58213 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753312AbYCXUWz (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Mon, 24 Mar 2008 16:22:55 -0400
In-Reply-To: <20080324202228.5055.11326.stgit@thinkpad.local>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
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

