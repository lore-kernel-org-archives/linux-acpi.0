From: malattia@linux.it
Subject: [patch 1/9 v2] sony-laptop: add camera enable/disable parameter, better handle possible infinite loop
Date: Sat, 28 Apr 2007 23:18:45 +0900
Message-ID: <20070428141845.GA5293@inferi.kami.home>
References: <20070428141557.GA4764@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi13.ns.itscom.net ([219.110.2.183]:44067 "EHLO
	mtoichi13.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbXD1OUN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Apr 2007 10:20:13 -0400
Content-Disposition: inline; filename="0006-add-SNY6001-platform-attributes-fix-camera-opts.patch"
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>

Use a parameter to enable/disable motion eye camera (for C1VE/C1VN models)
controls and avoid entering an infinite loop if the camera is not present
and the HW doesn't answer as we expect on io commands.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
Index: linux-2.6/drivers/misc/sony-laptop.c
===================================================================
--- linux-2.6.orig/drivers/misc/sony-laptop.c	2007-04-23 00:20:19.586798352 +0900
+++ linux-2.6/drivers/misc/sony-laptop.c	2007-04-23 00:26:25.107628197 +0900
@@ -107,6 +107,12 @@ module_param(mask, ulong, 0644);
 MODULE_PARM_DESC(mask,
 		 "set this to the mask of event you want to enable (see doc)");
 
+static int camera;		/* = 0 */
+module_param(camera, int, 0444);
+MODULE_PARM_DESC(camera,
+		 "set this to 1 to enable Motion Eye camera controls "
+		 "(only use it if you have a C1VE or C1VN model)");
+
 #ifdef CONFIG_SONY_LAPTOP_OLD
 static int minor = -1;
 module_param(minor, int, 0);
@@ -1226,29 +1232,39 @@ static int sony_pic_camera_ready(void)
 	return (v != 0xff && (v & SONYPI_CAMERA_STATUS_READY));
 }
 
-static void sony_pic_camera_off(void)
+static int sony_pic_camera_off(void)
 {
+	if (!camera) {
+		printk(KERN_WARNING DRV_PFX "camera control not enabled\n");
+		return -ENODEV;
+	}
+
 	wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_PICTURE,
 				SONYPI_CAMERA_MUTE_MASK),
 			ITERATIONS_SHORT);
 
-	if (!spic_dev.camera_power)
-		return;
-
-	sony_pic_call2(0x91, 0);
-	spic_dev.camera_power = 0;
+	if (spic_dev.camera_power) {
+		sony_pic_call2(0x91, 0);
+		spic_dev.camera_power = 0;
+	}
+	return 0;
 }
 
-static void sony_pic_camera_on(void)
+static int sony_pic_camera_on(void)
 {
-	int i, j;
+	int i, j, x;
+
+	if (!camera) {
+		printk(KERN_WARNING DRV_PFX "camera control not enabled\n");
+		return -ENODEV;
+	}
 
 	if (spic_dev.camera_power)
-		return;
+		return 0;
 
 	for (j = 5; j > 0; j--) {
 
-		while (sony_pic_call2(0x91, 0x1))
+		for (x = 0; x < 100 && sony_pic_call2(0x91, 0x1); x++)
 			msleep(10);
 		sony_pic_call1(0x93);
 
@@ -1262,8 +1278,8 @@ static void sony_pic_camera_on(void)
 	}
 
 	if (j == 0) {
-		printk(KERN_WARNING "sonypi: failed to power on camera\n");
-		return;
+		printk(KERN_WARNING DRV_PFX "failed to power on camera\n");
+		return -ENODEV;
 	}
 
 	wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_CONTROL,
@@ -1271,6 +1287,7 @@ static void sony_pic_camera_on(void)
 			ITERATIONS_SHORT);
 
 	spic_dev.camera_power = 1;
+	return 0;
 }
 
 static ssize_t sony_pic_camerapower_store(struct device *dev,
@@ -1278,14 +1295,18 @@ static ssize_t sony_pic_camerapower_stor
 		const char *buffer, size_t count)
 {
 	unsigned long value;
+	int result;
 	if (count > 31)
 		return -EINVAL;
 
 	value = simple_strtoul(buffer, NULL, 10);
 	if (value)
-		sony_pic_camera_on();
+		result = sony_pic_camera_on();
 	else
-		sony_pic_camera_off();
+		result = sony_pic_camera_off();
+
+	if (result)
+		return result;
 
 	return count;
 }
@@ -1662,7 +1683,7 @@ static int sonypi_compat_init(void)
 		goto err_free_kfifo;
 	}
 	if (minor == -1)
-		printk(KERN_INFO "sonypi: device allocated minor is %d\n",
+		printk(KERN_INFO DRV_PFX "device allocated minor is %d\n",
 		       sonypi_misc_device.minor);
 
 	return 0;

--
mattia
:wq!
