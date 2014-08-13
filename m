From: Samuel Ortiz <sameo@linux.intel.com>
Subject: [PATCH v4 1/2] USB: Use ACPI device information
Date: Wed, 13 Aug 2014 19:15:31 +0200
Message-ID: <1407950132-15863-1-git-send-email-sameo@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8165 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753810AbaHMRSj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Aug 2014 13:18:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sameo@linux.intel.com, Faouaz TENOUTIT <faouaz.tenoutit@intel.com>

From: Faouaz TENOUTIT <faouaz.tenoutit@intel.com>

Use ACPI device pld information instead of calling
acpi_get_physical_device_location.

Signed-off-by: Faouaz TENOUTIT <faouaz.tenoutit@intel.com>
Acked-by: Samuel Ortiz <samuel.ortiz@intel.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/scan.c         | 13 +++++++++++++
 drivers/usb/core/usb-acpi.c | 14 +++++---------
 include/acpi/acpi_bus.h     |  1 +
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0a817ad..2ca42d5 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -767,6 +767,13 @@ static int acpi_device_setup_files(struct acpi_device *dev)
 						    &dev_attr_real_power_state);
 	}
 
+	/*
+	 * If device has _PLD, initialize the 'pld' struct
+	 */
+	if (acpi_has_method(dev->handle, "_PLD"))
+		acpi_get_physical_device_location(dev->handle,
+						  &dev->pld);
+
 end:
 	return result;
 }
@@ -806,6 +813,12 @@ static void acpi_device_remove_files(struct acpi_device *dev)
 		device_remove_file(&dev->dev, &dev_attr_status);
 	if (dev->handle)
 		device_remove_file(&dev->dev, &dev_attr_path);
+
+	/*
+	 * If device has _PLD, free 'pld' struct
+	 */
+	if (dev->pld)
+		ACPI_FREE(dev->pld);
 }
 /* --------------------------------------------------------------------------
 			ACPI Bus operations
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 2776cfe..940b3e5 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -157,9 +157,6 @@ static struct acpi_device *usb_acpi_find_companion(struct device *dev)
 	} else if (is_usb_port(dev)) {
 		struct usb_port *port_dev = to_usb_port(dev);
 		int port1 = port_dev->portnum;
-		struct acpi_pld_info *pld;
-		acpi_handle *handle;
-		acpi_status status;
 
 		/* Get the struct usb_device point of port's hub */
 		udev = to_usb_device(dev->parent->parent);
@@ -190,15 +187,14 @@ static struct acpi_device *usb_acpi_find_companion(struct device *dev)
 			if (!adev)
 				return NULL;
 		}
-		handle = adev->handle;
-		status = acpi_get_physical_device_location(handle, &pld);
-		if (ACPI_FAILURE(status) || !pld)
+		if (!adev->pld)
 			return adev;
 
 		port_dev->location = USB_ACPI_LOCATION_VALID
-			| pld->group_token << 8 | pld->group_position;
-		port_dev->connect_type = usb_acpi_get_connect_type(handle, pld);
-		ACPI_FREE(pld);
+			| adev->pld->group_token << 8
+			| adev->pld->group_position;
+		port_dev->connect_type = usb_acpi_get_connect_type(adev->handle,
+								   adev->pld);
 
 		return adev;
 	}
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index bcfd808..e439cfa 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -357,6 +357,7 @@ struct acpi_device {
 	struct acpi_scan_handler *handler;
 	struct acpi_hotplug_context *hp;
 	struct acpi_driver *driver;
+	struct acpi_pld_info *pld;
 	void *driver_data;
 	struct device dev;
 	unsigned int physical_node_count;
-- 
2.0.0

