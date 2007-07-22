From: Len Brown <len.brown@intel.com>
Subject: [PATCH 03/77] ACPI: battery: Lindent
Date: Sun, 22 Jul 2007 05:13:48 -0400
Message-ID: <11850957053842-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54665 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761916AbXGVJPH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:07 -0400
In-Reply-To: <11850957043270-git-send-email-len.brown@intel.com>
Message-Id: <9ea7d57576f40c6af03c8c9fa7a069f2222b498b.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Vladimir Lebedev <vladimir.p.lebedev@intel.com>, Len Brown <len.brown@intel.com>

From: Vladimir Lebedev <vladimir.p.lebedev@intel.com>

Signed-off-by: Vladimir Lebedev <vladimir.p.lebedev@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |   36 +++++++++++++++++++++++-------------
 1 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index f3b0024..fc9c50a 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -123,7 +123,7 @@ struct acpi_battery_flags {
 
 struct acpi_battery {
 	struct mutex mutex;
-	struct acpi_device * device;
+	struct acpi_device *device;
 	struct acpi_battery_flags flags;
 	struct acpi_buffer bif_data;
 	struct acpi_buffer bst_data;
@@ -241,7 +241,9 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 
 	/* Evalute _BIF */
 
-	status = acpi_evaluate_object(acpi_battery_handle(battery), "_BIF", NULL, &buffer);
+	status =
+	    acpi_evaluate_object(acpi_battery_handle(battery), "_BIF", NULL,
+				 &buffer);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BIF"));
 		return -ENODEV;
@@ -253,7 +255,9 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 
 	/* Extract Package Data */
 
-	result = acpi_battery_extract_package(battery, package, &format, data, "_BIF");
+	result =
+	    acpi_battery_extract_package(battery, package, &format, data,
+					 "_BIF");
 	if (result)
 		goto end;
 
@@ -289,7 +293,9 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 
 	/* Evalute _BST */
 
-	status = acpi_evaluate_object(acpi_battery_handle(battery), "_BST", NULL, &buffer);
+	status =
+	    acpi_evaluate_object(acpi_battery_handle(battery), "_BST", NULL,
+				 &buffer);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BST"));
 		return -ENODEV;
@@ -301,7 +307,9 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 
 	/* Extract Package Data */
 
-	result = acpi_battery_extract_package(battery, package, &format, data, "_BST");
+	result =
+	    acpi_battery_extract_package(battery, package, &format, data,
+					 "_BST");
 	if (result)
 		goto end;
 
@@ -320,7 +328,8 @@ static int acpi_battery_get_alarm(struct acpi_battery *battery)
 	return 0;
 }
 
-static int acpi_battery_set_alarm(struct acpi_battery *battery, unsigned long alarm)
+static int acpi_battery_set_alarm(struct acpi_battery *battery,
+				  unsigned long alarm)
 {
 	acpi_status status = 0;
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
@@ -336,7 +345,9 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery, unsigned long al
 
 	arg0.integer.value = alarm;
 
-	status = acpi_evaluate_object(acpi_battery_handle(battery), "_BTP", &arg_list, NULL);
+	status =
+	    acpi_evaluate_object(acpi_battery_handle(battery), "_BTP",
+				 &arg_list, NULL);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -400,7 +411,7 @@ static int acpi_battery_init_update(struct acpi_battery *battery)
 }
 
 static int acpi_battery_update(struct acpi_battery *battery,
-			   int update, int *update_result_ptr)
+			       int update, int *update_result_ptr)
 {
 	int result = 0;
 	int update_result = ACPI_BATTERY_NONE_UPDATE;
@@ -418,7 +429,8 @@ static int acpi_battery_update(struct acpi_battery *battery,
 		result = acpi_battery_get_status(battery);
 		if (result)
 			goto end;;
-		if (acpi_battery_inserted(battery) || acpi_battery_removed(battery)) {
+		if (acpi_battery_inserted(battery)
+		    || acpi_battery_removed(battery)) {
 			result = acpi_battery_init_update(battery);
 			if (result)
 				goto end;;
@@ -770,7 +782,6 @@ acpi_battery_write_alarm(struct file *file,
 	struct acpi_battery *battery = m->private;
 	int update_result = ACPI_BATTERY_NONE_UPDATE;
 
-
 	if (!battery || (count > sizeof(alarm_string) - 1))
 		return -EINVAL;
 
@@ -845,7 +856,6 @@ static int acpi_battery_add_fs(struct acpi_device *device)
 {
 	struct proc_dir_entry *entry = NULL;
 
-
 	if (!acpi_device_dir(device)) {
 		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
 						     acpi_battery_dir);
@@ -917,7 +927,6 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 	struct acpi_battery *battery = data;
 	struct acpi_device *device = NULL;
 
-
 	if (!battery)
 		return;
 
@@ -932,7 +941,8 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 		device = battery->device;
 		acpi_battery_notify_update(battery);
 		acpi_battery_mutex_unlock(battery);
-		acpi_bus_generate_event(device, event, acpi_battery_present(battery));
+		acpi_bus_generate_event(device, event,
+					acpi_battery_present(battery));
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-- 
1.5.3.rc2.22.g69a9b
