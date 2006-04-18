From: mochel@linux.intel.com
Subject: [PATCH 24/24] Remove unneeded debugging macros in drivers/acpi/thermal.c
Date: Mon, 17 Apr 2006 18:21:55 -0700
Message-ID: <11453233153765-git-send-email-mochel@linux.intel.com>
References: <11453233151188-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:26502 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932136AbWDRBZ1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:27 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr005.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1PQ6X013977
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:26 GMT
In-Reply-To: <11453233151188-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/thermal.c |  195 +++++++++++++++++-------------------------------
 1 files changed, 68 insertions(+), 127 deletions(-)

applies-to: a4c30af519d8362f7b24bb5f7f87f4946383e1f5
3944e854ecd6c583395c26abd83c66ad1da0c31d
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 4829f06..db3bef1 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -220,51 +220,45 @@ static int acpi_thermal_get_temperature(
 {
 	acpi_status status = AE_OK;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_get_temperature");
-
 	if (!tz)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	tz->last_temperature = tz->temperature;
 
 	status =
 	    acpi_evaluate_integer(tz->handle, "_TMP", NULL, &tz->temperature);
 	if (ACPI_FAILURE(status))
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Temperature is %lu dK\n",
 			  tz->temperature));
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_thermal_get_polling_frequency(struct acpi_thermal *tz)
 {
 	acpi_status status = AE_OK;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_get_polling_frequency");
-
 	if (!tz)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	status =
 	    acpi_evaluate_integer(tz->handle, "_TZP", NULL,
 				  &tz->polling_frequency);
 	if (ACPI_FAILURE(status))
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Polling frequency is %lu dS\n",
 			  tz->polling_frequency));
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_thermal_set_polling(struct acpi_thermal *tz, int seconds)
 {
-	ACPI_FUNCTION_TRACE("acpi_thermal_set_polling");
-
 	if (!tz)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	tz->polling_frequency = seconds * 10;	/* Convert value to deci-seconds */
 
@@ -272,7 +266,7 @@ static int acpi_thermal_set_polling(stru
 			  "Polling frequency set to %lu seconds\n",
 			  tz->polling_frequency));
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_thermal_set_cooling_mode(struct acpi_thermal *tz, int mode)
@@ -282,29 +276,27 @@ static int acpi_thermal_set_cooling_mode
 	struct acpi_object_list arg_list = { 1, &arg0 };
 	acpi_handle handle = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_set_cooling_mode");
-
 	if (!tz)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	status = acpi_get_handle(tz->handle, "_SCP", &handle);
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_SCP not present\n"));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	arg0.integer.value = mode;
 
 	status = acpi_evaluate_object(handle, NULL, &arg_list, NULL);
 	if (ACPI_FAILURE(status))
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	tz->cooling_mode = mode;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Cooling mode [%s]\n",
 			  mode ? "passive" : "active"));
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
@@ -312,10 +304,8 @@ static int acpi_thermal_get_trip_points(
 	acpi_status status = AE_OK;
 	int i = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_get_trip_points");
-
 	if (!tz)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	/* Critical Shutdown (required) */
 
@@ -324,7 +314,7 @@ static int acpi_thermal_get_trip_points(
 	if (ACPI_FAILURE(status)) {
 		tz->trips.critical.flags.valid = 0;
 		ACPI_EXCEPTION((AE_INFO, status, "No critical threshold"));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	} else {
 		tz->trips.critical.flags.valid = 1;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -415,24 +405,22 @@ static int acpi_thermal_get_trip_points(
 					"Invalid active threshold [%d]", i));
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_thermal_get_devices(struct acpi_thermal *tz)
 {
 	acpi_status status = AE_OK;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_get_devices");
-
 	if (!tz)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	status =
 	    acpi_evaluate_reference(tz->handle, "_TZD", NULL, &tz->devices);
 	if (ACPI_FAILURE(status))
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_thermal_call_usermode(char *path)
@@ -440,10 +428,8 @@ static int acpi_thermal_call_usermode(ch
 	char *argv[2] = { NULL, NULL };
 	char *envp[3] = { NULL, NULL, NULL };
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_call_usermode");
-
 	if (!path)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	argv[0] = path;
 
@@ -453,7 +439,7 @@ static int acpi_thermal_call_usermode(ch
 
 	call_usermodehelper(argv[0], argv, envp, 0);
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_thermal_critical(struct acpi_thermal *tz)
@@ -461,10 +447,8 @@ static int acpi_thermal_critical(struct 
 	int result = 0;
 	struct acpi_device *device = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_critical");
-
 	if (!tz || !tz->trips.critical.flags.valid)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (tz->temperature >= tz->trips.critical.temperature) {
 		ACPI_WARNING((AE_INFO, "Critical trip point"));
@@ -474,7 +458,7 @@ static int acpi_thermal_critical(struct 
 
 	result = acpi_bus_get_device(tz->handle, &device);
 	if (result)
-		return_VALUE(result);
+		return result;
 
 	printk(KERN_EMERG
 	       "Critical temperature reached (%ld C), shutting down.\n",
@@ -484,7 +468,7 @@ static int acpi_thermal_critical(struct 
 
 	acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_thermal_hot(struct acpi_thermal *tz)
@@ -492,10 +476,8 @@ static int acpi_thermal_hot(struct acpi_
 	int result = 0;
 	struct acpi_device *device = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_hot");
-
 	if (!tz || !tz->trips.hot.flags.valid)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (tz->temperature >= tz->trips.hot.temperature) {
 		ACPI_WARNING((AE_INFO, "Hot trip point"));
@@ -505,14 +487,14 @@ static int acpi_thermal_hot(struct acpi_
 
 	result = acpi_bus_get_device(tz->handle, &device);
 	if (result)
-		return_VALUE(result);
+		return result;
 
 	acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_HOT,
 				tz->trips.hot.flags.enabled);
 
 	/* TBD: Call user-mode "sleep(S4)" function */
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void acpi_thermal_passive(struct acpi_thermal *tz)
@@ -522,8 +504,6 @@ static void acpi_thermal_passive(struct 
 	int trend = 0;
 	int i = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_passive");
-
 	if (!tz || !tz->trips.passive.flags.valid)
 		return;
 
@@ -611,8 +591,6 @@ static void acpi_thermal_active(struct a
 	int j = 0;
 	unsigned long maxtemp = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_active");
-
 	if (!tz)
 		return;
 
@@ -694,18 +672,16 @@ static void acpi_thermal_check(void *dat
 	int i = 0;
 	struct acpi_thermal_state state;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_check");
-
 	if (!tz) {
 		ACPI_ERROR((AE_INFO, "Invalid (NULL) context"));
-		return_VOID;
+		return;
 	}
 
 	state = tz->state;
 
 	result = acpi_thermal_get_temperature(tz);
 	if (result)
-		return_VOID;
+		return;
 
 	memset(&tz->state, 0, sizeof(tz->state));
 
@@ -794,7 +770,6 @@ static void acpi_thermal_check(void *dat
 		}
 	}
 
-	return_VOID;
 }
 
 /* --------------------------------------------------------------------------
@@ -807,8 +782,6 @@ static int acpi_thermal_state_seq_show(s
 {
 	struct acpi_thermal *tz = (struct acpi_thermal *)seq->private;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_state_seq_show");
-
 	if (!tz)
 		goto end;
 
@@ -830,7 +803,7 @@ static int acpi_thermal_state_seq_show(s
 	}
 
       end:
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_thermal_state_open_fs(struct inode *inode, struct file *file)
@@ -843,8 +816,6 @@ static int acpi_thermal_temp_seq_show(st
 	int result = 0;
 	struct acpi_thermal *tz = (struct acpi_thermal *)seq->private;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_temp_seq_show");
-
 	if (!tz)
 		goto end;
 
@@ -856,7 +827,7 @@ static int acpi_thermal_temp_seq_show(st
 		   KELVIN_TO_CELSIUS(tz->temperature));
 
       end:
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_thermal_temp_open_fs(struct inode *inode, struct file *file)
@@ -870,8 +841,6 @@ static int acpi_thermal_trip_seq_show(st
 	int i = 0;
 	int j = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_trip_seq_show");
-
 	if (!tz)
 		goto end;
 
@@ -910,7 +879,7 @@ static int acpi_thermal_trip_seq_show(st
 	}
 
       end:
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_thermal_trip_open_fs(struct inode *inode, struct file *file)
@@ -931,18 +900,16 @@ acpi_thermal_write_trip_points(struct fi
 	int *active;
 	int i = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_write_trip_points");
-
 	limit_string = kmalloc(ACPI_THERMAL_MAX_LIMIT_STR_LEN, GFP_KERNEL);
 	if (!limit_string)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 
 	memset(limit_string, 0, ACPI_THERMAL_MAX_LIMIT_STR_LEN);
 
 	active = kmalloc(ACPI_THERMAL_MAX_ACTIVE * sizeof(int), GFP_KERNEL);
 	if (!active) {
 		kfree(limit_string);
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	}
 
 	if (!tz || (count > ACPI_THERMAL_MAX_LIMIT_STR_LEN - 1)) {
@@ -979,15 +946,13 @@ acpi_thermal_write_trip_points(struct fi
       end:
 	kfree(active);
 	kfree(limit_string);
-	return_VALUE(count);
+	return count;
 }
 
 static int acpi_thermal_cooling_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_thermal *tz = (struct acpi_thermal *)seq->private;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_cooling_seq_show");
-
 	if (!tz)
 		goto end;
 
@@ -1002,7 +967,7 @@ static int acpi_thermal_cooling_seq_show
 			   tz->cooling_mode ? "passive" : "active");
 
       end:
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_thermal_cooling_open_fs(struct inode *inode, struct file *file)
@@ -1021,16 +986,14 @@ acpi_thermal_write_cooling_mode(struct f
 	int result = 0;
 	char mode_string[12] = { '\0' };
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_write_cooling_mode");
-
 	if (!tz || (count > sizeof(mode_string) - 1))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (!tz->flags.cooling_mode)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	if (copy_from_user(mode_string, buffer, count))
-		return_VALUE(-EFAULT);
+		return -EFAULT;
 
 	mode_string[count] = '\0';
 
@@ -1038,19 +1001,17 @@ acpi_thermal_write_cooling_mode(struct f
 					       simple_strtoul(mode_string, NULL,
 							      0));
 	if (result)
-		return_VALUE(result);
+		return result;
 
 	acpi_thermal_check(tz);
 
-	return_VALUE(count);
+	return count;
 }
 
 static int acpi_thermal_polling_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_thermal *tz = (struct acpi_thermal *)seq->private;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_polling_seq_show");
-
 	if (!tz)
 		goto end;
 
@@ -1063,7 +1024,7 @@ static int acpi_thermal_polling_seq_show
 		   (tz->polling_frequency / 10));
 
       end:
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_thermal_polling_open_fs(struct inode *inode, struct file *file)
@@ -1083,13 +1044,11 @@ acpi_thermal_write_polling(struct file *
 	char polling_string[12] = { '\0' };
 	int seconds = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_write_polling");
-
 	if (!tz || (count > sizeof(polling_string) - 1))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (copy_from_user(polling_string, buffer, count))
-		return_VALUE(-EFAULT);
+		return -EFAULT;
 
 	polling_string[count] = '\0';
 
@@ -1097,24 +1056,22 @@ acpi_thermal_write_polling(struct file *
 
 	result = acpi_thermal_set_polling(tz, seconds);
 	if (result)
-		return_VALUE(result);
+		return result;
 
 	acpi_thermal_check(tz);
 
-	return_VALUE(count);
+	return count;
 }
 
 static int acpi_thermal_add_fs(struct acpi_device *device)
 {
 	struct proc_dir_entry *entry = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_add_fs");
-
 	if (!acpi_device_dir(device)) {
 		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
 						     acpi_thermal_dir);
 		if (!acpi_device_dir(device))
-			return_VALUE(-ENODEV);
+			return -ENODEV;
 		acpi_device_dir(device)->owner = THIS_MODULE;
 	}
 
@@ -1122,7 +1079,7 @@ static int acpi_thermal_add_fs(struct ac
 	entry = create_proc_entry(ACPI_THERMAL_FILE_STATE,
 				  S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	else {
 		entry->proc_fops = &acpi_thermal_state_fops;
 		entry->data = acpi_driver_data(device);
@@ -1133,7 +1090,7 @@ static int acpi_thermal_add_fs(struct ac
 	entry = create_proc_entry(ACPI_THERMAL_FILE_TEMPERATURE,
 				  S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	else {
 		entry->proc_fops = &acpi_thermal_temp_fops;
 		entry->data = acpi_driver_data(device);
@@ -1145,7 +1102,7 @@ static int acpi_thermal_add_fs(struct ac
 				  S_IFREG | S_IRUGO | S_IWUSR,
 				  acpi_device_dir(device));
 	if (!entry)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	else {
 		entry->proc_fops = &acpi_thermal_trip_fops;
 		entry->data = acpi_driver_data(device);
@@ -1157,7 +1114,7 @@ static int acpi_thermal_add_fs(struct ac
 				  S_IFREG | S_IRUGO | S_IWUSR,
 				  acpi_device_dir(device));
 	if (!entry)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	else {
 		entry->proc_fops = &acpi_thermal_cooling_fops;
 		entry->data = acpi_driver_data(device);
@@ -1169,20 +1126,18 @@ static int acpi_thermal_add_fs(struct ac
 				  S_IFREG | S_IRUGO | S_IWUSR,
 				  acpi_device_dir(device));
 	if (!entry)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	else {
 		entry->proc_fops = &acpi_thermal_polling_fops;
 		entry->data = acpi_driver_data(device);
 		entry->owner = THIS_MODULE;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_thermal_remove_fs(struct acpi_device *device)
 {
-	ACPI_FUNCTION_TRACE("acpi_thermal_remove_fs");
-
 	if (acpi_device_dir(device)) {
 		remove_proc_entry(ACPI_THERMAL_FILE_POLLING_FREQ,
 				  acpi_device_dir(device));
@@ -1198,7 +1153,7 @@ static int acpi_thermal_remove_fs(struct
 		acpi_device_dir(device) = NULL;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 /* --------------------------------------------------------------------------
@@ -1210,13 +1165,11 @@ static void acpi_thermal_notify(acpi_han
 	struct acpi_thermal *tz = (struct acpi_thermal *)data;
 	struct acpi_device *device = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_notify");
-
 	if (!tz)
-		return_VOID;
+		return;
 
 	if (acpi_bus_get_device(tz->handle, &device))
-		return_VOID;
+		return;
 
 	switch (event) {
 	case ACPI_THERMAL_NOTIFY_TEMPERATURE:
@@ -1238,27 +1191,24 @@ static void acpi_thermal_notify(acpi_han
 		break;
 	}
 
-	return_VOID;
 }
 
 static int acpi_thermal_get_info(struct acpi_thermal *tz)
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_get_info");
-
 	if (!tz)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	/* Get temperature [_TMP] (required) */
 	result = acpi_thermal_get_temperature(tz);
 	if (result)
-		return_VALUE(result);
+		return result;
 
 	/* Get trip points [_CRT, _PSV, etc.] (required) */
 	result = acpi_thermal_get_trip_points(tz);
 	if (result)
-		return_VALUE(result);
+		return result;
 
 	/* Set the cooling mode [_SCP] to active cooling (default) */
 	result = acpi_thermal_set_cooling_mode(tz, ACPI_THERMAL_MODE_ACTIVE);
@@ -1298,7 +1248,7 @@ static int acpi_thermal_get_info(struct 
 	if (!result)
 		tz->flags.devices = 1;
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_thermal_add(struct acpi_device *device)
@@ -1307,14 +1257,12 @@ static int acpi_thermal_add(struct acpi_
 	acpi_status status = AE_OK;
 	struct acpi_thermal *tz = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_add");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	tz = kmalloc(sizeof(struct acpi_thermal), GFP_KERNEL);
 	if (!tz)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	memset(tz, 0, sizeof(struct acpi_thermal));
 
 	tz->handle = device->handle;
@@ -1329,7 +1277,7 @@ static int acpi_thermal_add(struct acpi_
 
 	result = acpi_thermal_add_fs(device);
 	if (result)
-		return_VALUE(result);
+		return result;
 
 	init_timer(&tz->timer);
 
@@ -1353,7 +1301,7 @@ static int acpi_thermal_add(struct acpi_
 		kfree(tz);
 	}
 
-	return_VALUE(result);
+	return result;
 }
 
 static int acpi_thermal_remove(struct acpi_device *device, int type)
@@ -1361,10 +1309,8 @@ static int acpi_thermal_remove(struct ac
 	acpi_status status = AE_OK;
 	struct acpi_thermal *tz = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_remove");
-
 	if (!device || !acpi_driver_data(device))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	tz = (struct acpi_thermal *)acpi_driver_data(device);
 
@@ -1395,38 +1341,33 @@ static int acpi_thermal_remove(struct ac
 	acpi_thermal_remove_fs(device);
 
 	kfree(tz);
-	return_VALUE(0);
+	return 0;
 }
 
 static int __init acpi_thermal_init(void)
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_thermal_init");
-
 	acpi_thermal_dir = proc_mkdir(ACPI_THERMAL_CLASS, acpi_root_dir);
 	if (!acpi_thermal_dir)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	acpi_thermal_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_thermal_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_THERMAL_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_thermal_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_thermal_exit");
-
 	acpi_bus_unregister_driver(&acpi_thermal_driver);
 
 	remove_proc_entry(ACPI_THERMAL_CLASS, acpi_root_dir);
 
-	return_VOID;
 }
 
 module_init(acpi_thermal_init);
---
0.99.9.GIT


