From: Len Brown <lenb@kernel.org>
Subject: [PATCH 056/112] ACPI: register ACPI Fan as generic thermal cooling device
Date: Thu,  7 Feb 2008 04:34:18 -0500
Message-ID: <05a83d972293f39a66bc2aa409a5e7996bba585d.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:9414 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754483AbYBGJgK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:10 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Thomas Sujith <sujith.thomas@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Register ACPI Fan as thermal cooling device.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/fan.c |   90 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index a6e149d..f6e8165 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -30,7 +30,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
-
+#include <linux/thermal.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
@@ -68,9 +68,55 @@ static struct acpi_driver acpi_fan_driver = {
 		},
 };
 
+/* thermal cooling device callbacks */
+static int fan_get_max_state(struct thermal_cooling_device *cdev, char *buf)
+{
+	/* ACPI fan device only support two states: ON/OFF */
+	return sprintf(buf, "1\n");
+}
+
+static int fan_get_cur_state(struct thermal_cooling_device *cdev, char *buf)
+{
+	struct acpi_device *device = cdev->devdata;
+	int state;
+	int result;
+
+	if (!device)
+		return -EINVAL;
+
+	result = acpi_bus_get_power(device->handle, &state);
+	if (result)
+		return result;
+
+	return sprintf(buf, "%s\n", state == ACPI_STATE_D3 ? "0" :
+			 (state == ACPI_STATE_D0 ? "1" : "unknown"));
+}
+
+static int
+fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned int state)
+{
+	struct acpi_device *device = cdev->devdata;
+	int result;
+
+	if (!device || (state != 0 && state != 1))
+		return -EINVAL;
+
+	result = acpi_bus_set_power(device->handle,
+				state ? ACPI_STATE_D0 : ACPI_STATE_D3);
+
+	return result;
+}
+
+static struct thermal_cooling_device_ops fan_cooling_ops = {
+	.get_max_state = fan_get_max_state,
+	.get_cur_state = fan_get_cur_state,
+	.set_cur_state = fan_set_cur_state,
+};
+
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
+#ifdef CONFIG_ACPI_PROCFS
 
 static struct proc_dir_entry *acpi_fan_dir;
 
@@ -171,7 +217,17 @@ static int acpi_fan_remove_fs(struct acpi_device *device)
 
 	return 0;
 }
+#else
+static int acpi_fan_add_fs(struct acpi_device *device)
+{
+	return 0;
+}
 
+static int acpi_fan_remove_fs(struct acpi_device *device)
+{
+	return 0;
+}
+#endif
 /* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
@@ -179,9 +235,8 @@ static int acpi_fan_remove_fs(struct acpi_device *device)
 static int acpi_fan_add(struct acpi_device *device)
 {
 	int result = 0;
-	struct acpi_fan *fan = NULL;
 	int state = 0;
-
+	struct thermal_cooling_device *cdev;
 
 	if (!device)
 		return -EINVAL;
@@ -199,6 +254,25 @@ static int acpi_fan_add(struct acpi_device *device)
 	acpi_bus_set_power(device->handle, state);
 	device->flags.force_power_state = 0;
 
+	cdev = thermal_cooling_device_register("Fan", device,
+						&fan_cooling_ops);
+	if (cdev)
+		printk(KERN_INFO PREFIX
+			"%s is registered as cooling_device%d\n",
+			device->dev.bus_id, cdev->id);
+	else
+		goto end;
+	acpi_driver_data(device) = cdev;
+	result = sysfs_create_link(&device->dev.kobj, &cdev->device.kobj,
+					"thermal_cooling");
+	if (result)
+		return result;
+
+	result = sysfs_create_link(&cdev->device.kobj, &device->dev.kobj,
+                                       "device");
+        if (result)
+                return result;
+
 	result = acpi_fan_add_fs(device);
 	if (result)
 		goto end;
@@ -208,18 +282,20 @@ static int acpi_fan_add(struct acpi_device *device)
 	       !device->power.state ? "on" : "off");
 
       end:
-	if (result)
-		kfree(fan);
-
 	return result;
 }
 
 static int acpi_fan_remove(struct acpi_device *device, int type)
 {
-	if (!device || !acpi_driver_data(device))
+	struct thermal_cooling_device *cdev = acpi_driver_data(device);
+
+	if (!device || !cdev)
 		return -EINVAL;
 
 	acpi_fan_remove_fs(device);
+	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
+	sysfs_remove_link(&cdev->device.kobj, "device");
+	thermal_cooling_device_unregister(cdev);
 
 	return 0;
 }
-- 
1.5.4.23.gef5b9

