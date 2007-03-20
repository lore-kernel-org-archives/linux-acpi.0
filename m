From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 4/8] [-mm] ACPI: add ACPI Power_resource sysfs interface
Date: Tue, 20 Mar 2007 17:21:26 +0800
Message-ID: <1174382486.8833.83.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5539 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932561AbXCTJWO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 05:22:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Add ACPI Power_resource sysfs interface.

Attribute	Mode	Description
state		RO	the current state of the Power Resource (0-OFF, 1-ON)
system_level	RO	the lowest power system sleep level OSPM must maintain
			to keep this power resource on (0 equals to S0,etc)
resource_order	RO		
reference_count	RO	

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/power.c |  134 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 117 insertions(+), 17 deletions(-)

Index: linux-2.6.21-rc3-mm2/drivers/acpi/power.c
===================================================================
--- linux-2.6.21-rc3-mm2.orig/drivers/acpi/power.c	2007-03-19 10:26:42.000000000 +0800
+++ linux-2.6.21-rc3-mm2/drivers/acpi/power.c	2007-03-19 15:42:52.000000000 +0800
@@ -57,7 +57,6 @@ ACPI_MODULE_NAME("power");
 static int acpi_power_add(struct acpi_device *device);
 static int acpi_power_remove(struct acpi_device *device, int type);
 static int acpi_power_resume(struct acpi_device *device);
-static int acpi_power_open_fs(struct inode *inode, struct file *file);
 
 static struct acpi_driver acpi_power_driver = {
 	.name = "power",
@@ -87,13 +86,6 @@ struct acpi_power_resource {
 
 static struct list_head acpi_power_resource_list;
 
-static const struct file_operations acpi_power_fops = {
-	.open = acpi_power_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
 /* --------------------------------------------------------------------------
                              Power Resource Management
    -------------------------------------------------------------------------- */
@@ -480,9 +472,82 @@ int acpi_power_transition(struct acpi_de
 }
 
 /* --------------------------------------------------------------------------
-                              FS Interface (/proc)
+                              FS Interface (/sys)
    -------------------------------------------------------------------------- */
+static ssize_t
+acpi_power_state_show(struct acpi_device *dev, char *buf)
+{
+	struct acpi_power_resource *resource = acpi_driver_data(dev);
+	int result;
+
+	if (!resource)
+		return -EINVAL;
+
+	result = acpi_power_get_state(resource);
+	if (result)
+		return result;
+
+	return sprintf(buf, "%d\n", resource->state);
+}
+static ACPI_DEVICE_ATTR(state, 0444, acpi_power_state_show, NULL);
+
+static ssize_t
+acpi_power_system_level_show(struct acpi_device *dev, char *buf)
+{
+	struct acpi_power_resource *resource = acpi_driver_data(dev);
+
+	if (!resource)
+		return -EINVAL;
+
+	return sprintf(buf, "%d\n", resource->system_level);
+}
+static ACPI_DEVICE_ATTR(system_level, 0444, acpi_power_system_level_show, NULL);
+
+static ssize_t
+acpi_power_resource_order_show(struct acpi_device *dev, char *buf)
+{
+	struct acpi_power_resource *resource = acpi_driver_data(dev);
+
+	if (!resource)
+		return -EINVAL;
+
+	return sprintf(buf, "%d\n", resource->order);
+}
+static ACPI_DEVICE_ATTR(resource_order, 0444, acpi_power_resource_order_show, NULL);
+
+static ssize_t
+acpi_power_reference_count_show(struct acpi_device *dev, char *buf)
+{
+	struct acpi_power_resource *resource = acpi_driver_data(dev);
+	int count = 0;
+	struct list_head *node, *next;
+	struct acpi_power_reference *ref;
+
+	if (!resource)
+		return -EINVAL;
+
+	mutex_lock(&resource->resource_lock);
+	list_for_each_safe(node, next, &resource->reference) {
+		ref = container_of(node, struct acpi_power_reference, node);
+		count++;
+	}
+	mutex_unlock(&resource->resource_lock);
+
+	return sprintf(buf, "%d\n", count);
+}
+static ACPI_DEVICE_ATTR(reference_count, 0444, acpi_power_reference_count_show, NULL);
 
+static struct device_attribute* power_attr[] = {
+	GET_DEV_ATTR(state),
+	GET_DEV_ATTR(system_level),
+	GET_DEV_ATTR(resource_order),
+	GET_DEV_ATTR(reference_count),
+	NULL,
+};
+/* --------------------------------------------------------------------------
+                              FS Interface (/proc)
+   -------------------------------------------------------------------------- */
+#ifdef CONFIG_ACPI_PROCFS
 static struct proc_dir_entry *acpi_power_dir;
 
 static int acpi_power_seq_show(struct seq_file *seq, void *offset)
@@ -538,7 +603,14 @@ static int acpi_power_open_fs(struct ino
 	return single_open(file, acpi_power_seq_show, PDE(inode)->data);
 }
 
-static int acpi_power_add_fs(struct acpi_device *device)
+static const struct file_operations acpi_power_fops = {
+	.open = acpi_power_open_fs,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int acpi_power_add_procfs(struct acpi_device *device)
 {
 	struct proc_dir_entry *entry = NULL;
 
@@ -566,7 +638,7 @@ static int acpi_power_add_fs(struct acpi
 	return 0;
 }
 
-static int acpi_power_remove_fs(struct acpi_device *device)
+static void acpi_power_remove_procfs(struct acpi_device *device)
 {
 
 	if (acpi_device_dir(device)) {
@@ -576,9 +648,27 @@ static int acpi_power_remove_fs(struct a
 		acpi_device_dir(device) = NULL;
 	}
 
+	return ;
+}
+
+static int acpi_power_procfs_init(void)
+{
+	acpi_power_dir = proc_mkdir(ACPI_POWER_CLASS, acpi_root_dir);
+	if (!acpi_power_dir)
+		return -ENODEV;
+
 	return 0;
 }
 
+static void acpi_power_procfs_exit(void)
+{
+	remove_proc_entry(ACPI_POWER_CLASS, acpi_root_dir);
+
+	return ;
+}
+#else
+DECLARE_ACPI_DEVICE_PROCFS(power);
+#endif
 /* --------------------------------------------------------------------------
                                 Driver Interface
    -------------------------------------------------------------------------- */
@@ -632,17 +722,24 @@ static int acpi_power_add(struct acpi_de
 		break;
 	}
 
-	result = acpi_power_add_fs(device);
+	result = acpi_device_add_sysfs(device, power_attr);
 	if (result)
 		goto end;
 
+	result = acpi_power_add_procfs(device);
+	if (result)
+		goto procfs_error;
+
 	printk(KERN_INFO PREFIX "%s [%s] (%s)\n", acpi_device_name(device),
 	       acpi_device_bid(device), resource->state ? "on" : "off");
 
+	goto end;
+
+      procfs_error:
+	acpi_device_remove_sysfs(device, power_attr);
       end:
 	if (result)
 		kfree(resource);
-
 	return result;
 }
 
@@ -657,7 +754,9 @@ static int acpi_power_remove(struct acpi
 
 	resource = acpi_driver_data(device);
 
-	acpi_power_remove_fs(device);
+	acpi_power_remove_procfs(device);
+
+	acpi_device_remove_sysfs(device, power_attr);
 
 	mutex_lock(&resource->resource_lock);
 	list_for_each_safe(node, next, &resource->reference) {
@@ -710,13 +809,14 @@ static int __init acpi_power_init(void)
 
 	INIT_LIST_HEAD(&acpi_power_resource_list);
 
-	acpi_power_dir = proc_mkdir(ACPI_POWER_CLASS, acpi_root_dir);
-	if (!acpi_power_dir)
+	result = acpi_power_procfs_init();
+	if (result)
 		return -ENODEV;
 
+	acpi_power_driver.owner = THIS_MODULE;
 	result = acpi_bus_register_driver(&acpi_power_driver);
 	if (result < 0) {
-		remove_proc_entry(ACPI_POWER_CLASS, acpi_root_dir);
+		acpi_power_procfs_exit();
 		return -ENODEV;
 	}
 
