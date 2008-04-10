From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: [PATCH 5/6] ACPI: elide a non-zero test on a result that is never 0
Date: Thu, 10 Apr 2008 16:19:01 +0800
Message-ID: <1207815541.27304.46.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56192 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753197AbYDJIgk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Apr 2008 04:36:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Julia Lawall <julia@diku.dk>

From: Julia Lawall <julia@diku.dk>

thermal_cooling_device_register used to return NULL if THERMAL is "n".
As the ACPI fan, processor and video drivers SELECT the generic
thermal in PATCH 01, this is not a problem any more.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/fan.c            |   35 +++++++++++++++++------------------
 drivers/acpi/processor_core.c |   31 +++++++++++++++----------------
 drivers/acpi/video.c          |   27 ++++++++++++---------------
 drivers/misc/intel_menlow.c   |   23 +++++++++--------------
 4 files changed, 53 insertions(+), 63 deletions(-)

Index: linux-2.6/drivers/acpi/fan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/fan.c
+++ linux-2.6/drivers/acpi/fan.c
@@ -260,24 +260,23 @@ static int acpi_fan_add(struct acpi_devi
 		result = PTR_ERR(cdev);
 		goto end;
 	}
-	if (cdev) {
-		printk(KERN_INFO PREFIX
-			"%s is registered as cooling_device%d\n",
-			device->dev.bus_id, cdev->id);
-
-		acpi_driver_data(device) = cdev;
-		result = sysfs_create_link(&device->dev.kobj,
-					   &cdev->device.kobj,
-					   "thermal_cooling");
-		if (result)
-			return result;
-
-		result = sysfs_create_link(&cdev->device.kobj,
-					   &device->dev.kobj,
-					   "device");
-		if (result)
-			return result;
-	}
+
+	printk(KERN_INFO PREFIX
+		"%s is registered as cooling_device%d\n",
+		device->dev.bus_id, cdev->id);
+
+	acpi_driver_data(device) = cdev;
+	result = sysfs_create_link(&device->dev.kobj,
+				   &cdev->device.kobj,
+				   "thermal_cooling");
+	if (result)
+		printk(KERN_ERR PREFIX "Create sysfs link\n");
+
+	result = sysfs_create_link(&cdev->device.kobj,
+				   &device->dev.kobj,
+				   "device");
+	if (result)
+		printk(KERN_ERR PREFIX "Create sysfs link\n");
 
 	result = acpi_fan_add_fs(device);
 	if (result)
Index: linux-2.6/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_core.c
+++ linux-2.6/drivers/acpi/processor_core.c
@@ -674,22 +674,21 @@ static int __cpuinit acpi_processor_star
 		result = PTR_ERR(pr->cdev);
 		goto end;
 	}
-	if (pr->cdev) {
-		printk(KERN_INFO PREFIX
-			"%s is registered as cooling_device%d\n",
-			device->dev.bus_id, pr->cdev->id);
-
-		result = sysfs_create_link(&device->dev.kobj,
-					   &pr->cdev->device.kobj,
-					   "thermal_cooling");
-		if (result)
-			return result;
-		result = sysfs_create_link(&pr->cdev->device.kobj,
-					   &device->dev.kobj,
-					   "device");
-		if (result)
-			return result;
-	}
+
+	printk(KERN_INFO PREFIX
+		"%s is registered as cooling_device%d\n",
+		device->dev.bus_id, pr->cdev->id);
+
+	result = sysfs_create_link(&device->dev.kobj,
+				   &pr->cdev->device.kobj,
+				   "thermal_cooling");
+	if (result)
+		printk(KERN_ERR PREFIX "Create sysfs link\n");
+	result = sysfs_create_link(&pr->cdev->device.kobj,
+				   &device->dev.kobj,
+				   "device");
+	if (result)
+		printk(KERN_ERR PREFIX "Create sysfs link\n");
 
 	if (pr->flags.throttling) {
 		printk(KERN_INFO PREFIX "%s [%s] (supports",
Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -734,21 +734,18 @@ static void acpi_video_device_find_cap(s
 		if (IS_ERR(device->cdev))
 			return;
 
-		if (device->cdev) {
-			printk(KERN_INFO PREFIX
-				"%s is registered as cooling_device%d\n",
-				device->dev->dev.bus_id, device->cdev->id);
-			result = sysfs_create_link(&device->dev->dev.kobj,
-					  &device->cdev->device.kobj,
-					  "thermal_cooling");
-			if (result)
-				printk(KERN_ERR PREFIX "Create sysfs link\n");
-			result = sysfs_create_link(&device->cdev->device.kobj,
-					  &device->dev->dev.kobj,
-					  "device");
-                        if (result)
-				printk(KERN_ERR PREFIX "Create sysfs link\n");
-		}
+		printk(KERN_INFO PREFIX
+			"%s is registered as cooling_device%d\n",
+			device->dev->dev.bus_id, device->cdev->id);
+		result = sysfs_create_link(&device->dev->dev.kobj,
+				  &device->cdev->device.kobj, "thermal_cooling");
+		if (result)
+			printk(KERN_ERR PREFIX "Create sysfs link\n");
+		result = sysfs_create_link(&device->cdev->device.kobj,
+				  &device->dev->dev.kobj, "device");
+		if (result)
+			printk(KERN_ERR PREFIX "Create sysfs link\n");
+
 	}
 	if (device->cap._DCS && device->cap._DSS){
 		static int count = 0;
Index: linux-2.6/drivers/misc/intel_menlow.c
===================================================================
--- linux-2.6.orig/drivers/misc/intel_menlow.c
+++ linux-2.6/drivers/misc/intel_menlow.c
@@ -175,20 +175,15 @@ static int intel_menlow_memory_add(struc
 		goto end;
 	}
 
-	if (cdev) {
-		acpi_driver_data(device) = cdev;
-		result = sysfs_create_link(&device->dev.kobj,
-					&cdev->device.kobj, "thermal_cooling");
-		if (result)
-			goto unregister;
-
-		result = sysfs_create_link(&cdev->device.kobj,
-					&device->dev.kobj, "device");
-		if (result) {
-			sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
-			goto unregister;
-		}
-	}
+	acpi_driver_data(device) = cdev;
+	result = sysfs_create_link(&device->dev.kobj,
+				&cdev->device.kobj, "thermal_cooling");
+	if (result)
+		printk(KERN_ERR PREFIX "Create sysfs link\n");
+	result = sysfs_create_link(&cdev->device.kobj,
+				&device->dev.kobj, "device");
+	if (result)
+		printk(KERN_ERR PREFIX "Create sysfs link\n");
 
  end:
 	return result;


