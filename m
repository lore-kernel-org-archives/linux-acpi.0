From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: [patch 1/5] ACPI: Atlas ACPI driver
Date: Fri, 7 Jul 2006 20:43:34 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1120705@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22845 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932159AbWGGMoP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Jul 2006 08:44:15 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org, jayakumar.acpi@gmail.com
Cc: linux-acpi@vger.kernel.org, dtor_core@ameritech.net, "Brown, Len" <len.brown@intel.com>

+	if (function =3D=3D ACPI_WRITE) {
+		status =3D acpi_bus_generate_event(dev, 0x80, address);
+		atlas_input_report((u8) address);
+	} else {

Please don't use two mechanism to report one event.

=46or other part of code, I ACK.

Thanks
Luming=20

-----Original Message-----
=46rom: akpm@osdl.org [mailto:akpm@osdl.org]=20
Sent: 2006=C4=EA7=D4=C27=C8=D5 14:53
To: Brown, Len
Cc: linux-acpi@vger.kernel.org; akpm@osdl.org;=20
jayakumar.acpi@gmail.com; dtor_core@ameritech.net; Yu, Luming
Subject: [patch 1/5] ACPI: Atlas ACPI driver

=46rom: jayakumar.acpi@gmail.com

An ACPI driver for Atlas boards, including input support.

Signed-off-by: Jaya Kumar <jayakumar.acpi@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: "Yu, Luming" <luming.yu@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/Kconfig      |   13 ++
 drivers/acpi/Makefile     |    1=20
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
+ *  This program is free software; you can redistribute it=20
and/or modify
+ *  it under the terms of the GNU General Public License as=20
published by
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
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =20
02111-1307  USA
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
+	keycode =3D KEY_F1 + (address & 0x0F);
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
+	input_dev =3D input_allocate_device();
+	if (!input_dev) {
+		printk(KERN_ERR "atlas: insufficient mem to=20
allocate input "
+				"device\n");
+		return -ENOMEM;
+	}
+
+	input_dev->name =3D "Atlas ACPI button driver";
+	input_dev->phys =3D "acpi/input0";
+	input_dev->id.bustype =3D BUS_HOST;
+	input_dev->evbit[LONG(EV_KEY)] =3D BIT(EV_KEY);
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
+	err =3D input_register_device(input_dev);
+	if (err) {
+		printk(KERN_ERR "atlas: couldn't register input=20
device\n");
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
+		    u32 function, void *handler_context, void=20
**return_context)
+{
+	*return_context =3D
+		(function !=3D ACPI_REGION_DEACTIVATE) ?=20
handler_context : NULL;
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
+	struct acpi_device *dev =3D handler_context;
+
+	if (function =3D=3D ACPI_WRITE) {
+		status =3D acpi_bus_generate_event(dev, 0x80, address);
+		atlas_input_report((u8) address);
+	} else {
+		printk(KERN_WARNING "atlas: shrugged on=20
unexpected function"
+			":function=3D%x,address=3D%lx,value=3D%x\n",
+			function, (unsigned long)address, (u32)*value);
+		status =3D -EINVAL;
+	}
+
+	return status;
+}
+
+static int atlas_acpi_button_add(struct acpi_device *device)
+{
+	int err;
+
+	err =3D atlas_setup_input();
+	if (err)
+		return err;
+
+	/* hookup button handler */
+	return acpi_install_address_space_handler(device->handle,
+				0x81, &acpi_atlas_button_handler,
+				&acpi_atlas_button_setup, device);
+}
+
+static int atlas_acpi_button_remove(struct acpi_device=20
*device, int type)
+{
+	acpi_status status;
+
+	status =3D acpi_remove_address_space_handler(device->handle,
+				0x81, &acpi_atlas_button_handler);
+	if (ACPI_FAILURE(status))
+		printk(KERN_ERR "Atlas: Error removing addr spc=20
handler\n");
+	atlas_free_input();
+	return status;
+}
+
+static struct acpi_driver atlas_acpi_driver =3D {
+	.name =3D ACPI_ATLAS_NAME,
+	.class =3D ACPI_ATLAS_CLASS,
+	.ids =3D ACPI_ATLAS_BUTTON_HID,
+	.ops =3D {
+		.add =3D atlas_acpi_button_add,
+		.remove =3D atlas_acpi_button_remove,
+	},
+};
+
+static int atlas_acpi_init(void)
+{
+	int result;
+
+	result =3D acpi_bus_register_driver(&atlas_acpi_driver);
+	if (result < 0) {
+		printk(KERN_ERR "Atlas ACPI: Unable to register=20
driver\n");
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
diff -puN drivers/acpi/Kconfig~acpi-atlas-acpi-driver=20
drivers/acpi/Kconfig
--- a/drivers/acpi/Kconfig~acpi-atlas-acpi-driver
+++ a/drivers/acpi/Kconfig
@@ -198,7 +198,18 @@ config ACPI_ASUS
           driver is still under development, so if your laptop=20
is unsupported or
           something works not quite as expected, please use=20
the mailing list
           available on the above page=20
(acpi4asus-user@lists.sourceforge.net)
-         =20
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
+          If you have an Atlas wallmounted touchscreen, say Y=20
or M here.
+
 config ACPI_IBM
 	tristate "IBM ThinkPad Laptop Extras"
 	depends on X86
diff -puN drivers/acpi/Makefile~acpi-atlas-acpi-driver=20
drivers/acpi/Makefile
--- a/drivers/acpi/Makefile~acpi-atlas-acpi-driver
+++ a/drivers/acpi/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_ACPI_SYSTEM)	+=3D system.o ev
 obj-$(CONFIG_ACPI_DEBUG)	+=3D debug.o
 obj-$(CONFIG_ACPI_NUMA)		+=3D numa.o
 obj-$(CONFIG_ACPI_ASUS)		+=3D asus_acpi.o
+obj-$(CONFIG_ACPI_ATLAS)	+=3D atlas_acpi.o
 obj-$(CONFIG_ACPI_IBM)		+=3D ibm_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+=3D toshiba_acpi.o
 obj-y				+=3D scan.o motherboard.o
_
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
