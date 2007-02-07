From: Len Brown <lenb@kernel.org>
Subject: [PATCH 134/140] ACPI: bay: remove prototype procfs code
Date: Wed,  7 Feb 2007 13:52:28 -0500
Message-ID: <11708745522982-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <e9dd85e5bdff2a3981dfaa55869ba920e985ea8a.1170873819.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:22414 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422880AbXBGSzy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:54 -0500
In-Reply-To: <11708745514129-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <len.brown@intel.com>

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Remove all the procfs related code.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bay.c |  154 +---------------------------------------------------
 1 files changed, 2 insertions(+), 152 deletions(-)

diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index 412590d..0c0a620 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
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
@@ -219,147 +216,16 @@ static int acpi_bay_add(struct acpi_device *device)
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
-
-	/*
-	 * create a proc entry for this device
-	 * we need to do this a little bit differently than normal
-	 * acpi device drivers because our device may not be present
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
-	return 0;
 }
 
 static void acpi_bay_remove_fs(struct bay *bay)
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
@@ -384,13 +250,6 @@ static int bay_add(acpi_handle handle)
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
@@ -544,21 +403,15 @@ static int __init bay_init(void)
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
@@ -580,9 +433,6 @@ static void __exit bay_exit(void)
 		kfree(bay);
 	}
 
-	if (acpi_bay_dir)
-		remove_proc_entry(ACPI_BAY_CLASS, acpi_root_dir);
-
 	acpi_bus_unregister_driver(&acpi_bay_driver);
 }
 
-- 
1.5.0.rc3.39.gec804
