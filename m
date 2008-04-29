From: Len Brown <lenb@kernel.org>
Subject: [PATCH 098/171] ACPI: elide a non-zero test on a result that is never 0
Date: Tue, 29 Apr 2008 04:44:18 -0400
Message-ID: <9030062f3d61f87c1e787b3aa134fa3a8e4b2d25.1209457070.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:45231 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760734AbYD2IpZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:45:25 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Julia Lawall <julia@diku.dk>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Julia Lawall <julia@diku.dk>

thermal_cooling_device_register used to return NULL if THERMAL is "n".
As the ACPI fan, processor and video drivers SELECT the generic
thermal in PATCH 01, this is not a problem any more.

Signed-off-by: Julia Lawall <julia@diku.dk>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/fan.c            |   35 +++++++++++++++++------------------
 drivers/acpi/processor_core.c |   31 +++++++++++++++----------------
 drivers/acpi/video.c          |   28 +++++++++++++---------------
 drivers/misc/intel_menlow.c   |   23 +++++++++--------------
 4 files changed, 54 insertions(+), 63 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index c8e3cba..cf635cd 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -260,24 +260,23 @@ static int acpi_fan_add(struct acpi_device *device)
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
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index a825b43..ea5f628 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -674,22 +674,21 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
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
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 980a741..55c0956 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -734,21 +734,19 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
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
+				&device->cdev->device.kobj,
+				"thermal_cooling");
+		if (result)
+			printk(KERN_ERR PREFIX "Create sysfs link\n");
+		result = sysfs_create_link(&device->cdev->device.kobj,
+				&device->dev->dev.kobj, "device");
+		if (result)
+			printk(KERN_ERR PREFIX "Create sysfs link\n");
+
 	}
 	if (device->cap._DCS && device->cap._DSS){
 		static int count = 0;
diff --git a/drivers/misc/intel_menlow.c b/drivers/misc/intel_menlow.c
index 0c0bb30..3db83a2 100644
--- a/drivers/misc/intel_menlow.c
+++ b/drivers/misc/intel_menlow.c
@@ -175,20 +175,15 @@ static int intel_menlow_memory_add(struct acpi_device *device)
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
-- 
1.5.5.1.99.gf0ec4

