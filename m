From: jayakumar.acpi@gmail.com
Subject: [PATCH 2.6.17.4 1/1] ACPI: Atlas cleanup
Date: Sat, 8 Jul 2006 13:52:01 +0800
Message-ID: <200607080552.k685q1ce010124@localhost.localdomain>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [202.75.186.170] ([202.75.186.170]:27832 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S964788AbWGHFxH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 8 Jul 2006 01:53:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, len.brown@intel.com, dmitry.torokhov@gmail.com, akpm@osdl.org

This patch removes legacy usage of acpi events in the Atlas ACPI driver.

Signed-off-by: Jaya Kumar <jayakumar.acpi@gmail.com>

---

 Kconfig      |    6 +++---
 atlas_acpi.c |   16 +++-------------
 2 files changed, 6 insertions(+), 16 deletions(-)

---

diff -X linux-2.6.17.4/Documentation/dontdiff -uprN linux-2.6.17.4-vanilla/drivers/acpi/atlas_acpi.c linux-2.6.17.4/drivers/acpi/atlas_acpi.c
--- linux-2.6.17.4-vanilla/drivers/acpi/atlas_acpi.c	2006-07-08 00:49:29.000000000 +0800
+++ linux-2.6.17.4/drivers/acpi/atlas_acpi.c	2006-07-08 00:49:11.000000000 +0800
@@ -26,7 +26,6 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/types.h>
-#include <linux/proc_fs.h>
 #include <asm/uaccess.h>
 #include <acpi/acpi_drivers.h>
 
@@ -34,7 +33,6 @@
 #define ACPI_ATLAS_CLASS		"Atlas"
 #define ACPI_ATLAS_BUTTON_HID		"ASIM0000"
 
-#ifdef CONFIG_INPUT
 static struct input_dev *input_dev;
 
 static void atlas_input_report(u8 address)
@@ -62,7 +60,7 @@ static int atlas_setup_input(void)
 	}
 
 	input_dev->name = "Atlas ACPI button driver";
-	input_dev->phys = "acpi/input0";
+	input_dev->phys = "ASIM0000/atlas/input0";
 	input_dev->id.bustype = BUS_HOST;
 	input_dev->evbit[LONG(EV_KEY)] = BIT(EV_KEY);
 	set_bit(KEY_F1, input_dev->keybit);
@@ -89,13 +87,7 @@ static void atlas_free_input(void)
 {
 	if (input_dev)
 		input_unregister_device(input_dev);
-
 }
-#else
-#define atlas_free_input(...)
-#define atlas_setup_input(...) 0
-#define atlas_input_report(...)
-#endif
 
 /* button handling code */
 static acpi_status acpi_atlas_button_setup(acpi_handle region_handle,
@@ -113,12 +105,10 @@ static acpi_status acpi_atlas_button_han
 		      void *handler_context, void *region_context)
 {
 	acpi_status status;
-	struct acpi_device *dev = handler_context;
 
-	if (function == ACPI_WRITE) {
-		status = acpi_bus_generate_event(dev, 0x80, address);
+	if (function == ACPI_WRITE) 
 		atlas_input_report((u8) address);
-	} else {
+	else {
 		printk(KERN_WARNING "atlas: shrugged on unexpected function"
 			":function=%x,address=%lx,value=%x\n",
 			function, (unsigned long)address, (u32)*value);
diff -X linux-2.6.17.4/Documentation/dontdiff -uprN linux-2.6.17.4-vanilla/drivers/acpi/Kconfig linux-2.6.17.4/drivers/acpi/Kconfig
--- linux-2.6.17.4-vanilla/drivers/acpi/Kconfig	2006-07-08 00:49:29.000000000 +0800
+++ linux-2.6.17.4/drivers/acpi/Kconfig	2006-07-08 13:41:41.000000000 +0800
@@ -195,12 +195,12 @@ config ACPI_ASUS
 
 config ACPI_ATLAS
 	tristate "Atlas Wallmount Touchscreen Extras"
-	depends on X86
+	depends on X86 && INPUT
 	default n
          ---help---
           This driver is intended for Atlas wallmounted touchscreens.
-          The button events will show up in /proc/acpi/events and also
-          as scancodes F1 through F9, and in X if you use evdev.
+          The button events will show up as scancodes F1 through F9 via
+          evdev. 
 
           If you have an Atlas wallmounted touchscreen, say Y or M here.
 
