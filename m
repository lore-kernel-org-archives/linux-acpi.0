From: Len Brown <len.brown@intel.com>
Subject: [PATCH 09/12] ACPI: Battery: Synchronize battery operations.
Date: Fri,  3 Aug 2007 18:33:42 -0400
Message-ID: <11861804344148-git-send-email-len.brown@intel.com>
References: <11861804251625-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28479 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763845AbXHCWdz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Aug 2007 18:33:55 -0400
In-Reply-To: <11861804251625-git-send-email-len.brown@intel.com>
Message-Id: <3bd92ba19a89fe61ebf58804f9c8675372f50c1c.1186180370.git.len.brown@intel.com>
In-Reply-To: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
References: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikivskiy@suse.de>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikivskiy@suse.de>

http://bugzilla.kernel.org/show_bug.cgi?id=8768

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |   47 +++++++++++++++++------------------------------
 1 files changed, 17 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 8165103..d7b499f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -113,7 +113,7 @@ struct acpi_battery_info {
 	acpi_string oem_info;
 };
 
-enum acpi_battery_files{
+enum acpi_battery_files {
 	ACPI_BATTERY_INFO = 0,
 	ACPI_BATTERY_STATE,
 	ACPI_BATTERY_ALARM,
@@ -129,13 +129,14 @@ struct acpi_battery_flags {
 };
 
 struct acpi_battery {
-	struct mutex mutex;
 	struct acpi_device *device;
 	struct acpi_battery_flags flags;
 	struct acpi_buffer bif_data;
 	struct acpi_buffer bst_data;
+	struct mutex lock;
 	unsigned long alarm;
 	unsigned long update_time[ACPI_BATTERY_NUMFILES];
+
 };
 
 inline int acpi_battery_present(struct acpi_battery *battery)
@@ -235,10 +236,10 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 		return 0;
 
 	/* Evaluate _BIF */
-
-	status =
-	    acpi_evaluate_object(acpi_battery_handle(battery), "_BIF", NULL,
-				 &buffer);
+	mutex_lock(&battery->lock);
+	status = acpi_evaluate_object(acpi_battery_handle(battery), "_BIF",
+				      NULL, &buffer);
+	mutex_unlock(&battery->lock);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BIF"));
 		return -ENODEV;
@@ -285,10 +286,10 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 		return 0;
 
 	/* Evaluate _BST */
-
-	status =
-	    acpi_evaluate_object(acpi_battery_handle(battery), "_BST", NULL,
-				 &buffer);
+	mutex_lock(&battery->lock);
+	status = acpi_evaluate_object(acpi_battery_handle(battery), "_BST",
+				      NULL, &buffer);
+	mutex_unlock(&battery->lock);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BST"));
 		return -ENODEV;
@@ -336,9 +337,10 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery,
 
 	arg0.integer.value = alarm;
 
-	status =
-	    acpi_evaluate_object(acpi_battery_handle(battery), "_BTP",
+	mutex_lock(&battery->lock);
+	status = acpi_evaluate_object(acpi_battery_handle(battery), "_BTP",
 				 &arg_list, NULL);
+	mutex_unlock(&battery->lock);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -658,8 +660,6 @@ acpi_battery_write_alarm(struct file *file,
 	if (!battery || (count > sizeof(alarm_string) - 1))
 		return -EINVAL;
 
-	mutex_lock(&battery->mutex);
-
 	result = acpi_battery_update(battery, 1, &update_result);
 	if (result) {
 		result = -ENODEV;
@@ -688,9 +688,7 @@ acpi_battery_write_alarm(struct file *file,
 	acpi_battery_check_result(battery, result);
 
 	if (!result)
-		result = count;
-
-	mutex_unlock(&battery->mutex);
+		return count;
 
 	return result;
 }
@@ -714,8 +712,6 @@ static int acpi_battery_read(int fid, struct seq_file *seq)
 	int update_result = ACPI_BATTERY_NONE_UPDATE;
 	int update = 0;
 
-	mutex_lock(&battery->mutex);
-
 	update = (get_seconds() - battery->update_time[fid] >= update_time);
 	update = (update | battery->flags.update[fid]);
 
@@ -733,7 +729,6 @@ static int acpi_battery_read(int fid, struct seq_file *seq)
 	result = acpi_read_funcs[fid].print(seq, result);
 	acpi_battery_check_result(battery, result);
 	battery->flags.update[fid] = result;
-	mutex_unlock(&battery->mutex);
 	return result;
 }
 
@@ -897,10 +892,7 @@ static int acpi_battery_add(struct acpi_device *device)
 	if (!battery)
 		return -ENOMEM;
 
-	mutex_init(&battery->mutex);
-
-	mutex_lock(&battery->mutex);
-
+	mutex_init(&battery->lock);
 	battery->device = device;
 	strcpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
@@ -936,7 +928,6 @@ static int acpi_battery_add(struct acpi_device *device)
 		kfree(battery);
 	}
 
-	mutex_unlock(&battery->mutex);
 
 	return result;
 }
@@ -951,8 +942,6 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
 
 	battery = acpi_driver_data(device);
 
-	mutex_lock(&battery->mutex);
-
 	status = acpi_remove_notify_handler(device->handle,
 					    ACPI_ALL_NOTIFY,
 					    acpi_battery_notify);
@@ -963,9 +952,7 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
 
 	kfree(battery->bst_data.pointer);
 
-	mutex_unlock(&battery->mutex);
-
-	mutex_destroy(&battery->mutex);
+	mutex_destroy(&battery->lock);
 
 	kfree(battery);
 
-- 
1.5.3.rc3.7.gd58e
