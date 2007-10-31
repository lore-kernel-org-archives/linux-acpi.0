From: Dmitry Torokhov <dtor@insightbb.com>
Subject: [PATCH] sony-laptop: fit input devices into sysfs tree
Date: Wed, 31 Oct 2007 00:36:52 -0400
Message-ID: <200710310036.52791.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mxsf06.insightbb.com ([74.128.0.76]:61504 "EHLO
	mxsf06.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbXJaEqd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Oct 2007 00:46:33 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

Hi Mattia,

Here is a small patch for sony-laptop. Untested since I don't
have the hardware.

-- 
Dmitry

Subject: sony-laptop: fit input devices into sysfs tree
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Properly set up parent on input devices registered by sony-laptop.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/misc/sony-laptop.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Index: linux/drivers/misc/sony-laptop.c
===================================================================
--- linux.orig/drivers/misc/sony-laptop.c
+++ linux/drivers/misc/sony-laptop.c
@@ -338,7 +338,7 @@ static void sony_laptop_report_input_eve
 		dprintk("unknown input event %.2x\n", event);
 }
 
-static int sony_laptop_setup_input(void)
+static int sony_laptop_setup_input(struct acpi_device *acpi_device)
 {
 	struct input_dev *jog_dev;
 	struct input_dev *key_dev;
@@ -379,6 +379,7 @@ static int sony_laptop_setup_input(void)
 	key_dev->name = "Sony Vaio Keys";
 	key_dev->id.bustype = BUS_ISA;
 	key_dev->id.vendor = PCI_VENDOR_ID_SONY;
+	key_dev->dev.parent = &acpi_device->dev;
 
 	/* Initialize the Input Drivers: special keys */
 	set_bit(EV_KEY, key_dev->evbit);
@@ -410,6 +411,7 @@ static int sony_laptop_setup_input(void)
 	jog_dev->name = "Sony Vaio Jogdial";
 	jog_dev->id.bustype = BUS_ISA;
 	jog_dev->id.vendor = PCI_VENDOR_ID_SONY;
+	key_dev->dev.parent = &acpi_device->dev;
 
 	jog_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
 	jog_dev->keybit[BIT_WORD(BTN_MOUSE)] = BIT_MASK(BTN_MIDDLE);
@@ -1006,7 +1008,7 @@ static int sony_nc_add(struct acpi_devic
 	}
 
 	/* setup input devices and helper fifo */
-	result = sony_laptop_setup_input();
+	result = sony_laptop_setup_input(device);
 	if (result) {
 		printk(KERN_ERR DRV_PFX
 				"Unabe to create input devices.\n");
@@ -1034,7 +1036,7 @@ static int sony_nc_add(struct acpi_devic
 			sony_backlight_device->props.brightness =
 			    sony_backlight_get_brightness
 			    (sony_backlight_device);
-			sony_backlight_device->props.max_brightness = 
+			sony_backlight_device->props.max_brightness =
 			    SONY_MAX_BRIGHTNESS - 1;
 		}
 
@@ -2453,7 +2455,7 @@ static int sony_pic_add(struct acpi_devi
 	}
 
 	/* setup input devices and helper fifo */
-	result = sony_laptop_setup_input();
+	result = sony_laptop_setup_input(device);
 	if (result) {
 		printk(KERN_ERR DRV_PFX
 				"Unabe to create input devices.\n");
