From: Len Brown <lenb@kernel.org>
Subject: [PATCH 098/122] ACPI: replace ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 ...) with printk
Date: Thu, 23 Oct 2008 02:39:12 -0400
Message-ID: <55ac9a018f83e4f42f3c6ce98a8dbda73b985935.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:37959 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424AbYJWGk1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:27 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600ESLIJ5Q4G7@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:18 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

ACPI_DB_ERROR and ACPI_DB_WARN were removed from ACPICA core.
So replace ACPI_DEBUG_PRINT((ACPI_DB_ERROR, ...) with printk(KERN_ERR PREFIX ...)
and ACPI_DEBUG_PRINT((ACPI_DB_WARN, ...) with printk(KERN_WARNING PREFIX ...)

We do not use ACPI_ERROR/ACPI_WARNING since they're not exported, see
-------------------------------------------------------------
commit 6468463abd7051fcc29f3ee7c931f9bbbb26f5a4
Author: Len Brown <len.brown@intel.com>
Date:   Mon Jun 26 23:41:38 2006 -0400

    ACPI: un-export ACPI_ERROR() -- use printk(KERN_ERR...)

    Signed-off-by: Len Brown <len.brown@intel.com>
-------------------------------------------------------------

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpi_memhotplug.c      |    4 ++--
 drivers/acpi/cm_sbs.c               |    8 ++++----
 drivers/acpi/fan.c                  |    4 ++--
 drivers/acpi/osl.c                  |    4 ++--
 drivers/acpi/processor_perflib.c    |   10 +++++-----
 drivers/acpi/processor_throttling.c |   10 +++++-----
 drivers/acpi/scan.c                 |   10 +++++-----
 drivers/acpi/system.c               |    4 ++--
 drivers/acpi/thermal.c              |    4 ++--
 drivers/acpi/video.c                |   12 ++++++------
 10 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 5f1127a..bbad9b6 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -454,8 +454,8 @@ static int acpi_memory_device_start (struct acpi_device *device)
 		/* call add_memory func */
 		result = acpi_memory_enable_device(mem_device);
 		if (result)
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				"Error in acpi_memory_enable_device\n"));
+			printk(KERN_ERR PREFIX
+				"Error in acpi_memory_enable_device\n");
 	}
 	return result;
 }
diff --git a/drivers/acpi/cm_sbs.c b/drivers/acpi/cm_sbs.c
index f9db4f4..4441e84 100644
--- a/drivers/acpi/cm_sbs.c
+++ b/drivers/acpi/cm_sbs.c
@@ -52,8 +52,8 @@ struct proc_dir_entry *acpi_lock_ac_dir(void)
 	if (acpi_ac_dir) {
 		lock_ac_dir_cnt++;
 	} else {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Cannot create %s\n", ACPI_AC_CLASS));
+		printk(KERN_ERR PREFIX
+				  "Cannot create %s\n", ACPI_AC_CLASS);
 	}
 	mutex_unlock(&cm_sbs_mutex);
 	return acpi_ac_dir;
@@ -83,8 +83,8 @@ struct proc_dir_entry *acpi_lock_battery_dir(void)
 	if (acpi_battery_dir) {
 		lock_battery_dir_cnt++;
 	} else {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Cannot create %s\n", ACPI_BATTERY_CLASS));
+		printk(KERN_ERR PREFIX
+				  "Cannot create %s\n", ACPI_BATTERY_CLASS);
 	}
 	mutex_unlock(&cm_sbs_mutex);
 	return acpi_battery_dir;
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 2655bc1..dfc0486 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -327,8 +327,8 @@ static int acpi_fan_resume(struct acpi_device *device)
 
 	result = acpi_bus_get_power(device->handle, &power_state);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error reading fan power state\n"));
+		printk(KERN_ERR PREFIX
+				  "Error reading fan power state\n");
 		return result;
 	}
 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 235a138..1420a9f 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -729,8 +729,8 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 	INIT_WORK(&dpc->work, acpi_os_execute_deferred);
 	queue = (type == OSL_NOTIFY_HANDLER) ? kacpi_notify_wq : kacpid_wq;
 	if (!queue_work(queue, &dpc->work)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-			  "Call to queue_work() failed.\n"));
+		printk(KERN_ERR PREFIX
+			  "Call to queue_work() failed.\n");
 		status = AE_ERROR;
 		kfree(dpc);
 	}
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 80c251e..e5c457b 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -524,13 +524,13 @@ static int acpi_processor_get_psd(struct acpi_processor	*pr)
 
 	psd = buffer.pointer;
 	if (!psd || (psd->type != ACPI_TYPE_PACKAGE)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PSD data\n"));
+		printk(KERN_ERR PREFIX "Invalid _PSD data\n");
 		result = -EFAULT;
 		goto end;
 	}
 
 	if (psd->package.count != 1) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PSD data\n"));
+		printk(KERN_ERR PREFIX "Invalid _PSD data\n");
 		result = -EFAULT;
 		goto end;
 	}
@@ -543,19 +543,19 @@ static int acpi_processor_get_psd(struct acpi_processor	*pr)
 	status = acpi_extract_package(&(psd->package.elements[0]),
 		&format, &state);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PSD data\n"));
+		printk(KERN_ERR PREFIX "Invalid _PSD data\n");
 		result = -EFAULT;
 		goto end;
 	}
 
 	if (pdomain->num_entries != ACPI_PSD_REV0_ENTRIES) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unknown _PSD:num_entries\n"));
+		printk(KERN_ERR PREFIX "Unknown _PSD:num_entries\n");
 		result = -EFAULT;
 		goto end;
 	}
 
 	if (pdomain->revision != ACPI_PSD_REV0_REVISION) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unknown _PSD:revision\n"));
+		printk(KERN_ERR PREFIX "Unknown _PSD:revision\n");
 		result = -EFAULT;
 		goto end;
 	}
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index a56fc6c..e89a258 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -528,13 +528,13 @@ static int acpi_processor_get_tsd(struct acpi_processor *pr)
 
 	tsd = buffer.pointer;
 	if (!tsd || (tsd->type != ACPI_TYPE_PACKAGE)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _TSD data\n"));
+		printk(KERN_ERR PREFIX "Invalid _TSD data\n");
 		result = -EFAULT;
 		goto end;
 	}
 
 	if (tsd->package.count != 1) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _TSD data\n"));
+		printk(KERN_ERR PREFIX "Invalid _TSD data\n");
 		result = -EFAULT;
 		goto end;
 	}
@@ -547,19 +547,19 @@ static int acpi_processor_get_tsd(struct acpi_processor *pr)
 	status = acpi_extract_package(&(tsd->package.elements[0]),
 				      &format, &state);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _TSD data\n"));
+		printk(KERN_ERR PREFIX "Invalid _TSD data\n");
 		result = -EFAULT;
 		goto end;
 	}
 
 	if (pdomain->num_entries != ACPI_TSD_REV0_ENTRIES) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unknown _TSD:num_entries\n"));
+		printk(KERN_ERR PREFIX "Unknown _TSD:num_entries\n");
 		result = -EFAULT;
 		goto end;
 	}
 
 	if (pdomain->revision != ACPI_TSD_REV0_REVISION) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unknown _TSD:revision\n"));
+		printk(KERN_ERR PREFIX "Unknown _TSD:revision\n");
 		result = -EFAULT;
 		goto end;
 	}
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f6f52c1..81d6095 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -113,16 +113,16 @@ static int acpi_bus_hot_remove_device(void *context)
 
 
 	if (acpi_bus_trim(device, 1)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				"Removing device failed\n"));
+		printk(KERN_ERR PREFIX
+				"Removing device failed\n");
 		return -1;
 	}
 
 	/* power off device */
 	status = acpi_evaluate_object(handle, "_PS3", NULL, NULL);
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-				"Power-off device failed\n"));
+		printk(KERN_WARNING PREFIX
+				"Power-off device failed\n");
 
 	if (device->flags.lockable) {
 		arg_list.count = 1;
@@ -477,7 +477,7 @@ static int acpi_device_register(struct acpi_device *device,
 
 	result = acpi_device_setup_files(device);
 	if(result)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error creating sysfs interface for device %s\n", device->dev.bus_id));
+		printk(KERN_ERR PREFIX "Error creating sysfs interface for device %s\n", device->dev.bus_id);
 
 	device->removal_type = ACPI_BUS_REMOVAL_NORMAL;
 	return 0;
diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index 91dec44..3eefd6d 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -387,8 +387,8 @@ static ssize_t counter_set(struct kobject *kobj,
 		goto end;
 
 	if (!(all_counters[index].flags & ACPI_EVENT_VALID)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-			"Can not change Invalid GPE/Fixed Event status\n"));
+		printk(KERN_WARNING PREFIX
+			"Can not change Invalid GPE/Fixed Event status\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 9127036..263ec08 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1213,8 +1213,8 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 				  acpi_bus_private_data_handler,
 				  tz->thermal_zone);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				"Error attaching device data\n"));
+		printk(KERN_ERR PREFIX
+				"Error attaching device data\n");
 		return -ENODEV;
 	}
 
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index e8a51a1..4ae39ee 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1530,8 +1530,8 @@ acpi_video_bus_get_one_device(struct acpi_device *device,
 						     acpi_video_device_notify,
 						     data);
 		if (ACPI_FAILURE(status)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Error installing notify handler\n"));
+			printk(KERN_ERR PREFIX
+					  "Error installing notify handler\n");
 			if(data->brightness)
 				kfree(data->brightness->levels);
 			kfree(data->brightness);
@@ -1745,8 +1745,8 @@ acpi_video_bus_get_devices(struct acpi_video_bus *video,
 
 		status = acpi_video_bus_get_one_device(dev, video);
 		if (ACPI_FAILURE(status)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-					"Cant attach device"));
+			printk(KERN_WARNING PREFIX
+					"Cant attach device");
 			continue;
 		}
 	}
@@ -2003,8 +2003,8 @@ static int acpi_video_bus_add(struct acpi_device *device)
 					     ACPI_DEVICE_NOTIFY,
 					     acpi_video_bus_notify, video);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error installing notify handler\n"));
+		printk(KERN_ERR PREFIX
+				  "Error installing notify handler\n");
 		error = -ENODEV;
 		goto err_stop_video;
 	}
-- 
1.5.5.1

