From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/32] ACPI: Battery: Misc clean-ups, no functional changes
Date: Fri, 21 Sep 2007 23:46:13 -0400
Message-ID: <11904328041498-git-send-email-lenb@kernel.org>
References: <11904327981905-git-send-email-lenb@kernel.org>
 <11904327991059-git-send-email-lenb@kernel.org>
 <11904328003655-git-send-email-lenb@kernel.org>
 <11904328012791-git-send-email-lenb@kernel.org>
 <11904328011699-git-send-email-lenb@kernel.org>
 <1190432802575-git-send-email-lenb@kernel.org>
 <11904328031107-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:18967 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754915AbXIVDqp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 23:46:45 -0400
In-Reply-To: <11904328031107-git-send-email-lenb@kernel.org>
Message-Id: <89543b032d6a389f7d75e239b1d45b0ce3604a5f.1190432418.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikivskiy@suse.de>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikivskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |  342 ++++++++++++++++++------------------------------
 1 files changed, 125 insertions(+), 217 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index faa70a5..db725bf 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1,6 +1,8 @@
 /*
- *  acpi_battery.c - ACPI Battery Driver ($Revision: 37 $)
+ *  battery.c - ACPI Battery Driver (Revision: 2.0)
  *
+ *  Copyright (C) 2007 Alexey Starikovskiy <astarikovskiy@suse.de>
+ *  Copyright (C) 2004-2007 Vladimir Lebedev <vladimir.p.lebedev@intel.com>
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
  *
@@ -48,6 +50,7 @@
 ACPI_MODULE_NAME("battery");
 
 MODULE_AUTHOR("Paul Diefenbaugh");
+MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
 MODULE_DESCRIPTION("ACPI Battery Driver");
 MODULE_LICENSE("GPL");
 
@@ -58,31 +61,17 @@ MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
 extern struct proc_dir_entry *acpi_lock_battery_dir(void);
 extern void *acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
 
-static int acpi_battery_add(struct acpi_device *device);
-static int acpi_battery_remove(struct acpi_device *device, int type);
-static int acpi_battery_resume(struct acpi_device *device);
-
 static const struct acpi_device_id battery_device_ids[] = {
 	{"PNP0C0A", 0},
 	{"", 0},
 };
-MODULE_DEVICE_TABLE(acpi, battery_device_ids);
 
-static struct acpi_driver acpi_battery_driver = {
-	.name = "battery",
-	.class = ACPI_BATTERY_CLASS,
-	.ids = battery_device_ids,
-	.ops = {
-		.add = acpi_battery_add,
-		.resume = acpi_battery_resume,
-		.remove = acpi_battery_remove,
-		},
-};
+MODULE_DEVICE_TABLE(acpi, battery_device_ids);
 
 enum acpi_battery_files {
-	ACPI_BATTERY_INFO = 0,
-	ACPI_BATTERY_STATE,
-	ACPI_BATTERY_ALARM,
+	info_tag = 0,
+	state_tag,
+	alarm_tag,
 	ACPI_BATTERY_NUMFILES,
 };
 
@@ -124,7 +113,6 @@ inline char *acpi_battery_units(struct acpi_battery *battery)
 /* --------------------------------------------------------------------------
                                Battery Management
    -------------------------------------------------------------------------- */
-
 struct acpi_offsets {
 	size_t offset;		/* offset inside struct acpi_sbs_battery */
 	u8 mode;		/* int or string? */
@@ -183,19 +171,16 @@ static int extract_package(struct acpi_battery *battery,
 
 static int acpi_battery_get_status(struct acpi_battery *battery)
 {
-	int result = 0;
-
-	result = acpi_bus_get_status(battery->device);
-	if (result) {
+	if (acpi_bus_get_status(battery->device)) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR, "Evaluating _STA"));
 		return -ENODEV;
 	}
-	return result;
+	return 0;
 }
 
 static int acpi_battery_get_info(struct acpi_battery *battery)
 {
-	int result = 0;
+	int result = -EFAULT;
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
@@ -205,10 +190,12 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	status = acpi_evaluate_object(battery->device->handle, "_BIF",
 				      NULL, &buffer);
 	mutex_unlock(&battery->lock);
+
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BIF"));
 		return -ENODEV;
 	}
+
 	result = extract_package(battery, buffer.pointer,
 				 info_offsets, ARRAY_SIZE(info_offsets));
 	kfree(buffer.pointer);
@@ -238,6 +225,7 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BST"));
 		return -ENODEV;
 	}
+
 	result = extract_package(battery, buffer.pointer,
 				 state_offsets, ARRAY_SIZE(state_offsets));
 	battery->update_time = jiffies;
@@ -245,37 +233,26 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	return result;
 }
 
-static int acpi_battery_get_alarm(struct acpi_battery *battery)
-{
-	return 0;
-}
-
-static int acpi_battery_set_alarm(struct acpi_battery *battery,
-				  unsigned long alarm)
+static int acpi_battery_set_alarm(struct acpi_battery *battery)
 {
 	acpi_status status = 0;
-	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
+	union acpi_object arg0 = { .type = ACPI_TYPE_INTEGER };
 	struct acpi_object_list arg_list = { 1, &arg0 };
 
-	if (!acpi_battery_present(battery))
-		return -ENODEV;
-
-	if (!battery->alarm_present)
+	if (!acpi_battery_present(battery)|| !battery->alarm_present)
 		return -ENODEV;
 
-	arg0.integer.value = alarm;
+	arg0.integer.value = battery->alarm;
 
 	mutex_lock(&battery->lock);
 	status = acpi_evaluate_object(battery->device->handle, "_BTP",
 				 &arg_list, NULL);
 	mutex_unlock(&battery->lock);
+
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Alarm set to %d\n", (u32) alarm));
-
-	battery->alarm = alarm;
-
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Alarm set to %d\n", battery->alarm));
 	return 0;
 }
 
@@ -293,7 +270,7 @@ static int acpi_battery_init_alarm(struct acpi_battery *battery)
 	battery->alarm_present = 1;
 	if (!battery->alarm)
 		battery->alarm = battery->design_capacity_warning;
-	return acpi_battery_set_alarm(battery, battery->alarm);
+	return acpi_battery_set_alarm(battery);
 }
 
 static int acpi_battery_update(struct acpi_battery *battery)
@@ -322,130 +299,101 @@ static struct proc_dir_entry *acpi_battery_dir;
 static int acpi_battery_print_info(struct seq_file *seq, int result)
 {
 	struct acpi_battery *battery = seq->private;
-	char *units = "?";
 
 	if (result)
 		goto end;
 
-	if (acpi_battery_present(battery))
-		seq_printf(seq, "present:                 yes\n");
-	else {
-		seq_printf(seq, "present:                 no\n");
+	seq_printf(seq, "present:                 %s\n",
+		   acpi_battery_present(battery)?"yes":"no");
+	if (!acpi_battery_present(battery))
 		goto end;
-	}
-
-	/* Battery Units */
-
-	units = acpi_battery_units(battery);
-
 	if (battery->design_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "design capacity:         unknown\n");
 	else
 		seq_printf(seq, "design capacity:         %d %sh\n",
-			   (u32) battery->design_capacity, units);
+			   battery->design_capacity,
+			   acpi_battery_units(battery));
 
 	if (battery->last_full_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "last full capacity:      unknown\n");
 	else
 		seq_printf(seq, "last full capacity:      %d %sh\n",
-			   (u32) battery->last_full_capacity, units);
-
-	switch ((u32) battery->technology) {
-	case 0:
-		seq_printf(seq, "battery technology:      non-rechargeable\n");
-		break;
-	case 1:
-		seq_printf(seq, "battery technology:      rechargeable\n");
-		break;
-	default:
-		seq_printf(seq, "battery technology:      unknown\n");
-		break;
-	}
+			   battery->last_full_capacity,
+			   acpi_battery_units(battery));
+
+	seq_printf(seq, "battery technology:      %srechargeable\n",
+		   (!battery->technology)?"non-":"");
 
 	if (battery->design_voltage == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "design voltage:          unknown\n");
 	else
 		seq_printf(seq, "design voltage:          %d mV\n",
-			   (u32) battery->design_voltage);
+			   battery->design_voltage);
 	seq_printf(seq, "design capacity warning: %d %sh\n",
-		   (u32) battery->design_capacity_warning, units);
+		   battery->design_capacity_warning,
+		   acpi_battery_units(battery));
 	seq_printf(seq, "design capacity low:     %d %sh\n",
-		   (u32) battery->design_capacity_low, units);
+		   battery->design_capacity_low,
+		   acpi_battery_units(battery));
 	seq_printf(seq, "capacity granularity 1:  %d %sh\n",
-		   (u32) battery->capacity_granularity_1, units);
+		   battery->capacity_granularity_1,
+		   acpi_battery_units(battery));
 	seq_printf(seq, "capacity granularity 2:  %d %sh\n",
-		   (u32) battery->capacity_granularity_2, units);
+		   battery->capacity_granularity_2,
+		   acpi_battery_units(battery));
 	seq_printf(seq, "model number:            %s\n", battery->model_number);
 	seq_printf(seq, "serial number:           %s\n", battery->serial_number);
 	seq_printf(seq, "battery type:            %s\n", battery->type);
 	seq_printf(seq, "OEM info:                %s\n", battery->oem_info);
-
       end:
-
 	if (result)
 		seq_printf(seq, "ERROR: Unable to read battery info\n");
-
 	return result;
 }
 
 static int acpi_battery_print_state(struct seq_file *seq, int result)
 {
 	struct acpi_battery *battery = seq->private;
-	char *units = "?";
 
 	if (result)
 		goto end;
 
-	if (acpi_battery_present(battery))
-		seq_printf(seq, "present:                 yes\n");
-	else {
-		seq_printf(seq, "present:                 no\n");
+	seq_printf(seq, "present:                 %s\n",
+		   acpi_battery_present(battery)?"yes":"no");
+	if (!acpi_battery_present(battery))
 		goto end;
-	}
-
-	/* Battery Units */
-
-	units = acpi_battery_units(battery);
 
-	if (!(battery->state & 0x04))
-		seq_printf(seq, "capacity state:          ok\n");
-	else
-		seq_printf(seq, "capacity state:          critical\n");
-
-	if ((battery->state & 0x01) && (battery->state & 0x02)) {
+	seq_printf(seq, "capacity state:          %s\n",
+			(battery->state & 0x04)?"critical":"ok");
+	if ((battery->state & 0x01) && (battery->state & 0x02))
 		seq_printf(seq,
 			   "charging state:          charging/discharging\n");
-	} else if (battery->state & 0x01)
+	else if (battery->state & 0x01)
 		seq_printf(seq, "charging state:          discharging\n");
 	else if (battery->state & 0x02)
 		seq_printf(seq, "charging state:          charging\n");
-	else {
+	else
 		seq_printf(seq, "charging state:          charged\n");
-	}
 
 	if (battery->present_rate == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "present rate:            unknown\n");
 	else
 		seq_printf(seq, "present rate:            %d %s\n",
-			   (u32) battery->present_rate, units);
+			   battery->present_rate, acpi_battery_units(battery));
 
 	if (battery->remaining_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "remaining capacity:      unknown\n");
 	else
 		seq_printf(seq, "remaining capacity:      %d %sh\n",
-			   (u32) battery->remaining_capacity, units);
-
+			   battery->remaining_capacity, acpi_battery_units(battery));
 	if (battery->present_voltage == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "present voltage:         unknown\n");
 	else
 		seq_printf(seq, "present voltage:         %d mV\n",
-			   (u32) battery->present_voltage);
-
+			   battery->present_voltage);
       end:
-
-	if (result) {
+	if (result)
 		seq_printf(seq, "ERROR: Unable to read battery state\n");
-	}
 
 	return result;
 }
@@ -453,7 +401,6 @@ static int acpi_battery_print_state(struct seq_file *seq, int result)
 static int acpi_battery_print_alarm(struct seq_file *seq, int result)
 {
 	struct acpi_battery *battery = seq->private;
-	char *units = "?";
 
 	if (result)
 		goto end;
@@ -462,22 +409,15 @@ static int acpi_battery_print_alarm(struct seq_file *seq, int result)
 		seq_printf(seq, "present:                 no\n");
 		goto end;
 	}
-
-	/* Battery Units */
-
-	units = acpi_battery_units(battery);
-
 	seq_printf(seq, "alarm:                   ");
 	if (!battery->alarm)
 		seq_printf(seq, "unsupported\n");
 	else
-		seq_printf(seq, "%u %sh\n", battery->alarm, units);
-
+		seq_printf(seq, "%u %sh\n", battery->alarm,
+				acpi_battery_units(battery));
       end:
-
 	if (result)
 		seq_printf(seq, "ERROR: Unable to read battery alarm\n");
-
 	return result;
 }
 
@@ -506,7 +446,7 @@ static ssize_t acpi_battery_write_alarm(struct file *file,
 	}
 	alarm_string[count] = '\0';
 	battery->alarm = simple_strtol(alarm_string, NULL, 0);
-	result = acpi_battery_set_alarm(battery, battery->alarm);
+	result = acpi_battery_set_alarm(battery);
       end:
 	if (!result)
 		return count;
@@ -514,95 +454,76 @@ static ssize_t acpi_battery_write_alarm(struct file *file,
 }
 
 typedef int(*print_func)(struct seq_file *seq, int result);
-typedef int(*get_func)(struct acpi_battery *battery);
-
-static struct acpi_read_mux {
-	print_func print;
-	get_func get;
-} acpi_read_funcs[ACPI_BATTERY_NUMFILES] = {
-	{.get = acpi_battery_get_info, .print = acpi_battery_print_info},
-	{.get = acpi_battery_get_state, .print = acpi_battery_print_state},
-	{.get = acpi_battery_get_alarm, .print = acpi_battery_print_alarm},
+
+static print_func acpi_print_funcs[ACPI_BATTERY_NUMFILES] = {
+	acpi_battery_print_info,
+	acpi_battery_print_state,
+	acpi_battery_print_alarm,
 };
 
 static int acpi_battery_read(int fid, struct seq_file *seq)
 {
 	struct acpi_battery *battery = seq->private;
 	int result = acpi_battery_update(battery);
-	return acpi_read_funcs[fid].print(seq, result);
-}
-
-static int acpi_battery_read_info(struct seq_file *seq, void *offset)
-{
-	return acpi_battery_read(ACPI_BATTERY_INFO, seq);
-}
-
-static int acpi_battery_read_state(struct seq_file *seq, void *offset)
-{
-	return acpi_battery_read(ACPI_BATTERY_STATE, seq);
-}
-
-static int acpi_battery_read_alarm(struct seq_file *seq, void *offset)
-{
-	return acpi_battery_read(ACPI_BATTERY_ALARM, seq);
+	return acpi_print_funcs[fid](seq, result);
 }
 
-static int acpi_battery_info_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_battery_read_info, PDE(inode)->data);
+#define DECLARE_FILE_FUNCTIONS(_name) \
+static int acpi_battery_read_##_name(struct seq_file *seq, void *offset) \
+{ \
+	return acpi_battery_read(_name##_tag, seq); \
+} \
+static int acpi_battery_##_name##_open_fs(struct inode *inode, struct file *file) \
+{ \
+	return single_open(file, acpi_battery_read_##_name, PDE(inode)->data); \
 }
 
-static int acpi_battery_state_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_battery_read_state, PDE(inode)->data);
-}
+DECLARE_FILE_FUNCTIONS(info);
+DECLARE_FILE_FUNCTIONS(state);
+DECLARE_FILE_FUNCTIONS(alarm);
+
+#undef DECLARE_FILE_FUNCTIONS
+
+#define FILE_DESCRIPTION_RO(_name) \
+	{ \
+	.name = __stringify(_name), \
+	.mode = S_IRUGO, \
+	.ops = { \
+		.open = acpi_battery_##_name##_open_fs, \
+		.read = seq_read, \
+		.llseek = seq_lseek, \
+		.release = single_release, \
+		.owner = THIS_MODULE, \
+		}, \
+	}
 
-static int acpi_battery_alarm_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_battery_read_alarm, PDE(inode)->data);
-}
+#define FILE_DESCRIPTION_RW(_name) \
+	{ \
+	.name = __stringify(_name), \
+	.mode = S_IFREG | S_IRUGO | S_IWUSR, \
+	.ops = { \
+		.open = acpi_battery_##_name##_open_fs, \
+		.read = seq_read, \
+		.llseek = seq_lseek, \
+		.write = acpi_battery_write_##_name, \
+		.release = single_release, \
+		.owner = THIS_MODULE, \
+		}, \
+	}
 
 static struct battery_file {
 	struct file_operations ops;
 	mode_t mode;
 	char *name;
 } acpi_battery_file[] = {
-	{
-	.name = "info",
-	.mode = S_IRUGO,
-	.ops = {
-	.open = acpi_battery_info_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-	},
-	},
-	{
-	.name = "state",
-	.mode = S_IRUGO,
-	.ops = {
-	.open = acpi_battery_state_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-	},
-	},
-	{
-	.name = "alarm",
-	.mode = S_IFREG | S_IRUGO | S_IWUSR,
-	.ops = {
-	.open = acpi_battery_alarm_open_fs,
-	.read = seq_read,
-	.write = acpi_battery_write_alarm,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-	},
-	},
+	FILE_DESCRIPTION_RO(info),
+	FILE_DESCRIPTION_RO(state),
+	FILE_DESCRIPTION_RW(alarm),
 };
 
+#undef FILE_DESCRIPTION_RO
+#undef FILE_DESCRIPTION_RW
+
 static int acpi_battery_add_fs(struct acpi_device *device)
 {
 	struct proc_dir_entry *entry = NULL;
@@ -627,23 +548,20 @@ static int acpi_battery_add_fs(struct acpi_device *device)
 			entry->owner = THIS_MODULE;
 		}
 	}
-
 	return 0;
 }
 
-static int acpi_battery_remove_fs(struct acpi_device *device)
+static void acpi_battery_remove_fs(struct acpi_device *device)
 {
 	int i;
-	if (acpi_device_dir(device)) {
-		for (i = 0; i < ACPI_BATTERY_NUMFILES; ++i) {
-			remove_proc_entry(acpi_battery_file[i].name,
+	if (!acpi_device_dir(device))
+		return;
+	for (i = 0; i < ACPI_BATTERY_NUMFILES; ++i)
+		remove_proc_entry(acpi_battery_file[i].name,
 				  acpi_device_dir(device));
-		}
-		remove_proc_entry(acpi_device_bid(device), acpi_battery_dir);
-		acpi_device_dir(device) = NULL;
-	}
 
-	return 0;
+	remove_proc_entry(acpi_device_bid(device), acpi_battery_dir);
+	acpi_device_dir(device) = NULL;
 }
 
 /* --------------------------------------------------------------------------
@@ -670,14 +588,11 @@ static int acpi_battery_add(struct acpi_device *device)
 	int result = 0;
 	acpi_status status = 0;
 	struct acpi_battery *battery = NULL;
-
 	if (!device)
 		return -EINVAL;
-
 	battery = kzalloc(sizeof(struct acpi_battery), GFP_KERNEL);
 	if (!battery)
 		return -ENOMEM;
-
 	battery->device = device;
 	strcpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
@@ -687,7 +602,6 @@ static int acpi_battery_add(struct acpi_device *device)
 	result = acpi_battery_add_fs(device);
 	if (result)
 		goto end;
-
 	status = acpi_install_notify_handler(device->handle,
 					     ACPI_ALL_NOTIFY,
 					     acpi_battery_notify, battery);
@@ -696,18 +610,14 @@ static int acpi_battery_add(struct acpi_device *device)
 		result = -ENODEV;
 		goto end;
 	}
-
 	printk(KERN_INFO PREFIX "%s Slot [%s] (battery %s)\n",
 	       ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
 	       device->status.battery_present ? "present" : "absent");
-
       end:
-
 	if (result) {
 		acpi_battery_remove_fs(device);
 		kfree(battery);
 	}
-
 	return result;
 }
 
@@ -718,17 +628,13 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
 
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
-
 	battery = acpi_driver_data(device);
-
 	status = acpi_remove_notify_handler(device->handle,
 					    ACPI_ALL_NOTIFY,
 					    acpi_battery_notify);
-
 	acpi_battery_remove_fs(device);
 	mutex_destroy(&battery->lock);
 	kfree(battery);
-
 	return 0;
 }
 
@@ -743,33 +649,35 @@ static int acpi_battery_resume(struct acpi_device *device)
 	return 0;
 }
 
+static struct acpi_driver acpi_battery_driver = {
+	.name = "battery",
+	.class = ACPI_BATTERY_CLASS,
+	.ids = battery_device_ids,
+	.ops = {
+		.add = acpi_battery_add,
+		.resume = acpi_battery_resume,
+		.remove = acpi_battery_remove,
+		},
+};
+
 static int __init acpi_battery_init(void)
 {
-	int result;
-
 	if (acpi_disabled)
 		return -ENODEV;
-
 	acpi_battery_dir = acpi_lock_battery_dir();
 	if (!acpi_battery_dir)
 		return -ENODEV;
-
-	result = acpi_bus_register_driver(&acpi_battery_driver);
-	if (result < 0) {
+	if (acpi_bus_register_driver(&acpi_battery_driver) < 0) {
 		acpi_unlock_battery_dir(acpi_battery_dir);
 		return -ENODEV;
 	}
-
 	return 0;
 }
 
 static void __exit acpi_battery_exit(void)
 {
 	acpi_bus_unregister_driver(&acpi_battery_driver);
-
 	acpi_unlock_battery_dir(acpi_battery_dir);
-
-	return;
 }
 
 module_init(acpi_battery_init);
-- 
1.5.3.1.27.g57543
