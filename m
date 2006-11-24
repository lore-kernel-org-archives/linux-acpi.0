From: Len Brown <len.brown@intel.com>
Subject: [PATCH 13/13] ACPI: use unique number as bus_id of ACPI device in sysfs
Date: Fri, 24 Nov 2006 00:17:41 -0500
Message-ID: <11643454762691-git-send-email-len.brown@intel.com>
References: <11643454612902-git-send-email-len.brown@intel.com> <1164345463205-git-send-email-len.brown@intel.com> <11643454641312-git-send-email-len.brown@intel.com> <11643454642611-git-send-email-len.brown@intel.com> <11643454652241-git-send-email-len.brown@intel.com> <11643454662740-git-send-email-len.brown@intel.com> <1164345468324-git-send-email-len.brown@intel.com> <11643454703489-git-send-email-len.brown@intel.com> <11643454711040-git-send-email-len.brown@intel.com> <11643454722679-git-send-email-len.brown@intel.com> <11643454732506-git-send-email-len.brown@intel.com> <11643454741258-git-send-email-len.brown@intel.com> <11643454754138-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:40864 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934295AbWKXFOE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 00:14:04 -0500
In-Reply-To: <11643454754138-git-send-email-len.brown@intel.com>
Message-Id: <d1f75c71119c62e4a399c5108250248213adfda6.1164343921.git.len.brown@intel.com>
In-Reply-To: <bd119392c453771fdb994728a2568c2e3f17705d.1164343921.git.len.brown@intel.com>
References: <bd119392c453771fdb994728a2568c2e3f17705d.1164343921.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Li Shaohua <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Previously we used the device name in the DSDT, but would
crash upon encountering a duplicate.  Also, exposing
the DSDT device name to the user in a path isn't a
good idea, becauase it is arbitrary.
So just add two attributes for each device,
the full pathname in ACPI namespace and hardware_id.

Signed-off-by: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |   70 +++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 4a1484c..5e8b8b0 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -24,6 +24,8 @@ static LIST_HEAD(acpi_device_list);
 DEFINE_SPINLOCK(acpi_device_lock);
 LIST_HEAD(acpi_wakeup_device_list);
 
+static unsigned int device_id = 0;
+
 static int acpi_eject_operation(acpi_handle handle, int lockable)
 {
 	struct acpi_object_list arg_list;
@@ -103,18 +105,55 @@ acpi_eject_store(struct device *d, struc
 
 static DEVICE_ATTR(eject, 0200, NULL, acpi_eject_store);
 
-static void acpi_device_setup_files(struct acpi_device *dev)
+static ssize_t
+acpi_device_hid_show(struct device *dev, struct device_attribute *attr, char *buf) {
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+
+	return sprintf(buf, "%s\n", acpi_dev->pnp.hardware_id);
+}
+static DEVICE_ATTR(hid, 0444, acpi_device_hid_show, NULL);
+
+static ssize_t
+acpi_device_path_show(struct device *dev, struct device_attribute *attr, char *buf) {
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct acpi_buffer path = {ACPI_ALLOCATE_BUFFER, NULL};
+	int result;
+
+	result = acpi_get_name(acpi_dev->handle, ACPI_FULL_PATHNAME, &path);
+	if(result)
+		goto end;
+
+	result = sprintf(buf, "%s\n", (char*)path.pointer);
+	kfree(path.pointer);
+  end:
+	return result;
+}
+static DEVICE_ATTR(path, 0444, acpi_device_path_show, NULL);
+
+static int acpi_device_setup_files(struct acpi_device *dev)
 {
 	acpi_status status;
 	acpi_handle temp;
-
+	int result;
 	/*
 	 * If device has _EJ0, 'eject' file is created that is used to trigger
 	 * hot-removal function from userland.
 	 */
+	result = device_create_file(&dev->dev, &dev_attr_path);
+	if(result)
+		goto end;
+
+	if(dev->flags.hardware_id) {
+		result = device_create_file(&dev->dev, &dev_attr_hid);
+		if(result)
+			goto end;
+	}
+
 	status = acpi_get_handle(dev->handle, "_EJ0", &temp);
 	if (ACPI_SUCCESS(status))
-		device_create_file(&dev->dev, &dev_attr_eject);
+		result = device_create_file(&dev->dev, &dev_attr_eject);
+  end:
+	return result;
 }
 
 static void acpi_device_remove_files(struct acpi_device *dev)
@@ -129,6 +168,11 @@ static void acpi_device_remove_files(str
 	status = acpi_get_handle(dev->handle, "_EJ0", &temp);
 	if (ACPI_SUCCESS(status))
 		device_remove_file(&dev->dev, &dev_attr_eject);
+
+	if(dev->flags.hardware_id)
+		device_remove_file(&dev->dev, &dev_attr_hid);
+
+	device_remove_file(&dev->dev, &dev_attr_path);
 }
 /* --------------------------------------------------------------------------
 			ACPI Bus operations
@@ -260,9 +304,10 @@ static struct bus_type acpi_bus_type = {
 	.uevent		= acpi_device_uevent,
 };
 
-static void acpi_device_register(struct acpi_device *device,
+static int acpi_device_register(struct acpi_device *device,
 				 struct acpi_device *parent)
 {
+	int result;
 	/*
 	 * Linkage
 	 * -------
@@ -287,12 +332,21 @@ static void acpi_device_register(struct
 		device->dev.parent = &parent->dev;
 	device->dev.bus = &acpi_bus_type;
 	device_initialize(&device->dev);
-	sprintf(device->dev.bus_id, "%s", device->pnp.bus_id);
+	sprintf(device->dev.bus_id, "%d", device_id);
 	device->dev.release = &acpi_device_release;
-	device_add(&device->dev);
+	result = device_add(&device->dev);
+	if(result) {
+		printk("Error adding device %s", device->pnp.bus_id);
+		return result;
+	}
+
+	result = acpi_device_setup_files(device);
+	if(result)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error creating sysfs interface for device %s\n", device->pnp.bus_id));
 
-	acpi_device_setup_files(device);
 	device->removal_type = ACPI_BUS_REMOVAL_NORMAL;
+	device_id++;
+	return 0;
 }
 
 static void acpi_device_unregister(struct acpi_device *device, int type)
@@ -1041,7 +1095,7 @@ acpi_add_single_object(struct acpi_devic
 
 	acpi_device_get_debug_info(device, handle, type);
 
-	acpi_device_register(device, parent);
+	result = acpi_device_register(device, parent);
 
       end:
 	if (!result)
-- 
1.4.4.g59427
