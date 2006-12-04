From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 2/3] acpi: Add a docked sysfs file to the dock driver.
Date: Mon, 4 Dec 2006 14:49:58 -0800
Message-ID: <20061204144958.207e58e2.kristen.c.accardi@intel.com>
References: <20061204224037.713257809@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:13382 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967734AbWLDWzA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Dec 2006 17:55:00 -0500
In-Reply-To: <20061204224037.713257809@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Brandon Philips <brandon@ifup.org>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

From: brandon@ifup.org

Add 2 sysfs files for user interface.
1) docked - 1/0 (read only) - indicates whether the software believes the 
laptop is docked in a docking station.
2) undock - (write only) - writing to this file causes the software to
initiate an undock request to the firmware. 

Signed-off-by: Brandon Philips <brandon@ifup.org>
Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/acpi/dock.c |   95 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 79 insertions(+), 16 deletions(-)

--- kristen-2.6.orig/drivers/acpi/dock.c
+++ kristen-2.6/drivers/acpi/dock.c
@@ -514,6 +514,37 @@ void unregister_hotplug_dock_device(acpi
 EXPORT_SYMBOL_GPL(unregister_hotplug_dock_device);
 
 /**
+ * handle_eject_request - handle an undock request checking for error conditions
+ *
+ * Check to make sure the dock device is still present, then undock and
+ * hotremove all the devices that may need removing.
+ */
+static int handle_eject_request(struct dock_station *ds, u32 event)
+{
+	if (!dock_present(ds))
+		return -ENODEV;
+
+	if (dock_in_progress(ds))
+		return -EBUSY;
+
+	/*
+	 * here we need to generate the undock
+	 * event prior to actually doing the undock
+	 * so that the device struct still exists.
+	 */
+	dock_event(ds, event, UNDOCK_EVENT);
+	hotplug_dock_devices(ds, ACPI_NOTIFY_EJECT_REQUEST);
+	undock(ds);
+	eject_dock(ds);
+	if (dock_present(ds)) {
+		printk(KERN_ERR PREFIX "Unable to undock!\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+/**
  * dock_notify - act upon an acpi dock notification
  * @handle: the dock station handle
  * @event: the acpi event
@@ -521,9 +552,7 @@ EXPORT_SYMBOL_GPL(unregister_hotplug_doc
  *
  * If we are notified to dock, then check to see if the dock is
  * present and then dock.  Notify all drivers of the dock event,
- * and then hotplug and devices that may need hotplugging.  For undock
- * check to make sure the dock device is still present, then undock
- * and hotremove all the devices that may need removing.
+ * and then hotplug and devices that may need hotplugging.
  */
 static void dock_notify(acpi_handle handle, u32 event, void *data)
 {
@@ -555,19 +584,7 @@ static void dock_notify(acpi_handle hand
 	 * to the driver who wish to hotplug.
          */
 	case ACPI_NOTIFY_EJECT_REQUEST:
-		if (!dock_in_progress(ds) && dock_present(ds)) {
-			/*
-			 * here we need to generate the undock
-			 * event prior to actually doing the undock
-			 * so that the device struct still exists.
-			 */
-			dock_event(ds, event, UNDOCK_EVENT);
-			hotplug_dock_devices(ds, ACPI_NOTIFY_EJECT_REQUEST);
-			undock(ds);
-			eject_dock(ds);
-			if (dock_present(ds))
-				printk(KERN_ERR PREFIX "Unable to undock!\n");
-		}
+		handle_eject_request(ds, event);
 		break;
 	default:
 		printk(KERN_ERR PREFIX "Unknown dock event %d\n", event);
@@ -606,6 +623,33 @@ find_dock_devices(acpi_handle handle, u3
 	return AE_OK;
 }
 
+/*
+ * show_docked - read method for "docked" file in sysfs
+ */
+static ssize_t show_docked(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", dock_present(dock_station));
+
+}
+DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
+
+/*
+ * write_undock - write method for "undock" file in sysfs
+ */
+static ssize_t write_undock(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	int ret;
+
+	if (!count)
+		return -EINVAL;
+
+	ret = handle_eject_request(dock_station, ACPI_NOTIFY_EJECT_REQUEST);
+	return ret ? ret: count;
+}
+DEVICE_ATTR(undock, S_IWUSR, NULL, write_undock);
+
 /**
  * dock_add - add a new dock station
  * @handle: the dock station handle
@@ -639,6 +683,21 @@ static int dock_add(acpi_handle handle)
 		kfree(dock_station);
 		return ret;
 	}
+	ret = device_create_file(&dock_device.dev, &dev_attr_docked);
+	if (ret) {
+		printk("Error %d adding sysfs file\n", ret);
+		platform_device_unregister(&dock_device);
+		kfree(dock_station);
+		return ret;
+	}
+	ret = device_create_file(&dock_device.dev, &dev_attr_undock);
+	if (ret) {
+		printk("Error %d adding sysfs file\n", ret);
+		device_remove_file(&dock_device.dev, &dev_attr_docked);
+		platform_device_unregister(&dock_device);
+		kfree(dock_station);
+		return ret;
+	}
 
 	/* Find dependent devices */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
@@ -672,6 +731,8 @@ static int dock_add(acpi_handle handle)
 dock_add_err:
 	kfree(dd);
 dock_add_err_unregister:
+	device_remove_file(&dock_device.dev, &dev_attr_docked);
+	device_remove_file(&dock_device.dev, &dev_attr_undock);
 	platform_device_unregister(&dock_device);
 	kfree(dock_station);
 	return ret;
@@ -701,6 +762,8 @@ static int dock_remove(void)
 		printk(KERN_ERR "Error removing notify handler\n");
 
 	/* cleanup sysfs */
+	device_remove_file(&dock_device.dev, &dev_attr_docked);
+	device_remove_file(&dock_device.dev, &dev_attr_undock);
 	platform_device_unregister(&dock_device);
 
 	/* free dock station memory */

--
