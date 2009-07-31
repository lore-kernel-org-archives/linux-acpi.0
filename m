From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 18/19] ACPI: factor out device type and status checking
Date: Fri, 31 Jul 2009 15:38:05 -0600
Message-ID: <20090731213805.29930.87415.stgit@bob.kio>
References: <20090731213501.29930.39957.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:45820 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068AbZGaViu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2009 17:38:50 -0400
In-Reply-To: <20090731213501.29930.39957.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

This patch adds acpi_bus_type_and_status(), which determines the type
of the object and whether we want to build an acpi_device for it.  If
it is acpi_device-worthy, it returns the type and the device's current
status.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |  129 +++++++++++++++++++++------------------------------
 1 files changed, 52 insertions(+), 77 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 4bbfde6..c078390 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1198,6 +1198,7 @@ static int acpi_bus_remove(struct acpi_device *dev, int rmdevice)
 
 static int acpi_add_single_object(struct acpi_device **child,
 				  acpi_handle handle, int type,
+				  unsigned long long sta,
 				  struct acpi_bus_ops *ops)
 {
 	int result;
@@ -1214,61 +1215,21 @@ static int acpi_add_single_object(struct acpi_device **child,
 	device->handle = handle;
 	device->parent = acpi_bus_get_parent(handle);
 	device->bus_ops = *ops; /* workround for not call .start */
+	STRUCT_TO_INT(device->status) = sta;
 
 	acpi_device_get_busid(device);
 
 	/*
 	 * Flags
 	 * -----
-	 * Get prior to calling acpi_bus_get_status() so we know whether
-	 * or not _STA is present.  Note that we only look for object
-	 * handles -- cannot evaluate objects until we know the device is
-	 * present and properly initialized.
+	 * Note that we only look for object handles -- cannot evaluate objects
+	 * until we know the device is present and properly initialized.
 	 */
 	result = acpi_bus_get_flags(device);
 	if (result)
 		goto end;
 
 	/*
-	 * Status
-	 * ------
-	 * See if the device is present.  We always assume that non-Device
-	 * and non-Processor objects (e.g. thermal zones, power resources,
-	 * etc.) are present, functioning, etc. (at least when parent object
-	 * is present).  Note that _STA has a different meaning for some
-	 * objects (e.g. power resources) so we need to be careful how we use
-	 * it.
-	 */
-	switch (type) {
-	case ACPI_BUS_TYPE_PROCESSOR:
-	case ACPI_BUS_TYPE_DEVICE:
-		result = acpi_bus_get_status(device);
-		if (ACPI_FAILURE(result)) {
-			result = -ENODEV;
-			goto end;
-		}
-		/*
-		 * When the device is neither present nor functional, the
-		 * device should not be added to Linux ACPI device tree.
-		 * When the status of the device is not present but functinal,
-		 * it should be added to Linux ACPI tree. For example : bay
-		 * device , dock device.
-		 * In such conditions it is unncessary to check whether it is
-		 * bay device or dock device.
-		 */
-		if (!device->status.present && !device->status.functional) {
-			result = -ENODEV;
-			goto end;
-		}
-		break;
-	default:
-		STRUCT_TO_INT(device->status) =
-		    ACPI_STA_DEVICE_PRESENT | ACPI_STA_DEVICE_ENABLED |
-		    ACPI_STA_DEVICE_UI      | ACPI_STA_DEVICE_FUNCTIONING;
-		break;
-	}
-
-	/*
 	 * Initialize Device
 	 * -----------------
 	 * TBD: Synch with Core's enumeration/initialization process.
@@ -1347,41 +1308,69 @@ end:
 	return result;
 }
 
-static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl,
-				      void *context, void **return_value)
+#define ACPI_STA_DEFAULT (ACPI_STA_DEVICE_PRESENT | ACPI_STA_DEVICE_ENABLED | \
+			  ACPI_STA_DEVICE_UI      | ACPI_STA_DEVICE_FUNCTIONING)
+
+static int acpi_bus_type_and_status(acpi_handle handle, int *type,
+				    unsigned long long *sta)
 {
-	acpi_status status = AE_OK;
-	struct acpi_device *device = NULL;
-	acpi_object_type type = 0;
-	struct acpi_bus_ops *ops = context;
+	acpi_status status;
+	acpi_object_type acpi_type;
 
-	status = acpi_get_type(handle, &type);
+	status = acpi_get_type(handle, &acpi_type);
 	if (ACPI_FAILURE(status))
-		return AE_OK;
+		return -ENODEV;
 
-	/*
-	 * We're only interested in objects that we consider 'devices'.
-	 */
-	switch (type) {
+	switch (acpi_type) {
 	case ACPI_TYPE_ANY:		/* for ACPI_ROOT_OBJECT */
 	case ACPI_TYPE_DEVICE:
-		type = ACPI_BUS_TYPE_DEVICE;
+		*type = ACPI_BUS_TYPE_DEVICE;
+		status = acpi_bus_get_status_handle(handle, sta);
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
 		break;
 	case ACPI_TYPE_PROCESSOR:
-		type = ACPI_BUS_TYPE_PROCESSOR;
+		*type = ACPI_BUS_TYPE_PROCESSOR;
+		status = acpi_bus_get_status_handle(handle, sta);
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
 		break;
 	case ACPI_TYPE_THERMAL:
-		type = ACPI_BUS_TYPE_THERMAL;
+		*type = ACPI_BUS_TYPE_THERMAL;
+		*sta = ACPI_STA_DEFAULT;
 		break;
 	case ACPI_TYPE_POWER:
-		type = ACPI_BUS_TYPE_POWER;
+		*type = ACPI_BUS_TYPE_POWER;
+		*sta = ACPI_STA_DEFAULT;
 		break;
 	default:
-		return AE_OK;
+		return -ENODEV;
 	}
 
+	return 0;
+}
+
+static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl,
+				      void *context, void **return_value)
+{
+	struct acpi_bus_ops *ops = context;
+	struct acpi_device *device = NULL;
+	acpi_status status;
+	int type;
+	unsigned long long sta;
+	int result;
+
+	result = acpi_bus_type_and_status(handle, &type, &sta);
+	if (result)
+		return AE_OK;
+
+	if (!(sta & ACPI_STA_DEVICE_PRESENT) &&
+	    !(sta & ACPI_STA_DEVICE_FUNCTIONING))
+		return AE_CTRL_DEPTH;
+
 	if (ops->acpi_op_add)
-		status = acpi_add_single_object(&device, handle, type, ops);
+		status = acpi_add_single_object(&device, handle, type, sta,
+						ops);
 	else
 		status = acpi_bus_get_device(handle, &device);
 
@@ -1394,22 +1383,6 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl,
 			return AE_CTRL_DEPTH;
 	}
 
-	/*
-	 * If the device is present, enabled, and functioning then
-	 * parse its scope (depth-first).  Note that we need to
-	 * represent absent devices to facilitate PnP notifications
-	 * -- but only the subtree head (not all of its children,
-	 * which will be enumerated when the parent is inserted).
-	 *
-	 * TBD: Need notifications and other detection mechanisms
-	 *      in place before we can fully implement this.
-	 *
-	 * When the device is not present but functional, it is also
-	 * necessary to scan the children of this device.
-	 */
-	if (!device->status.present && !device->status.functional)
-		return AE_CTRL_DEPTH;
-
 	if (!*return_value)
 		*return_value = device;
 	return AE_OK;
@@ -1533,12 +1506,14 @@ static int acpi_bus_scan_fixed(void)
 	if ((acpi_gbl_FADT.flags & ACPI_FADT_POWER_BUTTON) == 0) {
 		result = acpi_add_single_object(&device, NULL,
 						ACPI_BUS_TYPE_POWER_BUTTON,
+						ACPI_STA_DEFAULT,
 						&ops);
 	}
 
 	if ((acpi_gbl_FADT.flags & ACPI_FADT_SLEEP_BUTTON) == 0) {
 		result = acpi_add_single_object(&device, NULL,
 						ACPI_BUS_TYPE_SLEEP_BUTTON,
+						ACPI_STA_DEFAULT,
 						&ops);
 	}
 

