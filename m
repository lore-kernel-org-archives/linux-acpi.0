From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH RESEND v2] ACPI: Fix resource_lock dead lock in acpi_power_on_device
Date: Mon, 27 Aug 2012 17:10:16 +0800
Message-ID: <1346058616-3453-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21144 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240Ab2H0JKt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Aug 2012 05:10:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Aaron Lu <aaron.lu@intel.com>, Lin Ming <ming.m.lin@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Commit 0090def("ACPI: Add interface to register/unregister device
to/from power resources") used resource_lock to protect the devices list
that relies on power resource. It caused a mutex dead lock, as below

acpi_power_on ---> lock resource_lock
  __acpi_power_on
    acpi_power_on_device
      acpi_power_get_inferred_state
        acpi_power_get_list_state ---> lock resource_lock

This patch adds a new mutex "devices_lock" to protect the devices list
and calls acpi_power_on_device in acpi_power_on, instead of
__acpi_power_on, after the resource_lock is released.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
v2:
Fixed a stupid bug when rebasing, device_list should be got only after
resource is initialized.

Originally sent by Lin Ming:
http://marc.info/?l=linux-acpi&m=134060115701726&w=2

 drivers/acpi/power.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index fc18034..d0702d6 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -107,6 +107,7 @@ struct acpi_power_resource {
 
 	/* List of devices relying on this power resource */
 	struct acpi_power_resource_device *devices;
+	struct mutex devices_lock;
 };
 
 static struct list_head acpi_power_resource_list;
@@ -225,7 +226,6 @@ static void acpi_power_on_device(struct acpi_power_managed_device *device)
 
 static int __acpi_power_on(struct acpi_power_resource *resource)
 {
-	struct acpi_power_resource_device *device_list = resource->devices;
 	acpi_status status = AE_OK;
 
 	status = acpi_evaluate_object(resource->device->handle, "_ON", NULL, NULL);
@@ -238,12 +238,6 @@ static int __acpi_power_on(struct acpi_power_resource *resource)
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Power resource [%s] turned on\n",
 			  resource->name));
 
-	while (device_list) {
-		acpi_power_on_device(device_list->device);
-
-		device_list = device_list->next;
-	}
-
 	return 0;
 }
 
@@ -251,6 +245,7 @@ static int acpi_power_on(acpi_handle handle)
 {
 	int result = 0;
 	struct acpi_power_resource *resource = NULL;
+	struct acpi_power_resource_device *device_list;
 
 	result = acpi_power_get_context(handle, &resource);
 	if (result)
@@ -270,6 +265,17 @@ static int acpi_power_on(acpi_handle handle)
 
 	mutex_unlock(&resource->resource_lock);
 
+	mutex_lock(&resource->devices_lock);
+
+	device_list = resource->devices;
+	while (device_list) {
+		acpi_power_on_device(device_list->device);
+
+		device_list = device_list->next;
+	}
+
+	mutex_unlock(&resource->devices_lock);
+
 	return result;
 }
 
@@ -355,7 +361,7 @@ static void __acpi_power_resource_unregister_device(struct device *dev,
 	if (acpi_power_get_context(res_handle, &resource))
 		return;
 
-	mutex_lock(&resource->resource_lock);
+	mutex_lock(&resource->devices_lock);
 	prev = NULL;
 	curr = resource->devices;
 	while (curr) {
@@ -372,7 +378,7 @@ static void __acpi_power_resource_unregister_device(struct device *dev,
 		prev = curr;
 		curr = curr->next;
 	}
-	mutex_unlock(&resource->resource_lock);
+	mutex_unlock(&resource->devices_lock);
 }
 
 /* Unlink dev from all power resources in _PR0 */
@@ -414,10 +420,10 @@ static int __acpi_power_resource_register_device(
 
 	power_resource_device->device = powered_device;
 
-	mutex_lock(&resource->resource_lock);
+	mutex_lock(&resource->devices_lock);
 	power_resource_device->next = resource->devices;
 	resource->devices = power_resource_device;
-	mutex_unlock(&resource->resource_lock);
+	mutex_unlock(&resource->devices_lock);
 
 	return 0;
 }
@@ -721,6 +727,7 @@ static int acpi_power_add(struct acpi_device *device)
 
 	resource->device = device;
 	mutex_init(&resource->resource_lock);
+	mutex_init(&resource->devices_lock);
 	strcpy(resource->name, device->pnp.bus_id);
 	strcpy(acpi_device_name(device), ACPI_POWER_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_POWER_CLASS);
-- 
1.7.12.21.g871e293

