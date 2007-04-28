From: malattia@linux.it
Subject: [patch 8/9 v2] meye: make meye use sony-laptop instead of sonypi
Date: Sat, 28 Apr 2007 23:36:26 +0900
Message-ID: <20070428143626.GH5293@inferi.kami.home>
References: <20070428141557.GA4764@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi14.ns.itscom.net ([219.110.2.184]:61040 "EHLO
	mtoichi14.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964784AbXD1Ohr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Apr 2007 10:37:47 -0400
Content-Disposition: inline; filename="0015-meye-use-sony-laptop.patch"
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>

Change sonypi_camera_command() calls to sony_pic_camera_command() and use
the renamed macros.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
Index: linux-2.6/drivers/media/video/meye.c
===================================================================
--- linux-2.6.orig/drivers/media/video/meye.c	2007-04-25 22:21:20.067353196 +0900
+++ linux-2.6/drivers/media/video/meye.c	2007-04-25 22:35:21.115281786 +0900
@@ -925,13 +925,13 @@ static int meye_do_ioctl(struct inode *i
 		if (p->palette != VIDEO_PALETTE_YUV422 && p->palette != VIDEO_PALETTE_YUYV)
 			return -EINVAL;
 		mutex_lock(&meye.lock);
-		sonypi_camera_command(SONYPI_COMMAND_SETCAMERABRIGHTNESS,
+		sony_pic_camera_command(SONY_PIC_COMMAND_SETCAMERABRIGHTNESS,
 				      p->brightness >> 10);
-		sonypi_camera_command(SONYPI_COMMAND_SETCAMERAHUE,
+		sony_pic_camera_command(SONY_PIC_COMMAND_SETCAMERAHUE,
 				      p->hue >> 10);
-		sonypi_camera_command(SONYPI_COMMAND_SETCAMERACOLOR,
+		sony_pic_camera_command(SONY_PIC_COMMAND_SETCAMERACOLOR,
 				      p->colour >> 10);
-		sonypi_camera_command(SONYPI_COMMAND_SETCAMERACONTRAST,
+		sony_pic_camera_command(SONY_PIC_COMMAND_SETCAMERACONTRAST,
 				      p->contrast >> 10);
 		meye.picture = *p;
 		mutex_unlock(&meye.lock);
@@ -1043,11 +1043,11 @@ static int meye_do_ioctl(struct inode *i
 		    meye.params.quality != jp->quality)
 			mchip_hic_stop();	/* need restart */
 		meye.params = *jp;
-		sonypi_camera_command(SONYPI_COMMAND_SETCAMERASHARPNESS,
+		sony_pic_camera_command(SONY_PIC_COMMAND_SETCAMERASHARPNESS,
 				      meye.params.sharpness);
-		sonypi_camera_command(SONYPI_COMMAND_SETCAMERAAGC,
+		sony_pic_camera_command(SONY_PIC_COMMAND_SETCAMERAAGC,
 				      meye.params.agc);
-		sonypi_camera_command(SONYPI_COMMAND_SETCAMERAPICTURE,
+		sony_pic_camera_command(SONY_PIC_COMMAND_SETCAMERAPICTURE,
 				      meye.params.picture);
 		mutex_unlock(&meye.lock);
 		break;
@@ -1287,38 +1287,38 @@ static int meye_do_ioctl(struct inode *i
 		mutex_lock(&meye.lock);
 		switch (c->id) {
 		case V4L2_CID_BRIGHTNESS:
-			sonypi_camera_command(
-				SONYPI_COMMAND_SETCAMERABRIGHTNESS, c->value);
+			sony_pic_camera_command(
+				SONY_PIC_COMMAND_SETCAMERABRIGHTNESS, c->value);
 			meye.picture.brightness = c->value << 10;
 			break;
 		case V4L2_CID_HUE:
-			sonypi_camera_command(
-				SONYPI_COMMAND_SETCAMERAHUE, c->value);
+			sony_pic_camera_command(
+				SONY_PIC_COMMAND_SETCAMERAHUE, c->value);
 			meye.picture.hue = c->value << 10;
 			break;
 		case V4L2_CID_CONTRAST:
-			sonypi_camera_command(
-				SONYPI_COMMAND_SETCAMERACONTRAST, c->value);
+			sony_pic_camera_command(
+				SONY_PIC_COMMAND_SETCAMERACONTRAST, c->value);
 			meye.picture.contrast = c->value << 10;
 			break;
 		case V4L2_CID_SATURATION:
-			sonypi_camera_command(
-				SONYPI_COMMAND_SETCAMERACOLOR, c->value);
+			sony_pic_camera_command(
+				SONY_PIC_COMMAND_SETCAMERACOLOR, c->value);
 			meye.picture.colour = c->value << 10;
 			break;
 		case V4L2_CID_AGC:
-			sonypi_camera_command(
-				SONYPI_COMMAND_SETCAMERAAGC, c->value);
+			sony_pic_camera_command(
+				SONY_PIC_COMMAND_SETCAMERAAGC, c->value);
 			meye.params.agc = c->value;
 			break;
 		case V4L2_CID_SHARPNESS:
-			sonypi_camera_command(
-				SONYPI_COMMAND_SETCAMERASHARPNESS, c->value);
+			sony_pic_camera_command(
+				SONY_PIC_COMMAND_SETCAMERASHARPNESS, c->value);
 			meye.params.sharpness = c->value;
 			break;
 		case V4L2_CID_PICTURE:
-			sonypi_camera_command(
-				SONYPI_COMMAND_SETCAMERAPICTURE, c->value);
+			sony_pic_camera_command(
+				SONY_PIC_COMMAND_SETCAMERAPICTURE, c->value);
 			meye.params.picture = c->value;
 			break;
 		case V4L2_CID_JPEGQUAL:
@@ -1848,7 +1848,7 @@ static int __devinit meye_probe(struct p
 	memcpy(meye.video_dev, &meye_template, sizeof(meye_template));
 	meye.video_dev->dev = &meye.mchip_dev->dev;
 
-	if ((ret = sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 1))) {
+	if ((ret = sony_pic_camera_command(SONY_PIC_COMMAND_SETCAMERA, 1))) {
 		printk(KERN_ERR "meye: unable to power on the camera\n");
 		printk(KERN_ERR "meye: did you enable the camera in "
 				"sonypi using the module options ?\n");
@@ -1928,13 +1928,13 @@ static int __devinit meye_probe(struct p
 	meye.params.picture = 0;
 	meye.params.framerate = 0;
 
-	sonypi_camera_command(SONYPI_COMMAND_SETCAMERABRIGHTNESS, 32);
-	sonypi_camera_command(SONYPI_COMMAND_SETCAMERAHUE, 32);
-	sonypi_camera_command(SONYPI_COMMAND_SETCAMERACOLOR, 32);
-	sonypi_camera_command(SONYPI_COMMAND_SETCAMERACONTRAST, 32);
-	sonypi_camera_command(SONYPI_COMMAND_SETCAMERASHARPNESS, 32);
-	sonypi_camera_command(SONYPI_COMMAND_SETCAMERAPICTURE, 0);
-	sonypi_camera_command(SONYPI_COMMAND_SETCAMERAAGC, 48);
+	sony_pic_camera_command(SONY_PIC_COMMAND_SETCAMERABRIGHTNESS, 32);
+	sony_pic_camera_command(SONY_PIC_COMMAND_SETCAMERAHUE, 32);
+	sony_pic_camera_command(SONY_PIC_COMMAND_SETCAMERACOLOR, 32);
+	sony_pic_camera_command(SONY_PIC_COMMAND_SETCAMERACONTRAST, 32);
+	sony_pic_camera_command(SONY_PIC_COMMAND_SETCAMERASHARPNESS, 32);
+	sony_pic_camera_command(SONY_PIC_COMMAND_SETCAMERAPICTURE, 0);
+	sony_pic_camera_command(SONY_PIC_COMMAND_SETCAMERAAGC, 48);
 
 	printk(KERN_INFO "meye: Motion Eye Camera Driver v%s.\n",
 	       MEYE_DRIVER_VERSION);
@@ -1953,7 +1953,7 @@ outremap:
 outregions:
 	pci_disable_device(meye.mchip_dev);
 outenabledev:
-	sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 0);
+	sony_pic_camera_command(SONY_PIC_COMMAND_SETCAMERA, 0);
 outsonypienable:
 	kfifo_free(meye.doneq);
 outkfifoalloc2:
@@ -1986,7 +1986,7 @@ static void __devexit meye_remove(struct
 
 	pci_disable_device(meye.mchip_dev);
 
-	sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 0);
+	sony_pic_camera_command(SONY_PIC_COMMAND_SETCAMERA, 0);
 
 	kfifo_free(meye.doneq);
 	kfifo_free(meye.grabq);
Index: linux-2.6/drivers/media/video/meye.h
===================================================================
--- linux-2.6.orig/drivers/media/video/meye.h	2007-04-25 22:21:20.067353196 +0900
+++ linux-2.6/drivers/media/video/meye.h	2007-04-25 22:35:21.115281786 +0900
@@ -255,7 +255,7 @@
 /****************************************************************************/
 
 /* Sony Programmable I/O Controller for accessing the camera commands */
-#include <linux/sonypi.h>
+#include <linux/sony-laptop.h>
 
 /* private API definitions */
 #include <linux/meye.h>
Index: linux-2.6/drivers/media/video/Kconfig
===================================================================
--- linux-2.6.orig/drivers/media/video/Kconfig	2007-04-27 23:11:42.404111919 +0900
+++ linux-2.6/drivers/media/video/Kconfig	2007-04-27 23:12:35.907160884 +0900
@@ -577,14 +577,14 @@ config VIDEO_ZORAN_AVS6EYES
 
 config VIDEO_MEYE
 	tristate "Sony Vaio Picturebook Motion Eye Video For Linux"
-	depends on PCI && SONYPI && VIDEO_V4L1
+	depends on PCI && SONY_LAPTOP && VIDEO_V4L1
 	---help---
 	  This is the video4linux driver for the Motion Eye camera found
 	  in the Vaio Picturebook laptops. Please read the material in
 	  <file:Documentation/video4linux/meye.txt> for more information.
 
-	  If you say Y or M here, you need to say Y or M to "Sony Programmable
-	  I/O Control Device" in the character device section.
+	  If you say Y or M here, you need to say Y or M to "Sony Laptop
+	  Extras" in the misc device section.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called meye.
Index: linux-2.6/Documentation/video4linux/meye.txt
===================================================================
--- linux-2.6.orig/Documentation/video4linux/meye.txt	2007-04-27 23:15:28.917020154 +0900
+++ linux-2.6/Documentation/video4linux/meye.txt	2007-04-27 23:15:44.417903499 +0900
@@ -5,10 +5,9 @@ Vaio Picturebook Motion Eye Camera Drive
 	Copyright (C) 2000 Andrew Tridgell <tridge@samba.org>
 
 This driver enable the use of video4linux compatible applications with the
-Motion Eye camera. This driver requires the "Sony Vaio Programmable I/O
-Control Device" driver (which can be found in the "Character drivers"
-section of the kernel configuration utility) to be compiled and installed
-(using its "camera=1" parameter).
+Motion Eye camera. This driver requires the "Sony Laptop Extras" driver (which
+can be found in the "Misc devices" section of the kernel configuration utility)
+to be compiled and installed (using its "camera=1" parameter).
 
 It can do at maximum 30 fps @ 320x240 or 15 fps @ 640x480.
 

--
mattia
:wq!
