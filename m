From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 1/2] acpi: Remove procfs from bay
Date: Sat, 16 Dec 2006 14:40:27 -0800
Message-ID: <20061216144027.9765bdd1.kristen.c.accardi@intel.com>
References: <20061216223309.365745735@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33442 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422732AbWLPWuS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Dec 2006 17:50:18 -0500
In-Reply-To: <20061216223309.365745735@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Remove the procfs related code from the bay driver.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/acpi/bay.c |  152 -----------------------------------------------------
 1 file changed, 2 insertions(+), 150 deletions(-)

--- kristen-2.6.orig/drivers/acpi/bay.c
+++ kristen-2.6/drivers/acpi/bay.c
@@ -28,7 +28,6 @@
 #include <linux/notifier.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
-#include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
 
@@ -67,12 +66,10 @@ struct bay {
 	acpi_handle handle;
 	char *name;
 	struct list_head list;
-	struct proc_dir_entry *proc;
 };
 
 LIST_HEAD(drive_bays);
 
-static struct proc_dir_entry *acpi_bay_dir;
 
 /*****************************************************************************
  *                         Drive Bay functions                               *
@@ -219,130 +216,11 @@ static int acpi_bay_add(struct acpi_devi
 	return 0;
 }
 
-static int acpi_bay_status_seq_show(struct seq_file *seq, void *offset)
-{
-	struct bay *bay = (struct bay *)seq->private;
-
-	if (!bay)
-		return 0;
-
-	if (bay_present(bay))
-		seq_printf(seq, "present\n");
-	else
-		seq_printf(seq, "removed\n");
-
-	return 0;
-}
-
-static ssize_t
-acpi_bay_write_eject(struct file *file,
-		      const char __user * buffer,
-		      size_t count, loff_t * data)
-{
-	struct seq_file *m = (struct seq_file *)file->private_data;
-	struct bay *bay = (struct bay *)m->private;
-	char str[12] = { 0 };
-	u32 state = 0;
-
-	/* FIXME - our only valid value here is 1 */
-	if (!bay || count + 1 > sizeof str)
-		return -EINVAL;
-
-	if (copy_from_user(str, buffer, count))
-		return -EFAULT;
-
-	str[count] = 0;
-	state = simple_strtoul(str, NULL, 0);
-	if (state)
-		eject_device(bay->handle);
-
-	return count;
-}
-
-static int
-acpi_bay_status_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_bay_status_seq_show,
-			   PDE(inode)->data);
-}
-
-static int
-acpi_bay_eject_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_bay_status_seq_show,
-			   PDE(inode)->data);
-}
-
-static struct file_operations acpi_bay_status_fops = {
-	.open = acpi_bay_status_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static struct file_operations acpi_bay_eject_fops = {
-	.open = acpi_bay_eject_open_fs,
-	.read = seq_read,
-	.write = acpi_bay_write_eject,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-#if 0
-static struct file_operations acpi_bay_insert_fops = {
-	.open = acpi_bay_insert_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-#endif
 static int acpi_bay_add_fs(struct bay *bay)
 {
-	struct proc_dir_entry *entry = NULL;
-
 	if (!bay)
 		return -EINVAL;
 
-	/*
-	 * create a proc entry for this device
-	 * we need to do this a little bit differently than normal
-  	 * acpi device drivers because our device may not be present
-	 * at the moment, and therefore we have no acpi_device struct
-	 */
-
-	bay->proc = proc_mkdir(bay->name, acpi_bay_dir);
-
-	/* 'status' [R] */
-	entry = create_proc_entry("status",
-				  S_IRUGO, bay->proc);
-	if (!entry)
-		return -EIO;
-	else {
-		entry->proc_fops = &acpi_bay_status_fops;
-		entry->data = bay;
-		entry->owner = THIS_MODULE;
-	}
-	/* 'eject' [W] */
-	entry = create_proc_entry("eject",
-				  S_IWUGO, bay->proc);
-	if (!entry)
-		return -EIO;
-	else {
-		entry->proc_fops = &acpi_bay_eject_fops;
-		entry->data = bay;
-		entry->owner = THIS_MODULE;
-	}
-#if 0
-	/* 'insert' [W] */
-	entry = create_proc_entry("insert",
-				  S_IWUGO, bay->proc);
-	if (!entry)
-		return -EIO;
-	else {
-		entry->proc_fops = &acpi_bay_insert_fops;
-		entry->data = bay;
-		entry->owner = THIS_MODULE;
-	}
-#endif
 	return 0;
 }
 
@@ -350,16 +228,6 @@ static void acpi_bay_remove_fs(struct ba
 {
 	if (!bay)
 		return;
-
-	if (bay->proc) {
-		remove_proc_entry("status", bay->proc);
-		remove_proc_entry("eject", bay->proc);
-#if 0
-		remove_proc_entry("insert", bay->proc);
-#endif
-		remove_proc_entry(bay->name, acpi_bay_dir);
-		bay->proc = NULL;
-	}
 }
 
 static int bay_is_dock_device(acpi_handle handle)
@@ -384,13 +252,6 @@ static int bay_add(acpi_handle handle)
 	bay_dprintk(handle, "Adding notify handler");
 
 	/*
-	 * if this is the first bay device found, make the root
-	 * proc entry
-	 */
-	if (acpi_bay_dir == NULL)
-		acpi_bay_dir = proc_mkdir(ACPI_BAY_CLASS, acpi_root_dir);
-
-	/*
 	 * Initialize bay device structure
 	 */
 	new_bay = kmalloc(GFP_ATOMIC, sizeof(*new_bay));
@@ -545,21 +406,15 @@ static int __init bay_init(void)
 {
 	int bays = 0;
 
-	acpi_bay_dir = NULL;
 	INIT_LIST_HEAD(&drive_bays);
 
 	/* look for dockable drive bays */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 		ACPI_UINT32_MAX, find_bay, &bays, NULL);
 
-	if (bays) {
-		if ((acpi_bus_register_driver(&acpi_bay_driver) < 0)) {
+	if (bays)
+		if ((acpi_bus_register_driver(&acpi_bay_driver) < 0))
 			printk(KERN_ERR "Unable to register bay driver\n");
-			if (acpi_bay_dir)
-				remove_proc_entry(ACPI_BAY_CLASS,
-					acpi_root_dir);
-		}
-	}
 
 	if (!bays)
 		return -ENODEV;
@@ -581,9 +436,6 @@ static void __exit bay_exit(void)
 		kfree(bay);
 	}
 
-	if (acpi_bay_dir)
-		remove_proc_entry(ACPI_BAY_CLASS, acpi_root_dir);
-
 	acpi_bus_unregister_driver(&acpi_bay_driver);
 }
 

--
