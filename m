From: malattia@linux.it
Subject: [patch 6/9 v2] sony-laptop: complete the motion eye camera support in sony-laptop
Date: Sat, 28 Apr 2007 23:34:22 +0900
Message-ID: <20070428143422.GF5293@inferi.kami.home>
References: <20070428141557.GA4764@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi16.ns.itscom.net ([219.110.2.186]:46300 "EHLO
	mtoichi16.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938AbXD1Ofr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Apr 2007 10:35:47 -0400
Content-Disposition: inline; filename="0013-complete-motion-eye-camera-support-from-sonypi.patch"
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>

Add the exported sony_pic_camera_command() function to make the MEYE
driver happy.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
Index: linux-2.6/drivers/misc/sony-laptop.c
===================================================================
--- linux-2.6.orig/drivers/misc/sony-laptop.c	2007-04-25 18:52:34.353553446 +0900
+++ linux-2.6/drivers/misc/sony-laptop.c	2007-04-25 18:52:37.353724416 +0900
@@ -1220,11 +1220,35 @@ static u8 sony_pic_call3(u8 dev, u8 fn, 
 
 /* camera tests and poweron/poweroff */
 #define SONYPI_CAMERA_PICTURE		5
-#define SONYPI_CAMERA_MUTE_MASK		0x40
 #define SONYPI_CAMERA_CONTROL		0x10
-#define SONYPI_CAMERA_STATUS 		7
-#define SONYPI_CAMERA_STATUS_READY 	0x2
-#define SONYPI_CAMERA_STATUS_POSITION	0x4
+
+#define SONYPI_CAMERA_BRIGHTNESS		0
+#define SONYPI_CAMERA_CONTRAST			1
+#define SONYPI_CAMERA_HUE			2
+#define SONYPI_CAMERA_COLOR			3
+#define SONYPI_CAMERA_SHARPNESS			4
+
+#define SONYPI_CAMERA_EXPOSURE_MASK		0xC
+#define SONYPI_CAMERA_WHITE_BALANCE_MASK	0x3
+#define SONYPI_CAMERA_PICTURE_MODE_MASK		0x30
+#define SONYPI_CAMERA_MUTE_MASK			0x40
+
+/* the rest don't need a loop until not 0xff */
+#define SONYPI_CAMERA_AGC			6
+#define SONYPI_CAMERA_AGC_MASK			0x30
+#define SONYPI_CAMERA_SHUTTER_MASK 		0x7
+
+#define SONYPI_CAMERA_SHUTDOWN_REQUEST		7
+#define SONYPI_CAMERA_CONTROL			0x10
+
+#define SONYPI_CAMERA_STATUS 			7
+#define SONYPI_CAMERA_STATUS_READY 		0x2
+#define SONYPI_CAMERA_STATUS_POSITION		0x4
+
+#define SONYPI_DIRECTION_BACKWARDS 		0x4
+
+#define SONYPI_CAMERA_REVISION 			8
+#define SONYPI_CAMERA_ROMVERSION 		9
 
 static int __sony_pic_camera_ready(void)
 {
@@ -1234,14 +1258,13 @@ static int __sony_pic_camera_ready(void)
 	return (v != 0xff && (v & SONYPI_CAMERA_STATUS_READY));
 }
 
-static int sony_pic_camera_off(void)
+static int __sony_pic_camera_off(void)
 {
 	if (!camera) {
 		printk(KERN_WARNING DRV_PFX "camera control not enabled\n");
 		return -ENODEV;
 	}
 
-	mutex_lock(&spic_dev.lock);
 	wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_PICTURE,
 				SONYPI_CAMERA_MUTE_MASK),
 			ITERATIONS_SHORT);
@@ -1250,23 +1273,20 @@ static int sony_pic_camera_off(void)
 		sony_pic_call2(0x91, 0);
 		spic_dev.camera_power = 0;
 	}
-	mutex_unlock(&spic_dev.lock);
 	return 0;
 }
 
-static int sony_pic_camera_on(void)
+static int __sony_pic_camera_on(void)
 {
 	int i, j, x;
-	int result = 0;
 
 	if (!camera) {
 		printk(KERN_WARNING DRV_PFX "camera control not enabled\n");
 		return -ENODEV;
 	}
 
-	mutex_lock(&spic_dev.lock);
 	if (spic_dev.camera_power)
-		goto out_unlock;
+		return 0;
 
 	for (j = 5; j > 0; j--) {
 
@@ -1285,8 +1305,7 @@ static int sony_pic_camera_on(void)
 
 	if (j == 0) {
 		printk(KERN_WARNING DRV_PFX "failed to power on camera\n");
-		result = -ENODEV;
-		goto out_unlock;
+		return -ENODEV;
 	}
 
 	wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_CONTROL,
@@ -1294,9 +1313,6 @@ static int sony_pic_camera_on(void)
 			ITERATIONS_SHORT);
 
 	spic_dev.camera_power = 1;
-
-out_unlock:
-	mutex_unlock(&spic_dev.lock);
 	return 0;
 }
 
@@ -1310,10 +1326,13 @@ static ssize_t sony_pic_camerapower_stor
 		return -EINVAL;
 
 	value = simple_strtoul(buffer, NULL, 10);
+
+	mutex_lock(&spic_dev.lock);
 	if (value)
-		result = sony_pic_camera_on();
+		result = __sony_pic_camera_on();
 	else
-		result = sony_pic_camera_off();
+		result = __sony_pic_camera_off();
+	mutex_unlock(&spic_dev.lock);
 
 	if (result)
 		return result;
@@ -1331,6 +1350,59 @@ static ssize_t sony_pic_camerapower_show
 	return count;
 }
 
+/* External camera command (exported to the motion eye v4l driver) */
+int sony_pic_camera_command(int command, u8 value)
+{
+	if (!camera)
+		return -EIO;
+
+	mutex_lock(&spic_dev.lock);
+
+	switch (command) {
+	case SONYPI_COMMAND_SETCAMERA:
+		if (value)
+			__sony_pic_camera_on();
+		else
+			__sony_pic_camera_off();
+		break;
+	case SONYPI_COMMAND_SETCAMERABRIGHTNESS:
+		wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_BRIGHTNESS, value),
+				ITERATIONS_SHORT);
+		break;
+	case SONYPI_COMMAND_SETCAMERACONTRAST:
+		wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_CONTRAST, value),
+				ITERATIONS_SHORT);
+		break;
+	case SONYPI_COMMAND_SETCAMERAHUE:
+		wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_HUE, value),
+				ITERATIONS_SHORT);
+		break;
+	case SONYPI_COMMAND_SETCAMERACOLOR:
+		wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_COLOR, value),
+				ITERATIONS_SHORT);
+		break;
+	case SONYPI_COMMAND_SETCAMERASHARPNESS:
+		wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_SHARPNESS, value),
+				ITERATIONS_SHORT);
+		break;
+	case SONYPI_COMMAND_SETCAMERAPICTURE:
+		wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_PICTURE, value),
+				ITERATIONS_SHORT);
+		break;
+	case SONYPI_COMMAND_SETCAMERAAGC:
+		wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_AGC, value),
+				ITERATIONS_SHORT);
+		break;
+	default:
+		printk(KERN_ERR DRV_PFX "sony_pic_camera_command invalid: %d\n",
+		       command);
+		break;
+	}
+	mutex_unlock(&spic_dev.lock);
+	return 0;
+}
+EXPORT_SYMBOL(sony_pic_camera_command);
+
 /* gprs/edge modem (SZ460N and SZ210P), thanks to Joshua Wise */
 static void sony_pic_set_wwanpower(u8 state)
 {

--
mattia
:wq!
