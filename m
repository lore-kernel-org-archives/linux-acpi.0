From: Len Brown <lenb@kernel.org>
Subject: [PATCH 53/65] ACPI: remove unused return values from Bus Check &
 Device Check handling
Date: Fri, 29 May 2009 21:42:31 -0400
Message-ID: <6ab63e597c52625c379d6dffa6226752c8d8b768.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:40281 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756840AbZE3BnC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:02 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00CIJORQ4V63@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:03 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Remove return values from acpi_bus_check_device() and acpi_bus_check_scope()
since nobody looks at them.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
-- 
1.6.0.6

