From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [RFC PATCH] ACPI: Add support for binding multi struct devices to one acpi device
Date: Thu,  5 Apr 2012 15:20:23 +0800
Message-ID: <1333610423-4708-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31158 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753052Ab2DEHYF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Apr 2012 03:24:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, mjg@redhat.com

The original glue framework can only bind one struct device to one acpi
device node. This can not work with the situation of two or more struct
devices associated with one acpi device node. The usb3.0 will cause such
the situation.

Following is the acpi device nodes' description under xhci hcd.
Device (XHC)
            Device (RHUB)
                Device (HSP1)
                Device (HSP2)
                Device (HSP3)
                Device (HSP4)
                Device (SSP1)
                Device (SSP2)
                Device (SSP3)
                Device (SSP4)

The usb3.0 hub has two logical hubs. Each works for usb2.0 and usb3.0
devices. In the usb subsystem, those two logical hubs are treated as two
seperate devices that have two struct devices. But in the ACPI DSDT, those
two logical hubs share one acpi device node. "Device (HSPx)" means usb
high speed ports working for usb2.0 devices and "Device (SSPx)" means usb
super speed ports working for usb3.0 devices.

This patch is to resolve such prolbem. Add list in struct the acpi_device to
record all the struct devices associated with the acpi device node. Creat
firmware_node link when the first device is found. Create physical_nodex
according the sequence.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/glue.c        |  107 ++++++++++++++++++++++++-------------------
 drivers/acpi/proc.c        |   43 ++++++++++--------
 drivers/acpi/scan.c        |    1 +
 drivers/pnp/pnpacpi/core.c |    2 +-
 include/acpi/acpi_bus.h    |   12 ++++-
 5 files changed, 96 insertions(+), 69 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 29a4a5c..976db6a 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -122,84 +122,97 @@ acpi_handle acpi_get_child(acpi_handle parent, u64 address)
 
 EXPORT_SYMBOL(acpi_get_child);
 
-/* Link ACPI devices with physical devices */
-static void acpi_glue_data_handler(acpi_handle handle,
-				   void *context)
-{
-	/* we provide an empty handler */
-}
-
-/* Note: a success call will increase reference count by one */
-struct device *acpi_get_physical_device(acpi_handle handle)
-{
-	acpi_status status;
-	struct device *dev;
-
-	status = acpi_get_data(handle, acpi_glue_data_handler, (void **)&dev);
-	if (ACPI_SUCCESS(status))
-		return get_device(dev);
-	return NULL;
-}
-
-EXPORT_SYMBOL(acpi_get_physical_device);
-
 static int acpi_bind_one(struct device *dev, acpi_handle handle)
 {
 	struct acpi_device *acpi_dev;
 	acpi_status status;
+	struct acpi_device_physical_node *physical_node;
+	char physical_node_name[20];
 
 	if (dev->archdata.acpi_handle) {
 		dev_warn(dev, "Drivers changed 'acpi_handle'\n");
 		return -EINVAL;
 	}
+
 	get_device(dev);
-	status = acpi_attach_data(handle, acpi_glue_data_handler, dev);
-	if (ACPI_FAILURE(status)) {
-		put_device(dev);
-		return -EINVAL;
+	status = acpi_bus_get_device(handle, &acpi_dev);
+	if (ACPI_FAILURE(status))
+		goto err;
+
+	physical_node = kzalloc(sizeof(struct acpi_device_physical_node),
+		GFP_KERNEL);
+	if (!physical_node) {
+		DBG("Memory allocation err!\n");
+		goto err;
 	}
-	dev->archdata.acpi_handle = handle;
 
-	status = acpi_bus_get_device(handle, &acpi_dev);
-	if (!ACPI_FAILURE(status)) {
-		int ret;
+	physical_node->node_id =
+		find_first_zero_bit(acpi_dev->id_bitmap,
+		ACPI_MAX_PHYSICAL_NODE);
+	set_bit(physical_node->node_id, acpi_dev->id_bitmap);
+	physical_node->dev = dev;
+	list_add_tail(&physical_node->node, &acpi_dev->physical_node_list);
+	acpi_dev->physical_node_count++;
+	dev->archdata.acpi_handle = handle;
 
-		ret = sysfs_create_link(&dev->kobj, &acpi_dev->dev.kobj,
+	if (acpi_dev->physical_node_count == 1)
+		sysfs_create_link(&dev->kobj, &acpi_dev->dev.kobj,
 				"firmware_node");
-		ret = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
-				"physical_node");
-		if (acpi_dev->wakeup.flags.valid)
-			device_set_wakeup_capable(dev, true);
-	}
+
+	sprintf(physical_node_name, "physical_node%d", physical_node->node_id);
+	sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
+			physical_node_name);
+
+	if (acpi_dev->wakeup.flags.valid)
+		device_set_wakeup_capable(dev, true);
 
 	return 0;
+
+ err:
+	put_device(dev);
+	return -EINVAL;
 }
 
 static int acpi_unbind_one(struct device *dev)
 {
+	struct acpi_device_physical_node *entry;
+	struct acpi_device *acpi_dev;
+	acpi_status status;
+
 	if (!dev->archdata.acpi_handle)
 		return 0;
-	if (dev == acpi_get_physical_device(dev->archdata.acpi_handle)) {
-		struct acpi_device *acpi_dev;
 
-		/* acpi_get_physical_device increase refcnt by one */
-		put_device(dev);
+	status = acpi_bus_get_device(dev->archdata.acpi_handle,
+		&acpi_dev);
+	if (ACPI_FAILURE(status))
+		goto err;
+
+	list_for_each_entry(entry, &acpi_dev->physical_node_list, node) {
+		char physical_node_name[20];
+
+		if (entry->dev != dev)
+			continue;
+
+		list_del(&entry->node);
+		clear_bit(entry->node_id, acpi_dev->id_bitmap);
 
-		if (!acpi_bus_get_device(dev->archdata.acpi_handle,
-					&acpi_dev)) {
+		acpi_dev->physical_node_count--;
+		if (!acpi_dev->physical_node_count)
 			sysfs_remove_link(&dev->kobj, "firmware_node");
-			sysfs_remove_link(&acpi_dev->dev.kobj, "physical_node");
-		}
 
-		acpi_detach_data(dev->archdata.acpi_handle,
-				 acpi_glue_data_handler);
+		sprintf(physical_node_name, "physical_node%d", entry->node_id);
+		sysfs_remove_link(&acpi_dev->dev.kobj, physical_node_name);
 		dev->archdata.acpi_handle = NULL;
 		/* acpi_bind_one increase refcnt by one */
 		put_device(dev);
-	} else {
-		dev_err(dev, "Oops, 'acpi_handle' corrupt\n");
+		kfree(entry);
 	}
+
 	return 0;
+
+err:
+	dev_err(dev, "Oops, 'acpi_handle' corrupt\n");
+	return -EINVAL;
 }
 
 static int acpi_platform_notify(struct device *dev)
diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index 251c7b62..8b7cfed 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -303,24 +303,27 @@ acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 		struct acpi_device *dev =
 		    container_of(node, struct acpi_device, wakeup_list);
 		struct device *ldev;
+		struct acpi_device_physical_node *entry;
 
 		if (!dev->wakeup.flags.valid)
 			continue;
 
-		ldev = acpi_get_physical_device(dev->handle);
-		seq_printf(seq, "%s\t  S%d\t%c%-8s  ",
-			   dev->pnp.bus_id,
-			   (u32) dev->wakeup.sleep_state,
-			   dev->wakeup.flags.run_wake ? '*' : ' ',
-			   (device_may_wakeup(&dev->dev)
-			     || (ldev && device_may_wakeup(ldev))) ?
-			       "enabled" : "disabled");
-		if (ldev)
-			seq_printf(seq, "%s:%s",
-				   ldev->bus ? ldev->bus->name : "no-bus",
-				   dev_name(ldev));
-		seq_printf(seq, "\n");
-		put_device(ldev);
+		list_for_each_entry(entry, &dev->physical_node_list, node) {
+			ldev = get_device(entry->dev);
+			seq_printf(seq, "%s\t  S%d\t%c%-8s  ",
+				   dev->pnp.bus_id,
+				   (u32) dev->wakeup.sleep_state,
+				   dev->wakeup.flags.run_wake ? '*' : ' ',
+				   (device_may_wakeup(&dev->dev)
+				     || (ldev && device_may_wakeup(ldev))) ?
+				       "enabled" : "disabled");
+			if (ldev)
+				seq_printf(seq, "%s:%s",
+					   ldev->bus ? ldev->bus->name :
+					   "no-bus", dev_name(ldev));
+			seq_printf(seq, "\n");
+			put_device(ldev);
+		}
 
 	}
 	mutex_unlock(&acpi_device_lock);
@@ -329,12 +332,14 @@ acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 
 static void physical_device_enable_wakeup(struct acpi_device *adev)
 {
-	struct device *dev = acpi_get_physical_device(adev->handle);
+	struct acpi_device_physical_node *entry;
 
-	if (dev && device_can_wakeup(dev)) {
-		bool enable = !device_may_wakeup(dev);
-		device_set_wakeup_enable(dev, enable);
-	}
+	list_for_each_entry(entry,
+		&adev->physical_node_list, node)
+		if (entry->dev && device_can_wakeup(entry->dev)) {
+			bool enable = !device_may_wakeup(entry->dev);
+			device_set_wakeup_enable(entry->dev, enable);
+		}
 }
 
 static ssize_t
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 8ab80ba..1b6e799 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -463,6 +463,7 @@ static int acpi_device_register(struct acpi_device *device)
 	INIT_LIST_HEAD(&device->children);
 	INIT_LIST_HEAD(&device->node);
 	INIT_LIST_HEAD(&device->wakeup_list);
+	INIT_LIST_HEAD(&device->physical_node_list);
 
 	new_bus_id = kzalloc(sizeof(struct acpi_device_bus_id), GFP_KERNEL);
 	if (!new_bus_id) {
diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index b00c176..d33f006 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -323,7 +323,7 @@ static int __init acpi_pnp_match(struct device *dev, void *_pnp)
 	struct pnp_dev *pnp = _pnp;
 
 	/* true means it matched */
-	return !acpi_get_physical_device(acpi->handle)
+	return !acpi->physical_node_count
 	    && compare_pnp_id(pnp->id, acpi_device_hid(acpi));
 }
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 39d7de9..09933e2 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -283,8 +283,14 @@ struct acpi_device_wakeup {
 	int prepare_count;
 };
 
-/* Device */
+struct acpi_device_physical_node {
+	u8 node_id;
+	struct list_head node;
+	struct device *dev;
+};
 
+/* Device */
+#define ACPI_MAX_PHYSICAL_NODE	15
 struct acpi_device {
 	int device_type;
 	acpi_handle handle;		/* no handle for fixed hardware */
@@ -305,6 +311,9 @@ struct acpi_device {
 	struct device dev;
 	struct acpi_bus_ops bus_ops;	/* workaround for different code path for hotplug */
 	enum acpi_bus_removal_type removal_type;	/* indicate for different removal type */
+	u8 physical_node_count;
+	struct list_head physical_node_list;
+	DECLARE_BITMAP(id_bitmap, ACPI_MAX_PHYSICAL_NODE);
 };
 
 static inline void *acpi_driver_data(struct acpi_device *d)
@@ -387,7 +396,6 @@ struct acpi_bus_type {
 };
 int register_acpi_bus_type(struct acpi_bus_type *);
 int unregister_acpi_bus_type(struct acpi_bus_type *);
-struct device *acpi_get_physical_device(acpi_handle);
 
 struct acpi_pci_root {
 	struct list_head node;
-- 
1.7.6.rc2.8.g28eb

