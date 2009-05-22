From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/4] ACPI: remove unused "status_changed" return value from
	Check Device handling
Date: Fri, 22 May 2009 11:43:46 -0600
Message-ID: <20090522174346.4304.35773.stgit@bob.kio>
References: <20090522174223.4304.7099.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:25395 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757201AbZEVRnp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 May 2009 13:43:45 -0400
In-Reply-To: <20090522174223.4304.7099.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Remove "status_changed" return from acpi_bus_check_device().  Nobody
does anything useful based on its value.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/bus.c |   22 +++-------------------
 1 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index eb98638..19e78fb 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -450,8 +450,7 @@ int acpi_bus_receive_event(struct acpi_bus_event *event)
                              Notification Handling
    -------------------------------------------------------------------------- */
 
-static int
-acpi_bus_check_device(struct acpi_device *device, int *status_changed)
+static int acpi_bus_check_device(struct acpi_device *device)
 {
 	acpi_status status = 0;
 	struct acpi_device_status old_status;
@@ -460,9 +459,6 @@ acpi_bus_check_device(struct acpi_device *device, int *status_changed)
 	if (!device)
 		return -EINVAL;
 
-	if (status_changed)
-		*status_changed = 0;
-
 	old_status = device->status;
 
 	/*
@@ -471,10 +467,6 @@ acpi_bus_check_device(struct acpi_device *device, int *status_changed)
 	 */
 	if (device->parent && !device->parent->status.present) {
 		device->status = device->parent->status;
-		if (STRUCT_TO_INT(old_status) != STRUCT_TO_INT(device->status)) {
-			if (status_changed)
-				*status_changed = 1;
-		}
 		return 0;
 	}
 
@@ -485,9 +477,6 @@ acpi_bus_check_device(struct acpi_device *device, int *status_changed)
 	if (STRUCT_TO_INT(old_status) == STRUCT_TO_INT(device->status))
 		return 0;
 
-	if (status_changed)
-		*status_changed = 1;
-
 	/*
 	 * Device Insertion/Removal
 	 */
@@ -505,20 +494,15 @@ acpi_bus_check_device(struct acpi_device *device, int *status_changed)
 static int acpi_bus_check_scope(struct acpi_device *device)
 {
 	int result = 0;
-	int status_changed = 0;
-
 
 	if (!device)
 		return -EINVAL;
 
 	/* Status Change? */
-	result = acpi_bus_check_device(device, &status_changed);
+	result = acpi_bus_check_device(device);
 	if (result)
 		return result;
 
-	if (!status_changed)
-		return 0;
-
 	/*
 	 * TBD: Enumerate child devices within this device's scope and
 	 *       run acpi_bus_check_device()'s on them.
@@ -571,7 +555,7 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 		break;
 
 	case ACPI_NOTIFY_DEVICE_CHECK:
-		result = acpi_bus_check_device(device, NULL);
+		result = acpi_bus_check_device(device);
 		/*
 		 * TBD: We'll need to outsource certain events to non-ACPI
 		 *      drivers via the device manager (device.c).

