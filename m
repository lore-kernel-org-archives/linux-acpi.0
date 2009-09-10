From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [RFC] acpi: remove redundant NULL checks in acpi drivers
Date: Thu, 10 Sep 2009 17:43:25 +0100
Message-ID: <4AA92CAD.8020208@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:22274 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbZIJQnf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Sep 2009 12:43:35 -0400
Received: by ey-out-2122.google.com with SMTP id 25so69224eya.19
        for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2009 09:43:37 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Hi

I noticed a pattern of unnecessary checks, and wrote some semantic
patches to remove them (using the spatch tool).  Here are the
results, modulo some manual adjustment of blank lines to try and
preserve the coding style in different files.

Would you be interested in accepting this?  Can I submit it like
this, or should I break it up somehow?

Regards
Alan

------------------------------
>From 5d501848505d36a7b432fa41805a7335bdee20bd Mon Sep 17 00:00:00 2001
From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Date: Fri, 4 Sep 2009 10:18:59 +0100
Subject: [PATCH] acpi: remove redundant NULL checks in acpi drivers

The acpi device callbacks add, start, remove, suspend and resume can
never be called with a NULL acpi_device. Each callsite in acpi/scan.c
has to dereference the device in order to get the ops structure, e.g.

    struct acpi_device *acpi_dev = to_acpi_device(dev);
    struct acpi_driver *acpi_drv = acpi_dev->driver;

    if (acpi_drv && acpi_drv->ops.suspend)
	    return acpi_drv->ops.suspend(acpi_dev, state);

Remove all checks for acpi_dev == NULL within these callbacks.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/acpi/ac.c                       |   14 ++++----------
 drivers/acpi/acpi_memhotplug.c          |    9 ++-------
 drivers/acpi/battery.c                  |   10 +++-------
 drivers/acpi/container.c                |    5 -----
 drivers/acpi/ec.c                       |    3 ---
 drivers/acpi/fan.c                      |    9 ---------
 drivers/acpi/power.c                    |   15 ++++-----------
 drivers/acpi/processor_core.c           |    6 ++----
 drivers/acpi/sbs.c                      |    4 ----
 drivers/acpi/sbshc.c                    |    6 ------
 drivers/acpi/thermal.c                  |   15 ++++-----------
 drivers/acpi/video.c                    |   12 ++++--------
 drivers/hwmon/hp_accel.c                |    6 ------
 drivers/platform/x86/asus-laptop.c      |    5 +----
 drivers/platform/x86/asus_acpi.c        |    5 +----
 drivers/platform/x86/eeepc-laptop.c     |    4 +---
 drivers/platform/x86/fujitsu-laptop.c   |    6 ------
 drivers/platform/x86/intel_menlow.c     |    5 +----
 drivers/platform/x86/panasonic-laptop.c |    7 ++-----
 19 files changed, 29 insertions(+), 117 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 98b9690..57fbf70 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -259,9 +259,6 @@ static int acpi_ac_add(struct acpi_device *device)
 	struct acpi_ac *ac = NULL;
 
 
-	if (!device)
-		return -EINVAL;
-
 	ac = kzalloc(sizeof(struct acpi_ac), GFP_KERNEL);
 	if (!ac)
 		return -ENOMEM;
@@ -306,11 +303,10 @@ static int acpi_ac_add(struct acpi_device *device)
 
 static int acpi_ac_resume(struct acpi_device *device)
 {
-	struct acpi_ac *ac;
+	struct acpi_ac *ac = acpi_driver_data(device);
 	unsigned old_state;
-	if (!device || !acpi_driver_data(device))
+	if (!ac)
 		return -EINVAL;
-	ac = acpi_driver_data(device);
 	old_state = ac->state;
 	if (acpi_ac_get_state(ac))
 		return 0;
@@ -323,14 +319,12 @@ static int acpi_ac_resume(struct acpi_device *device)
 
 static int acpi_ac_remove(struct acpi_device *device, int type)
 {
-	struct acpi_ac *ac = NULL;
+	struct acpi_ac *ac = acpi_driver_data(device);
 
 
-	if (!device || !acpi_driver_data(device))
+	if (!ac)
 		return -EINVAL;
 
-	ac = acpi_driver_data(device);
-
 #ifdef CONFIG_ACPI_SYSFS_POWER
 	if (ac->charger.dev)
 		power_supply_unregister(&ac->charger);
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 28ccdbc..d4ab33e 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -404,9 +404,6 @@ static int acpi_memory_device_add(struct acpi_device *device)
 	struct acpi_memory_device *mem_device = NULL;
 
 
-	if (!device)
-		return -EINVAL;
-
 	mem_device = kzalloc(sizeof(struct acpi_memory_device), GFP_KERNEL);
 	if (!mem_device)
 		return -ENOMEM;
@@ -450,13 +447,11 @@ static int acpi_memory_device_add(struct acpi_device *device)
 
 static int acpi_memory_device_remove(struct acpi_device *device, int type)
 {
-	struct acpi_memory_device *mem_device = NULL;
+	struct acpi_memory_device *mem_device = acpi_driver_data(device);
 
 
-	if (!device || !acpi_driver_data(device))
+	if (!mem_device)
 		return -EINVAL;
-
-	mem_device = acpi_driver_data(device);
 	kfree(mem_device);
 
 	return 0;
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 3f4602b..360fc84 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -841,8 +841,7 @@ static int acpi_battery_add(struct acpi_device *device)
 {
 	int result = 0;
 	struct acpi_battery *battery = NULL;
-	if (!device)
-		return -EINVAL;
+
 	battery = kzalloc(sizeof(struct acpi_battery), GFP_KERNEL);
 	if (!battery)
 		return -ENOMEM;
@@ -870,11 +869,10 @@ static int acpi_battery_add(struct acpi_device *device)
 
 static int acpi_battery_remove(struct acpi_device *device, int type)
 {
-	struct acpi_battery *battery = NULL;
+	struct acpi_battery *battery = acpi_driver_data(device);
 
-	if (!device || !acpi_driver_data(device))
+	if (!battery)
 		return -EINVAL;
-	battery = acpi_driver_data(device);
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_battery_remove_fs(device);
 #endif
@@ -890,8 +888,6 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
 static int acpi_battery_resume(struct acpi_device *device)
 {
 	struct acpi_battery *battery;
-	if (!device)
-		return -EINVAL;
 	battery = acpi_driver_data(device);
 	battery->update_time = 0;
 	acpi_battery_update(battery);
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 642bb30..c8ba3a0 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -97,11 +97,6 @@ static int acpi_container_add(struct acpi_device *device)
 	struct acpi_container *container;
 
 
-	if (!device) {
-		printk(KERN_ERR PREFIX "device is NULL\n");
-		return -EINVAL;
-	}
-
 	container = kzalloc(sizeof(struct acpi_container), GFP_KERNEL);
 	if (!container)
 		return -ENOMEM;
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 64a20ef..c7c26da 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -840,9 +840,6 @@ static int acpi_ec_remove(struct acpi_device *device, int type)
 	struct acpi_ec *ec;
 	struct acpi_ec_query_handler *handler, *tmp;
 
-	if (!device)
-		return -EINVAL;
-
 	ec = acpi_driver_data(device);
 	ec_remove_handlers(ec);
 	mutex_lock(&ec->lock);
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index f419849..a3a7301 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -244,9 +244,6 @@ static int acpi_fan_add(struct acpi_device *device)
 	int state = 0;
 	struct thermal_cooling_device *cdev;
 
-	if (!device)
-		return -EINVAL;
-
 	strcpy(acpi_device_name(device), "Fan");
 	strcpy(acpi_device_class(device), ACPI_FAN_CLASS);
 
@@ -313,9 +310,6 @@ static int acpi_fan_remove(struct acpi_device *device, int type)
 
 static int acpi_fan_suspend(struct acpi_device *device, pm_message_t state)
 {
-	if (!device)
-		return -EINVAL;
-
 	acpi_bus_set_power(device->handle, ACPI_STATE_D0);
 
 	return AE_OK;
@@ -326,9 +320,6 @@ static int acpi_fan_resume(struct acpi_device *device)
 	int result = 0;
 	int power_state = 0;
 
-	if (!device)
-		return -EINVAL;
-
 	result = acpi_bus_get_power(device->handle, &power_state);
 	if (result) {
 		printk(KERN_ERR PREFIX
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index e86603f..d04376d 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -639,9 +639,6 @@ static int acpi_power_add(struct acpi_device *device)
 	struct acpi_buffer buffer = { sizeof(acpi_object), &acpi_object };
 
 
-	if (!device)
-		return -EINVAL;
-
 	resource = kzalloc(sizeof(struct acpi_power_resource), GFP_KERNEL);
 	if (!resource)
 		return -ENOMEM;
@@ -695,15 +692,13 @@ static int acpi_power_add(struct acpi_device *device)
 
 static int acpi_power_remove(struct acpi_device *device, int type)
 {
-	struct acpi_power_resource *resource = NULL;
+	struct acpi_power_resource *resource = acpi_driver_data(device);
 	struct list_head *node, *next;
 
 
-	if (!device || !acpi_driver_data(device))
+	if (!resource)
 		return -EINVAL;
 
-	resource = acpi_driver_data(device);
-
 	acpi_power_remove_fs(device);
 
 	mutex_lock(&resource->resource_lock);
@@ -722,14 +717,12 @@ static int acpi_power_remove(struct acpi_device *device, int type)
 static int acpi_power_resume(struct acpi_device *device)
 {
 	int result = 0, state;
-	struct acpi_power_resource *resource = NULL;
+	struct acpi_power_resource *resource = acpi_driver_data(device);
 	struct acpi_power_reference *ref;
 
-	if (!device || !acpi_driver_data(device))
+	if (!resource)
 		return -EINVAL;
 
-	resource = acpi_driver_data(device);
-
 	result = acpi_power_get_state(device->handle, &state);
 	if (result)
 		return result;
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index c2d4d6e..ccac96d 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -888,14 +888,12 @@ err_free_cpumask:
 
 static int acpi_processor_remove(struct acpi_device *device, int type)
 {
-	struct acpi_processor *pr = NULL;
+	struct acpi_processor *pr = acpi_driver_data(device);
 
 
-	if (!device || !acpi_driver_data(device))
+	if (!pr)
 		return -EINVAL;
 
-	pr = acpi_driver_data(device);
-
 	if (pr->id >= nr_cpu_ids)
 		goto free;
 
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 52b9db8..b4a6c65 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -963,8 +963,6 @@ static int acpi_sbs_remove(struct acpi_device *device, int type)
 	struct acpi_sbs *sbs;
 	int id;
 
-	if (!device)
-		return -EINVAL;
 	sbs = acpi_driver_data(device);
 	if (!sbs)
 		return -EINVAL;
@@ -996,8 +994,6 @@ static void acpi_sbs_rmdirs(void)
 static int acpi_sbs_resume(struct acpi_device *device)
 {
 	struct acpi_sbs *sbs;
-	if (!device)
-		return -EINVAL;
 	sbs = device->driver_data;
 	acpi_sbs_callback(sbs);
 	return 0;
diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index d933980..95a5b27 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -262,9 +262,6 @@ static int acpi_smbus_hc_add(struct acpi_device *device)
 	unsigned long long val;
 	struct acpi_smb_hc *hc;
 
-	if (!device)
-		return -EINVAL;
-
 	status = acpi_evaluate_integer(device->handle, "_EC", NULL, &val);
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX "error obtaining _EC.\n");
@@ -298,9 +295,6 @@ static int acpi_smbus_hc_remove(struct acpi_device *device, int type)
 {
 	struct acpi_smb_hc *hc;
 
-	if (!device)
-		return -EINVAL;
-
 	hc = acpi_driver_data(device);
 	acpi_ec_remove_query_handler(hc->ec, hc->query_bit);
 	kfree(hc);
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 65f6781..a962aaf 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1364,9 +1364,6 @@ static int acpi_thermal_add(struct acpi_device *device)
 	struct acpi_thermal *tz = NULL;
 
 
-	if (!device)
-		return -EINVAL;
-
 	tz = kzalloc(sizeof(struct acpi_thermal), GFP_KERNEL);
 	if (!tz)
 		return -ENOMEM;
@@ -1408,13 +1405,11 @@ end:
 
 static int acpi_thermal_remove(struct acpi_device *device, int type)
 {
-	struct acpi_thermal *tz = NULL;
+	struct acpi_thermal *tz = acpi_driver_data(device);
 
-	if (!device || !acpi_driver_data(device))
+	if (!tz)
 		return -EINVAL;
 
-	tz = acpi_driver_data(device);
-
 	acpi_thermal_remove_fs(device);
 	acpi_thermal_unregister_thermal_zone(tz);
 	mutex_destroy(&tz->lock);
@@ -1424,15 +1419,13 @@ static int acpi_thermal_remove(struct acpi_device *device, int type)
 
 static int acpi_thermal_resume(struct acpi_device *device)
 {
-	struct acpi_thermal *tz = NULL;
+	struct acpi_thermal *tz = acpi_driver_data(device);
 	int i, j, power_state, result;
 
 
-	if (!device || !acpi_driver_data(device))
+	if (!tz)
 		return -EINVAL;
 
-	tz = acpi_driver_data(device);
-
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		if (!(&tz->trips.active[i]))
 			break;
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index b51f1fe..900437a 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -2207,15 +2207,13 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
 static int instance;
 static int acpi_video_resume(struct acpi_device *device)
 {
-	struct acpi_video_bus *video;
+	struct acpi_video_bus *video = acpi_driver_data(device);
 	struct acpi_video_device *video_device;
 	int i;
 
-	if (!device || !acpi_driver_data(device))
+	if (!video)
 		return -EINVAL;
 
-	video = acpi_driver_data(device);
-
 	for (i = 0; i < video->attached_count; i++) {
 		video_device = video->attached_array[i].bind_info;
 		if (video_device && video_device->backlight)
@@ -2352,14 +2350,12 @@ static int acpi_video_bus_add(struct acpi_device *device)
 
 static int acpi_video_bus_remove(struct acpi_device *device, int type)
 {
-	struct acpi_video_bus *video = NULL;
+	struct acpi_video_bus *video = acpi_driver_data(device);
 
 
-	if (!device || !acpi_driver_data(device))
+	if (!video)
 		return -EINVAL;
 
-	video = acpi_driver_data(device);
-
 	acpi_video_bus_stop_devices(video);
 	acpi_video_bus_put_devices(video);
 	acpi_video_bus_remove_fs(device);
diff --git a/drivers/hwmon/hp_accel.c b/drivers/hwmon/hp_accel.c
index 6679854..c8d3c88 100644
--- a/drivers/hwmon/hp_accel.c
+++ b/drivers/hwmon/hp_accel.c
@@ -275,9 +275,6 @@ static int lis3lv02d_add(struct acpi_device *device)
 {
 	int ret;
 
-	if (!device)
-		return -EINVAL;
-
 	lis3_dev.bus_priv = device;
 	lis3_dev.init = lis3lv02d_acpi_init;
 	lis3_dev.read = lis3lv02d_acpi_read;
@@ -315,9 +312,6 @@ static int lis3lv02d_add(struct acpi_device *device)
 
 static int lis3lv02d_remove(struct acpi_device *device, int type)
 {
-	if (!device)
-		return -EINVAL;
-
 	lis3lv02d_joystick_disable();
 	lis3lv02d_poweroff(&lis3_dev);
 
diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index b39d2bb..3cd267e 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1240,9 +1240,6 @@ static int asus_hotk_add(struct acpi_device *device)
 {
 	int result;
 
-	if (!device)
-		return -EINVAL;
-
 	pr_notice("Asus Laptop Support version %s\n",
 	       ASUS_LAPTOP_VERSION);
 
@@ -1306,7 +1303,7 @@ end:
 
 static int asus_hotk_remove(struct acpi_device *device, int type)
 {
-	if (!device || !acpi_driver_data(device))
+	if (!acpi_driver_data(device))
 		return -EINVAL;
 
 	kfree(hotk->name);
diff --git a/drivers/platform/x86/asus_acpi.c b/drivers/platform/x86/asus_acpi.c
index ddf5240..5a73e75 100644
--- a/drivers/platform/x86/asus_acpi.c
+++ b/drivers/platform/x86/asus_acpi.c
@@ -1334,9 +1334,6 @@ static int asus_hotk_add(struct acpi_device *device)
 	acpi_status status = AE_OK;
 	int result;
 
-	if (!device)
-		return -EINVAL;
-
 	printk(KERN_NOTICE "Asus Laptop ACPI Extras version %s\n",
 	       ASUS_ACPI_VERSION);
 
@@ -1392,7 +1389,7 @@ end:
 
 static int asus_hotk_remove(struct acpi_device *device, int type)
 {
-	if (!device || !acpi_driver_data(device))
+	if (!acpi_driver_data(device))
 		return -EINVAL;
 
 	asus_hotk_remove_fs(device);
diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index da3c08b..9a86c55 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1194,8 +1194,6 @@ static int eeepc_hotk_add(struct acpi_device *device)
 	struct device *dev;
 	int result;
 
-	if (!device)
-		return -EINVAL;
 	pr_notice(EEEPC_HOTK_NAME "\n");
 	ehotk = kzalloc(sizeof(struct eeepc_hotk), GFP_KERNEL);
 	if (!ehotk)
@@ -1276,7 +1274,7 @@ fail_platform_driver:
 
 static int eeepc_hotk_remove(struct acpi_device *device, int type)
 {
-	if (!device || !acpi_driver_data(device))
+	if (!acpi_driver_data(device))
 		return -EINVAL;
 
 	eeepc_backlight_exit();
diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index f35aee5..2ab0318 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -657,9 +657,6 @@ static int acpi_fujitsu_add(struct acpi_device *device)
 	struct input_dev *input;
 	int error;
 
-	if (!device)
-		return -EINVAL;
-
 	fujitsu->acpi_handle = device->handle;
 	sprintf(acpi_device_name(device), "%s", ACPI_FUJITSU_DEVICE_NAME);
 	sprintf(acpi_device_class(device), "%s", ACPI_FUJITSU_CLASS);
@@ -813,9 +810,6 @@ static int acpi_fujitsu_hotkey_add(struct acpi_device *device)
 	int error;
 	int i;
 
-	if (!device)
-		return -EINVAL;
-
 	fujitsu_hotkey->acpi_handle = device->handle;
 	sprintf(acpi_device_name(device), "%s",
 		ACPI_FUJITSU_HOTKEY_DEVICE_NAME);
diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel_menlow.c
index 29432a5..79807ba 100644
--- a/drivers/platform/x86/intel_menlow.c
+++ b/drivers/platform/x86/intel_menlow.c
@@ -156,9 +156,6 @@ static int intel_menlow_memory_add(struct acpi_device *device)
 	acpi_handle dummy;
 	struct thermal_cooling_device *cdev;
 
-	if (!device)
-		return -EINVAL;
-
 	status = acpi_get_handle(device->handle, MEMORY_GET_BANDWIDTH, &dummy);
 	if (ACPI_FAILURE(status))
 		goto end;
@@ -200,7 +197,7 @@ static int intel_menlow_memory_remove(struct acpi_device *device, int type)
 {
 	struct thermal_cooling_device *cdev = acpi_driver_data(device);
 
-	if (!device || !cdev)
+	if (!cdev)
 		return -EINVAL;
 
 	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index fe7cf01..d4203bd 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -588,7 +588,7 @@ static int acpi_pcc_hotkey_resume(struct acpi_device *device)
 	struct pcc_acpi *pcc = acpi_driver_data(device);
 	acpi_status status = AE_OK;
 
-	if (device == NULL || pcc == NULL)
+	if (pcc == NULL)
 		return -EINVAL;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Sticky mode restore: %d\n",
@@ -604,9 +604,6 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	struct pcc_acpi *pcc;
 	int num_sifr, result;
 
-	if (!device)
-		return -EINVAL;
-
 	num_sifr = acpi_pcc_get_sqty(device);
 
 	if (num_sifr > 255) {
@@ -703,7 +700,7 @@ static int acpi_pcc_hotkey_remove(struct acpi_device *device, int type)
 {
 	struct pcc_acpi *pcc = acpi_driver_data(device);
 
-	if (!device || !pcc)
+	if (!pcc)
 		return -EINVAL;
 
 	sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
-- 
1.6.3.2


