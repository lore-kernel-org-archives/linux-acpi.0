From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 4/4] ACPI: use handle, not device, in system notification path
Date: Fri, 22 May 2009 11:43:56 -0600
Message-ID: <20090522174356.4304.94935.stgit@bob.kio>
References: <20090522174223.4304.7099.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:35822 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757224AbZEVRnz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 May 2009 13:43:55 -0400
In-Reply-To: <20090522174223.4304.7099.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

This patch changes the global system notification path so it uses the
acpi_handle, not the acpi_device.

System notifications often deal with device presence and status change.
In these cases, we may not have an acpi_device.  For example, we may
get a Device Check notification on an object that previously was not
present.  Since the object was not present, we would not have had an
acpi_device for it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
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

