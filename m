From: malattia@linux.it
Subject: [patch 2/9 v2] sony-laptop: add locking on accesses to the ioport and global vars
Date: Sat, 28 Apr 2007 23:19:36 +0900
Message-ID: <20070428141936.GB5293@inferi.kami.home>
References: <20070428141557.GA4764@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi14.ns.itscom.net ([219.110.2.184]:51915 "EHLO
	mtoichi14.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbXD1OVK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Apr 2007 10:21:10 -0400
Content-Disposition: inline; filename="0009-add-locking-to-ioport-code-paths.patch"
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>

Better avoid having ioport commands mixing and global variables reading/writing.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
Index: linux-2.6/drivers/misc/sony-laptop.c
===================================================================
--- linux-2.6.orig/drivers/misc/sony-laptop.c	2007-04-25 18:50:52.347740466 +0900
+++ linux-2.6/drivers/misc/sony-laptop.c	2007-04-25 22:21:24.067581156 +0900
@@ -928,6 +928,7 @@ struct sony_pic_dev {
 	struct sony_pic_ioport	*cur_ioport;
 	struct list_head	interrupts;
 	struct list_head	ioports;
+	struct mutex		lock;
 };
 
 static struct sony_pic_dev spic_dev = {
@@ -1224,7 +1225,7 @@ static u8 sony_pic_call3(u8 dev, u8 fn, 
 #define SONYPI_CAMERA_STATUS_READY 	0x2
 #define SONYPI_CAMERA_STATUS_POSITION	0x4
 
-static int sony_pic_camera_ready(void)
+static int __sony_pic_camera_ready(void)
 {
 	u8 v;
 
@@ -1239,6 +1240,7 @@ static int sony_pic_camera_off(void)
 		return -ENODEV;
 	}
 
+	mutex_lock(&spic_dev.lock);
 	wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_PICTURE,
 				SONYPI_CAMERA_MUTE_MASK),
 			ITERATIONS_SHORT);
@@ -1247,20 +1249,23 @@ static int sony_pic_camera_off(void)
 		sony_pic_call2(0x91, 0);
 		spic_dev.camera_power = 0;
 	}
+	mutex_unlock(&spic_dev.lock);
 	return 0;
 }
 
 static int sony_pic_camera_on(void)
 {
 	int i, j, x;
+	int result = 0;
 
 	if (!camera) {
 		printk(KERN_WARNING DRV_PFX "camera control not enabled\n");
 		return -ENODEV;
 	}
 
+	mutex_lock(&spic_dev.lock);
 	if (spic_dev.camera_power)
-		return 0;
+		goto out_unlock;
 
 	for (j = 5; j > 0; j--) {
 
@@ -1269,7 +1274,7 @@ static int sony_pic_camera_on(void)
 		sony_pic_call1(0x93);
 
 		for (i = 400; i > 0; i--) {
-			if (sony_pic_camera_ready())
+			if (__sony_pic_camera_ready())
 				break;
 			msleep(10);
 		}
@@ -1279,7 +1284,8 @@ static int sony_pic_camera_on(void)
 
 	if (j == 0) {
 		printk(KERN_WARNING DRV_PFX "failed to power on camera\n");
-		return -ENODEV;
+		result = -ENODEV;
+		goto out_unlock;
 	}
 
 	wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_CONTROL,
@@ -1287,6 +1293,9 @@ static int sony_pic_camera_on(void)
 			ITERATIONS_SHORT);
 
 	spic_dev.camera_power = 1;
+
+out_unlock:
+	mutex_unlock(&spic_dev.lock);
 	return 0;
 }
 
@@ -1314,11 +1323,15 @@ static ssize_t sony_pic_camerapower_stor
 static ssize_t sony_pic_camerapower_show(struct device *dev,
 		struct device_attribute *attr, char *buffer)
 {
-	return snprintf(buffer, PAGE_SIZE, "%d\n", spic_dev.camera_power);
+	ssize_t count;
+	mutex_lock(&spic_dev.lock);
+	count = snprintf(buffer, PAGE_SIZE, "%d\n", spic_dev.camera_power);
+	mutex_unlock(&spic_dev.lock);
+	return count;
 }
 
 /* bluetooth subsystem power state */
-static void sony_pic_set_bluetoothpower(u8 state)
+static void __sony_pic_set_bluetoothpower(u8 state)
 {
 	state = !!state;
 	if (spic_dev.bluetooth_power == state)
@@ -1337,7 +1350,9 @@ static ssize_t sony_pic_bluetoothpower_s
 		return -EINVAL;
 
 	value = simple_strtoul(buffer, NULL, 10);
-	sony_pic_set_bluetoothpower(value);
+	mutex_lock(&spic_dev.lock);
+	__sony_pic_set_bluetoothpower(value);
+	mutex_unlock(&spic_dev.lock);
 
 	return count;
 }
@@ -1345,7 +1360,11 @@ static ssize_t sony_pic_bluetoothpower_s
 static ssize_t sony_pic_bluetoothpower_show(struct device *dev,
 		struct device_attribute *attr, char *buffer)
 {
-	return snprintf(buffer, PAGE_SIZE, "%d\n", spic_dev.bluetooth_power);
+	ssize_t count = 0;
+	mutex_lock(&spic_dev.lock);
+	count = snprintf(buffer, PAGE_SIZE, "%d\n", spic_dev.bluetooth_power);
+	mutex_unlock(&spic_dev.lock);
+	return count;
 }
 
 /* fan speed */
@@ -1518,7 +1537,7 @@ static int sonypi_misc_ioctl(struct inod
 	u16 val16;
 	int value;
 
-	/*down(&sonypi_device.lock);*/
+	mutex_lock(&spic_dev.lock);
 	switch (cmd) {
 	case SONYPI_IOCGBRT:
 		if (sony_backlight_device == NULL) {
@@ -1602,7 +1621,7 @@ static int sonypi_misc_ioctl(struct inod
 			ret = -EFAULT;
 			break;
 		}
-		sony_pic_set_bluetoothpower(val8);
+		__sony_pic_set_bluetoothpower(val8);
 		break;
 	/* FAN Controls */
 	case SONYPI_IOCGFAN:
@@ -1633,7 +1652,7 @@ static int sonypi_misc_ioctl(struct inod
 	default:
 		ret = -EINVAL;
 	}
-	/*up(&sonypi_device.lock);*/
+	mutex_unlock(&spic_dev.lock);
 	return ret;
 }
 
@@ -1673,7 +1692,6 @@ static int sonypi_compat_init(void)
 	}
 
 	init_waitqueue_head(&sonypi_compat.fifo_proc_list);
-	/*init_MUTEX(&sonypi_device.lock);*/
 
 	if (minor != -1)
 		sonypi_misc_device.minor = minor;
@@ -2004,6 +2022,7 @@ static int sony_pic_add(struct acpi_devi
 	spic_dev.acpi_dev = device;
 	strcpy(acpi_device_class(device), "sony/hotkey");
 	spic_dev.model = sony_pic_detect_device_type();
+	mutex_init(&spic_dev.lock);
 
 	/* read _PRS resources */
 	result = sony_pic_possible_resources(device);

-- 
mattia
:wq!
