From: malattia@linux.it
Subject: [patch 7/9 v2] sony-laptop: add a meye-usable include file for camera ops
Date: Sat, 28 Apr 2007 23:34:36 +0900
Message-ID: <20070428143436.GG5293@inferi.kami.home>
References: <20070428141557.GA4764@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi11.ns.itscom.net ([219.110.2.181]:57638 "EHLO
	mtoichi11.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932309AbXD1OgJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Apr 2007 10:36:09 -0400
Content-Disposition: inline; filename="0014-sony-laptop-add-meye-interface.patch"
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>

Copy and rename (for easier co-existence) the MEYE-wise exported interface.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
Index: linux-2.6/include/linux/sony-laptop.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/include/linux/sony-laptop.h	2007-04-25 21:34:50.408379591 +0900
@@ -0,0 +1,34 @@
+#ifndef _SONYLAPTOP_H_
+#define _SONYLAPTOP_H_
+
+#include <linux/types.h>
+
+#ifdef __KERNEL__
+
+/* used only for communication between v4l and sony-laptop */
+
+#define SONY_PIC_COMMAND_GETCAMERA		 1	/* obsolete */
+#define SONY_PIC_COMMAND_SETCAMERA		 2
+#define SONY_PIC_COMMAND_GETCAMERABRIGHTNESS	 3	/* obsolete */
+#define SONY_PIC_COMMAND_SETCAMERABRIGHTNESS	 4
+#define SONY_PIC_COMMAND_GETCAMERACONTRAST	 5	/* obsolete */
+#define SONY_PIC_COMMAND_SETCAMERACONTRAST	 6
+#define SONY_PIC_COMMAND_GETCAMERAHUE		 7	/* obsolete */
+#define SONY_PIC_COMMAND_SETCAMERAHUE		 8
+#define SONY_PIC_COMMAND_GETCAMERACOLOR		 9	/* obsolete */
+#define SONY_PIC_COMMAND_SETCAMERACOLOR		10
+#define SONY_PIC_COMMAND_GETCAMERASHARPNESS	11	/* obsolete */
+#define SONY_PIC_COMMAND_SETCAMERASHARPNESS	12
+#define SONY_PIC_COMMAND_GETCAMERAPICTURE	13	/* obsolete */
+#define SONY_PIC_COMMAND_SETCAMERAPICTURE	14
+#define SONY_PIC_COMMAND_GETCAMERAAGC		15	/* obsolete */
+#define SONY_PIC_COMMAND_SETCAMERAAGC		16
+#define SONY_PIC_COMMAND_GETCAMERADIRECTION	17	/* obsolete */
+#define SONY_PIC_COMMAND_GETCAMERAROMVERSION	18	/* obsolete */
+#define SONY_PIC_COMMAND_GETCAMERAREVISION	19	/* obsolete */
+
+int sony_pic_camera_command(int command, u8 value);
+
+#endif	/* __KERNEL__ */
+
+#endif /* _SONYLAPTOP_H_ */
Index: linux-2.6/drivers/misc/sony-laptop.c
===================================================================
--- linux-2.6.orig/drivers/misc/sony-laptop.c	2007-04-25 21:49:18.957875406 +0900
+++ linux-2.6/drivers/misc/sony-laptop.c	2007-04-25 21:50:20.961408786 +0900
@@ -62,6 +62,7 @@
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
 #include <linux/sonypi.h>
+#include <linux/sony-laptop.h>
 #ifdef CONFIG_SONY_LAPTOP_OLD
 #include <linux/poll.h>
 #include <linux/miscdevice.h>
@@ -1359,37 +1360,37 @@ int sony_pic_camera_command(int command,
 	mutex_lock(&spic_dev.lock);
 
 	switch (command) {
-	case SONYPI_COMMAND_SETCAMERA:
+	case SONY_PIC_COMMAND_SETCAMERA:
 		if (value)
 			__sony_pic_camera_on();
 		else
 			__sony_pic_camera_off();
 		break;
-	case SONYPI_COMMAND_SETCAMERABRIGHTNESS:
+	case SONY_PIC_COMMAND_SETCAMERABRIGHTNESS:
 		wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_BRIGHTNESS, value),
 				ITERATIONS_SHORT);
 		break;
-	case SONYPI_COMMAND_SETCAMERACONTRAST:
+	case SONY_PIC_COMMAND_SETCAMERACONTRAST:
 		wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_CONTRAST, value),
 				ITERATIONS_SHORT);
 		break;
-	case SONYPI_COMMAND_SETCAMERAHUE:
+	case SONY_PIC_COMMAND_SETCAMERAHUE:
 		wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_HUE, value),
 				ITERATIONS_SHORT);
 		break;
-	case SONYPI_COMMAND_SETCAMERACOLOR:
+	case SONY_PIC_COMMAND_SETCAMERACOLOR:
 		wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_COLOR, value),
 				ITERATIONS_SHORT);
 		break;
-	case SONYPI_COMMAND_SETCAMERASHARPNESS:
+	case SONY_PIC_COMMAND_SETCAMERASHARPNESS:
 		wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_SHARPNESS, value),
 				ITERATIONS_SHORT);
 		break;
-	case SONYPI_COMMAND_SETCAMERAPICTURE:
+	case SONY_PIC_COMMAND_SETCAMERAPICTURE:
 		wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_PICTURE, value),
 				ITERATIONS_SHORT);
 		break;
-	case SONYPI_COMMAND_SETCAMERAAGC:
+	case SONY_PIC_COMMAND_SETCAMERAAGC:
 		wait_on_command(sony_pic_call3(0x90, SONYPI_CAMERA_AGC, value),
 				ITERATIONS_SHORT);
 		break;

--
mattia
:wq!
