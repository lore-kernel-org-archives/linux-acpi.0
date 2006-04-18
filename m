From: mochel@linux.intel.com
Subject: [PATCH 10/24] Remove unneeded debugging macros in drivers/acpi/fan.c
Date: Mon, 17 Apr 2006 18:21:53 -0700
Message-ID: <11453233132362-git-send-email-mochel@linux.intel.com>
References: <11453233131896-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:64440 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932118AbWDRBZZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:25 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr004.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1POlA026785
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:24 GMT
In-Reply-To: <11453233131896-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/fan.c |   53 ++++++++++++++++++----------------------------------
 1 files changed, 18 insertions(+), 35 deletions(-)

applies-to: c94bea86ad8c2fc4ba53c16055997112e6dedf86
9a0a67e1e7dd58323362c2e05a1ecf4c0a02beea
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 1495b86..208f0e1 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -74,8 +74,6 @@ static int acpi_fan_read_state(struct se
 	struct acpi_fan *fan = seq->private;
 	int state = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_fan_read_state");
-
 	if (fan) {
 		if (acpi_bus_get_power(fan->handle, &state))
 			seq_printf(seq, "status:                  ERROR\n");
@@ -83,7 +81,7 @@ static int acpi_fan_read_state(struct se
 			seq_printf(seq, "status:                  %s\n",
 				   !state ? "on" : "off");
 	}
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_fan_state_open_fs(struct inode *inode, struct file *file)
@@ -100,22 +98,20 @@ acpi_fan_write_state(struct file *file, 
 	struct acpi_fan *fan = (struct acpi_fan *)m->private;
 	char state_string[12] = { '\0' };
 
-	ACPI_FUNCTION_TRACE("acpi_fan_write_state");
-
 	if (!fan || (count > sizeof(state_string) - 1))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (copy_from_user(state_string, buffer, count))
-		return_VALUE(-EFAULT);
+		return -EFAULT;
 
 	state_string[count] = '\0';
 
 	result = acpi_bus_set_power(fan->handle,
 				    simple_strtoul(state_string, NULL, 0));
 	if (result)
-		return_VALUE(result);
+		return result;
 
-	return_VALUE(count);
+	return count;
 }
 
 static struct file_operations acpi_fan_state_ops = {
@@ -131,16 +127,14 @@ static int acpi_fan_add_fs(struct acpi_d
 {
 	struct proc_dir_entry *entry = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_fan_add_fs");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (!acpi_device_dir(device)) {
 		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
 						     acpi_fan_dir);
 		if (!acpi_device_dir(device))
-			return_VALUE(-ENODEV);
+			return -ENODEV;
 		acpi_device_dir(device)->owner = THIS_MODULE;
 	}
 
@@ -149,27 +143,25 @@ static int acpi_fan_add_fs(struct acpi_d
 				  S_IFREG | S_IRUGO | S_IWUSR,
 				  acpi_device_dir(device));
 	if (!entry)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	else {
 		entry->proc_fops = &acpi_fan_state_ops;
 		entry->data = acpi_driver_data(device);
 		entry->owner = THIS_MODULE;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_fan_remove_fs(struct acpi_device *device)
 {
-	ACPI_FUNCTION_TRACE("acpi_fan_remove_fs");
-
 	if (acpi_device_dir(device)) {
 		remove_proc_entry(ACPI_FAN_FILE_STATE, acpi_device_dir(device));
 		remove_proc_entry(acpi_device_bid(device), acpi_fan_dir);
 		acpi_device_dir(device) = NULL;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 /* --------------------------------------------------------------------------
@@ -182,14 +174,12 @@ static int acpi_fan_add(struct acpi_devi
 	struct acpi_fan *fan = NULL;
 	int state = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_fan_add");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	fan = kmalloc(sizeof(struct acpi_fan), GFP_KERNEL);
 	if (!fan)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	memset(fan, 0, sizeof(struct acpi_fan));
 
 	fan->handle = device->handle;
@@ -215,17 +205,15 @@ static int acpi_fan_add(struct acpi_devi
 	if (result)
 		kfree(fan);
 
-	return_VALUE(result);
+	return result;
 }
 
 static int acpi_fan_remove(struct acpi_device *device, int type)
 {
 	struct acpi_fan *fan = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_fan_remove");
-
 	if (!device || !acpi_driver_data(device))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	fan = (struct acpi_fan *)acpi_driver_data(device);
 
@@ -233,38 +221,33 @@ static int acpi_fan_remove(struct acpi_d
 
 	kfree(fan);
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int __init acpi_fan_init(void)
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_fan_init");
-
 	acpi_fan_dir = proc_mkdir(ACPI_FAN_CLASS, acpi_root_dir);
 	if (!acpi_fan_dir)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	acpi_fan_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_fan_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_FAN_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_fan_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_fan_exit");
-
 	acpi_bus_unregister_driver(&acpi_fan_driver);
 
 	remove_proc_entry(ACPI_FAN_CLASS, acpi_root_dir);
 
-	return_VOID;
 }
 
 module_init(acpi_fan_init);
---
0.99.9.GIT


