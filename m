From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2] acpi: fan.c: printk replacement
Date: Thu, 28 Aug 2014 19:17:19 +0530
Message-ID: <1409233639-9165-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:48145 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbaH1Nre (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Aug 2014 09:47:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

printk replaced with corresponding dev_err and dev_info 
fixed one broken user-visible string 
multiine comment edited for correct commenting style 
asm/uaccess.h replaced with linux/uaccess.h
PREFIX removed

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

modified with reference to the discussion at https://lkml.org/lkml/2014/8/22/176 

 drivers/acpi/fan.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 8acf53e..5328b10 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -27,12 +27,10 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <linux/thermal.h>
 #include <linux/acpi.h>
 
-#define PREFIX "ACPI: "
-
 #define ACPI_FAN_CLASS			"fan"
 #define ACPI_FAN_FILE_STATE		"state"
 
@@ -127,8 +125,9 @@ static const struct thermal_cooling_device_ops fan_cooling_ops = {
 };
 
 /* --------------------------------------------------------------------------
-                                 Driver Interface
-   -------------------------------------------------------------------------- */
+ *                               Driver Interface
+ * --------------------------------------------------------------------------
+*/
 
 static int acpi_fan_add(struct acpi_device *device)
 {
@@ -143,7 +142,7 @@ static int acpi_fan_add(struct acpi_device *device)
 
 	result = acpi_bus_update_power(device->handle, NULL);
 	if (result) {
-		printk(KERN_ERR PREFIX "Setting initial power state\n");
+		dev_err(&device->dev, "Setting initial power state\n");
 		goto end;
 	}
 
@@ -168,10 +167,9 @@ static int acpi_fan_add(struct acpi_device *device)
 				   &device->dev.kobj,
 				   "device");
 	if (result)
-		dev_err(&device->dev, "Failed to create sysfs link "
-			"'device'\n");
+		dev_err(&device->dev, "Failed to create sysfs link 'device'\n");
 
-	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
+	dev_info(&device->dev, "ACPI: %s [%s] (%s)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
 	       !device->power.state ? "on" : "off");
 
@@ -217,7 +215,7 @@ static int acpi_fan_resume(struct device *dev)
 
 	result = acpi_bus_update_power(to_acpi_device(dev)->handle, NULL);
 	if (result)
-		printk(KERN_ERR PREFIX "Error updating fan power state\n");
+		dev_err(dev, "Error updating fan power state\n");
 
 	return result;
 }
-- 
1.8.1.2

