From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: [PATCH] topstar_acpi: add new driver for hotkeys support on Topstar N01
Date: Mon, 7 Sep 2009 16:26:03 -0300
Message-ID: <200909071626.03334.herton@mandriva.com.br>
References: <200909050229.55665.herton@mandriva.com.br> <9b2b86520909050602q1c62c648kdce76dc77b9f3dfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_L5VpKqs2/WBI6Ka"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:53955 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbZIGT0H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2009 15:26:07 -0400
In-Reply-To: <9b2b86520909050602q1c62c648kdce76dc77b9f3dfd@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentin.chary@gmail.com>

--Boundary-00=_L5VpKqs2/WBI6Ka
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Em S=E1b 05 Set 2009, =E0s 10:02:32, Alan Jenkins escreveu:
> On 9/5/09, Herton Ronaldo Krzesinski <herton@mandriva.com.br> wrote:
> > This adds Topstar Laptop Extras ACPI driver. It enables hotkeys
> > functionality with Topstar N01 netbook. Besides hotkeys there are
> > other functions exposed by its ACPI firmware, but for now only
> > hotkeys reporting on Topstar N01 is supported. Topstar is a chinese
> > manufacturer, its website can be currently reached at
> > http://www.topstardigital.cn/
> >
> > Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
>=20
> > +static void __exit acpi_topstar_exit(void)
> > +{
> > +	acpi_bus_unregister_driver(&acpi_topstar_driver);
> > +
> > +	printk(KERN_INFO "Topstar Laptop ACPI extras driver unloaded\n");
>=20
> Oh... and this type of message always strikes me as gratuitous.  rmmod
> doesn't happen during normal operation.  So if the user removed the
> module... they know they did it.  They can check lsmod if they forget
> and are not sure.
>=20
> If (as a developer) you want to be sure the acpi driver was really
> unregistered, you can (and probably should) look in sysfs.

Hi, thanks for review. I addressed all issues you pointed out, and renamed =
the
driver to topstar-laptop as suggested by Corentin Chary. I'll attach also t=
he
diff on top of previous topstar_acpi.c as reference (before the rename and
without Kconfig/Makefile changes). I only compiled tested it, as because of
bank holidays here will only be able to retest wednesday this, but the chan=
ges
are safe anyway. Here is new version of the patch (feel free to add your
Reviewed-by to it):

=46rom e4fb36e01af04248e1a4ddda0964187e4b7fdb4a Mon Sep 17 00:00:00 2001
=46rom: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Date: Mon, 7 Sep 2009 16:12:48 -0300
Subject: [PATCH] topstar-laptop: add new driver for hotkeys support on Tops=
tar N01

This adds Topstar Laptop Extras ACPI driver. It enables hotkeys
functionality with Topstar N01 netbook. Besides hotkeys there are
other functions exposed by its ACPI firmware, but for now only
hotkeys reporting on Topstar N01 is supported. Topstar is a chinese
manufacturer, its website can be currently reached at
http://www.topstardigital.cn/

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
=2D--
 drivers/platform/x86/Kconfig          |    9 +
 drivers/platform/x86/Makefile         |    1 +
 drivers/platform/x86/topstar-laptop.c |  297 +++++++++++++++++++++++++++++=
++++
 3 files changed, 307 insertions(+), 0 deletions(-)
 create mode 100644 drivers/platform/x86/topstar-laptop.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 77c6097..4831562 100644
=2D-- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -396,6 +396,15 @@ config ACPI_ASUS
 	  NOTE: This driver is deprecated and will probably be removed soon,
 	  use asus-laptop instead.
=20
+config TOPSTAR_LAPTOP
+	tristate "Topstar Laptop Extras"
+	depends on ACPI
+	depends on INPUT
+	---help---
+	  This driver adds support for hotkeys found on Topstar laptops.
+
+	  If you have a Topstar laptop, say Y or M here.
+
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 641b8bf..d1c1621 100644
=2D-- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -19,4 +19,5 @@ obj-$(CONFIG_PANASONIC_LAPTOP)	+=3D panasonic-laptop.o
 obj-$(CONFIG_INTEL_MENLOW)	+=3D intel_menlow.o
 obj-$(CONFIG_ACPI_WMI)		+=3D wmi.o
 obj-$(CONFIG_ACPI_ASUS)		+=3D asus_acpi.o
+obj-$(CONFIG_TOPSTAR_LAPTOP)	+=3D topstar-laptop.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+=3D toshiba_acpi.o
diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/t=
opstar-laptop.c
new file mode 100644
index 0000000..7be5b45
=2D-- /dev/null
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -0,0 +1,297 @@
+/*
+ * ACPI driver for Topstar notebooks (hotkeys support only)
+ *
+ * Copyright (c) 2009 Herton Ronaldo Krzesinski <herton@mandriva.com.br>
+ *
+ * Implementation inspired by existing x86 platform drivers, in special
+ * asus/eepc/fujitsu-laptop, thanks to their authors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <linux/input.h>
+
+#define ACPI_TOPSTAR_HID "TPSACPI01"
+#define ACPI_TOPSTAR_DEVICE_NAME "Topstar TPSACPI01"
+#define ACPI_TOPSTAR_DRIVER_NAME "Topstar laptop ACPI driver"
+#define ACPI_TOPSTAR_CLASS "topstar"
+
+static const struct acpi_device_id topstar_device_ids[] =3D {
+	{ ACPI_TOPSTAR_HID, 0 },
+	{ "", 0 },
+};
+
+struct topstar_hkey {
+	struct input_dev *inputdev;
+};
+
+struct tps_key_entry {
+	u8 code;
+	u16 keycode;
+};
+
+static struct tps_key_entry topstar_keymap[] =3D {
+	{ 0x80, KEY_BRIGHTNESSUP },
+	{ 0x81, KEY_BRIGHTNESSDOWN },
+	{ 0x83, KEY_VOLUMEUP },
+	{ 0x84, KEY_VOLUMEDOWN },
+	{ 0x85, KEY_MUTE },
+	{ 0x86, KEY_SWITCHVIDEOMODE },
+	{ 0x87, KEY_F13 }, /* touchpad enable/disable key */
+	{ 0x88, KEY_WLAN },
+	{ 0x8a, KEY_WWW },
+	{ 0x8b, KEY_MAIL },
+	{ 0x8c, KEY_MEDIA },
+	{ 0x96, KEY_F14 }, /* G key? */
+	{ }
+};
+
+static struct tps_key_entry *tps_get_key_by_scancode(int code)
+{
+	struct tps_key_entry *key;
+
+	for (key =3D topstar_keymap; key->code; key++)
+		if (code =3D=3D key->code)
+			return key;
+
+	return NULL;
+}
+
+static struct tps_key_entry *tps_get_key_by_keycode(int code)
+{
+	struct tps_key_entry *key;
+
+	for (key =3D topstar_keymap; key->code; key++)
+		if (code =3D=3D key->keycode)
+			return key;
+
+	return NULL;
+}
+
+static void acpi_topstar_notify(struct acpi_device *device, u32 event)
+{
+	struct tps_key_entry *key;
+	static bool dup_evnt[2];
+	bool *dup;
+	struct topstar_hkey *hkey =3D device->driver_data;
+
+	/* 0x83 and 0x84 key events comes duplicated... */
+	if (event =3D=3D 0x83 || event =3D=3D 0x84) {
+		dup =3D &dup_evnt[event - 0x83];
+		if (*dup) {
+			*dup =3D false;
+			return;
+		}
+		*dup =3D true;
+	}
+
+	/*
+	 * 'G key' generate two event codes, convert to only
+	 * one event/key code for now (3G switch?)
+	 */
+	if (event =3D=3D 0x97)
+		event =3D 0x96;
+
+	key =3D tps_get_key_by_scancode(event);
+	if (key) {
+		input_report_key(hkey->inputdev, key->keycode, 1);
+		input_sync(hkey->inputdev);
+		input_report_key(hkey->inputdev, key->keycode, 0);
+		input_sync(hkey->inputdev);
+		return;
+	}
+
+	/* Known non hotkey events don't handled or that we don't care yet */
+	if (event =3D=3D 0x8e || event =3D=3D 0x8f || event =3D=3D 0x90)
+		return;
+
+	pr_info("unknown event =3D 0x%02x\n", event);
+}
+
+static int acpi_topstar_fncx_switch(struct acpi_device *device, bool state)
+{
+	acpi_status status;
+	acpi_handle handle =3D NULL;
+	union acpi_object fncx_params[1] =3D {
+		{ .type =3D ACPI_TYPE_INTEGER }
+	};
+	struct acpi_object_list fncx_arg_list =3D { 1, &fncx_params[0] };
+	struct acpi_buffer buf;
+	union acpi_object obj;
+
+	status =3D acpi_get_handle(device->handle, "FNCX", &handle);
+	if (ACPI_FAILURE(status)) {
+		pr_err("FNCX method not found\n");
+		return -ENODEV;
+	}
+	fncx_params[0].integer.value =3D state ? 0x86 : 0x87;
+	buf.length =3D sizeof(obj);
+	buf.pointer =3D &obj;
+	status =3D acpi_evaluate_object(handle, NULL, &fncx_arg_list, &buf);
+	if (ACPI_FAILURE(status)) {
+		pr_err("Unable to switch FNCX notifications\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int topstar_getkeycode(struct input_dev *dev, int scancode, int *ke=
ycode)
+{
+	struct tps_key_entry *key =3D tps_get_key_by_scancode(scancode);
+
+	if (key) {
+		*keycode =3D key->keycode;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int topstar_setkeycode(struct input_dev *dev, int scancode, int key=
code)
+{
+	struct tps_key_entry *key;
+	int old_keycode;
+
+	if (keycode < 0 || keycode > KEY_MAX)
+		return -EINVAL;
+
+	key =3D tps_get_key_by_scancode(scancode);
+	if (key) {
+		old_keycode =3D key->keycode;
+		key->keycode =3D keycode;
+		set_bit(keycode, dev->keybit);
+		if (!tps_get_key_by_keycode(old_keycode))
+			clear_bit(old_keycode, dev->keybit);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int acpi_topstar_init_hkey(struct topstar_hkey *hkey)
+{
+	struct tps_key_entry *key;
+
+	hkey->inputdev =3D input_allocate_device();
+	if (!hkey->inputdev) {
+		pr_err("Unable to allocate input device\n");
+		return -ENODEV;
+	}
+	hkey->inputdev->name =3D "Topstar Laptop extra buttons";
+	hkey->inputdev->phys =3D "topstar/input0";
+	hkey->inputdev->id.bustype =3D BUS_HOST;
+	hkey->inputdev->getkeycode =3D topstar_getkeycode;
+	hkey->inputdev->setkeycode =3D topstar_setkeycode;
+	for (key =3D topstar_keymap; key->code; key++) {
+		set_bit(EV_KEY, hkey->inputdev->evbit);
+		set_bit(key->keycode, hkey->inputdev->keybit);
+	}
+	if (input_register_device(hkey->inputdev)) {
+		pr_err("Unable to register input device\n");
+		input_free_device(hkey->inputdev);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int is_tps_dev;
+
+static int acpi_topstar_add(struct acpi_device *device)
+{
+	struct topstar_hkey *tps_hkey;
+
+	if (!device)
+		return -EINVAL;
+
+	tps_hkey =3D kzalloc(sizeof(struct topstar_hkey), GFP_KERNEL);
+	if (!tps_hkey)
+		return -ENOMEM;
+
+	sprintf(acpi_device_name(device), "%s", ACPI_TOPSTAR_DEVICE_NAME);
+	sprintf(acpi_device_class(device), "%s", ACPI_TOPSTAR_CLASS);
+
+	if (acpi_topstar_fncx_switch(device, true))
+		goto add_err;
+
+	device->driver_data =3D tps_hkey;
+
+	if (acpi_topstar_init_hkey(tps_hkey))
+		goto add_err;
+
+	is_tps_dev =3D 1;
+	return 0;
+
+add_err:
+	kfree(tps_hkey);
+	device->driver_data =3D NULL;
+	return -ENODEV;
+}
+
+static int acpi_topstar_remove(struct acpi_device *device, int type)
+{
+	struct topstar_hkey *tps_hkey =3D acpi_driver_data(device);
+
+	if (!device || !tps_hkey)
+		return -EINVAL;
+
+	acpi_topstar_fncx_switch(device, false);
+
+	input_unregister_device(tps_hkey->inputdev);
+	kfree(tps_hkey);
+	device->driver_data =3D NULL;
+
+	return 0;
+}
+
+static struct acpi_driver acpi_topstar_driver =3D {
+	.name =3D ACPI_TOPSTAR_DRIVER_NAME,
+	.class =3D ACPI_TOPSTAR_CLASS,
+	.ids =3D topstar_device_ids,
+	.ops =3D {
+		.add =3D acpi_topstar_add,
+		.remove =3D acpi_topstar_remove,
+		.notify =3D acpi_topstar_notify,
+	},
+};
+
+static int __init topstar_laptop_init(void)
+{
+	int ret;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	ret =3D acpi_bus_register_driver(&acpi_topstar_driver);
+	if (ret < 0)
+		return ret;
+
+	if (!is_tps_dev) {
+		acpi_bus_unregister_driver(&acpi_topstar_driver);
+		return -ENODEV;
+	}
+
+	printk(KERN_INFO "Topstar Laptop ACPI extras driver loaded\n");
+
+	return 0;
+}
+
+static void __exit topstar_laptop_exit(void)
+{
+	acpi_bus_unregister_driver(&acpi_topstar_driver);
+}
+
+module_init(topstar_laptop_init);
+module_exit(topstar_laptop_exit);
+
+MODULE_AUTHOR("Herton Ronaldo Krzesinski");
+MODULE_DESCRIPTION("Topstar Laptop ACPI Extras driver");
+MODULE_LICENSE("GPL");
=2D-=20
1.6.4.2



>=20
> Thanks
> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

=2D-=20
[]'s
Herton

--Boundary-00=_L5VpKqs2/WBI6Ka
Content-Type: text/x-patch;
  charset="UTF-8";
  name="topstar-review2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="topstar-review2.patch"

diff --git a/drivers/platform/x86/topstar_acpi.c b/drivers/platform/x86/topstar_acpi.c
index e852de2..7be5b45 100644
--- a/drivers/platform/x86/topstar_acpi.c
+++ b/drivers/platform/x86/topstar_acpi.c
@@ -11,11 +11,11 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/mod_devicetable.h>
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
-#include <acpi/actypes.h>
-#include <acpi/acpixf.h>
 #include <linux/input.h>
 
 #define ACPI_TOPSTAR_HID "TPSACPI01"
@@ -23,10 +23,6 @@
 #define ACPI_TOPSTAR_DRIVER_NAME "Topstar laptop ACPI driver"
 #define ACPI_TOPSTAR_CLASS "topstar"
 
-#define TOPSTAR_ACPI_NAME "topstar_acpi"
-#define TOPSTAR_ACPI_ERR KERN_ERR TOPSTAR_ACPI_NAME ": "
-#define TOPSTAR_ACPI_INFO KERN_INFO TOPSTAR_ACPI_NAME ": "
-
 static const struct acpi_device_id topstar_device_ids[] = {
 	{ ACPI_TOPSTAR_HID, 0 },
 	{ "", 0 },
@@ -79,12 +75,12 @@ static struct tps_key_entry *tps_get_key_by_keycode(int code)
 	return NULL;
 }
 
-static void acpi_topstar_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_topstar_notify(struct acpi_device *device, u32 event)
 {
 	struct tps_key_entry *key;
 	static bool dup_evnt[2];
 	bool *dup;
-	struct topstar_hkey *hkey = data;
+	struct topstar_hkey *hkey = device->driver_data;
 
 	/* 0x83 and 0x84 key events comes duplicated... */
 	if (event == 0x83 || event == 0x84) {
@@ -116,7 +112,7 @@ static void acpi_topstar_notify(acpi_handle handle, u32 event, void *data)
 	if (event == 0x8e || event == 0x8f || event == 0x90)
 		return;
 
-	printk(TOPSTAR_ACPI_INFO "unknown event = 0x%02x\n", event);
+	pr_info("unknown event = 0x%02x\n", event);
 }
 
 static int acpi_topstar_fncx_switch(struct acpi_device *device, bool state)
@@ -132,7 +128,7 @@ static int acpi_topstar_fncx_switch(struct acpi_device *device, bool state)
 
 	status = acpi_get_handle(device->handle, "FNCX", &handle);
 	if (ACPI_FAILURE(status)) {
-		printk(TOPSTAR_ACPI_ERR "FNCX method not found\n");
+		pr_err("FNCX method not found\n");
 		return -ENODEV;
 	}
 	fncx_params[0].integer.value = state ? 0x86 : 0x87;
@@ -140,8 +136,7 @@ static int acpi_topstar_fncx_switch(struct acpi_device *device, bool state)
 	buf.pointer = &obj;
 	status = acpi_evaluate_object(handle, NULL, &fncx_arg_list, &buf);
 	if (ACPI_FAILURE(status)) {
-		printk(TOPSTAR_ACPI_ERR
-		       "Unable to switch FNCX notifications\n");
+		pr_err("Unable to switch FNCX notifications\n");
 		return -ENODEV;
 	}
 
@@ -187,7 +182,7 @@ static int acpi_topstar_init_hkey(struct topstar_hkey *hkey)
 
 	hkey->inputdev = input_allocate_device();
 	if (!hkey->inputdev) {
-		printk(TOPSTAR_ACPI_ERR "Unable to allocate input device\n");
+		pr_err("Unable to allocate input device\n");
 		return -ENODEV;
 	}
 	hkey->inputdev->name = "Topstar Laptop extra buttons";
@@ -200,7 +195,7 @@ static int acpi_topstar_init_hkey(struct topstar_hkey *hkey)
 		set_bit(key->keycode, hkey->inputdev->keybit);
 	}
 	if (input_register_device(hkey->inputdev)) {
-		printk(TOPSTAR_ACPI_ERR "Unable to register input device\n");
+		pr_err("Unable to register input device\n");
 		input_free_device(hkey->inputdev);
 		return -ENODEV;
 	}
@@ -208,9 +203,10 @@ static int acpi_topstar_init_hkey(struct topstar_hkey *hkey)
 	return 0;
 }
 
+static int is_tps_dev;
+
 static int acpi_topstar_add(struct acpi_device *device)
 {
-	acpi_status status;
 	struct topstar_hkey *tps_hkey;
 
 	if (!device)
@@ -231,11 +227,7 @@ static int acpi_topstar_add(struct acpi_device *device)
 	if (acpi_topstar_init_hkey(tps_hkey))
 		goto add_err;
 
-	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
-					     acpi_topstar_notify, tps_hkey);
-	if (ACPI_FAILURE(status))
-		goto add_err;
-
+	is_tps_dev = 1;
 	return 0;
 
 add_err:
@@ -251,9 +243,6 @@ static int acpi_topstar_remove(struct acpi_device *device, int type)
 	if (!device || !tps_hkey)
 		return -EINVAL;
 
-	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
-				   acpi_topstar_notify);
-
 	acpi_topstar_fncx_switch(device, false);
 
 	input_unregister_device(tps_hkey->inputdev);
@@ -270,31 +259,38 @@ static struct acpi_driver acpi_topstar_driver = {
 	.ops = {
 		.add = acpi_topstar_add,
 		.remove = acpi_topstar_remove,
+		.notify = acpi_topstar_notify,
 	},
 };
 
-static int __init acpi_topstar_init(void)
+static int __init topstar_laptop_init(void)
 {
+	int ret;
+
 	if (acpi_disabled)
 		return -ENODEV;
 
-	if (acpi_bus_register_driver(&acpi_topstar_driver) < 0)
+	ret = acpi_bus_register_driver(&acpi_topstar_driver);
+	if (ret < 0)
+		return ret;
+
+	if (!is_tps_dev) {
+		acpi_bus_unregister_driver(&acpi_topstar_driver);
 		return -ENODEV;
+	}
 
 	printk(KERN_INFO "Topstar Laptop ACPI extras driver loaded\n");
 
 	return 0;
 }
 
-static void __exit acpi_topstar_exit(void)
+static void __exit topstar_laptop_exit(void)
 {
 	acpi_bus_unregister_driver(&acpi_topstar_driver);
-
-	printk(KERN_INFO "Topstar Laptop ACPI extras driver unloaded\n");
 }
 
-module_init(acpi_topstar_init);
-module_exit(acpi_topstar_exit);
+module_init(topstar_laptop_init);
+module_exit(topstar_laptop_exit);
 
 MODULE_AUTHOR("Herton Ronaldo Krzesinski");
 MODULE_DESCRIPTION("Topstar Laptop ACPI Extras driver");

--Boundary-00=_L5VpKqs2/WBI6Ka--
