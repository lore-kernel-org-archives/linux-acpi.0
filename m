From: jayakumar.acpi@gmail.com
Subject: [PATCH 2.6.17.4 1/1] ACPI,INPUT: Move atlas to input
Date: Tue, 25 Jul 2006 17:09:01 +0800
Message-ID: <200607250909.k6P991HK011003@localhost.localdomain>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [202.75.186.170] ([202.75.186.170]:15364 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751535AbWGYJbG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Jul 2006 05:31:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, len.brown@intel.com, dmitry.torokhov@gmail.com, akpm@osdl.org, akpm@kernel.org, linux-input@atrey.karlin.mff.cuni.cz

This patch moves the Atlas driver from acpi over to input/misc and adds
check for acpi_disabled. Added maintainer entry as per Len's request. 

Signed-off-by: Jaya Kumar <jayakumar.acpi@gmail.com>

---

 MAINTAINERS                     |    5 +
 drivers/acpi/Kconfig            |   11 --
 drivers/acpi/Makefile           |    1 
 drivers/acpi/atlas_acpi.c       |  181 ---------------------------------------
 drivers/input/misc/Kconfig      |   10 ++
 drivers/input/misc/Makefile     |    1 
 drivers/input/misc/atlas_btns.c |  184 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 200 insertions(+), 193 deletions(-)

---

diff -X linux-2.6.17.4/Documentation/dontdiff -uprN linux-2.6.17.4-a1/drivers/acpi/atlas_acpi.c linux-2.6.17.4/drivers/acpi/atlas_acpi.c
--- linux-2.6.17.4-a1/drivers/acpi/atlas_acpi.c	2006-07-24 18:21:46.000000000 +0800
+++ linux-2.6.17.4/drivers/acpi/atlas_acpi.c	1970-01-01 07:30:00.000000000 +0730
@@ -1,181 +0,0 @@
-/*
- *  atlas_acpi.c - Atlas Wallmount Touchscreen ACPI Extras
- *
- *  Copyright (C) 2006 Jaya Kumar
- *  Based on Toshiba ACPI by John Belmonte and ASUS ACPI
- *  This work was sponsored by CIS(M) Sdn Bhd.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/input.h>
-#include <linux/types.h>
-#include <asm/uaccess.h>
-#include <acpi/acpi_drivers.h>
-
-#define ACPI_ATLAS_NAME			"Atlas ACPI"
-#define ACPI_ATLAS_CLASS		"Atlas"
-#define ACPI_ATLAS_BUTTON_HID		"ASIM0000"
-
-static struct input_dev *input_dev;
-
-static void atlas_input_report(u8 address)
-{
-	int keycode;
-
-	keycode = KEY_F1 + (address & 0x0F);
-
-	if (address & 0x10)
-		input_report_key(input_dev, keycode, 0);
-	else
-		input_report_key(input_dev, keycode, 1);
-	input_sync(input_dev);
-}
-
-static int atlas_setup_input(void)
-{
-	int err;
-
-	input_dev = input_allocate_device();
-	if (!input_dev) {
-		printk(KERN_ERR "atlas: insufficient mem to allocate input "
-				"device\n");
-		return -ENOMEM;
-	}
-
-	input_dev->name = "Atlas ACPI button driver";
-	input_dev->phys = "ASIM0000/atlas/input0";
-	input_dev->id.bustype = BUS_HOST;
-	input_dev->evbit[LONG(EV_KEY)] = BIT(EV_KEY);
-	set_bit(KEY_F1, input_dev->keybit);
-	set_bit(KEY_F2, input_dev->keybit);
-	set_bit(KEY_F3, input_dev->keybit);
-	set_bit(KEY_F4, input_dev->keybit);
-	set_bit(KEY_F5, input_dev->keybit);
-	set_bit(KEY_F6, input_dev->keybit);
-	set_bit(KEY_F7, input_dev->keybit);
-	set_bit(KEY_F8, input_dev->keybit);
-	set_bit(KEY_F9, input_dev->keybit);
-
-	err = input_register_device(input_dev);
-	if (err) {
-		printk(KERN_ERR "atlas: couldn't register input device\n");
-		input_free_device(input_dev);
-		return err;
-	}
-
-	return 0;
-}
-
-static void atlas_free_input(void)
-{
-	if (input_dev)
-		input_unregister_device(input_dev);
-}
-
-/* button handling code */
-static acpi_status acpi_atlas_button_setup(acpi_handle region_handle,
-		    u32 function, void *handler_context, void **return_context)
-{
-	*return_context =
-		(function != ACPI_REGION_DEACTIVATE) ? handler_context : NULL;
-
-	return AE_OK;
-}
-
-static acpi_status acpi_atlas_button_handler(u32 function,
-		      acpi_physical_address address,
-		      u32 bit_width, acpi_integer *value,
-		      void *handler_context, void *region_context)
-{
-	acpi_status status;
-
-	if (function == ACPI_WRITE) 
-		atlas_input_report((u8) address);
-	else {
-		printk(KERN_WARNING "atlas: shrugged on unexpected function"
-			":function=%x,address=%lx,value=%x\n",
-			function, (unsigned long)address, (u32)*value);
-		status = -EINVAL;
-	}
-
-	return status;
-}
-
-static int atlas_acpi_button_add(struct acpi_device *device)
-{
-	int err;
-
-	err = atlas_setup_input();
-	if (err)
-		return err;
-
-	/* hookup button handler */
-	return acpi_install_address_space_handler(device->handle,
-				0x81, &acpi_atlas_button_handler,
-				&acpi_atlas_button_setup, device);
-}
-
-static int atlas_acpi_button_remove(struct acpi_device *device, int type)
-{
-	acpi_status status;
-
-	status = acpi_remove_address_space_handler(device->handle,
-				0x81, &acpi_atlas_button_handler);
-	if (ACPI_FAILURE(status))
-		printk(KERN_ERR "Atlas: Error removing addr spc handler\n");
-	atlas_free_input();
-	return status;
-}
-
-static struct acpi_driver atlas_acpi_driver = {
-	.name = ACPI_ATLAS_NAME,
-	.class = ACPI_ATLAS_CLASS,
-	.ids = ACPI_ATLAS_BUTTON_HID,
-	.ops = {
-		.add = atlas_acpi_button_add,
-		.remove = atlas_acpi_button_remove,
-	},
-};
-
-static int atlas_acpi_init(void)
-{
-	int result;
-
-	result = acpi_bus_register_driver(&atlas_acpi_driver);
-	if (result < 0) {
-		printk(KERN_ERR "Atlas ACPI: Unable to register driver\n");
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-static void atlas_acpi_exit(void)
-{
-	acpi_bus_unregister_driver(&atlas_acpi_driver);
-}
-
-module_init(atlas_acpi_init);
-module_exit(atlas_acpi_exit);
-
-MODULE_AUTHOR("Jaya Kumar");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Atlas ACPI");
-
diff -X linux-2.6.17.4/Documentation/dontdiff -uprN linux-2.6.17.4-a1/drivers/acpi/Kconfig linux-2.6.17.4/drivers/acpi/Kconfig
--- linux-2.6.17.4-a1/drivers/acpi/Kconfig	2006-07-24 18:21:40.000000000 +0800
+++ linux-2.6.17.4/drivers/acpi/Kconfig	2006-07-24 18:32:19.000000000 +0800
@@ -193,17 +193,6 @@ config ACPI_ASUS
           something works not quite as expected, please use the mailing list
           available on the above page (acpi4asus-user@lists.sourceforge.net)
 
-config ACPI_ATLAS
-	tristate "Atlas Wallmount Touchscreen Extras"
-	depends on X86 && INPUT
-	default n
-         ---help---
-          This driver is intended for Atlas wallmounted touchscreens.
-          The button events will show up as scancodes F1 through F9 via
-          evdev. 
-
-          If you have an Atlas wallmounted touchscreen, say Y or M here.
-
 config ACPI_IBM
 	tristate "IBM ThinkPad Laptop Extras"
 	depends on X86
diff -X linux-2.6.17.4/Documentation/dontdiff -uprN linux-2.6.17.4-a1/drivers/acpi/Makefile linux-2.6.17.4/drivers/acpi/Makefile
--- linux-2.6.17.4-a1/drivers/acpi/Makefile	2006-07-24 18:21:40.000000000 +0800
+++ linux-2.6.17.4/drivers/acpi/Makefile	2006-07-25 16:44:45.000000000 +0800
@@ -53,7 +53,6 @@ obj-$(CONFIG_ACPI_SYSTEM)	+= system.o ev
 obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
-obj-$(CONFIG_ACPI_ATLAS)	+= atlas_acpi.o
 obj-$(CONFIG_ACPI_IBM)		+= ibm_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-y				+= scan.o motherboard.o
diff -X linux-2.6.17.4/Documentation/dontdiff -uprN linux-2.6.17.4-a1/drivers/input/misc/atlas_btns.c linux-2.6.17.4/drivers/input/misc/atlas_btns.c
--- linux-2.6.17.4-a1/drivers/input/misc/atlas_btns.c	1970-01-01 07:30:00.000000000 +0730
+++ linux-2.6.17.4/drivers/input/misc/atlas_btns.c	2006-07-25 17:04:38.000000000 +0800
@@ -0,0 +1,184 @@
+/*
+ *  atlas_btns.c - Atlas Wallmount Touchscreen ACPI Extras
+ *
+ *  Copyright (C) 2006 Jaya Kumar
+ *  Based on Toshiba ACPI by John Belmonte and ASUS ACPI
+ *  This work was sponsored by CIS(M) Sdn Bhd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/types.h>
+#include <asm/uaccess.h>
+#include <acpi/acpi_drivers.h>
+
+#define ACPI_ATLAS_NAME			"Atlas ACPI"
+#define ACPI_ATLAS_CLASS		"Atlas"
+#define ACPI_ATLAS_BUTTON_HID		"ASIM0000"
+
+static struct input_dev *input_dev;
+
+static void atlas_input_report(u8 address)
+{
+	int keycode;
+
+	keycode = KEY_F1 + (address & 0x0F);
+
+	if (address & 0x10)
+		input_report_key(input_dev, keycode, 0);
+	else
+		input_report_key(input_dev, keycode, 1);
+	input_sync(input_dev);
+}
+
+static int atlas_setup_input(void)
+{
+	int err;
+
+	input_dev = input_allocate_device();
+	if (!input_dev) {
+		printk(KERN_ERR "atlas: insufficient mem to allocate input "
+				"device\n");
+		return -ENOMEM;
+	}
+
+	input_dev->name = "Atlas ACPI button driver";
+	input_dev->phys = "ASIM0000/atlas/input0";
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->evbit[LONG(EV_KEY)] = BIT(EV_KEY);
+	set_bit(KEY_F1, input_dev->keybit);
+	set_bit(KEY_F2, input_dev->keybit);
+	set_bit(KEY_F3, input_dev->keybit);
+	set_bit(KEY_F4, input_dev->keybit);
+	set_bit(KEY_F5, input_dev->keybit);
+	set_bit(KEY_F6, input_dev->keybit);
+	set_bit(KEY_F7, input_dev->keybit);
+	set_bit(KEY_F8, input_dev->keybit);
+	set_bit(KEY_F9, input_dev->keybit);
+
+	err = input_register_device(input_dev);
+	if (err) {
+		printk(KERN_ERR "atlas: couldn't register input device\n");
+		input_free_device(input_dev);
+		return err;
+	}
+
+	return 0;
+}
+
+static void atlas_free_input(void)
+{
+	if (input_dev)
+		input_unregister_device(input_dev);
+}
+
+/* button handling code */
+static acpi_status acpi_atlas_button_setup(acpi_handle region_handle,
+		    u32 function, void *handler_context, void **return_context)
+{
+	*return_context =
+		(function != ACPI_REGION_DEACTIVATE) ? handler_context : NULL;
+
+	return AE_OK;
+}
+
+static acpi_status acpi_atlas_button_handler(u32 function,
+		      acpi_physical_address address,
+		      u32 bit_width, acpi_integer *value,
+		      void *handler_context, void *region_context)
+{
+	acpi_status status;
+
+	if (function == ACPI_WRITE) 
+		atlas_input_report((u8) address);
+	else {
+		printk(KERN_WARNING "atlas: shrugged on unexpected function"
+			":function=%x,address=%lx,value=%x\n",
+			function, (unsigned long)address, (u32)*value);
+		status = -EINVAL;
+	}
+
+	return status;
+}
+
+static int atlas_acpi_button_add(struct acpi_device *device)
+{
+	int err;
+
+	err = atlas_setup_input();
+	if (err)
+		return err;
+
+	/* hookup button handler */
+	return acpi_install_address_space_handler(device->handle,
+				0x81, &acpi_atlas_button_handler,
+				&acpi_atlas_button_setup, device);
+}
+
+static int atlas_acpi_button_remove(struct acpi_device *device, int type)
+{
+	acpi_status status;
+
+	status = acpi_remove_address_space_handler(device->handle,
+				0x81, &acpi_atlas_button_handler);
+	if (ACPI_FAILURE(status))
+		printk(KERN_ERR "Atlas: Error removing addr spc handler\n");
+	atlas_free_input();
+	return status;
+}
+
+static struct acpi_driver atlas_acpi_driver = {
+	.name = ACPI_ATLAS_NAME,
+	.class = ACPI_ATLAS_CLASS,
+	.ids = ACPI_ATLAS_BUTTON_HID,
+	.ops = {
+		.add = atlas_acpi_button_add,
+		.remove = atlas_acpi_button_remove,
+	},
+};
+
+static int atlas_acpi_init(void)
+{
+	int result;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	result = acpi_bus_register_driver(&atlas_acpi_driver);
+	if (result < 0) {
+		printk(KERN_ERR "Atlas ACPI: Unable to register driver\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void atlas_acpi_exit(void)
+{
+	acpi_bus_unregister_driver(&atlas_acpi_driver);
+}
+
+module_init(atlas_acpi_init);
+module_exit(atlas_acpi_exit);
+
+MODULE_AUTHOR("Jaya Kumar");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Atlas button driver");
+
diff -X linux-2.6.17.4/Documentation/dontdiff -uprN linux-2.6.17.4-a1/drivers/input/misc/Kconfig linux-2.6.17.4/drivers/input/misc/Kconfig
--- linux-2.6.17.4-a1/drivers/input/misc/Kconfig	2006-07-24 18:21:49.000000000 +0800
+++ linux-2.6.17.4/drivers/input/misc/Kconfig	2006-07-25 16:42:44.000000000 +0800
@@ -50,6 +50,16 @@ config INPUT_WISTRON_BTNS
 	  To compile this driver as a module, choose M here: the module will
 	  be called wistron_btns.
 
+config INPUT_ATLAS_BTNS
+	tristate "x86 Atlas button interface"
+	depends on X86 && ACPI
+	help
+	  Say Y here for support of Atlas wallmount touchscreen buttons. 
+	  The events will show up as scancodes F1 through F9 via evdev.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called atlas_btns.
+
 config INPUT_IXP4XX_BEEPER
 	tristate "IXP4XX Beeper support"
 	depends on ARCH_IXP4XX
diff -X linux-2.6.17.4/Documentation/dontdiff -uprN linux-2.6.17.4-a1/drivers/input/misc/Makefile linux-2.6.17.4/drivers/input/misc/Makefile
--- linux-2.6.17.4-a1/drivers/input/misc/Makefile	2006-07-24 18:21:49.000000000 +0800
+++ linux-2.6.17.4/drivers/input/misc/Makefile	2006-07-25 16:45:28.000000000 +0800
@@ -9,5 +9,6 @@ obj-$(CONFIG_INPUT_PCSPKR)		+= pcspkr.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
 obj-$(CONFIG_INPUT_WISTRON_BTNS)	+= wistron_btns.o
+obj-$(CONFIG_INPUT_ATLAS_BTNS)		+= atlas_btns.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
 obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+= ixp4xx-beeper.o
diff -X linux-2.6.17.4/Documentation/dontdiff -uprN linux-2.6.17.4-a1/MAINTAINERS linux-2.6.17.4/MAINTAINERS
--- linux-2.6.17.4-a1/MAINTAINERS	2006-07-24 18:21:31.000000000 +0800
+++ linux-2.6.17.4/MAINTAINERS	2006-07-25 16:51:03.000000000 +0800
@@ -394,6 +394,11 @@ M:	ecashin@coraid.com
 W:	http://www.coraid.com/support/linux
 S:	Supported
 
+ATLAS INPUT DRIVER
+P:	Jaya Kumar
+M:	jayakumar.acpi@gmail.com
+S:	Maintained
+
 ATM
 P:	Chas Williams
 M:	chas@cmf.nrl.navy.mil
