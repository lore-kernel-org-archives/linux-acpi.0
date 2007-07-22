From: Len Brown <len.brown@intel.com>
Subject: [PATCH 13/77] ACPI: battery: syntax cleanup
Date: Sun, 22 Jul 2007 05:13:58 -0400
Message-ID: <1185095715506-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33449 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762477AbXGVJPT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:19 -0400
In-Reply-To: <1185095714699-git-send-email-len.brown@intel.com>
Message-Id: <78490d82129f7331d1366737c8704c1c053221a3.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <aystarik@gmail.com>

In response to review comments from Andrew Morton

Signed-off-by: Alexey Starikovskiy <aystarik@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |  418 ++++++++++++++++++++----------------------------
 1 files changed, 172 insertions(+), 246 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b5df318..cad932d 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -43,9 +43,6 @@
 #define ACPI_BATTERY_CLASS		"battery"
 #define ACPI_BATTERY_HID		"PNP0C0A"
 #define ACPI_BATTERY_DEVICE_NAME	"Battery"
-#define ACPI_BATTERY_FILE_INFO		"info"
-#define ACPI_BATTERY_FILE_STATE		"state"
-#define ACPI_BATTERY_FILE_ALARM		"alarm"
 #define ACPI_BATTERY_NOTIFY_STATUS	0x80
 #define ACPI_BATTERY_NOTIFY_INFO	0x81
 #define ACPI_BATTERY_UNITS_WATTS	"mW"
@@ -111,13 +108,18 @@ struct acpi_battery_info {
 	acpi_string oem_info;
 };
 
+enum acpi_battery_files{
+	ACPI_BATTERY_INFO = 0,
+	ACPI_BATTERY_STATE,
+	ACPI_BATTERY_ALARM,
+	ACPI_BATTERY_NUMFILES,
+};
+
 struct acpi_battery_flags {
 	u8 battery_present_prev;
 	u8 alarm_present;
 	u8 init_update;
-	u8 info_update;
-	u8 state_update;
-	u8 alarm_update;
+	u8 update[ACPI_BATTERY_NUMFILES];
 	u8 power_unit;
 };
 
@@ -128,47 +130,37 @@ struct acpi_battery {
 	struct acpi_buffer bif_data;
 	struct acpi_buffer bst_data;
 	unsigned long alarm;
-	unsigned long info_update_time;
-	unsigned long state_update_time;
-	unsigned long alarm_update_time;
+	unsigned long update_time[ACPI_BATTERY_NUMFILES];
 };
 
-#define acpi_battery_present(battery) battery->device->status.battery_present
-#define acpi_battery_present_prev(battery) battery->flags.battery_present_prev
-#define acpi_battery_alarm_present(battery) battery->flags.alarm_present
-#define acpi_battery_init_update_flag(battery) battery->flags.init_update
-#define acpi_battery_info_update_flag(battery) battery->flags.info_update
-#define acpi_battery_state_update_flag(battery) battery->flags.state_update
-#define acpi_battery_alarm_update_flag(battery) battery->flags.alarm_update
-#define acpi_battery_power_units(battery) battery->flags.power_unit ? \
-		ACPI_BATTERY_UNITS_AMPS : ACPI_BATTERY_UNITS_WATTS
-#define acpi_battery_handle(battery) battery->device->handle
-#define acpi_battery_inserted(battery) (!acpi_battery_present_prev(battery) & acpi_battery_present(battery))
-#define acpi_battery_removed(battery) (acpi_battery_present_prev(battery) & !acpi_battery_present(battery))
-#define acpi_battery_bid(battery) acpi_device_bid(battery->device)
-#define acpi_battery_status_str(battery) acpi_battery_present(battery) ? "present" : "absent"
-
-/* --------------------------------------------------------------------------
-                               Battery Management
-   -------------------------------------------------------------------------- */
-
-static void acpi_battery_mutex_lock(struct acpi_battery *battery)
+inline int acpi_battery_present(struct acpi_battery *battery)
 {
-	mutex_lock(&battery->mutex);
+	return battery->device->status.battery_present;
+}
+inline char *acpi_battery_power_units(struct acpi_battery *battery)
+{
+	if (battery->flags.power_unit)
+		return ACPI_BATTERY_UNITS_AMPS;
+	else
+		return ACPI_BATTERY_UNITS_WATTS;
 }
 
-static void acpi_battery_mutex_unlock(struct acpi_battery *battery)
+inline acpi_handle acpi_battery_handle(struct acpi_battery *battery)
 {
-	mutex_unlock(&battery->mutex);
+	return battery->device->handle;
 }
 
+/* --------------------------------------------------------------------------
+                               Battery Management
+   -------------------------------------------------------------------------- */
+
 static void acpi_battery_check_result(struct acpi_battery *battery, int result)
 {
 	if (!battery)
 		return;
 
 	if (result) {
-		acpi_battery_init_update_flag(battery) = 1;
+		battery->flags.init_update = 1;
 	}
 }
 
@@ -189,9 +181,7 @@ static int acpi_battery_extract_package(struct acpi_battery *battery,
 	}
 
 	if (data_null.length != data->length) {
-		if (data->pointer) {
-			kfree(data->pointer);
-		}
+		kfree(data->pointer);
 		data->pointer = kzalloc(data_null.length, GFP_KERNEL);
 		if (!data->pointer) {
 			ACPI_EXCEPTION((AE_INFO, AE_NO_MEMORY, "kzalloc()"));
@@ -234,12 +224,12 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	struct acpi_buffer *data = NULL;
 	struct acpi_battery_info *bif = NULL;
 
-	battery->info_update_time = get_seconds();
+	battery->update_time[ACPI_BATTERY_INFO] = get_seconds();
 
 	if (!acpi_battery_present(battery))
 		return 0;
 
-	/* Evalute _BIF */
+	/* Evaluate _BIF */
 
 	status =
 	    acpi_evaluate_object(acpi_battery_handle(battery), "_BIF", NULL,
@@ -263,9 +253,7 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 
       end:
 
-	if (buffer.pointer) {
-		kfree(buffer.pointer);
-	}
+	kfree(buffer.pointer);
 
 	if (!result) {
 		bif = data->pointer;
@@ -286,12 +274,12 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	union acpi_object *package = NULL;
 	struct acpi_buffer *data = NULL;
 
-	battery->state_update_time = get_seconds();
+	battery->update_time[ACPI_BATTERY_STATE] = get_seconds();
 
 	if (!acpi_battery_present(battery))
 		return 0;
 
-	/* Evalute _BST */
+	/* Evaluate _BST */
 
 	status =
 	    acpi_evaluate_object(acpi_battery_handle(battery), "_BST", NULL,
@@ -314,16 +302,14 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 		goto end;
 
       end:
-	if (buffer.pointer) {
-		kfree(buffer.pointer);
-	}
+	kfree(buffer.pointer);
 
 	return result;
 }
 
 static int acpi_battery_get_alarm(struct acpi_battery *battery)
 {
-	battery->alarm_update_time = get_seconds();
+	battery->update_time[ACPI_BATTERY_ALARM] = get_seconds();
 
 	return 0;
 }
@@ -335,12 +321,12 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery,
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list arg_list = { 1, &arg0 };
 
-	battery->alarm_update_time = get_seconds();
+	battery->update_time[ACPI_BATTERY_ALARM] = get_seconds();
 
 	if (!acpi_battery_present(battery))
 		return -ENODEV;
 
-	if (!acpi_battery_alarm_present(battery))
+	if (!battery->flags.alarm_present)
 		return -ENODEV;
 
 	arg0.integer.value = alarm;
@@ -370,7 +356,7 @@ static int acpi_battery_init_alarm(struct acpi_battery *battery)
 
 	status = acpi_get_handle(acpi_battery_handle(battery), "_BTP", &handle);
 	if (ACPI_SUCCESS(status)) {
-		acpi_battery_alarm_present(battery) = 1;
+		battery->flags.alarm_present = 1;
 		if (!alarm && bif) {
 			alarm = bif->design_capacity_warning;
 		}
@@ -378,7 +364,7 @@ static int acpi_battery_init_alarm(struct acpi_battery *battery)
 		if (result)
 			goto end;
 	} else {
-		acpi_battery_alarm_present(battery) = 0;
+		battery->flags.alarm_present = 0;
 	}
 
       end:
@@ -394,7 +380,7 @@ static int acpi_battery_init_update(struct acpi_battery *battery)
 	if (result)
 		return result;
 
-	acpi_battery_present_prev(battery) = acpi_battery_present(battery);
+	battery->flags.battery_present_prev = acpi_battery_present(battery);
 
 	if (acpi_battery_present(battery)) {
 		result = acpi_battery_get_info(battery);
@@ -420,20 +406,20 @@ static int acpi_battery_update(struct acpi_battery *battery,
 		update = 1;
 	}
 
-	if (acpi_battery_init_update_flag(battery)) {
+	if (battery->flags.init_update) {
 		result = acpi_battery_init_update(battery);
 		if (result)
-			goto end;;
+			goto end;
 		update_result = ACPI_BATTERY_INIT_UPDATE;
 	} else if (update) {
 		result = acpi_battery_get_status(battery);
 		if (result)
-			goto end;;
-		if (acpi_battery_inserted(battery)
-		    || acpi_battery_removed(battery)) {
+			goto end;
+		if ((!battery->flags.battery_present_prev & acpi_battery_present(battery))
+		    || (battery->flags.battery_present_prev & !acpi_battery_present(battery))) {
 			result = acpi_battery_init_update(battery);
 			if (result)
-				goto end;;
+				goto end;
 			update_result = ACPI_BATTERY_INIT_UPDATE;
 		} else {
 			update_result = ACPI_BATTERY_EASY_UPDATE;
@@ -442,7 +428,7 @@ static int acpi_battery_update(struct acpi_battery *battery,
 
       end:
 
-	acpi_battery_init_update_flag(battery) = (result != 0);
+	battery->flags.init_update = (result != 0);
 
 	*update_result_ptr = update_result;
 
@@ -453,16 +439,19 @@ static void acpi_battery_notify_update(struct acpi_battery *battery)
 {
 	acpi_battery_get_status(battery);
 
-	if (acpi_battery_init_update_flag(battery)) {
+	if (battery->flags.init_update) {
 		return;
 	}
 
-	if (acpi_battery_inserted(battery) || acpi_battery_removed(battery)) {
-		acpi_battery_init_update_flag(battery) = 1;
+	if ((!battery->flags.battery_present_prev &
+	     acpi_battery_present(battery)) ||
+	    (battery->flags.battery_present_prev &
+	     !acpi_battery_present(battery))) {
+		battery->flags.init_update = 1;
 	} else {
-		acpi_battery_info_update_flag(battery) = 1;
-		acpi_battery_state_update_flag(battery) = 1;
-		acpi_battery_alarm_update_flag(battery) = 1;
+		battery->flags.update[ACPI_BATTERY_INFO] = 1;
+		battery->flags.update[ACPI_BATTERY_STATE] = 1;
+		battery->flags.update[ACPI_BATTERY_ALARM] = 1;
 	}
 }
 
@@ -472,7 +461,7 @@ static void acpi_battery_notify_update(struct acpi_battery *battery)
 
 static struct proc_dir_entry *acpi_battery_dir;
 
-static int acpi_battery_read_info_print(struct seq_file *seq, int result)
+static int acpi_battery_print_info(struct seq_file *seq, int result)
 {
 	struct acpi_battery *battery = seq->private;
 	struct acpi_battery_info *bif = NULL;
@@ -549,49 +538,7 @@ static int acpi_battery_read_info_print(struct seq_file *seq, int result)
 	return result;
 }
 
-static int acpi_battery_read_info(struct seq_file *seq, void *offset)
-{
-	struct acpi_battery *battery = seq->private;
-	int result = 0;
-	int update_result = ACPI_BATTERY_NONE_UPDATE;
-	int update = 0;
-
-	acpi_battery_mutex_lock(battery);
-
-	update = (get_seconds() - battery->info_update_time >= update_time);
-	update = (update | acpi_battery_info_update_flag(battery));
-
-	result = acpi_battery_update(battery, update, &update_result);
-	if (result)
-		goto end;
-
-	/* Battery Info (_BIF) */
-
-	if (update_result == ACPI_BATTERY_EASY_UPDATE) {
-		result = acpi_battery_get_info(battery);
-		if (result)
-			goto end;
-	}
-
-      end:
-
-	result = acpi_battery_read_info_print(seq, result);
-
-	acpi_battery_check_result(battery, result);
-
-	acpi_battery_info_update_flag(battery) = result;
-
-	acpi_battery_mutex_unlock(battery);
-
-	return result;
-}
-
-static int acpi_battery_info_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_battery_read_info, PDE(inode)->data);
-}
-
-static int acpi_battery_read_state_print(struct seq_file *seq, int result)
+static int acpi_battery_print_state(struct seq_file *seq, int result)
 {
 	struct acpi_battery *battery = seq->private;
 	struct acpi_battery_state *bst = NULL;
@@ -661,49 +608,7 @@ static int acpi_battery_read_state_print(struct seq_file *seq, int result)
 	return result;
 }
 
-static int acpi_battery_read_state(struct seq_file *seq, void *offset)
-{
-	struct acpi_battery *battery = seq->private;
-	int result = 0;
-	int update_result = ACPI_BATTERY_NONE_UPDATE;
-	int update = 0;
-
-	acpi_battery_mutex_lock(battery);
-
-	update = (get_seconds() - battery->state_update_time >= update_time);
-	update = (update | acpi_battery_state_update_flag(battery));
-
-	result = acpi_battery_update(battery, update, &update_result);
-	if (result)
-		goto end;
-
-	/* Battery State (_BST) */
-
-	if (update_result == ACPI_BATTERY_EASY_UPDATE) {
-		result = acpi_battery_get_state(battery);
-		if (result)
-			goto end;
-	}
-
-      end:
-
-	result = acpi_battery_read_state_print(seq, result);
-
-	acpi_battery_check_result(battery, result);
-
-	acpi_battery_state_update_flag(battery) = result;
-
-	acpi_battery_mutex_unlock(battery);
-
-	return result;
-}
-
-static int acpi_battery_state_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_battery_read_state, PDE(inode)->data);
-}
-
-static int acpi_battery_read_alarm_print(struct seq_file *seq, int result)
+static int acpi_battery_print_alarm(struct seq_file *seq, int result)
 {
 	struct acpi_battery *battery = seq->private;
 	char *units = "?";
@@ -734,43 +639,6 @@ static int acpi_battery_read_alarm_print(struct seq_file *seq, int result)
 	return result;
 }
 
-static int acpi_battery_read_alarm(struct seq_file *seq, void *offset)
-{
-	struct acpi_battery *battery = seq->private;
-	int result = 0;
-	int update_result = ACPI_BATTERY_NONE_UPDATE;
-	int update = 0;
-
-	acpi_battery_mutex_lock(battery);
-
-	update = (get_seconds() - battery->alarm_update_time >= update_time);
-	update = (update | acpi_battery_alarm_update_flag(battery));
-
-	result = acpi_battery_update(battery, update, &update_result);
-	if (result)
-		goto end;
-
-	/* Battery Alarm */
-
-	if (update_result == ACPI_BATTERY_EASY_UPDATE) {
-		result = acpi_battery_get_alarm(battery);
-		if (result)
-			goto end;
-	}
-
-      end:
-
-	result = acpi_battery_read_alarm_print(seq, result);
-
-	acpi_battery_check_result(battery, result);
-
-	acpi_battery_alarm_update_flag(battery) = result;
-
-	acpi_battery_mutex_unlock(battery);
-
-	return result;
-}
-
 static ssize_t
 acpi_battery_write_alarm(struct file *file,
 			 const char __user * buffer,
@@ -785,7 +653,7 @@ acpi_battery_write_alarm(struct file *file,
 	if (!battery || (count > sizeof(alarm_string) - 1))
 		return -EINVAL;
 
-	acpi_battery_mutex_lock(battery);
+	mutex_lock(&battery->mutex);
 
 	result = acpi_battery_update(battery, 1, &update_result);
 	if (result) {
@@ -817,44 +685,128 @@ acpi_battery_write_alarm(struct file *file,
 	if (!result)
 		result = count;
 
-	acpi_battery_mutex_unlock(battery);
+	mutex_unlock(&battery->mutex);
+
+	return result;
+}
+
+typedef int(*print_func)(struct seq_file *seq, int result);
+typedef int(*get_func)(struct acpi_battery *battery);
+
+static struct acpi_read_mux {
+	print_func print;
+	get_func get;
+} acpi_read_funcs[ACPI_BATTERY_NUMFILES] = {
+	{.get = acpi_battery_get_info, .print = acpi_battery_print_info},
+	{.get = acpi_battery_get_state, .print = acpi_battery_print_state},
+	{.get = acpi_battery_get_alarm, .print = acpi_battery_print_alarm},
+};
 
+static int acpi_battery_read(int fid, struct seq_file *seq)
+{
+	struct acpi_battery *battery = seq->private;
+	int result = 0;
+	int update_result = ACPI_BATTERY_NONE_UPDATE;
+	int update = 0;
+
+	mutex_lock(&battery->mutex);
+
+	update = (get_seconds() - battery->update_time[fid] >= update_time);
+	update = (update | battery->flags.update[fid]);
+
+	result = acpi_battery_update(battery, update, &update_result);
+	if (result)
+		goto end;
+
+	if (update_result == ACPI_BATTERY_EASY_UPDATE) {
+		result = acpi_read_funcs[fid].get(battery);
+		if (result)
+			goto end;
+	}
+
+      end:
+	result = acpi_read_funcs[fid].print(seq, result);
+	acpi_battery_check_result(battery, result);
+	battery->flags.update[fid] = result;
+	mutex_unlock(&battery->mutex);
 	return result;
 }
 
+static int acpi_battery_read_info(struct seq_file *seq, void *offset)
+{
+	return acpi_battery_read(ACPI_BATTERY_INFO, seq);
+}
+
+static int acpi_battery_read_state(struct seq_file *seq, void *offset)
+{
+	return acpi_battery_read(ACPI_BATTERY_STATE, seq);
+}
+
+static int acpi_battery_read_alarm(struct seq_file *seq, void *offset)
+{
+	return acpi_battery_read(ACPI_BATTERY_ALARM, seq);
+}
+
+static int acpi_battery_info_open_fs(struct inode *inode, struct file *file)
+{
+	return single_open(file, acpi_battery_read_info, PDE(inode)->data);
+}
+
+static int acpi_battery_state_open_fs(struct inode *inode, struct file *file)
+{
+	return single_open(file, acpi_battery_read_state, PDE(inode)->data);
+}
+
 static int acpi_battery_alarm_open_fs(struct inode *inode, struct file *file)
 {
 	return single_open(file, acpi_battery_read_alarm, PDE(inode)->data);
 }
 
-static const struct file_operations acpi_battery_info_ops = {
+static struct battery_file {
+	struct file_operations ops;
+	mode_t mode;
+	char *name;
+} acpi_battery_file[] = {
+	{
+	.name = "info",
+	.mode = S_IRUGO,
+	.ops = {
 	.open = acpi_battery_info_open_fs,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
-};
-
-static const struct file_operations acpi_battery_state_ops = {
+	},
+	},
+	{
+	.name = "state",
+	.mode = S_IRUGO,
+	.ops = {
 	.open = acpi_battery_state_open_fs,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
-};
-
-static const struct file_operations acpi_battery_alarm_ops = {
+	},
+	},
+	{
+	.name = "alarm",
+	.mode = S_IFREG | S_IRUGO | S_IWUSR,
+	.ops = {
 	.open = acpi_battery_alarm_open_fs,
 	.read = seq_read,
 	.write = acpi_battery_write_alarm,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
+	},
+	},
 };
 
 static int acpi_battery_add_fs(struct acpi_device *device)
 {
 	struct proc_dir_entry *entry = NULL;
+	int i;
 
 	if (!acpi_device_dir(device)) {
 		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
@@ -864,38 +816,16 @@ static int acpi_battery_add_fs(struct acpi_device *device)
 		acpi_device_dir(device)->owner = THIS_MODULE;
 	}
 
-	/* 'info' [R] */
-	entry = create_proc_entry(ACPI_BATTERY_FILE_INFO,
-				  S_IRUGO, acpi_device_dir(device));
-	if (!entry)
-		return -ENODEV;
-	else {
-		entry->proc_fops = &acpi_battery_info_ops;
-		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
-	}
-
-	/* 'status' [R] */
-	entry = create_proc_entry(ACPI_BATTERY_FILE_STATE,
-				  S_IRUGO, acpi_device_dir(device));
-	if (!entry)
-		return -ENODEV;
-	else {
-		entry->proc_fops = &acpi_battery_state_ops;
-		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
-	}
-
-	/* 'alarm' [R/W] */
-	entry = create_proc_entry(ACPI_BATTERY_FILE_ALARM,
-				  S_IFREG | S_IRUGO | S_IWUSR,
-				  acpi_device_dir(device));
-	if (!entry)
-		return -ENODEV;
-	else {
-		entry->proc_fops = &acpi_battery_alarm_ops;
-		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
+	for (i = 0; i < ACPI_BATTERY_NUMFILES; ++i) {
+		entry = create_proc_entry(acpi_battery_file[i].name,
+				  acpi_battery_file[i].mode, acpi_device_dir(device));
+		if (!entry)
+			return -ENODEV;
+		else {
+			entry->proc_fops = &acpi_battery_file[i].ops;
+			entry->data = acpi_driver_data(device);
+			entry->owner = THIS_MODULE;
+		}
 	}
 
 	return 0;
@@ -903,14 +833,12 @@ static int acpi_battery_add_fs(struct acpi_device *device)
 
 static int acpi_battery_remove_fs(struct acpi_device *device)
 {
+	int i;
 	if (acpi_device_dir(device)) {
-		remove_proc_entry(ACPI_BATTERY_FILE_ALARM,
-				  acpi_device_dir(device));
-		remove_proc_entry(ACPI_BATTERY_FILE_STATE,
-				  acpi_device_dir(device));
-		remove_proc_entry(ACPI_BATTERY_FILE_INFO,
+		for (i = 0; i < ACPI_BATTERY_NUMFILES; ++i) {
+			remove_proc_entry(acpi_battery_file[i].name,
 				  acpi_device_dir(device));
-
+		}
 		remove_proc_entry(acpi_device_bid(device), acpi_battery_dir);
 		acpi_device_dir(device) = NULL;
 	}
@@ -966,7 +894,7 @@ static int acpi_battery_add(struct acpi_device *device)
 
 	mutex_init(&battery->mutex);
 
-	acpi_battery_mutex_lock(battery);
+	mutex_lock(&battery->mutex);
 
 	battery->device = device;
 	strcpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
@@ -977,7 +905,7 @@ static int acpi_battery_add(struct acpi_device *device)
 	if (result)
 		goto end;
 
-	acpi_battery_init_update_flag(battery) = 1;
+	battery->flags.init_update = 1;
 
 	result = acpi_battery_add_fs(device);
 	if (result)
@@ -1003,7 +931,7 @@ static int acpi_battery_add(struct acpi_device *device)
 		kfree(battery);
 	}
 
-	acpi_battery_mutex_unlock(battery);
+	mutex_unlock(&battery->mutex);
 
 	return result;
 }
@@ -1018,7 +946,7 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
 
 	battery = acpi_driver_data(device);
 
-	acpi_battery_mutex_lock(battery);
+	mutex_lock(&battery->mutex);
 
 	status = acpi_remove_notify_handler(device->handle,
 					    ACPI_ALL_NOTIFY,
@@ -1026,13 +954,11 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
 
 	acpi_battery_remove_fs(device);
 
-	if (battery->bif_data.pointer)
-		kfree(battery->bif_data.pointer);
+	kfree(battery->bif_data.pointer);
 
-	if (battery->bst_data.pointer)
-		kfree(battery->bst_data.pointer);
+	kfree(battery->bst_data.pointer);
 
-	acpi_battery_mutex_unlock(battery);
+	mutex_unlock(&battery->mutex);
 
 	mutex_destroy(&battery->mutex);
 
@@ -1051,7 +977,7 @@ static int acpi_battery_resume(struct acpi_device *device)
 
 	battery = device->driver_data;
 
-	acpi_battery_init_update_flag(battery) = 1;
+	battery->flags.init_update = 1;
 
 	return 0;
 }
-- 
1.5.3.rc2.22.g69a9b
