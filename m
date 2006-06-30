From: akpm@osdl.org
Subject: [patch 2/6] ACPI: Atlas ACPI driver
Date: Fri, 30 Jun 2006 02:15:15 -0700
Message-ID: <200606300915.k5U9FFHJ001035@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:37771 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751549AbWF3JPa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jun 2006 05:15:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, jayakumar.acpi@gmail.com, dtor_core@ameritech.net, luming.yu@intel.com

From: jayakumar.acpi@gmail.com

An ACPI driver for Atlas boards, including input support.

Signed-off-by: Jaya Kumar <jayakumar.acpi@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: "Yu, Luming" <luming.yu@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/Kconfig      |   13 ++
 drivers/acpi/Makefile     |    1 
 drivers/acpi/atlas_acpi.c |  191 ++++++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+), 1 deletion(-)

diff -puN /dev/null drivers/acpi/atlas_acpi.c
--- /dev/null
+++ a/drivers/acpi/atlas_acpi.c
@@ -0,0 +1,191 @@
+/*
+ *  atlas_acpi.c - Atlas Wallmount Touchscreen ACPI Extras
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
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
+#include <acpi/acpi_drivers.h>
+
+#define ACPI_ATLAS_NAME			"Atlas ACPI"
+#define ACPI_ATLAS_CLASS		"Atlas"
+#define ACPI_ATLAS_BUTTON_HID		"ASIM0000"
+
+#ifdef CONFIG_INPUT
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
+	input_dev->phys = "acpi/input0";
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
+
+}
+#else
+#define atlas_free_input(...)
+#define atlas_setup_input(...) 0
+#define atlas_input_report(...)
+#endif
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
+	struct acpi_device *dev = handler_context;
+
+	if (function == ACPI_WRITE) {
+		status = acpi_bus_generate_event(dev, 0x80, address);
+		atlas_input_report((u8) address);
+	} else {
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
+MODULE_DESCRIPTION("Atlas ACPI");
+
diff -puN drivers/acpi/Kconfig~acpi-atlas-acpi-driver drivers/acpi/Kconfig
--- a/drivers/acpi/Kconfig~acpi-atlas-acpi-driver
+++ a/drivers/acpi/Kconfig
@@ -198,7 +198,18 @@ config ACPI_ASUS
           driver is still under development, so if your laptop is unsupported or
           something works not quite as expected, please use the mailing list
           available on the above page (acpi4asus-user@lists.sourceforge.net)
-          
+
+config ACPI_ATLAS
+	tristate "Atlas Wallmount Touchscreen Extras"
+	depends on X86
+	default n
+         ---help---
+          This driver is intended for Atlas wallmounted touchscreens.
+          The button events will show up in /proc/acpi/events and also
+          as scancodes F1 through F9, and in X if you use evdev.
+
+          If you have an Atlas wallmounted touchscreen, say Y or M here.
+
 config ACPI_IBM
 	tristate "IBM ThinkPad Laptop Extras"
 	depends on X86
diff -puN drivers/acpi/Makefile~acpi-atlas-acpi-driver drivers/acpi/Makefile
--- a/drivers/acpi/Makefile~acpi-atlas-acpi-driver
+++ a/drivers/acpi/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_ACPI_SYSTEM)	+= system.o ev
 obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
+obj-$(CONFIG_ACPI_ATLAS)	+= atlas_acpi.o
 obj-$(CONFIG_ACPI_IBM)		+= ibm_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-y				+= scan.o motherboard.o
_
