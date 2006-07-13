From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 1/5] ACPI: Atlas ACPI driver
Date: Thu, 13 Jul 2006 16:37:27 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6F76C15@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10118 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030368AbWGMUht convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jul 2006 16:37:49 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, jayakumar.acpi@gmail.com, dtor_core@ameritech.net, "Yu, Luming" <luming.yu@intel.com>

Jaya,
Thanks for updating this patch.

Note that this driver can not be accepted into the kernel without
an entry being added to the MAINTAINERS file showing who is
going to look after it.

Preferably, that person should be inside Atlas, or have documentation
or other connections or insight into the platform.  I can't maintain it
because I don't have any of the above, and while this platform
specific driver uses ACPI, it is not part of ACPI.

Yes, I know that you were following the existing examples of
platform-specific drivers in /drivers/acpi, but those examples
need to change (and they are a little more complex than this one
b/c they scribble in their own unique ways /proc/acpi...)
But think sonypi, instead.

So when this does make it upstream, it will have to live outside
the /drivers/acpi/ directory, and acpi should not be part of
the driver name.  It should build depending on CONFIG_ACPI,
and should load depending on acpi_disabled, and should use
ACPI routines that are exported by the ACPI sub-system (it does,
though the headers are so incestuous at this point that it isn't
enforced)

thanks,
-Len

ps.
I believe that you want to delete the reference below to
/proc/acpi/event, yes?


>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Friday, July 07, 2006 2:53 AM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; 
>jayakumar.acpi@gmail.com; dtor_core@ameritech.net; Yu, Luming
>Subject: [patch 1/5] ACPI: Atlas ACPI driver
>
>From: jayakumar.acpi@gmail.com
>
>An ACPI driver for Atlas boards, including input support.
>
>Signed-off-by: Jaya Kumar <jayakumar.acpi@gmail.com>
>Cc: "Brown, Len" <len.brown@intel.com>
>Cc: Dmitry Torokhov <dtor_core@ameritech.net>
>Cc: "Yu, Luming" <luming.yu@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/Kconfig      |   13 ++
> drivers/acpi/Makefile     |    1 
> drivers/acpi/atlas_acpi.c |  191 ++++++++++++++++++++++++++++++++++++
> 3 files changed, 204 insertions(+), 1 deletion(-)
>
>diff -puN /dev/null drivers/acpi/atlas_acpi.c
>--- /dev/null
>+++ a/drivers/acpi/atlas_acpi.c
>@@ -0,0 +1,191 @@
>+/*
>+ *  atlas_acpi.c - Atlas Wallmount Touchscreen ACPI Extras
>+ *
>+ *  Copyright (C) 2006 Jaya Kumar
>+ *  Based on Toshiba ACPI by John Belmonte and ASUS ACPI
>+ *  This work was sponsored by CIS(M) Sdn Bhd.
>+ *
>+ *  This program is free software; you can redistribute it 
>and/or modify
>+ *  it under the terms of the GNU General Public License as 
>published by
>+ *  the Free Software Foundation; either version 2 of the License, or
>+ *  (at your option) any later version.
>+ *
>+ *  This program is distributed in the hope that it will be useful,
>+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>+ *  GNU General Public License for more details.
>+ *
>+ *  You should have received a copy of the GNU General Public License
>+ *  along with this program; if not, write to the Free Software
>+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  
>02111-1307  USA
>+ *
>+ */
>+
>+#include <linux/kernel.h>
>+#include <linux/module.h>
>+#include <linux/init.h>
>+#include <linux/input.h>
>+#include <linux/types.h>
>+#include <linux/proc_fs.h>
>+#include <asm/uaccess.h>
>+#include <acpi/acpi_drivers.h>
>+
>+#define ACPI_ATLAS_NAME			"Atlas ACPI"
>+#define ACPI_ATLAS_CLASS		"Atlas"
>+#define ACPI_ATLAS_BUTTON_HID		"ASIM0000"
>+
>+#ifdef CONFIG_INPUT
>+static struct input_dev *input_dev;
>+
>+static void atlas_input_report(u8 address)
>+{
>+	int keycode;
>+
>+	keycode = KEY_F1 + (address & 0x0F);
>+
>+	if (address & 0x10)
>+		input_report_key(input_dev, keycode, 0);
>+	else
>+		input_report_key(input_dev, keycode, 1);
>+	input_sync(input_dev);
>+}
>+
>+static int atlas_setup_input(void)
>+{
>+	int err;
>+
>+	input_dev = input_allocate_device();
>+	if (!input_dev) {
>+		printk(KERN_ERR "atlas: insufficient mem to 
>allocate input "
>+				"device\n");
>+		return -ENOMEM;
>+	}
>+
>+	input_dev->name = "Atlas ACPI button driver";
>+	input_dev->phys = "acpi/input0";
>+	input_dev->id.bustype = BUS_HOST;
>+	input_dev->evbit[LONG(EV_KEY)] = BIT(EV_KEY);
>+	set_bit(KEY_F1, input_dev->keybit);
>+	set_bit(KEY_F2, input_dev->keybit);
>+	set_bit(KEY_F3, input_dev->keybit);
>+	set_bit(KEY_F4, input_dev->keybit);
>+	set_bit(KEY_F5, input_dev->keybit);
>+	set_bit(KEY_F6, input_dev->keybit);
>+	set_bit(KEY_F7, input_dev->keybit);
>+	set_bit(KEY_F8, input_dev->keybit);
>+	set_bit(KEY_F9, input_dev->keybit);
>+
>+	err = input_register_device(input_dev);
>+	if (err) {
>+		printk(KERN_ERR "atlas: couldn't register input 
>device\n");
>+		input_free_device(input_dev);
>+		return err;
>+	}
>+
>+	return 0;
>+}
>+
>+static void atlas_free_input(void)
>+{
>+	if (input_dev)
>+		input_unregister_device(input_dev);
>+
>+}
>+#else
>+#define atlas_free_input(...)
>+#define atlas_setup_input(...) 0
>+#define atlas_input_report(...)
>+#endif
>+
>+/* button handling code */
>+static acpi_status acpi_atlas_button_setup(acpi_handle region_handle,
>+		    u32 function, void *handler_context, void 
>**return_context)
>+{
>+	*return_context =
>+		(function != ACPI_REGION_DEACTIVATE) ? 
>handler_context : NULL;
>+
>+	return AE_OK;
>+}
>+
>+static acpi_status acpi_atlas_button_handler(u32 function,
>+		      acpi_physical_address address,
>+		      u32 bit_width, acpi_integer *value,
>+		      void *handler_context, void *region_context)
>+{
>+	acpi_status status;
>+	struct acpi_device *dev = handler_context;
>+
>+	if (function == ACPI_WRITE) {
>+		status = acpi_bus_generate_event(dev, 0x80, address);
>+		atlas_input_report((u8) address);
>+	} else {
>+		printk(KERN_WARNING "atlas: shrugged on 
>unexpected function"
>+			":function=%x,address=%lx,value=%x\n",
>+			function, (unsigned long)address, (u32)*value);
>+		status = -EINVAL;
>+	}
>+
>+	return status;
>+}
>+
>+static int atlas_acpi_button_add(struct acpi_device *device)
>+{
>+	int err;
>+
>+	err = atlas_setup_input();
>+	if (err)
>+		return err;
>+
>+	/* hookup button handler */
>+	return acpi_install_address_space_handler(device->handle,
>+				0x81, &acpi_atlas_button_handler,
>+				&acpi_atlas_button_setup, device);
>+}
>+
>+static int atlas_acpi_button_remove(struct acpi_device 
>*device, int type)
>+{
>+	acpi_status status;
>+
>+	status = acpi_remove_address_space_handler(device->handle,
>+				0x81, &acpi_atlas_button_handler);
>+	if (ACPI_FAILURE(status))
>+		printk(KERN_ERR "Atlas: Error removing addr spc 
>handler\n");
>+	atlas_free_input();
>+	return status;
>+}
>+
>+static struct acpi_driver atlas_acpi_driver = {
>+	.name = ACPI_ATLAS_NAME,
>+	.class = ACPI_ATLAS_CLASS,
>+	.ids = ACPI_ATLAS_BUTTON_HID,
>+	.ops = {
>+		.add = atlas_acpi_button_add,
>+		.remove = atlas_acpi_button_remove,
>+	},
>+};
>+
>+static int atlas_acpi_init(void)
>+{
>+	int result;
>+
>+	result = acpi_bus_register_driver(&atlas_acpi_driver);
>+	if (result < 0) {
>+		printk(KERN_ERR "Atlas ACPI: Unable to register 
>driver\n");
>+		return -ENODEV;
>+	}
>+
>+	return 0;
>+}
>+
>+static void atlas_acpi_exit(void)
>+{
>+	acpi_bus_unregister_driver(&atlas_acpi_driver);
>+}
>+
>+module_init(atlas_acpi_init);
>+module_exit(atlas_acpi_exit);
>+
>+MODULE_AUTHOR("Jaya Kumar");
>+MODULE_LICENSE("GPL");
>+MODULE_DESCRIPTION("Atlas ACPI");
>+
>diff -puN drivers/acpi/Kconfig~acpi-atlas-acpi-driver 
>drivers/acpi/Kconfig
>--- a/drivers/acpi/Kconfig~acpi-atlas-acpi-driver
>+++ a/drivers/acpi/Kconfig
>@@ -198,7 +198,18 @@ config ACPI_ASUS
>           driver is still under development, so if your 
>laptop is unsupported or
>           something works not quite as expected, please use 
>the mailing list
>           available on the above page 
>(acpi4asus-user@lists.sourceforge.net)
>-          
>+
>+config ACPI_ATLAS
>+	tristate "Atlas Wallmount Touchscreen Extras"
>+	depends on X86
>+	default n
>+         ---help---
>+          This driver is intended for Atlas wallmounted touchscreens.
>+          The button events will show up in /proc/acpi/events and also
>+          as scancodes F1 through F9, and in X if you use evdev.
>+
>+          If you have an Atlas wallmounted touchscreen, say Y 
>or M here.
>+
> config ACPI_IBM
> 	tristate "IBM ThinkPad Laptop Extras"
> 	depends on X86
>diff -puN drivers/acpi/Makefile~acpi-atlas-acpi-driver 
>drivers/acpi/Makefile
>--- a/drivers/acpi/Makefile~acpi-atlas-acpi-driver
>+++ a/drivers/acpi/Makefile
>@@ -54,6 +54,7 @@ obj-$(CONFIG_ACPI_SYSTEM)	+= system.o ev
> obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
> obj-$(CONFIG_ACPI_NUMA)		+= numa.o
> obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
>+obj-$(CONFIG_ACPI_ATLAS)	+= atlas_acpi.o
> obj-$(CONFIG_ACPI_IBM)		+= ibm_acpi.o
> obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
> obj-y				+= scan.o motherboard.o
>_
>
