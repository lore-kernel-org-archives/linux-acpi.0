From: Len Brown <lenb@kernel.org>
Subject: [PATCH 52/65] ACPI: remove unused "status_changed" return value from
 Check Device handling
Date: Fri, 29 May 2009 21:42:30 -0400
Message-ID: <48df8bbf5a80197c6fe3824e9f612d3aaa20d1ae.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:50006 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757509AbZE3BnQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:16 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF003YWORQ28T2@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:02 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Remove "status_changed" return from acpi_bus_check_device().  Nobody
does anything useful based on its value.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
-- 
1.6.0.6

