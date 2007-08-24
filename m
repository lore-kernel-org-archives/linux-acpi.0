From: Len Brown <len.brown@intel.com>
Subject: [PATCH 03/25] Revert "ACPI: Battery: Synchronize battery operations."
Date: Fri, 24 Aug 2007 03:20:50 -0400
Message-ID: <11879400793131-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
 <11879400782033-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56620 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762486AbXHXHVU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:20 -0400
In-Reply-To: <11879400782033-git-send-email-len.brown@intel.com>
Message-Id: <5b31d895874f56174e4d885c065c9fc4b24b28bb.1187939442.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

This reverts commit 3bd92ba19a89fe61ebf58804f9c8675372f50c1c.

It is no longer necessary, and it opens up a race.

Acked-by: Vladimir Lebedev <vladimir.p.lebedev@gmail.com>
Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |   47 ++++++++++++++++++++++++++++++-----------------
 1 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index d7b499f..8165103 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -113,7 +113,7 @@ struct acpi_battery_info {
 	acpi_string oem_info;
 };
 
-enum acpi_battery_files {
+enum acpi_battery_files{
 	ACPI_BATTERY_INFO = 0,
 	ACPI_BATTERY_STATE,
 	ACPI_BATTERY_ALARM,
@@ -129,14 +129,13 @@ struct acpi_battery_flags {
 };
 
 struct acpi_battery {
+	struct mutex mutex;
 	struct acpi_device *device;
 	struct acpi_battery_flags flags;
 	struct acpi_buffer bif_data;
 	struct acpi_buffer bst_data;
-	struct mutex lock;
 	unsigned long alarm;
 	unsigned long update_time[ACPI_BATTERY_NUMFILES];
-
 };
 
 inline int acpi_battery_present(struct acpi_battery *battery)
@@ -236,10 +235,10 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 		return 0;
 
 	/* Evaluate _BIF */
-	mutex_lock(&battery->lock);
-	status = acpi_evaluate_object(acpi_battery_handle(battery), "_BIF",
-				      NULL, &buffer);
-	mutex_unlock(&battery->lock);
+
+	status =
+	    acpi_evaluate_object(acpi_battery_handle(battery), "_BIF", NULL,
+				 &buffer);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BIF"));
 		return -ENODEV;
@@ -286,10 +285,10 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 		return 0;
 
 	/* Evaluate _BST */
-	mutex_lock(&battery->lock);
-	status = acpi_evaluate_object(acpi_battery_handle(battery), "_BST",
-				      NULL, &buffer);
-	mutex_unlock(&battery->lock);
+
+	status =
+	    acpi_evaluate_object(acpi_battery_handle(battery), "_BST", NULL,
+				 &buffer);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BST"));
 		return -ENODEV;
@@ -337,10 +336,9 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery,
 
 	arg0.integer.value = alarm;
 
-	mutex_lock(&battery->lock);
-	status = acpi_evaluate_object(acpi_battery_handle(battery), "_BTP",
+	status =
+	    acpi_evaluate_object(acpi_battery_handle(battery), "_BTP",
 				 &arg_list, NULL);
-	mutex_unlock(&battery->lock);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -660,6 +658,8 @@ acpi_battery_write_alarm(struct file *file,
 	if (!battery || (count > sizeof(alarm_string) - 1))
 		return -EINVAL;
 
+	mutex_lock(&battery->mutex);
+
 	result = acpi_battery_update(battery, 1, &update_result);
 	if (result) {
 		result = -ENODEV;
@@ -688,7 +688,9 @@ acpi_battery_write_alarm(struct file *file,
 	acpi_battery_check_result(battery, result);
 
 	if (!result)
-		return count;
+		result = count;
+
+	mutex_unlock(&battery->mutex);
 
 	return result;
 }
@@ -712,6 +714,8 @@ static int acpi_battery_read(int fid, struct seq_file *seq)
 	int update_result = ACPI_BATTERY_NONE_UPDATE;
 	int update = 0;
 
+	mutex_lock(&battery->mutex);
+
 	update = (get_seconds() - battery->update_time[fid] >= update_time);
 	update = (update | battery->flags.update[fid]);
 
@@ -729,6 +733,7 @@ static int acpi_battery_read(int fid, struct seq_file *seq)
 	result = acpi_read_funcs[fid].print(seq, result);
 	acpi_battery_check_result(battery, result);
 	battery->flags.update[fid] = result;
+	mutex_unlock(&battery->mutex);
 	return result;
 }
 
@@ -892,7 +897,10 @@ static int acpi_battery_add(struct acpi_device *device)
 	if (!battery)
 		return -ENOMEM;
 
-	mutex_init(&battery->lock);
+	mutex_init(&battery->mutex);
+
+	mutex_lock(&battery->mutex);
+
 	battery->device = device;
 	strcpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
@@ -928,6 +936,7 @@ static int acpi_battery_add(struct acpi_device *device)
 		kfree(battery);
 	}
 
+	mutex_unlock(&battery->mutex);
 
 	return result;
 }
@@ -942,6 +951,8 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
 
 	battery = acpi_driver_data(device);
 
+	mutex_lock(&battery->mutex);
+
 	status = acpi_remove_notify_handler(device->handle,
 					    ACPI_ALL_NOTIFY,
 					    acpi_battery_notify);
@@ -952,7 +963,9 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
 
 	kfree(battery->bst_data.pointer);
 
-	mutex_destroy(&battery->lock);
+	mutex_unlock(&battery->mutex);
+
+	mutex_destroy(&battery->mutex);
 
 	kfree(battery);
 
-- 
1.5.3.rc6.17.g1911
