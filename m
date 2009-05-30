From: Len Brown <lenb@kernel.org>
Subject: [PATCH 54/65] ACPI: use handle, not device, in system notification path
Date: Fri, 29 May 2009 21:42:32 -0400
Message-ID: <0d74789c76c14d3364c5e9c7abe41be4da29e0f1.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:60103 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757248AbZE3BnE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:04 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF003QZORQE2K0@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:03 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch changes the global system notification path so it uses the
acpi_handle, not the acpi_device.

System notifications often deal with device presence and status change.
In these cases, we may not have an acpi_device.  For example, we may
get a Device Check notification on an object that previously was not
present.  Since the object was not present, we would not have had an
acpi_device for it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 2b08c3d..2876fc7 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -450,11 +450,14 @@ int acpi_bus_receive_event(struct acpi_bus_event *event)
                              Notification Handling
    -------------------------------------------------------------------------- */
 
-static void acpi_bus_check_device(struct acpi_device *device)
+static void acpi_bus_check_device(acpi_handle handle)
 {
+	struct acpi_device *device;
 	acpi_status status;
 	struct acpi_device_status old_status;
 
+	if (acpi_bus_get_device(handle, &device))
+		return;
 	if (!device)
 		return;
 
@@ -488,13 +491,10 @@ static void acpi_bus_check_device(struct acpi_device *device)
 	}
 }
 
-static void acpi_bus_check_scope(struct acpi_device *device)
+static void acpi_bus_check_scope(acpi_handle handle)
 {
-	if (!device)
-		return;
-
 	/* Status Change? */
-	acpi_bus_check_device(device);
+	acpi_bus_check_device(handle);
 
 	/*
 	 * TBD: Enumerate child devices within this device's scope and
@@ -531,13 +531,10 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 	blocking_notifier_call_chain(&acpi_bus_notify_list,
 		type, (void *)handle);
 
-	if (acpi_bus_get_device(handle, &device))
-		return;
-
 	switch (type) {
 
 	case ACPI_NOTIFY_BUS_CHECK:
-		acpi_bus_check_scope(device);
+		acpi_bus_check_scope(handle);
 		/*
 		 * TBD: We'll need to outsource certain events to non-ACPI
 		 *      drivers via the device manager (device.c).
@@ -545,7 +542,7 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 		break;
 
 	case ACPI_NOTIFY_DEVICE_CHECK:
-		acpi_bus_check_device(device);
+		acpi_bus_check_device(handle);
 		/*
 		 * TBD: We'll need to outsource certain events to non-ACPI
 		 *      drivers via the device manager (device.c).
@@ -583,10 +580,13 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 		break;
 	}
 
-	driver = device->driver;
-	if (driver && driver->ops.notify &&
-	    (driver->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS))
-		driver->ops.notify(device, type);
+	acpi_bus_get_device(handle, &device);
+	if (device) {
+		driver = device->driver;
+		if (driver && driver->ops.notify &&
+		    (driver->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS))
+			driver->ops.notify(device, type);
+	}
 }
 
 /* --------------------------------------------------------------------------
-- 
1.6.0.6

