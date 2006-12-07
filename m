From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 13/14] ACPI: use PNPID:instance_no as bus_id of ACPI device
Date: Thu, 07 Dec 2006 20:57:45 +0800
Message-ID: <1165496265.11485.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30189 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032180AbWLGMxk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Dec 2006 07:53:40 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>

From: Zhang Rui <rui.zhang@intel.com>

Previously we used the device name in the DSDT, but would
crash upon encountering a duplicate. Also, exposing the
DSDT device name to the user in a patch isn't a good idea,
because it is arbitrary.

After some discussion, we finally decided to use
"PNPID:instance_no" as the bus_id of ACPI devices.

Two attributes for each device are added at the same time,
the full pathname in ACPI namespace and hardware_id if it has.

NOTE:	acpi_bus_id_list is used to keep the information of PNPID
	and instance number of the given PNPID. Loop the
	acpi_bus_id_list to find the instance_no of the	same PNPID
	when register a device. If failed, i.e. we don't have a
	node with this PNPID, allocate one and link it to this list.

NOTE:	Now I don't take the memory free work in charge.
	If necessary, I can add a reference count in
	struct acpi_device_bus_id, and check the reference and
	when unregister a device, i.e. memory is freed when
	the reference count of a given PNPID is 0.
	
Signed-off-by: Li Shaohua <shaohua.li@intel.com>

---
 drivers/acpi/scan.c |  103 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 94 insertions(+), 9 deletions(-)

Index: linux-2.6.19/drivers/acpi/scan.c
===================================================================
--- linux-2.6.19.orig/drivers/acpi/scan.c	2006-12-01 16:23:50.000000000 +0800
+++ linux-2.6.19/drivers/acpi/scan.c	2006-12-01 16:29:05.000000000 +0800
@@ -21,9 +21,15 @@ extern struct acpi_device *acpi_root;
 #define ACPI_BUS_DEVICE_NAME		"System Bus"
 
 static LIST_HEAD(acpi_device_list);
+static LIST_HEAD(acpi_bus_id_list);
 DEFINE_SPINLOCK(acpi_device_lock);
 LIST_HEAD(acpi_wakeup_device_list);
 
+struct acpi_device_bus_id{
+	char bus_id[9];
+	unsigned int instance_no;
+	struct list_head node;
+};
 static int acpi_eject_operation(acpi_handle handle, int lockable)
 {
 	struct acpi_object_list arg_list;
@@ -103,18 +109,61 @@ acpi_eject_store(struct device *d, struc
 
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
+	int result = 0;
 
 	/*
-	 * If device has _EJ0, 'eject' file is created that is used to trigger
-	 * hot-removal function from userland.
+	 * Devices gotten from FADT don't need "path" attribute
 	 */
+	if(dev->handle) {
+		result = device_create_file(&dev->dev, &dev_attr_path);
+		if(result)
+			goto end;
+	}
+
+	if(dev->flags.hardware_id) {
+		result = device_create_file(&dev->dev, &dev_attr_hid);
+		if(result)
+			goto end;
+	}
+
+        /*
+         * If device has _EJ0, 'eject' file is created that is used to trigger
+         * hot-removal function from userland.
+         */
 	status = acpi_get_handle(dev->handle, "_EJ0", &temp);
 	if (ACPI_SUCCESS(status))
-		device_create_file(&dev->dev, &dev_attr_eject);
+		result = device_create_file(&dev->dev, &dev_attr_eject);
+  end:
+	return result;
 }
 
 static void acpi_device_remove_files(struct acpi_device *dev)
@@ -129,6 +178,11 @@ static void acpi_device_remove_files(str
 	status = acpi_get_handle(dev->handle, "_EJ0", &temp);
 	if (ACPI_SUCCESS(status))
 		device_remove_file(&dev->dev, &dev_attr_eject);
+
+	if(dev->flags.hardware_id)
+		device_remove_file(&dev->dev, &dev_attr_hid);
+	if(dev->handle)
+		device_remove_file(&dev->dev, &dev_attr_path);
 }
 /* --------------------------------------------------------------------------
 			ACPI Bus operations
@@ -260,9 +314,13 @@ static struct bus_type acpi_bus_type = {
 	.uevent		= acpi_device_uevent,
 };
 
-static void acpi_device_register(struct acpi_device *device,
+static int acpi_device_register(struct acpi_device *device,
 				 struct acpi_device *parent)
 {
+	int result;
+	struct list_head *node, *next;
+	struct acpi_device_bus_id *acpi_device_bus_id;
+	int found = 0;
 	/*
 	 * Linkage
 	 * -------
@@ -281,18 +339,45 @@ static void acpi_device_register(struct 
 		list_add_tail(&device->g_list, &acpi_device_list);
 	if (device->wakeup.flags.valid)
 		list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
+	/*
+	 * Find suitable bus_id and instance number in acpi_bus_id_list
+	 * If failed, create one and link it into acpi_bus_id_list
+	 */
+	list_for_each_safe(node, next, &acpi_bus_id_list) {
+		acpi_device_bus_id = container_of(node, struct acpi_device_bus_id, node);
+		if(!strcmp(acpi_device_bus_id->bus_id, device->flags.hardware_id? device->pnp.hardware_id : "PNPIDNON")) {
+			acpi_device_bus_id->instance_no ++;
+			found = 1;
+			break;
+		}
+	}
+	if(!found) {
+		acpi_device_bus_id = kmalloc(sizeof(struct acpi_device_bus_id), GFP_KERNEL);
+		memset(acpi_device_bus_id, sizeof(struct acpi_device_bus_id), 0);
+		strcpy(acpi_device_bus_id->bus_id, device->flags.hardware_id ? device->pnp.hardware_id : "PNPIDNON");
+		acpi_device_bus_id->instance_no = 0;
+		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
+		}
+	sprintf(device->dev.bus_id, "%s:%02x", acpi_device_bus_id->bus_id, acpi_device_bus_id->instance_no);
 	spin_unlock(&acpi_device_lock);
 
 	if (device->parent)
 		device->dev.parent = &parent->dev;
 	device->dev.bus = &acpi_bus_type;
 	device_initialize(&device->dev);
-	sprintf(device->dev.bus_id, "%s", device->pnp.bus_id);
 	device->dev.release = &acpi_device_release;
-	device_add(&device->dev);
+	result = device_add(&device->dev);
+	if(result) {
+		printk("Error adding device %s", device->dev.bus_id);
+		return result;
+	}
+
+	result = acpi_device_setup_files(device);
+	if(result)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error creating sysfs interface for device %s\n", device->dev.bus_id));
 
-	acpi_device_setup_files(device);
 	device->removal_type = ACPI_BUS_REMOVAL_NORMAL;
+	return 0;
 }
 
 static void acpi_device_unregister(struct acpi_device *device, int type)
@@ -1035,7 +1120,7 @@ acpi_add_single_object(struct acpi_devic
 
 	acpi_device_get_debug_info(device, handle, type);
 
-	acpi_device_register(device, parent);
+	result = acpi_device_register(device, parent);
 
       end:
 	if (!result)
