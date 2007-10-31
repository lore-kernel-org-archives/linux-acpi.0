From: Dmitry Torokhov <dtor@insightbb.com>
Subject: [PATCH 2/2] Sonypi: fit input devices into sysfs tree
Date: Wed, 31 Oct 2007 00:43:10 -0400
Message-ID: <200710310043.10250.dtor@insightbb.com>
References: <200710310041.54252.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mxsf08.insightbb.com ([74.128.0.78]:46290 "EHLO
	mxsf08.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbXJaEnM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Oct 2007 00:43:12 -0400
In-Reply-To: <200710310041.54252.dtor@insightbb.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

Subject: Sonypi: fit input devices into sysfs tree
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Properly set up parent on input devices registered by sonypi.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/char/sonypi.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux/drivers/char/sonypi.c
===================================================================
--- linux.orig/drivers/char/sonypi.c
+++ linux/drivers/char/sonypi.c
@@ -1163,7 +1163,7 @@ static struct acpi_driver sonypi_acpi_dr
 };
 #endif
 
-static int __devinit sonypi_create_input_devices(void)
+static int __devinit sonypi_create_input_devices(struct platform_device *pdev)
 {
 	struct input_dev *jog_dev;
 	struct input_dev *key_dev;
@@ -1177,6 +1177,7 @@ static int __devinit sonypi_create_input
 	jog_dev->name = "Sony Vaio Jogdial";
 	jog_dev->id.bustype = BUS_ISA;
 	jog_dev->id.vendor = PCI_VENDOR_ID_SONY;
+	jog_dev->dev.parent = &pdev->dev;
 
 	jog_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
 	jog_dev->keybit[BIT_WORD(BTN_MOUSE)] = BIT_MASK(BTN_MIDDLE);
@@ -1191,6 +1192,7 @@ static int __devinit sonypi_create_input
 	key_dev->name = "Sony Vaio Keys";
 	key_dev->id.bustype = BUS_ISA;
 	key_dev->id.vendor = PCI_VENDOR_ID_SONY;
+	key_dev->dev.parent = &pdev->dev;
 
 	/* Initialize the Input Drivers: special keys */
 	key_dev->evbit[0] = BIT_MASK(EV_KEY);
@@ -1385,7 +1387,7 @@ static int __devinit sonypi_probe(struct
 
 	if (useinput) {
 
-		error = sonypi_create_input_devices();
+		error = sonypi_create_input_devices(dev);
 		if (error) {
 			printk(KERN_ERR
 				"sonypi: failed to create input devices\n");
