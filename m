From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 3/4] ACPI: remove unused return values from Bus Check & Device
	Check handling
Date: Fri, 22 May 2009 11:43:51 -0600
Message-ID: <20090522174351.4304.51599.stgit@bob.kio>
References: <20090522174223.4304.7099.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:25829 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757089AbZEVRnu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 May 2009 13:43:50 -0400
In-Reply-To: <20090522174223.4304.7099.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Remove return values from acpi_bus_check_device() and acpi_bus_check_scope()
since nobody looks at them.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/bus.c |   32 +++++++++++---------------------
 1 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 19e78fb..2b08c3d 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -450,14 +450,13 @@ int acpi_bus_receive_event(struct acpi_bus_event *event)
                              Notification Handling
    -------------------------------------------------------------------------- */
 
-static int acpi_bus_check_device(struct acpi_device *device)
+static void acpi_bus_check_device(struct acpi_device *device)
 {
-	acpi_status status = 0;
+	acpi_status status;
 	struct acpi_device_status old_status;
 
-
 	if (!device)
-		return -EINVAL;
+		return;
 
 	old_status = device->status;
 
@@ -467,15 +466,15 @@ static int acpi_bus_check_device(struct acpi_device *device)
 	 */
 	if (device->parent && !device->parent->status.present) {
 		device->status = device->parent->status;
-		return 0;
+		return;
 	}
 
 	status = acpi_bus_get_status(device);
 	if (ACPI_FAILURE(status))
-		return -ENODEV;
+		return;
 
 	if (STRUCT_TO_INT(old_status) == STRUCT_TO_INT(device->status))
-		return 0;
+		return;
 
 	/*
 	 * Device Insertion/Removal
@@ -487,28 +486,20 @@ static int acpi_bus_check_device(struct acpi_device *device)
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device removal detected\n"));
 		/* TBD: Handle device removal */
 	}
-
-	return 0;
 }
 
-static int acpi_bus_check_scope(struct acpi_device *device)
+static void acpi_bus_check_scope(struct acpi_device *device)
 {
-	int result = 0;
-
 	if (!device)
-		return -EINVAL;
+		return;
 
 	/* Status Change? */
-	result = acpi_bus_check_device(device);
-	if (result)
-		return result;
+	acpi_bus_check_device(device);
 
 	/*
 	 * TBD: Enumerate child devices within this device's scope and
 	 *       run acpi_bus_check_device()'s on them.
 	 */
-
-	return 0;
 }
 
 static BLOCKING_NOTIFIER_HEAD(acpi_bus_notify_list);
@@ -531,7 +522,6 @@ EXPORT_SYMBOL_GPL(unregister_acpi_bus_notifier);
  */
 static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 {
-	int result = 0;
 	struct acpi_device *device = NULL;
 	struct acpi_driver *driver;
 
@@ -547,7 +537,7 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 	switch (type) {
 
 	case ACPI_NOTIFY_BUS_CHECK:
-		result = acpi_bus_check_scope(device);
+		acpi_bus_check_scope(device);
 		/*
 		 * TBD: We'll need to outsource certain events to non-ACPI
 		 *      drivers via the device manager (device.c).
@@ -555,7 +545,7 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 		break;
 
 	case ACPI_NOTIFY_DEVICE_CHECK:
-		result = acpi_bus_check_device(device);
+		acpi_bus_check_device(device);
 		/*
 		 * TBD: We'll need to outsource certain events to non-ACPI
 		 *      drivers via the device manager (device.c).

