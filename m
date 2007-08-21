From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 1/2] ACPI: EC: make boot_ec fully operational
Date: Tue, 21 Aug 2007 17:19:26 +0400
Message-ID: <46CAE65E.3000703@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:45826 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759847AbXHUNTf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Aug 2007 09:19:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Initialize all fields of boot_ec, so it does not require switch to
DSDT found one (fix for #8909).

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |   52
++++++++++++++++++++++++++--------------------------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 56bee9e..33afcd1 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -664,6 +664,16 @@ acpi_ec_register_query_methods(acpi_handle handle,
u32 level,
     return AE_OK;
 }
 
+static void
+ec_complete_parse_device(struct acpi_ec *ec)
+{
+    /* Find and register all query methods */
+    acpi_walk_namespace(ACPI_TYPE_METHOD, ec->handle, 1,
+                acpi_ec_register_query_methods, ec, NULL);
+    /* Use the global lock for all EC transactions? */
+    acpi_evaluate_integer(ec->handle, "_GLK", NULL, &ec->global_lock);
+}
+
 static acpi_status
 ec_parse_device(acpi_handle handle, u32 Level, void *context, void
**retval)
 {
@@ -680,19 +690,10 @@ ec_parse_device(acpi_handle handle, u32 Level,
void *context, void **retval)
     status = acpi_evaluate_integer(handle, "_GPE", NULL, &ec->gpe);
     if (ACPI_FAILURE(status))
         return status;
-
-    /* Find and register all query methods */
-    acpi_walk_namespace(ACPI_TYPE_METHOD, handle, 1,
-                acpi_ec_register_query_methods, ec, NULL);
-
-    /* Use the global lock for all EC transactions? */
-    acpi_evaluate_integer(handle, "_GLK", NULL, &ec->global_lock);
-
     ec->handle = handle;
-
+    ec_complete_parse_device(ec);
     printk(KERN_INFO PREFIX "GPE = 0x%lx, I/O: command/status = 0x%lx,
data = 0x%lx\n",
               ec->gpe, ec->command_addr, ec->data_addr);
-
     return AE_CTRL_TERMINATE;
 }
 
@@ -710,10 +711,15 @@ static int acpi_ec_add(struct acpi_device *device)
 
     if (!device)
         return -EINVAL;
-
     strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
     strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 
+    /* Check if we found the boot EC */
+    if (boot_ec && boot_ec->handle == device->handle) {
+        ec = boot_ec;
+        goto end;
+    }
+
     ec = make_acpi_ec();
     if (!ec)
         return -ENOMEM;
@@ -723,21 +729,11 @@ static int acpi_ec_add(struct acpi_device *device)
         kfree(ec);
         return -EINVAL;
     }
-
-    /* Check if we found the boot EC */
-    if (boot_ec) {
-        if (boot_ec->gpe == ec->gpe) {
-            ec_remove_handlers(boot_ec);
-            mutex_destroy(&boot_ec->lock);
-            kfree(boot_ec);
-            first_ec = boot_ec = NULL;
-        }
-    }
+    ec->handle = device->handle;
+      end:
     if (!first_ec)
         first_ec = ec;
-    ec->handle = device->handle;
     acpi_driver_data(device) = ec;
-
     acpi_ec_add_fs(device);
     return 0;
 }
@@ -824,8 +820,9 @@ static int acpi_ec_start(struct acpi_device *device)
 
     if (!ec)
         return -EINVAL;
-
-    ret = ec_install_handlers(ec);
+    
+    if (ec != boot_ec)
+        ret = ec_install_handlers(ec);
 
     /* EC is fully operational, allow queries */
     atomic_set(&ec->query_pending, 0);
@@ -866,7 +863,10 @@ int __init acpi_ec_ecdt_probe(void)
         boot_ec->command_addr = ecdt_ptr->control.address;
         boot_ec->data_addr = ecdt_ptr->data.address;
         boot_ec->gpe = ecdt_ptr->gpe;
-        boot_ec->handle = ACPI_ROOT_OBJECT;
+        status = acpi_get_handle(NULL, ecdt_ptr->id, &boot_ec->handle);
+        if (ACPI_FAILURE(status))
+            goto error;
+        ec_complete_parse_device(boot_ec);
     } else {
         printk(KERN_DEBUG PREFIX "Look up EC in DSDT\n");
         status = acpi_get_devices(ec_device_ids[0].id, ec_parse_device,

