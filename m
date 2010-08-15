From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/20] ACPI power_resource: remove unused procfs I/F
Date: Sun, 15 Aug 2010 01:23:20 -0400
Message-ID: <06af7eb043c02822072cea862fce1b7c74115e8f.1281849737.git.len.brown@intel.com>
References: <1281849804-7455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:57561 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab0HOFaI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Aug 2010 01:30:08 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L7600HN2HY5RHB4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Aug 2010 00:30:07 -0500 (CDT)
In-reply-to: <1281849804-7455-1-git-send-email-lenb@kernel.org>
In-reply-to: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
References: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Remove unused ACPI power procfs I/F.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/power.c |  128 +-------------------------------------------------
 1 files changed, 1 insertions(+), 127 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index f74d3b3..4fe5018 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -40,8 +40,6 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/slab.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 #include "sleep.h"
@@ -64,7 +62,6 @@ module_param_named(power_nocheck, acpi_power_nocheck, bool, 000);
 static int acpi_power_add(struct acpi_device *device);
 static int acpi_power_remove(struct acpi_device *device, int type);
 static int acpi_power_resume(struct acpi_device *device);
-static int acpi_power_open_fs(struct inode *inode, struct file *file);
 
 static const struct acpi_device_id power_device_ids[] = {
 	{ACPI_POWER_HID, 0},
@@ -99,14 +96,6 @@ struct acpi_power_resource {
 
 static struct list_head acpi_power_resource_list;
 
-static const struct file_operations acpi_power_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_power_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
 /* --------------------------------------------------------------------------
                              Power Resource Management
    -------------------------------------------------------------------------- */
@@ -542,102 +531,6 @@ int acpi_power_transition(struct acpi_device *device, int state)
 }
 
 /* --------------------------------------------------------------------------
-                              FS Interface (/proc)
-   -------------------------------------------------------------------------- */
-
-static struct proc_dir_entry *acpi_power_dir;
-
-static int acpi_power_seq_show(struct seq_file *seq, void *offset)
-{
-	int count = 0;
-	int result = 0, state;
-	struct acpi_power_resource *resource = NULL;
-	struct list_head *node, *next;
-	struct acpi_power_reference *ref;
-
-
-	resource = seq->private;
-
-	if (!resource)
-		goto end;
-
-	result = acpi_power_get_state(resource->device->handle, &state);
-	if (result)
-		goto end;
-
-	seq_puts(seq, "state:                   ");
-	switch (state) {
-	case ACPI_POWER_RESOURCE_STATE_ON:
-		seq_puts(seq, "on\n");
-		break;
-	case ACPI_POWER_RESOURCE_STATE_OFF:
-		seq_puts(seq, "off\n");
-		break;
-	default:
-		seq_puts(seq, "unknown\n");
-		break;
-	}
-
-	mutex_lock(&resource->resource_lock);
-	list_for_each_safe(node, next, &resource->reference) {
-		ref = container_of(node, struct acpi_power_reference, node);
-		count++;
-	}
-	mutex_unlock(&resource->resource_lock);
-
-	seq_printf(seq, "system level:            S%d\n"
-		   "order:                   %d\n"
-		   "reference count:         %d\n",
-		   resource->system_level,
-		   resource->order, count);
-
-      end:
-	return 0;
-}
-
-static int acpi_power_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_power_seq_show, PDE(inode)->data);
-}
-
-static int acpi_power_add_fs(struct acpi_device *device)
-{
-	struct proc_dir_entry *entry = NULL;
-
-
-	if (!device)
-		return -EINVAL;
-
-	if (!acpi_device_dir(device)) {
-		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
-						     acpi_power_dir);
-		if (!acpi_device_dir(device))
-			return -ENODEV;
-	}
-
-	/* 'status' [R] */
-	entry = proc_create_data(ACPI_POWER_FILE_STATUS,
-				 S_IRUGO, acpi_device_dir(device),
-				 &acpi_power_fops, acpi_driver_data(device));
-	if (!entry)
-		return -EIO;
-	return 0;
-}
-
-static int acpi_power_remove_fs(struct acpi_device *device)
-{
-
-	if (acpi_device_dir(device)) {
-		remove_proc_entry(ACPI_POWER_FILE_STATUS,
-				  acpi_device_dir(device));
-		remove_proc_entry(acpi_device_bid(device), acpi_power_dir);
-		acpi_device_dir(device) = NULL;
-	}
-
-	return 0;
-}
-
-/* --------------------------------------------------------------------------
                                 Driver Interface
    -------------------------------------------------------------------------- */
 
@@ -690,10 +583,6 @@ static int acpi_power_add(struct acpi_device *device)
 		break;
 	}
 
-	result = acpi_power_add_fs(device);
-	if (result)
-		goto end;
-
 	printk(KERN_INFO PREFIX "%s [%s] (%s)\n", acpi_device_name(device),
 	       acpi_device_bid(device), state ? "on" : "off");
 
@@ -715,8 +604,6 @@ static int acpi_power_remove(struct acpi_device *device, int type)
 
 	resource = acpi_driver_data(device);
 
-	acpi_power_remove_fs(device);
-
 	mutex_lock(&resource->resource_lock);
 	list_for_each_safe(node, next, &resource->reference) {
 		struct acpi_power_reference *ref = container_of(node, struct acpi_power_reference, node);
@@ -760,19 +647,6 @@ static int acpi_power_resume(struct acpi_device *device)
 
 int __init acpi_power_init(void)
 {
-	int result = 0;
-
 	INIT_LIST_HEAD(&acpi_power_resource_list);
-
-	acpi_power_dir = proc_mkdir(ACPI_POWER_CLASS, acpi_root_dir);
-	if (!acpi_power_dir)
-		return -ENODEV;
-
-	result = acpi_bus_register_driver(&acpi_power_driver);
-	if (result < 0) {
-		remove_proc_entry(ACPI_POWER_CLASS, acpi_root_dir);
-		return -ENODEV;
-	}
-
-	return 0;
+	return acpi_bus_register_driver(&acpi_power_driver);
 }
-- 
1.7.2.1.95.g3d045

