From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/4] ACPI fan: remove deprecated procfs I/F
Date: Sat, 02 Oct 2010 04:39:44 +0800
Message-ID: <1285965584.2111.3745.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:16978 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466Ab0JAUlB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Oct 2010 16:41:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


Remove deprecated ACPI Fan driver procfs interface.
New sysfs I/F is available at /sys/class/thermal/cooling_devicecX/

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/fan.c |  137 -----------------------------------------------------
 1 file changed, 1 insertion(+), 136 deletions(-)

Index: linux-2.6/drivers/acpi/fan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/fan.c
+++ linux-2.6/drivers/acpi/fan.c
@@ -27,8 +27,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
 #include <asm/uaccess.h>
 #include <linux/thermal.h>
 #include <acpi/acpi_bus.h>
@@ -119,122 +117,6 @@ static struct thermal_cooling_device_ops
 };
 
 /* --------------------------------------------------------------------------
-                              FS Interface (/proc)
-   -------------------------------------------------------------------------- */
-#ifdef CONFIG_ACPI_PROCFS
-
-static struct proc_dir_entry *acpi_fan_dir;
-
-static int acpi_fan_read_state(struct seq_file *seq, void *offset)
-{
-	struct acpi_device *device = seq->private;
-	int state = 0;
-
-
-	if (device) {
-		if (acpi_bus_get_power(device->handle, &state))
-			seq_printf(seq, "status:                  ERROR\n");
-		else
-			seq_printf(seq, "status:                  %s\n",
-				   !state ? "on" : "off");
-	}
-	return 0;
-}
-
-static int acpi_fan_state_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_fan_read_state, PDE(inode)->data);
-}
-
-static ssize_t
-acpi_fan_write_state(struct file *file, const char __user * buffer,
-		     size_t count, loff_t * ppos)
-{
-	int result = 0;
-	struct seq_file *m = file->private_data;
-	struct acpi_device *device = m->private;
-	char state_string[3] = { '\0' };
-
-	if (count > sizeof(state_string) - 1)
-		return -EINVAL;
-
-	if (copy_from_user(state_string, buffer, count))
-		return -EFAULT;
-
-	state_string[count] = '\0';
-	if ((state_string[0] < '0') || (state_string[0] > '3'))
-		return -EINVAL;
-	if (state_string[1] == '\n')
-		state_string[1] = '\0';
-	if (state_string[1] != '\0')
-		return -EINVAL;
-
-	result = acpi_bus_set_power(device->handle,
-				    simple_strtoul(state_string, NULL, 0));
-	if (result)
-		return result;
-
-	return count;
-}
-
-static const struct file_operations acpi_fan_state_ops = {
-	.open = acpi_fan_state_open_fs,
-	.read = seq_read,
-	.write = acpi_fan_write_state,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static int acpi_fan_add_fs(struct acpi_device *device)
-{
-	struct proc_dir_entry *entry = NULL;
-
-
-	if (!device)
-		return -EINVAL;
-
-	if (!acpi_device_dir(device)) {
-		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
-						     acpi_fan_dir);
-		if (!acpi_device_dir(device))
-			return -ENODEV;
-	}
-
-	/* 'status' [R/W] */
-	entry = proc_create_data(ACPI_FAN_FILE_STATE,
-				 S_IFREG | S_IRUGO | S_IWUSR,
-				 acpi_device_dir(device),
-				 &acpi_fan_state_ops,
-				 device);
-	if (!entry)
-		return -ENODEV;
-	return 0;
-}
-
-static int acpi_fan_remove_fs(struct acpi_device *device)
-{
-
-	if (acpi_device_dir(device)) {
-		remove_proc_entry(ACPI_FAN_FILE_STATE, acpi_device_dir(device));
-		remove_proc_entry(acpi_device_bid(device), acpi_fan_dir);
-		acpi_device_dir(device) = NULL;
-	}
-
-	return 0;
-}
-#else
-static int acpi_fan_add_fs(struct acpi_device *device)
-{
-	return 0;
-}
-
-static int acpi_fan_remove_fs(struct acpi_device *device)
-{
-	return 0;
-}
-#endif
-/* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
 
@@ -284,10 +166,6 @@ static int acpi_fan_add(struct acpi_devi
 		dev_err(&device->dev, "Failed to create sysfs link "
 			"'device'\n");
 
-	result = acpi_fan_add_fs(device);
-	if (result)
-		goto end;
-
 	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
 	       !device->power.state ? "on" : "off");
@@ -303,7 +181,6 @@ static int acpi_fan_remove(struct acpi_d
 	if (!device || !cdev)
 		return -EINVAL;
 
-	acpi_fan_remove_fs(device);
 	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
 	sysfs_remove_link(&cdev->device.kobj, "device");
 	thermal_cooling_device_unregister(cdev);
@@ -347,19 +224,9 @@ static int __init acpi_fan_init(void)
 {
 	int result = 0;
 
-#ifdef CONFIG_ACPI_PROCFS
-	acpi_fan_dir = proc_mkdir(ACPI_FAN_CLASS, acpi_root_dir);
-	if (!acpi_fan_dir)
-		return -ENODEV;
-#endif
-
 	result = acpi_bus_register_driver(&acpi_fan_driver);
-	if (result < 0) {
-#ifdef CONFIG_ACPI_PROCFS
-		remove_proc_entry(ACPI_FAN_CLASS, acpi_root_dir);
-#endif
+	if (result < 0)
 		return -ENODEV;
-	}
 
 	return 0;
 }
@@ -369,8 +236,6 @@ static void __exit acpi_fan_exit(void)
 
 	acpi_bus_unregister_driver(&acpi_fan_driver);
 
-	remove_proc_entry(ACPI_FAN_CLASS, acpi_root_dir);
-
 	return;
 }
 


