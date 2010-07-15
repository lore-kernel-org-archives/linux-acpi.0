From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 5/9] ACPI EC: remove deprecated procfs I/F
Date: Thu, 15 Jul 2010 10:46:36 +0800
Message-ID: <1279161996.4537.8518.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58806 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932128Ab0GOCoa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Jul 2010 22:44:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>


Remove deprecated EC procfs I/F as the same info can be got in dmesg.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/ec.c |   86 ------------------------------------------------------
 1 file changed, 1 insertion(+), 85 deletions(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -34,8 +34,6 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/delay.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
@@ -672,72 +670,6 @@ acpi_ec_space_handler(u32 function, acpi
 }
 
 /* --------------------------------------------------------------------------
-                              FS Interface (/proc)
-   -------------------------------------------------------------------------- */
-
-static struct proc_dir_entry *acpi_ec_dir;
-
-static int acpi_ec_read_info(struct seq_file *seq, void *offset)
-{
-	struct acpi_ec *ec = seq->private;
-
-	if (!ec)
-		goto end;
-
-	seq_printf(seq, "gpe:\t\t\t0x%02x\n", (u32) ec->gpe);
-	seq_printf(seq, "ports:\t\t\t0x%02x, 0x%02x\n",
-		   (unsigned)ec->command_addr, (unsigned)ec->data_addr);
-	seq_printf(seq, "use global lock:\t%s\n",
-		   ec->global_lock ? "yes" : "no");
-      end:
-	return 0;
-}
-
-static int acpi_ec_info_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_ec_read_info, PDE(inode)->data);
-}
-
-static const struct file_operations acpi_ec_info_ops = {
-	.open = acpi_ec_info_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static int acpi_ec_add_fs(struct acpi_device *device)
-{
-	struct proc_dir_entry *entry = NULL;
-
-	if (!acpi_device_dir(device)) {
-		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
-						     acpi_ec_dir);
-		if (!acpi_device_dir(device))
-			return -ENODEV;
-	}
-
-	entry = proc_create_data(ACPI_EC_FILE_INFO, S_IRUGO,
-				 acpi_device_dir(device),
-				 &acpi_ec_info_ops, acpi_driver_data(device));
-	if (!entry)
-		return -ENODEV;
-	return 0;
-}
-
-static int acpi_ec_remove_fs(struct acpi_device *device)
-{
-
-	if (acpi_device_dir(device)) {
-		remove_proc_entry(ACPI_EC_FILE_INFO, acpi_device_dir(device));
-		remove_proc_entry(acpi_device_bid(device), acpi_ec_dir);
-		acpi_device_dir(device) = NULL;
-	}
-
-	return 0;
-}
-
-/* --------------------------------------------------------------------------
                                Driver Interface
    -------------------------------------------------------------------------- */
 static acpi_status
@@ -887,7 +819,6 @@ static int acpi_ec_add(struct acpi_devic
 	if (!first_ec)
 		first_ec = ec;
 	device->driver_data = ec;
-	acpi_ec_add_fs(device);
 	pr_info(PREFIX "GPE = 0x%lx, I/O: command/status = 0x%lx, data = 0x%lx\n",
 			  ec->gpe, ec->command_addr, ec->data_addr);
 
@@ -914,7 +845,6 @@ static int acpi_ec_remove(struct acpi_de
 		kfree(handler);
 	}
 	mutex_unlock(&ec->lock);
-	acpi_ec_remove_fs(device);
 	device->driver_data = NULL;
 	if (ec == first_ec)
 		first_ec = NULL;
@@ -1093,20 +1023,8 @@ static struct acpi_driver acpi_ec_driver
 
 int __init acpi_ec_init(void)
 {
-	int result = 0;
-
-	acpi_ec_dir = proc_mkdir(ACPI_EC_CLASS, acpi_root_dir);
-	if (!acpi_ec_dir)
-		return -ENODEV;
-
 	/* Now register the driver for the EC */
-	result = acpi_bus_register_driver(&acpi_ec_driver);
-	if (result < 0) {
-		remove_proc_entry(ACPI_EC_CLASS, acpi_root_dir);
-		return -ENODEV;
-	}
-
-	return result;
+	return acpi_bus_register_driver(&acpi_ec_driver);
 }
 
 /* EC driver currently not unloadable */
@@ -1116,8 +1034,6 @@ static void __exit acpi_ec_exit(void)
 
 	acpi_bus_unregister_driver(&acpi_ec_driver);
 
-	remove_proc_entry(ACPI_EC_CLASS, acpi_root_dir);
-
 	return;
 }
 #endif	/* 0 */


