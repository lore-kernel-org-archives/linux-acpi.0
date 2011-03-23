From: Len Brown <lenb@kernel.org>
Subject: [PATCH 34/42] ACPI button: remove unused procfs I/F
Date: Wed, 23 Mar 2011 02:42:47 -0400
Message-ID: <912b7427fc13467bac042cc72f2eccbdbc39d773.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37018 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263Ab1CWHHj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 03:07:39 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII000XA14FEFN6@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 02:07:39 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Remove unused ACPI button procfs interface.
Only /proc/acpi/button/lid/LID/state remains.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/feature-removal-schedule.txt |    8 --
 drivers/acpi/button.c                      |  163 ++++++++++------------------
 2 files changed, 60 insertions(+), 111 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index b3f35e5..e461525 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -259,14 +259,6 @@ Who:	Zhang Rui <rui.zhang@intel.com>
 
 ---------------------------
 
-What:	/proc/acpi/button
-When:	August 2007
-Why:	/proc/acpi/button has been replaced by events to the input layer
-	since 2.6.20.
-Who:	Len Brown <len.brown@intel.com>
-
----------------------------
-
 What:	/proc/acpi/event
 When:	February 2008
 Why:	/proc/acpi/event has been replaced by events via the input layer
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 12c28f4..d27d072 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -78,8 +78,6 @@ static int acpi_button_add(struct acpi_device *device);
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
@@ -158,77 +127,85 @@ static int acpi_button_state_open_fs(struct inode *inode, struct file *file)
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
+		printk(KERN_ERR PREFIX "More than one Lid device found!\n");
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
 
-	/* 'info' [R] */
-	entry = proc_create_data(ACPI_BUTTON_FILE_INFO,
-				 S_IRUGO, acpi_device_dir(device),
-				 &acpi_button_info_fops, device);
-	if (!entry)
-		return -ENODEV;
+	/* create /proc/acpi/button/lid/LID/ */
+	acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device), acpi_lid_dir);
+	if (!acpi_device_dir(device)) {
+		ret = -ENODEV;
+		goto remove_lid_dir;
+	}
 
-	/* show lid state [R] */
-	if (button->type == ACPI_BUTTON_TYPE_LID) {
-		entry = proc_create_data(ACPI_BUTTON_FILE_STATE,
-					 S_IRUGO, acpi_device_dir(device),
-					 &acpi_button_state_fops, device);
-		if (!entry)
-			return -ENODEV;
+	/* create /proc/acpi/button/lid/LID/state */
+	entry = proc_create_data(ACPI_BUTTON_FILE_STATE,
+				 S_IRUGO, acpi_device_dir(device),
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
+	if (button->type != ACPI_BUTTON_TYPE_LID)
+		return 0;
 
-		remove_proc_entry(acpi_device_bid(device),
-				  acpi_device_dir(device)->parent);
-		acpi_device_dir(device) = NULL;
-	}
+	remove_proc_entry(ACPI_BUTTON_FILE_STATE,
+			  acpi_device_dir(device));
+	remove_proc_entry(acpi_device_bid(device),
+			  acpi_lid_dir);
+	acpi_device_dir(device) = NULL;
+	remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID, acpi_button_dir);
+	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
 
 	return 0;
 }
@@ -468,32 +445,12 @@ static int acpi_button_remove(struct acpi_device *device, int type)
 
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
-- 
1.7.4.1.343.ga91df

