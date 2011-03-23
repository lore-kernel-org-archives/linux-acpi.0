From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/2] ACPI button: remove unused procfs I/F
Date: Wed, 23 Mar 2011 09:34:25 +0800
Message-ID: <1300844065.31379.5.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13905 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046Ab1CWBej (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Mar 2011 21:34:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


Remove unused ACPI button procfs interface.
The only one left is /proc/acpi/button/lid/LID/state.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/button.c |  166 ++++++++++++++++++--------------------------------
 1 file changed, 62 insertions(+), 104 deletions(-)

Index: linux-2.6/drivers/acpi/button.c
===================================================================
--- linux-2.6.orig/drivers/acpi/button.c
+++ linux-2.6/drivers/acpi/button.c
@@ -78,8 +78,6 @@ static int acpi_button_add(struct acpi_d
 static int acpi_button_remove(struct acpi_device *device, int type);
 static int acpi_button_resume(struct acpi_device *device);
 static void acpi_button_notify(struct acpi_device *device, u32 event);
-static int acpi_button_info_open_fs(struct inode *inode, struct file *file);
-static int acpi_button_state_open_fs(struct inode *inode, struct file *file);
 
 static struct acpi_driver acpi_button_driver = {
 	.name = "button",
@@ -101,22 +99,6 @@ struct acpi_button {
 	bool wakeup_enabled;
 };
 
-static const struct file_operations acpi_button_info_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_button_info_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static const struct file_operations acpi_button_state_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_button_state_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
 static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
 static struct acpi_device *lid_device;
 
@@ -125,20 +107,7 @@ static struct acpi_device *lid_device;
    -------------------------------------------------------------------------- */
 
 static struct proc_dir_entry *acpi_button_dir;
-
-static int acpi_button_info_seq_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_device *device = seq->private;
-
-	seq_printf(seq, "type:                    %s\n",
-		   acpi_device_name(device));
-	return 0;
-}
-
-static int acpi_button_info_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_button_info_seq_show, PDE(inode)->data);
-}
+static struct proc_dir_entry *acpi_lid_dir;
 
 static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
 {
@@ -158,77 +127,86 @@ static int acpi_button_state_open_fs(str
 	return single_open(file, acpi_button_state_seq_show, PDE(inode)->data);
 }
 
-static struct proc_dir_entry *acpi_power_dir;
-static struct proc_dir_entry *acpi_sleep_dir;
-static struct proc_dir_entry *acpi_lid_dir;
+static const struct file_operations acpi_button_state_fops = {
+	.owner = THIS_MODULE,
+	.open = acpi_button_state_open_fs,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
 
 static int acpi_button_add_fs(struct acpi_device *device)
 {
 	struct acpi_button *button = acpi_driver_data(device);
 	struct proc_dir_entry *entry = NULL;
+	int ret = 0;
 
-	switch (button->type) {
-	case ACPI_BUTTON_TYPE_POWER:
-		if (!acpi_power_dir)
-			acpi_power_dir = proc_mkdir(ACPI_BUTTON_SUBCLASS_POWER,
-						    acpi_button_dir);
-		entry = acpi_power_dir;
-		break;
-	case ACPI_BUTTON_TYPE_SLEEP:
-		if (!acpi_sleep_dir)
-			acpi_sleep_dir = proc_mkdir(ACPI_BUTTON_SUBCLASS_SLEEP,
-						    acpi_button_dir);
-		entry = acpi_sleep_dir;
-		break;
-	case ACPI_BUTTON_TYPE_LID:
-		if (!acpi_lid_dir)
-			acpi_lid_dir = proc_mkdir(ACPI_BUTTON_SUBCLASS_LID,
-						  acpi_button_dir);
-		entry = acpi_lid_dir;
-		break;
+	/* procfs I/F for ACPI lid device only */
+	if (button->type != ACPI_BUTTON_TYPE_LID)
+		return 0;
+
+	if (acpi_button_dir || acpi_lid_dir) {
+		printk((PREFIX KERN_WARNING "More than one Lid devices found!\n"));
+		return -EEXIST;
 	}
 
-	if (!entry)
+	/* create /proc/acpi/button */
+	acpi_button_dir = proc_mkdir(ACPI_BUTTON_CLASS, acpi_root_dir);
+	if (!acpi_button_dir)
 		return -ENODEV;
 
-	acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device), entry);
-	if (!acpi_device_dir(device))
-		return -ENODEV;
+	/* create /proc/acpi/button/lid */
+	acpi_lid_dir = proc_mkdir(ACPI_BUTTON_SUBCLASS_LID, acpi_button_dir);
+	if (!acpi_lid_dir) {
+		ret = -ENODEV;
+		goto remove_button_dir;
+	}
+
+	/* create /proc/acpi/button/lid/LID/ */
+	acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device), acpi_lid_dir);
+	if (!acpi_device_dir(device)) {
+		ret = -ENODEV;
+		goto remove_lid_dir;
+	}
 
-	/* 'info' [R] */
-	entry = proc_create_data(ACPI_BUTTON_FILE_INFO,
+	/* create /proc/acpi/button/lid/LID/state */
+	entry = proc_create_data(ACPI_BUTTON_FILE_STATE,
 				 S_IRUGO, acpi_device_dir(device),
-				 &acpi_button_info_fops, device);
-	if (!entry)
-		return -ENODEV;
-
-	/* show lid state [R] */
-	if (button->type == ACPI_BUTTON_TYPE_LID) {
-		entry = proc_create_data(ACPI_BUTTON_FILE_STATE,
-					 S_IRUGO, acpi_device_dir(device),
-					 &acpi_button_state_fops, device);
-		if (!entry)
-			return -ENODEV;
+				 &acpi_button_state_fops, device);
+	if (!entry) {
+		ret = -ENODEV;
+		goto remove_dev_dir;
 	}
 
-	return 0;
+done:
+	return ret;
+
+remove_dev_dir:
+	remove_proc_entry(acpi_device_bid(device),
+			  acpi_lid_dir);
+	acpi_device_dir(device) = NULL;
+remove_lid_dir:
+	remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID, acpi_button_dir);
+remove_button_dir:
+	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
+	
+	goto done;
 }
 
 static int acpi_button_remove_fs(struct acpi_device *device)
 {
 	struct acpi_button *button = acpi_driver_data(device);
 
-	if (acpi_device_dir(device)) {
-		if (button->type == ACPI_BUTTON_TYPE_LID)
-			remove_proc_entry(ACPI_BUTTON_FILE_STATE,
-					  acpi_device_dir(device));
-		remove_proc_entry(ACPI_BUTTON_FILE_INFO,
-				  acpi_device_dir(device));
-
-		remove_proc_entry(acpi_device_bid(device),
-				  acpi_device_dir(device)->parent);
-		acpi_device_dir(device) = NULL;
-	}
+	if (button->type != ACPI_BUTTON_TYPE_LID)
+		return 0;
+
+	remove_proc_entry(ACPI_BUTTON_FILE_STATE,
+			  acpi_device_dir(device));
+	remove_proc_entry(acpi_device_bid(device),
+			  acpi_lid_dir);
+	acpi_device_dir(device) = NULL;
+	remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID, acpi_button_dir);
+	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
 
 	return 0;
 }
@@ -468,32 +446,12 @@ static int acpi_button_remove(struct acp
 
 static int __init acpi_button_init(void)
 {
-	int result;
-
-	acpi_button_dir = proc_mkdir(ACPI_BUTTON_CLASS, acpi_root_dir);
-	if (!acpi_button_dir)
-		return -ENODEV;
-
-	result = acpi_bus_register_driver(&acpi_button_driver);
-	if (result < 0) {
-		remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
-		return -ENODEV;
-	}
-
-	return 0;
+	return acpi_bus_register_driver(&acpi_button_driver);
 }
 
 static void __exit acpi_button_exit(void)
 {
 	acpi_bus_unregister_driver(&acpi_button_driver);
-
-	if (acpi_power_dir)
-		remove_proc_entry(ACPI_BUTTON_SUBCLASS_POWER, acpi_button_dir);
-	if (acpi_sleep_dir)
-		remove_proc_entry(ACPI_BUTTON_SUBCLASS_SLEEP, acpi_button_dir);
-	if (acpi_lid_dir)
-		remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID, acpi_button_dir);
-	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
 }
 
 module_init(acpi_button_init);


