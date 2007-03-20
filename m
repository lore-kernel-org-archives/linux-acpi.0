From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 5/8] [-mm] ACPI: add ACPI Processor_core sysfs interface
Date: Tue, 20 Mar 2007 17:21:31 +0800
Message-ID: <1174382491.8833.84.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5539 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932564AbXCTJWR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 05:22:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Add ACPI Processor_core sysfs interface.

Attribute	Mode	Description
processor_id	RO
acpi_id		RO
throttling
_control	RO	whether throttling control is supported
			1 = Support, 0 = Not Support.
limit_interface	RO	whether processor thermal control is supported
			1 = Support, 0 = Not Support.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/processor_core.c |  126 +++++++++++++++++++++++++++++++++++-------
 1 files changed, 105 insertions(+), 21 deletions(-)

Index: linux-2.6.21-rc3-mm2/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.21-rc3-mm2.orig/drivers/acpi/processor_core.c	2007-03-16 10:08:06.000000000 +0800
+++ linux-2.6.21-rc3-mm2/drivers/acpi/processor_core.c	2007-03-16 10:21:01.000000000 +0800
@@ -83,7 +83,6 @@ MODULE_LICENSE("GPL");
 static int acpi_processor_add(struct acpi_device *device);
 static int acpi_processor_start(struct acpi_device *device);
 static int acpi_processor_remove(struct acpi_device *device, int type);
-static int acpi_processor_info_open_fs(struct inode *inode, struct file *file);
 static void acpi_processor_notify(acpi_handle handle, u32 event, void *data);
 static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu);
 static int acpi_processor_handle_eject(struct acpi_processor *pr);
@@ -102,13 +101,6 @@ static struct acpi_driver acpi_processor
 #define INSTALL_NOTIFY_HANDLER		1
 #define UNINSTALL_NOTIFY_HANDLER	2
 
-static const struct file_operations acpi_processor_info_fops = {
-	.open = acpi_processor_info_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
 struct acpi_processor *processors[NR_CPUS];
 struct acpi_processor_errata errata __read_mostly;
 
@@ -270,9 +262,68 @@ static int acpi_processor_set_pdc(struct
 }
 
 /* --------------------------------------------------------------------------
-                              FS Interface (/proc)
+                              FS Interface (/sys)
    -------------------------------------------------------------------------- */
 
+static ssize_t
+acpi_processor_id_show(struct acpi_device *dev, char *buf)
+{
+	struct acpi_processor *pr = acpi_driver_data(dev);
+
+	if (!pr)
+		return -EINVAL;
+
+	return sprintf(buf, "%d\n", pr->id);
+}
+static ACPI_DEVICE_ATTR(processor_id, 0444, acpi_processor_id_show, NULL);
+
+static ssize_t
+acpi_processor_acpi_id_show(struct acpi_device *dev, char *buf)
+{
+	struct acpi_processor *pr = acpi_driver_data(dev);
+
+	if (!pr)
+		return -EINVAL;
+
+	return sprintf(buf, "%d\n", pr->acpi_id);
+}
+static ACPI_DEVICE_ATTR(acpi_id, 0444, acpi_processor_acpi_id_show, NULL);
+
+static ssize_t
+acpi_processor_throttling_control_show(struct acpi_device *dev, char *buf)
+{
+	struct acpi_processor *pr = acpi_driver_data(dev);
+
+	if (!pr)
+		return -EINVAL;
+
+	return sprintf(buf, "%d\n", pr->flags.throttling);
+}
+static ACPI_DEVICE_ATTR(throttling_control, 0444, acpi_processor_throttling_control_show, NULL);
+
+static ssize_t
+acpi_processor_limit_interaface_show(struct acpi_device *dev, char *buf)
+{
+	struct acpi_processor *pr = acpi_driver_data(dev);
+
+	if (!pr)
+		return -EINVAL;
+
+	return sprintf(buf, "%d\n", pr->flags.limit);
+}
+static ACPI_DEVICE_ATTR(limit_interface, 0444, acpi_processor_limit_interaface_show, NULL);
+
+static struct device_attribute* processor_info_attr[] = {
+	GET_DEV_ATTR(processor_id),
+	GET_DEV_ATTR(acpi_id),
+	GET_DEV_ATTR(throttling_control),
+	GET_DEV_ATTR(limit_interface),
+	NULL,
+};
+/* --------------------------------------------------------------------------
+                              FS Interface (/proc)
+   -------------------------------------------------------------------------- */
+#ifdef CONFIG_ACPI_PROCFS
 static struct proc_dir_entry *acpi_processor_dir = NULL;
 
 static int acpi_processor_info_seq_show(struct seq_file *seq, void *offset)
@@ -306,7 +357,14 @@ static int acpi_processor_info_open_fs(s
 			   PDE(inode)->data);
 }
 
-static int acpi_processor_add_fs(struct acpi_device *device)
+static const struct file_operations acpi_processor_info_fops = {
+	.open = acpi_processor_info_open_fs,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int acpi_processor_add_procfs(struct acpi_device *device)
 {
 	struct proc_dir_entry *entry = NULL;
 
@@ -357,9 +415,8 @@ static int acpi_processor_add_fs(struct 
 	return 0;
 }
 
-static int acpi_processor_remove_fs(struct acpi_device *device)
+static void acpi_processor_remove_procfs(struct acpi_device *device)
 {
-
 	if (acpi_device_dir(device)) {
 		remove_proc_entry(ACPI_PROCESSOR_FILE_INFO,
 				  acpi_device_dir(device));
@@ -371,9 +428,28 @@ static int acpi_processor_remove_fs(stru
 		acpi_device_dir(device) = NULL;
 	}
 
+	return;
+}
+
+static int acpi_processor_procfs_init(void)
+{
+	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+	if (!acpi_processor_dir)
+		return -ENOMEM;
+	acpi_processor_dir->owner = THIS_MODULE;
+
 	return 0;
 }
 
+static void acpi_processor_procfs_exit(void)
+{
+	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+	return;
+}
+#else
+DECLARE_ACPI_DEVICE_PROCFS(processor);
+#endif
+
 /* Use the acpiid in MADT to map cpus in case of SMP */
 
 #ifndef CONFIG_SMP
@@ -655,10 +731,14 @@ static int __cpuinit acpi_processor_star
 
 	processors[pr->id] = pr;
 
-	result = acpi_processor_add_fs(device);
+	result = acpi_device_add_sysfs(device, processor_info_attr);
 	if (result)
 		goto end;
 
+	result = acpi_processor_add_procfs(device);
+	if (result)
+		goto procfs_error;
+
 	status = acpi_install_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY,
 					     acpi_processor_notify, pr);
 
@@ -674,9 +754,11 @@ static int __cpuinit acpi_processor_star
 		printk(" %d throttling states", pr->throttling.state_count);
 		printk(")\n");
 	}
+	goto end;
 
+      procfs_error:
+	acpi_device_remove_sysfs(device, processor_info_attr);
       end:
-
 	return result;
 }
 
@@ -757,7 +839,9 @@ static int acpi_processor_remove(struct 
 	status = acpi_remove_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY,
 					    acpi_processor_notify);
 
-	acpi_processor_remove_fs(device);
+	acpi_processor_remove_procfs(device);
+
+	acpi_device_remove_sysfs(device, processor_info_attr);
 
 	processors[pr->id] = NULL;
 
@@ -1010,14 +1094,14 @@ static int __init acpi_processor_init(vo
 		madt = NULL;
 #endif
 
-	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-	if (!acpi_processor_dir)
-		return -ENOMEM;
-	acpi_processor_dir->owner = THIS_MODULE;
+	result = acpi_processor_procfs_init();
+	if (result)
+		return -ENODEV;
 
+	acpi_processor_driver.owner = THIS_MODULE;
 	result = acpi_bus_register_driver(&acpi_processor_driver);
 	if (result < 0) {
-		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+		acpi_processor_procfs_exit();
 		return result;
 	}
 
@@ -1046,7 +1130,7 @@ static void __exit acpi_processor_exit(v
 
 		acpi_bus_unregister_driver(&acpi_processor_driver);
 
-		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+		acpi_processor_procfs_exit();
 	}
 	return;
 }
