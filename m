From: mochel@linux.intel.com
Subject: [PATCH 3/24] Remove unneeded debugging macros in drivers/acpi/battery.c
Date: Mon, 17 Apr 2006 18:21:52 -0700
Message-ID: <1145323312569-git-send-email-mochel@linux.intel.com>
References: <11453233123014-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:24966 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932107AbWDRBZY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:24 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr005.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1PN6X013956
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:23 GMT
In-Reply-To: <11453233123014-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/battery.c |  110 +++++++++++++++++-------------------------------
 1 files changed, 39 insertions(+), 71 deletions(-)

applies-to: a6f9b1df27d3c3ea8da566f13c5dbd09e4785fa0
6e62e31ebb916529240a7a3a23fcd0f3c8836d0a
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 3b92c94..9df70f1 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -132,17 +132,15 @@ acpi_battery_get_info(struct acpi_batter
 	struct acpi_buffer data = { 0, NULL };
 	union acpi_object *package = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_battery_get_info");
-
 	if (!battery || !bif)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	/* Evalute _BIF */
 
 	status = acpi_evaluate_object(battery->handle, "_BIF", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BIF"));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	package = (union acpi_object *)buffer.pointer;
@@ -177,7 +175,7 @@ acpi_battery_get_info(struct acpi_batter
 	if (!result)
 		(*bif) = (struct acpi_battery_info *)data.pointer;
 
-	return_VALUE(result);
+	return result;
 }
 
 static int
@@ -193,17 +191,15 @@ acpi_battery_get_status(struct acpi_batt
 	struct acpi_buffer data = { 0, NULL };
 	union acpi_object *package = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_battery_get_status");
-
 	if (!battery || !bst)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	/* Evalute _BST */
 
 	status = acpi_evaluate_object(battery->handle, "_BST", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BST"));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	package = (union acpi_object *)buffer.pointer;
@@ -238,7 +234,7 @@ acpi_battery_get_status(struct acpi_batt
 	if (!result)
 		(*bst) = (struct acpi_battery_status *)data.pointer;
 
-	return_VALUE(result);
+	return result;
 }
 
 static int
@@ -248,25 +244,23 @@ acpi_battery_set_alarm(struct acpi_batte
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list arg_list = { 1, &arg0 };
 
-	ACPI_FUNCTION_TRACE("acpi_battery_set_alarm");
-
 	if (!battery)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (!battery->flags.alarm)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	arg0.integer.value = alarm;
 
 	status = acpi_evaluate_object(battery->handle, "_BTP", &arg_list, NULL);
 	if (ACPI_FAILURE(status))
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Alarm set to %d\n", (u32) alarm));
 
 	battery->alarm = alarm;
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_battery_check(struct acpi_battery *battery)
@@ -277,18 +271,16 @@ static int acpi_battery_check(struct acp
 	struct acpi_device *device = NULL;
 	struct acpi_battery_info *bif = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_battery_check");
-
 	if (!battery)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	result = acpi_bus_get_device(battery->handle, &device);
 	if (result)
-		return_VALUE(result);
+		return result;
 
 	result = acpi_bus_get_status(device);
 	if (result)
-		return_VALUE(result);
+		return result;
 
 	/* Insertion? */
 
@@ -300,7 +292,7 @@ static int acpi_battery_check(struct acp
 
 		result = acpi_battery_get_info(battery, &bif);
 		if (result)
-			return_VALUE(result);
+			return result;
 
 		battery->flags.power_unit = bif->power_unit;
 		battery->trips.warning = bif->design_capacity_warning;
@@ -324,7 +316,7 @@ static int acpi_battery_check(struct acp
 
 	battery->flags.present = device->status.battery_present;
 
-	return_VALUE(result);
+	return result;
 }
 
 /* --------------------------------------------------------------------------
@@ -339,8 +331,6 @@ static int acpi_battery_read_info(struct
 	struct acpi_battery_info *bif = NULL;
 	char *units = "?";
 
-	ACPI_FUNCTION_TRACE("acpi_battery_read_info");
-
 	if (!battery)
 		goto end;
 
@@ -409,7 +399,7 @@ static int acpi_battery_read_info(struct
       end:
 	kfree(bif);
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_battery_info_open_fs(struct inode *inode, struct file *file)
@@ -424,8 +414,6 @@ static int acpi_battery_read_state(struc
 	struct acpi_battery_status *bst = NULL;
 	char *units = "?";
 
-	ACPI_FUNCTION_TRACE("acpi_battery_read_state");
-
 	if (!battery)
 		goto end;
 
@@ -487,7 +475,7 @@ static int acpi_battery_read_state(struc
       end:
 	kfree(bst);
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_battery_state_open_fs(struct inode *inode, struct file *file)
@@ -500,8 +488,6 @@ static int acpi_battery_read_alarm(struc
 	struct acpi_battery *battery = (struct acpi_battery *)seq->private;
 	char *units = "?";
 
-	ACPI_FUNCTION_TRACE("acpi_battery_read_alarm");
-
 	if (!battery)
 		goto end;
 
@@ -525,7 +511,7 @@ static int acpi_battery_read_alarm(struc
 		seq_printf(seq, "%d %sh\n", (u32) battery->alarm, units);
 
       end:
-	return_VALUE(0);
+	return 0;
 }
 
 static ssize_t
@@ -538,25 +524,23 @@ acpi_battery_write_alarm(struct file *fi
 	struct seq_file *m = (struct seq_file *)file->private_data;
 	struct acpi_battery *battery = (struct acpi_battery *)m->private;
 
-	ACPI_FUNCTION_TRACE("acpi_battery_write_alarm");
-
 	if (!battery || (count > sizeof(alarm_string) - 1))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (!battery->flags.present)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	if (copy_from_user(alarm_string, buffer, count))
-		return_VALUE(-EFAULT);
+		return -EFAULT;
 
 	alarm_string[count] = '\0';
 
 	result = acpi_battery_set_alarm(battery,
 					simple_strtoul(alarm_string, NULL, 0));
 	if (result)
-		return_VALUE(result);
+		return result;
 
-	return_VALUE(count);
+	return count;
 }
 
 static int acpi_battery_alarm_open_fs(struct inode *inode, struct file *file)
@@ -593,13 +577,11 @@ static int acpi_battery_add_fs(struct ac
 {
 	struct proc_dir_entry *entry = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_battery_add_fs");
-
 	if (!acpi_device_dir(device)) {
 		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
 						     acpi_battery_dir);
 		if (!acpi_device_dir(device))
-			return_VALUE(-ENODEV);
+			return -ENODEV;
 		acpi_device_dir(device)->owner = THIS_MODULE;
 	}
 
@@ -607,7 +589,7 @@ static int acpi_battery_add_fs(struct ac
 	entry = create_proc_entry(ACPI_BATTERY_FILE_INFO,
 				  S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	else {
 		entry->proc_fops = &acpi_battery_info_ops;
 		entry->data = acpi_driver_data(device);
@@ -618,7 +600,7 @@ static int acpi_battery_add_fs(struct ac
 	entry = create_proc_entry(ACPI_BATTERY_FILE_STATUS,
 				  S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	else {
 		entry->proc_fops = &acpi_battery_state_ops;
 		entry->data = acpi_driver_data(device);
@@ -630,20 +612,18 @@ static int acpi_battery_add_fs(struct ac
 				  S_IFREG | S_IRUGO | S_IWUSR,
 				  acpi_device_dir(device));
 	if (!entry)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	else {
 		entry->proc_fops = &acpi_battery_alarm_ops;
 		entry->data = acpi_driver_data(device);
 		entry->owner = THIS_MODULE;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_battery_remove_fs(struct acpi_device *device)
 {
-	ACPI_FUNCTION_TRACE("acpi_battery_remove_fs");
-
 	if (acpi_device_dir(device)) {
 		remove_proc_entry(ACPI_BATTERY_FILE_ALARM,
 				  acpi_device_dir(device));
@@ -656,7 +636,7 @@ static int acpi_battery_remove_fs(struct
 		acpi_device_dir(device) = NULL;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 /* --------------------------------------------------------------------------
@@ -668,13 +648,11 @@ static void acpi_battery_notify(acpi_han
 	struct acpi_battery *battery = (struct acpi_battery *)data;
 	struct acpi_device *device = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_battery_notify");
-
 	if (!battery)
-		return_VOID;
+		return;
 
 	if (acpi_bus_get_device(handle, &device))
-		return_VOID;
+		return;
 
 	switch (event) {
 	case ACPI_BATTERY_NOTIFY_STATUS:
@@ -688,7 +666,6 @@ static void acpi_battery_notify(acpi_han
 		break;
 	}
 
-	return_VOID;
 }
 
 static int acpi_battery_add(struct acpi_device *device)
@@ -697,14 +674,12 @@ static int acpi_battery_add(struct acpi_
 	acpi_status status = 0;
 	struct acpi_battery *battery = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_battery_add");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	battery = kmalloc(sizeof(struct acpi_battery), GFP_KERNEL);
 	if (!battery)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	memset(battery, 0, sizeof(struct acpi_battery));
 
 	battery->handle = device->handle;
@@ -738,7 +713,7 @@ static int acpi_battery_add(struct acpi_
 		kfree(battery);
 	}
 
-	return_VALUE(result);
+	return result;
 }
 
 static int acpi_battery_remove(struct acpi_device *device, int type)
@@ -746,10 +721,8 @@ static int acpi_battery_remove(struct ac
 	acpi_status status = 0;
 	struct acpi_battery *battery = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_battery_remove");
-
 	if (!device || !acpi_driver_data(device))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	battery = (struct acpi_battery *)acpi_driver_data(device);
 
@@ -761,38 +734,33 @@ static int acpi_battery_remove(struct ac
 
 	kfree(battery);
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int __init acpi_battery_init(void)
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_battery_init");
-
 	acpi_battery_dir = proc_mkdir(ACPI_BATTERY_CLASS, acpi_root_dir);
 	if (!acpi_battery_dir)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	acpi_battery_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_battery_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_BATTERY_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_battery_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_battery_exit");
-
 	acpi_bus_unregister_driver(&acpi_battery_driver);
 
 	remove_proc_entry(ACPI_BATTERY_CLASS, acpi_root_dir);
 
-	return_VOID;
 }
 
 module_init(acpi_battery_init);
---
0.99.9.GIT


