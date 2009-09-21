From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v3 15/17] ACPI: add acpi_bus_get_status_handle()
Date: Mon, 21 Sep 2009 13:30:01 -0600
Message-ID: <20090921193001.21322.53671.stgit@bob.kio>
References: <20090921192656.21322.23072.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:40674 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbZIUT36 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2009 15:29:58 -0400
In-Reply-To: <20090921192656.21322.23072.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Add acpi_bus_get_status_handle() so we can get the status of a namespace
object before building a struct acpi_device.

This removes a use of "device->flags.dynamic_status", a cached indicator of
whether _STA exists.  It seems simpler and more reliable to just evaluate
_STA and catch AE_NOT_FOUND errors.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/bus.c      |   49 +++++++++++++++++++++--------------------------
 include/acpi/acpi_bus.h |    2 ++
 2 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 135fbfe..7411915 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -94,36 +94,33 @@ int acpi_bus_get_device(acpi_handle handle, struct acpi_device **device)
 
 EXPORT_SYMBOL(acpi_bus_get_device);
 
-int acpi_bus_get_status(struct acpi_device *device)
+acpi_status acpi_bus_get_status_handle(acpi_handle handle,
+				       unsigned long long *sta)
 {
-	acpi_status status = AE_OK;
-	unsigned long long sta = 0;
-
+	acpi_status status;
 
-	if (!device)
-		return -EINVAL;
+	status = acpi_evaluate_integer(handle, "_STA", NULL, sta);
+	if (ACPI_SUCCESS(status))
+		return AE_OK;
 
-	/*
-	 * Evaluate _STA if present.
-	 */
-	if (device->flags.dynamic_status) {
-		status =
-		    acpi_evaluate_integer(device->handle, "_STA", NULL, &sta);
-		if (ACPI_FAILURE(status))
-			return -ENODEV;
-		STRUCT_TO_INT(device->status) = (int)sta;
+	if (status == AE_NOT_FOUND) {
+		*sta = ACPI_STA_DEVICE_PRESENT | ACPI_STA_DEVICE_ENABLED |
+		       ACPI_STA_DEVICE_UI      | ACPI_STA_DEVICE_FUNCTIONING;
+		return AE_OK;
 	}
+	return status;
+}
 
-	/*
-	 * According to ACPI spec some device can be present and functional
-	 * even if the parent is not present but functional.
-	 * In such conditions the child device should not inherit the status
-	 * from the parent.
-	 */
-	else
-		STRUCT_TO_INT(device->status) =
-		    ACPI_STA_DEVICE_PRESENT | ACPI_STA_DEVICE_ENABLED |
-		    ACPI_STA_DEVICE_UI      | ACPI_STA_DEVICE_FUNCTIONING;
+int acpi_bus_get_status(struct acpi_device *device)
+{
+	acpi_status status;
+	unsigned long long sta;
+
+	status = acpi_bus_get_status_handle(device->handle, &sta);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	STRUCT_TO_INT(device->status) = (int) sta;
 
 	if (device->status.functional && !device->status.present) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] status [%08x]: "
@@ -135,10 +132,8 @@ int acpi_bus_get_status(struct acpi_device *device)
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] status [%08x]\n",
 			  device->pnp.bus_id,
 			  (u32) STRUCT_TO_INT(device->status)));
-
 	return 0;
 }
-
 EXPORT_SYMBOL(acpi_bus_get_status);
 
 void acpi_bus_private_data_handler(acpi_handle handle,
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index ef1cb23..13a63a6 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -322,6 +322,8 @@ extern void unregister_acpi_bus_notifier(struct notifier_block *nb);
 
 int acpi_bus_get_device(acpi_handle handle, struct acpi_device **device);
 void acpi_bus_data_handler(acpi_handle handle, void *context);
+acpi_status acpi_bus_get_status_handle(acpi_handle handle,
+				       unsigned long long *sta);
 int acpi_bus_get_status(struct acpi_device *device);
 int acpi_bus_get_power(acpi_handle handle, int *state);
 int acpi_bus_set_power(acpi_handle handle, int state);

