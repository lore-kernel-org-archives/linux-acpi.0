From: Len Brown <lenb@kernel.org>
Subject: [PATCH 21/37] ACPI: Battery: simplify update scheme
Date: Wed, 10 Oct 2007 01:06:28 -0400
Message-ID: <1191992804-14965-22-git-send-email-lenb@kernel.org>
References: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:57266 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751165AbXJJFHB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Oct 2007 01:07:01 -0400
In-Reply-To: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Message-Id: <f1d4661abe05d0a2c014166042d15ed8b69ae8f2.1191992584.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |  280 ++++++++++--------------------------------------
 1 files changed, 57 insertions(+), 223 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index de506f3..faa70a5 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/jiffies.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
@@ -41,27 +42,18 @@
 #define ACPI_BATTERY_DEVICE_NAME	"Battery"
 #define ACPI_BATTERY_NOTIFY_STATUS	0x80
 #define ACPI_BATTERY_NOTIFY_INFO	0x81
-#define ACPI_BATTERY_UNITS_WATTS	"mW"
-#define ACPI_BATTERY_UNITS_AMPS		"mA"
 
 #define _COMPONENT		ACPI_BATTERY_COMPONENT
 
-#define ACPI_BATTERY_UPDATE_TIME	0
-
-#define ACPI_BATTERY_NONE_UPDATE	0
-#define ACPI_BATTERY_EASY_UPDATE	1
-#define ACPI_BATTERY_INIT_UPDATE	2
-
 ACPI_MODULE_NAME("battery");
 
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Battery Driver");
 MODULE_LICENSE("GPL");
 
-static unsigned int update_time = ACPI_BATTERY_UPDATE_TIME;
-
-/* 0 - every time, > 0 - by update_time */
-module_param(update_time, uint, 0644);
+static unsigned int cache_time = 1000;
+module_param(cache_time, uint, 0644);
+MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
 
 extern struct proc_dir_entry *acpi_lock_battery_dir(void);
 extern void *acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
@@ -95,15 +87,12 @@ enum acpi_battery_files {
 };
 
 struct acpi_battery {
-	struct acpi_device *device;
 	struct mutex lock;
-	unsigned long alarm;
-	unsigned long update_time[ACPI_BATTERY_NUMFILES];
-	int state;
+	struct acpi_device *device;
+	unsigned long update_time;
 	int present_rate;
 	int remaining_capacity;
 	int present_voltage;
-	int power_unit;
 	int design_capacity;
 	int last_full_capacity;
 	int technology;
@@ -112,14 +101,14 @@ struct acpi_battery {
 	int design_capacity_low;
 	int capacity_granularity_1;
 	int capacity_granularity_2;
+	int alarm;
 	char model_number[32];
 	char serial_number[32];
 	char type[32];
 	char oem_info[32];
-	u8 present_prev;
+	int state;
+	int power_unit;
 	u8 alarm_present;
-	u8 init_update;
-	u8 update[ACPI_BATTERY_NUMFILES];
 };
 
 inline int acpi_battery_present(struct acpi_battery *battery)
@@ -127,33 +116,15 @@ inline int acpi_battery_present(struct acpi_battery *battery)
 	return battery->device->status.battery_present;
 }
 
-inline char *acpi_battery_power_units(struct acpi_battery *battery)
+inline char *acpi_battery_units(struct acpi_battery *battery)
 {
-	if (battery->power_unit)
-		return ACPI_BATTERY_UNITS_AMPS;
-	else
-		return ACPI_BATTERY_UNITS_WATTS;
-}
-
-inline acpi_handle acpi_battery_handle(struct acpi_battery *battery)
-{
-	return battery->device->handle;
+	return (battery->power_unit)?"mA":"mW";
 }
 
 /* --------------------------------------------------------------------------
                                Battery Management
    -------------------------------------------------------------------------- */
 
-static void acpi_battery_check_result(struct acpi_battery *battery, int result)
-{
-	if (!battery)
-		return;
-
-	if (result) {
-		battery->init_update = 1;
-	}
-}
-
 struct acpi_offsets {
 	size_t offset;		/* offset inside struct acpi_sbs_battery */
 	u8 mode;		/* int or string? */
@@ -228,11 +199,10 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
-	battery->update_time[ACPI_BATTERY_INFO] = get_seconds();
 	if (!acpi_battery_present(battery))
 		return 0;
 	mutex_lock(&battery->lock);
-	status = acpi_evaluate_object(acpi_battery_handle(battery), "_BIF",
+	status = acpi_evaluate_object(battery->device->handle, "_BIF",
 				      NULL, &buffer);
 	mutex_unlock(&battery->lock);
 	if (ACPI_FAILURE(status)) {
@@ -251,13 +221,16 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
-	battery->update_time[ACPI_BATTERY_STATE] = get_seconds();
-
 	if (!acpi_battery_present(battery))
 		return 0;
 
+	if (battery->update_time &&
+	    time_before(jiffies, battery->update_time +
+			msecs_to_jiffies(cache_time)))
+		return 0;
+
 	mutex_lock(&battery->lock);
-	status = acpi_evaluate_object(acpi_battery_handle(battery), "_BST",
+	status = acpi_evaluate_object(battery->device->handle, "_BST",
 				      NULL, &buffer);
 	mutex_unlock(&battery->lock);
 
@@ -267,14 +240,13 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	}
 	result = extract_package(battery, buffer.pointer,
 				 state_offsets, ARRAY_SIZE(state_offsets));
+	battery->update_time = jiffies;
 	kfree(buffer.pointer);
 	return result;
 }
 
 static int acpi_battery_get_alarm(struct acpi_battery *battery)
 {
-	battery->update_time[ACPI_BATTERY_ALARM] = get_seconds();
-
 	return 0;
 }
 
@@ -285,8 +257,6 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery,
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list arg_list = { 1, &arg0 };
 
-	battery->update_time[ACPI_BATTERY_ALARM] = get_seconds();
-
 	if (!acpi_battery_present(battery))
 		return -ENODEV;
 
@@ -296,8 +266,8 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery,
 	arg0.integer.value = alarm;
 
 	mutex_lock(&battery->lock);
-	status = acpi_evaluate_object(acpi_battery_handle(battery), "_BTP",
-				      &arg_list, NULL);
+	status = acpi_evaluate_object(battery->device->handle, "_BTP",
+				 &arg_list, NULL);
 	mutex_unlock(&battery->lock);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
@@ -311,112 +281,36 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery,
 
 static int acpi_battery_init_alarm(struct acpi_battery *battery)
 {
-	int result = 0;
 	acpi_status status = AE_OK;
 	acpi_handle handle = NULL;
-	unsigned long alarm = battery->alarm;
 
 	/* See if alarms are supported, and if so, set default */
-
-	status = acpi_get_handle(acpi_battery_handle(battery), "_BTP", &handle);
-	if (ACPI_SUCCESS(status)) {
-		battery->alarm_present = 1;
-		if (!alarm) {
-			alarm = battery->design_capacity_warning;
-		}
-		result = acpi_battery_set_alarm(battery, alarm);
-		if (result)
-			goto end;
-	} else {
+	status = acpi_get_handle(battery->device->handle, "_BTP", &handle);
+	if (ACPI_FAILURE(status)) {
 		battery->alarm_present = 0;
+		return 0;
 	}
-
-      end:
-
-	return result;
+	battery->alarm_present = 1;
+	if (!battery->alarm)
+		battery->alarm = battery->design_capacity_warning;
+	return acpi_battery_set_alarm(battery, battery->alarm);
 }
 
-static int acpi_battery_init_update(struct acpi_battery *battery)
+static int acpi_battery_update(struct acpi_battery *battery)
 {
-	int result = 0;
-
-	result = acpi_battery_get_status(battery);
-	if (result)
+	int saved_present = acpi_battery_present(battery);
+	int result = acpi_battery_get_status(battery);
+	if (result || !acpi_battery_present(battery))
 		return result;
-
-	battery->present_prev = acpi_battery_present(battery);
-
-	if (acpi_battery_present(battery)) {
+	if (saved_present != acpi_battery_present(battery) ||
+	    !battery->update_time) {
+		battery->update_time = 0;
 		result = acpi_battery_get_info(battery);
 		if (result)
 			return result;
-		result = acpi_battery_get_state(battery);
-		if (result)
-			return result;
-
 		acpi_battery_init_alarm(battery);
 	}
-
-	return result;
-}
-
-static int acpi_battery_update(struct acpi_battery *battery,
-			       int update, int *update_result_ptr)
-{
-	int result = 0;
-	int update_result = ACPI_BATTERY_NONE_UPDATE;
-
-	if (!acpi_battery_present(battery)) {
-		update = 1;
-	}
-
-	if (battery->init_update) {
-		result = acpi_battery_init_update(battery);
-		if (result)
-			goto end;
-		update_result = ACPI_BATTERY_INIT_UPDATE;
-	} else if (update) {
-		result = acpi_battery_get_status(battery);
-		if (result)
-			goto end;
-		if ((!battery->present_prev & acpi_battery_present(battery))
-		    || (battery->present_prev & !acpi_battery_present(battery))) {
-			result = acpi_battery_init_update(battery);
-			if (result)
-				goto end;
-			update_result = ACPI_BATTERY_INIT_UPDATE;
-		} else {
-			update_result = ACPI_BATTERY_EASY_UPDATE;
-		}
-	}
-
-      end:
-
-	battery->init_update = (result != 0);
-
-	*update_result_ptr = update_result;
-
-	return result;
-}
-
-static void acpi_battery_notify_update(struct acpi_battery *battery)
-{
-	acpi_battery_get_status(battery);
-
-	if (battery->init_update) {
-		return;
-	}
-
-	if ((!battery->present_prev &
-	     acpi_battery_present(battery)) ||
-	    (battery->present_prev &
-	     !acpi_battery_present(battery))) {
-		battery->init_update = 1;
-	} else {
-		battery->update[ACPI_BATTERY_INFO] = 1;
-		battery->update[ACPI_BATTERY_STATE] = 1;
-		battery->update[ACPI_BATTERY_ALARM] = 1;
-	}
+	return acpi_battery_get_state(battery);
 }
 
 /* --------------------------------------------------------------------------
@@ -442,7 +336,7 @@ static int acpi_battery_print_info(struct seq_file *seq, int result)
 
 	/* Battery Units */
 
-	units = acpi_battery_power_units(battery);
+	units = acpi_battery_units(battery);
 
 	if (battery->design_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "design capacity:         unknown\n");
@@ -511,7 +405,7 @@ static int acpi_battery_print_state(struct seq_file *seq, int result)
 
 	/* Battery Units */
 
-	units = acpi_battery_power_units(battery);
+	units = acpi_battery_units(battery);
 
 	if (!(battery->state & 0x04))
 		seq_printf(seq, "capacity state:          ok\n");
@@ -571,13 +465,13 @@ static int acpi_battery_print_alarm(struct seq_file *seq, int result)
 
 	/* Battery Units */
 
-	units = acpi_battery_power_units(battery);
+	units = acpi_battery_units(battery);
 
 	seq_printf(seq, "alarm:                   ");
 	if (!battery->alarm)
 		seq_printf(seq, "unsupported\n");
 	else
-		seq_printf(seq, "%lu %sh\n", battery->alarm, units);
+		seq_printf(seq, "%u %sh\n", battery->alarm, units);
 
       end:
 
@@ -587,49 +481,35 @@ static int acpi_battery_print_alarm(struct seq_file *seq, int result)
 	return result;
 }
 
-static ssize_t
-acpi_battery_write_alarm(struct file *file,
-			 const char __user * buffer,
-			 size_t count, loff_t * ppos)
+static ssize_t acpi_battery_write_alarm(struct file *file,
+					const char __user * buffer,
+					size_t count, loff_t * ppos)
 {
 	int result = 0;
 	char alarm_string[12] = { '\0' };
 	struct seq_file *m = file->private_data;
 	struct acpi_battery *battery = m->private;
-	int update_result = ACPI_BATTERY_NONE_UPDATE;
 
 	if (!battery || (count > sizeof(alarm_string) - 1))
 		return -EINVAL;
-
-	result = acpi_battery_update(battery, 1, &update_result);
 	if (result) {
 		result = -ENODEV;
 		goto end;
 	}
-
 	if (!acpi_battery_present(battery)) {
 		result = -ENODEV;
 		goto end;
 	}
-
 	if (copy_from_user(alarm_string, buffer, count)) {
 		result = -EFAULT;
 		goto end;
 	}
-
 	alarm_string[count] = '\0';
-
-	result = acpi_battery_set_alarm(battery,
-					simple_strtoul(alarm_string, NULL, 0));
-	if (result)
-		goto end;
-
+	battery->alarm = simple_strtol(alarm_string, NULL, 0);
+	result = acpi_battery_set_alarm(battery, battery->alarm);
       end:
-
-	acpi_battery_check_result(battery, result);
-
 	if (!result)
-		result = count;
+		return count;
 	return result;
 }
 
@@ -648,28 +528,8 @@ static struct acpi_read_mux {
 static int acpi_battery_read(int fid, struct seq_file *seq)
 {
 	struct acpi_battery *battery = seq->private;
-	int result = 0;
-	int update_result = ACPI_BATTERY_NONE_UPDATE;
-	int update = 0;
-
-	update = (get_seconds() - battery->update_time[fid] >= update_time);
-	update = (update | battery->update[fid]);
-
-	result = acpi_battery_update(battery, update, &update_result);
-	if (result)
-		goto end;
-
-	if (update_result == ACPI_BATTERY_EASY_UPDATE) {
-		result = acpi_read_funcs[fid].get(battery);
-		if (result)
-			goto end;
-	}
-
-      end:
-	result = acpi_read_funcs[fid].print(seq, result);
-	acpi_battery_check_result(battery, result);
-	battery->update[fid] = result;
-	return result;
+	int result = acpi_battery_update(battery);
+	return acpi_read_funcs[fid].print(seq, result);
 }
 
 static int acpi_battery_read_info(struct seq_file *seq, void *offset)
@@ -793,33 +653,16 @@ static int acpi_battery_remove_fs(struct acpi_device *device)
 static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_battery *battery = data;
-	struct acpi_device *device = NULL;
-
+	struct acpi_device *device;
 	if (!battery)
 		return;
-
 	device = battery->device;
-
-	switch (event) {
-	case ACPI_BATTERY_NOTIFY_STATUS:
-	case ACPI_BATTERY_NOTIFY_INFO:
-	case ACPI_NOTIFY_BUS_CHECK:
-	case ACPI_NOTIFY_DEVICE_CHECK:
-		device = battery->device;
-		acpi_battery_notify_update(battery);
-		acpi_bus_generate_proc_event(device, event,
+	acpi_battery_update(battery);
+	acpi_bus_generate_proc_event(device, event,
+				     acpi_battery_present(battery));
+	acpi_bus_generate_netlink_event(device->pnp.device_class,
+					device->dev.bus_id, event,
 					acpi_battery_present(battery));
-		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  device->dev.bus_id, event,
-						  acpi_battery_present(battery));
-		break;
-	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
-		break;
-	}
-
-	return;
 }
 
 static int acpi_battery_add(struct acpi_device *device)
@@ -840,12 +683,7 @@ static int acpi_battery_add(struct acpi_device *device)
 	strcpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
 	acpi_driver_data(device) = battery;
 	mutex_init(&battery->lock);
-	result = acpi_battery_get_status(battery);
-	if (result)
-		goto end;
-
-	battery->init_update = 1;
-
+	acpi_battery_update(battery);
 	result = acpi_battery_add_fs(device);
 	if (result)
 		goto end;
@@ -898,14 +736,10 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
 static int acpi_battery_resume(struct acpi_device *device)
 {
 	struct acpi_battery *battery;
-
 	if (!device)
 		return -EINVAL;
-
-	battery = device->driver_data;
-
-	battery->init_update = 1;
-
+	battery = acpi_driver_data(device);
+	battery->update_time = 0;
 	return 0;
 }
 
-- 
1.5.3.4.206.g58ba4
