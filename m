From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/140] ACPI: use PNPID:instance_no as bus_id of ACPI device
Date: Wed,  7 Feb 2007 13:50:30 -0500
Message-ID: <11708743962377-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:7926 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422729AbXBGSxT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:19 -0500
In-Reply-To: <11708743943108-git-send-email-lenb@kernel.org>
Message-Id: <e49bd2dd5a503bb94fe2f2af45422b610940b75d.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Li Shaohua <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |  118 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 109 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9efe3e9..769e54b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
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
@@ -103,18 +109,61 @@ acpi_eject_store(struct device *d, struct device_attribute *attr,
 
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
+	 * Devices gotten from FADT don't have a "path" attribute
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
@@ -129,6 +178,11 @@ static void acpi_device_remove_files(struct acpi_device *dev)
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
@@ -260,9 +314,12 @@ static struct bus_type acpi_bus_type = {
 	.uevent		= acpi_device_uevent,
 };
 
-static void acpi_device_register(struct acpi_device *device,
+static int acpi_device_register(struct acpi_device *device,
 				 struct acpi_device *parent)
 {
+	int result;
+	struct acpi_device_bus_id *acpi_device_bus_id, *new_bus_id;
+	int found = 0;
 	/*
 	 * Linkage
 	 * -------
@@ -273,7 +330,33 @@ static void acpi_device_register(struct acpi_device *device,
 	INIT_LIST_HEAD(&device->g_list);
 	INIT_LIST_HEAD(&device->wakeup_list);
 
+	new_bus_id = kzalloc(sizeof(struct acpi_device_bus_id), GFP_KERNEL);
+	if (!new_bus_id) {
+		printk(KERN_ERR PREFIX "Memory allocation error\n");
+		return -ENOMEM;
+	}
+
 	spin_lock(&acpi_device_lock);
+	/*
+	 * Find suitable bus_id and instance number in acpi_bus_id_list
+	 * If failed, create one and link it into acpi_bus_id_list
+	 */
+	list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node) {
+		if(!strcmp(acpi_device_bus_id->bus_id, device->flags.hardware_id? device->pnp.hardware_id : "PNPIDNON")) {
+			acpi_device_bus_id->instance_no ++;
+			found = 1;
+			kfree(new_bus_id);
+			break;
+		}
+	}
+	if(!found) {
+		acpi_device_bus_id = new_bus_id;
+		strcpy(acpi_device_bus_id->bus_id, device->flags.hardware_id ? device->pnp.hardware_id : "PNPIDNON");
+		acpi_device_bus_id->instance_no = 0;
+		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
+	}
+	sprintf(device->dev.bus_id, "%s:%02x", acpi_device_bus_id->bus_id, acpi_device_bus_id->instance_no);
+
 	if (device->parent) {
 		list_add_tail(&device->node, &device->parent->children);
 		list_add_tail(&device->g_list, &device->parent->g_list);
@@ -287,12 +370,29 @@ static void acpi_device_register(struct acpi_device *device,
 		device->dev.parent = &parent->dev;
 	device->dev.bus = &acpi_bus_type;
 	device_initialize(&device->dev);
-	sprintf(device->dev.bus_id, "%s", device->pnp.bus_id);
 	device->dev.release = &acpi_device_release;
-	device_add(&device->dev);
+	result = device_add(&device->dev);
+	if(result) {
+		printk("Error adding device %s", device->dev.bus_id);
+		goto end;
+	}
+
+	result = acpi_device_setup_files(device);
+	if(result)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error creating sysfs interface for device %s\n", device->dev.bus_id));
 
-	acpi_device_setup_files(device);
 	device->removal_type = ACPI_BUS_REMOVAL_NORMAL;
+	return 0;
+  end:
+	spin_lock(&acpi_device_lock);
+	if (device->parent) {
+		list_del(&device->node);
+		list_del(&device->g_list);
+	} else
+		list_del(&device->g_list);
+	list_del(&device->wakeup_list);
+	spin_unlock(&acpi_device_lock);
+	return result;
 }
 
 static void acpi_device_unregister(struct acpi_device *device, int type)
@@ -1035,7 +1135,7 @@ acpi_add_single_object(struct acpi_device **child,
 
 	acpi_device_get_debug_info(device, handle, type);
 
-	acpi_device_register(device, parent);
+	result = acpi_device_register(device, parent);
 
       end:
 	if (!result)
-- 
1.5.0.rc3.39.gec804
