From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: [PATCH v4] topstar-laptop: add new driver for hotkeys support on Topstar N01
Date: Sat, 12 Sep 2009 01:55:45 -0300
Message-ID: <200909120155.45521.herton@mandriva.com.br>
References: <200909092102.22152.herton@mandriva.com.br> <200909101702.54249.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RnyqKBOsZVtTwdJ"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:39049 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbZILEzt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Sep 2009 00:55:49 -0400
In-Reply-To: <200909101702.54249.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Alan Jenkins <sourcejedi.lkml@googlemail.com>, Corentin Chary <corentin.chary@gmail.com>

--Boundary-00=_RnyqKBOsZVtTwdJ
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Em Qui 10 Set 2009, =E0s 20:02:53, Bjorn Helgaas escreveu:
> On Wednesday 09 September 2009 06:02:22 pm Herton Ronaldo Krzesinski wrot=
e:
> > This adds Topstar Laptop Extras ACPI driver. It enables hotkeys
> > functionality with Topstar N01 netbook. Besides hotkeys there are
> > other functions exposed by its ACPI firmware, but for now only
> > hotkeys reporting on Topstar N01 is supported. Topstar is a chinese
> > manufacturer, its website can be currently reached at
> > http://www.topstardigital.cn/
> >=20
> > Reviewed-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> > Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> > ---
> >  MAINTAINERS                           |    5 +
> >  drivers/platform/x86/Kconfig          |    9 +
> >  drivers/platform/x86/Makefile         |    1 +
> >  drivers/platform/x86/topstar-laptop.c |  299 +++++++++++++++++++++++++=
++++++++
> >  4 files changed, 314 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/platform/x86/topstar-laptop.c
> >=20
> > v3 addresses last comments on the patch previously posted and adds miss=
ing
> > MODULE_DEVICE_TABLE entry
> > v4 adds myself to MAINTAINERS
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8dca9d8..d75a7a7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4968,6 +4968,11 @@ T:	quilt http://svn.sourceforge.jp/svnroot/tomoy=
o/trunk/2.2.x/tomoyo-lsm/patches
> >  S:	Maintained
> >  F:	security/tomoyo/
> > =20
> > +TOPSTAR LAPTOP EXTRAS DRIVER
> > +M:	Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> > +S:	Maintained
> > +F:	drivers/platform/x86/topstar-laptop.c
> > +
> >  TOSHIBA ACPI EXTRAS DRIVER
> >  S:	Orphan
> >  F:	drivers/platform/x86/toshiba_acpi.c
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > index 77c6097..4831562 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -396,6 +396,15 @@ config ACPI_ASUS
> >  	  NOTE: This driver is deprecated and will probably be removed soon,
> >  	  use asus-laptop instead.
> > =20
> > +config TOPSTAR_LAPTOP
> > +	tristate "Topstar Laptop Extras"
> > +	depends on ACPI
> > +	depends on INPUT
> > +	---help---
> > +	  This driver adds support for hotkeys found on Topstar laptops.
> > +
> > +	  If you have a Topstar laptop, say Y or M here.
> > +
> >  config ACPI_TOSHIBA
> >  	tristate "Toshiba Laptop Extras"
> >  	depends on ACPI
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makef=
ile
> > index 641b8bf..d1c1621 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -19,4 +19,5 @@ obj-$(CONFIG_PANASONIC_LAPTOP)	+=3D panasonic-laptop.o
> >  obj-$(CONFIG_INTEL_MENLOW)	+=3D intel_menlow.o
> >  obj-$(CONFIG_ACPI_WMI)		+=3D wmi.o
> >  obj-$(CONFIG_ACPI_ASUS)		+=3D asus_acpi.o
> > +obj-$(CONFIG_TOPSTAR_LAPTOP)	+=3D topstar-laptop.o
> >  obj-$(CONFIG_ACPI_TOSHIBA)	+=3D toshiba_acpi.o
> > diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x=
86/topstar-laptop.c
> > new file mode 100644
> > index 0000000..795d788
> > --- /dev/null
> > +++ b/drivers/platform/x86/topstar-laptop.c
> > @@ -0,0 +1,299 @@
> > +/*
> > + * ACPI driver for Topstar notebooks (hotkeys support only)
> > + *
> > + * Copyright (c) 2009 Herton Ronaldo Krzesinski <herton@mandriva.com.b=
r>
> > + *
> > + * Implementation inspired by existing x86 platform drivers, in special
> > + * asus/eepc/fujitsu-laptop, thanks to their authors
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/acpi.h>
> > +#include <linux/input.h>
> > +
> > +#define ACPI_TOPSTAR_HID "TPSACPI01"
> > +#define ACPI_TOPSTAR_DEVICE_NAME "Topstar TPSACPI01"
> > +#define ACPI_TOPSTAR_DRIVER_NAME "Topstar laptop ACPI driver"
> > +#define ACPI_TOPSTAR_CLASS "topstar"
> > +
> > +static const struct acpi_device_id topstar_device_ids[] =3D {
> > +	{ ACPI_TOPSTAR_HID, 0 },
> > +	{ "", 0 },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, topstar_device_ids);
>=20
> Some of these #defines are only used once, and I don't think it adds
> anything to wrap the constant with a name.  Personally, I think it
> makes more sense to put the device_id table next to the acpi_driver
> struct that references it.
>=20
> > +
> > +struct topstar_hkey {
> > +	struct input_dev *inputdev;
> > +};
> > +
> > +struct tps_key_entry {
> > +	u8 code;
> > +	u16 keycode;
> > +};
> > +
> > +static struct tps_key_entry topstar_keymap[] =3D {
> > +	{ 0x80, KEY_BRIGHTNESSUP },
> > +	{ 0x81, KEY_BRIGHTNESSDOWN },
> > +	{ 0x83, KEY_VOLUMEUP },
> > +	{ 0x84, KEY_VOLUMEDOWN },
> > +	{ 0x85, KEY_MUTE },
> > +	{ 0x86, KEY_SWITCHVIDEOMODE },
> > +	{ 0x87, KEY_F13 }, /* touchpad enable/disable key */
> > +	{ 0x88, KEY_WLAN },
> > +	{ 0x8a, KEY_WWW },
> > +	{ 0x8b, KEY_MAIL },
> > +	{ 0x8c, KEY_MEDIA },
> > +	{ 0x96, KEY_F14 }, /* G key? */
> > +	{ }
> > +};
> > +
> > +static struct tps_key_entry *tps_get_key_by_scancode(int code)
> > +{
> > +	struct tps_key_entry *key;
> > +
> > +	for (key =3D topstar_keymap; key->code; key++)
> > +		if (code =3D=3D key->code)
> > +			return key;
> > +
> > +	return NULL;
> > +}
> > +
> > +static struct tps_key_entry *tps_get_key_by_keycode(int code)
> > +{
> > +	struct tps_key_entry *key;
> > +
> > +	for (key =3D topstar_keymap; key->code; key++)
> > +		if (code =3D=3D key->keycode)
> > +			return key;
> > +
> > +	return NULL;
> > +}
> > +
> > +static void acpi_topstar_notify(struct acpi_device *device, u32 event)
> > +{
> > +	struct tps_key_entry *key;
> > +	static bool dup_evnt[2];
> > +	bool *dup;
> > +	struct topstar_hkey *hkey =3D device->driver_data;
>=20
> I don't know whether acpi_driver_data() really adds any value,
> but you do use it in acpi_topstar_remove(), so it'd be good to
> at least use it consistently.
>=20
> > +	/* 0x83 and 0x84 key events comes duplicated... */
> > +	if (event =3D=3D 0x83 || event =3D=3D 0x84) {
> > +		dup =3D &dup_evnt[event - 0x83];
> > +		if (*dup) {
> > +			*dup =3D false;
> > +			return;
> > +		}
> > +		*dup =3D true;
> > +	}
> > +
> > +	/*
> > +	 * 'G key' generate two event codes, convert to only
> > +	 * one event/key code for now (3G switch?)
> > +	 */
> > +	if (event =3D=3D 0x97)
> > +		event =3D 0x96;
> > +
> > +	key =3D tps_get_key_by_scancode(event);
> > +	if (key) {
> > +		input_report_key(hkey->inputdev, key->keycode, 1);
> > +		input_sync(hkey->inputdev);
> > +		input_report_key(hkey->inputdev, key->keycode, 0);
> > +		input_sync(hkey->inputdev);
> > +		return;
> > +	}
> > +
> > +	/* Known non hotkey events don't handled or that we don't care yet */
> > +	if (event =3D=3D 0x8e || event =3D=3D 0x8f || event =3D=3D 0x90)
> > +		return;
> > +
> > +	pr_info("unknown event =3D 0x%02x\n", event);
> > +}
> > +
> > +static int acpi_topstar_fncx_switch(struct acpi_device *device, bool s=
tate)
> > +{
> > +	acpi_status status;
> > +	acpi_handle handle =3D NULL;
> > +	union acpi_object fncx_params[1] =3D {
> > +		{ .type =3D ACPI_TYPE_INTEGER }
> > +	};
> > +	struct acpi_object_list fncx_arg_list =3D { 1, &fncx_params[0] };
> > +	struct acpi_buffer buf;
> > +	union acpi_object obj;
> > +
> > +	status =3D acpi_get_handle(device->handle, "FNCX", &handle);
> > +	if (ACPI_FAILURE(status)) {
> > +		pr_err("FNCX method not found\n");
> > +		return -ENODEV;
> > +	}
>=20
> There's no need to check whether FNCX exists before trying to
> evaluate it (unless you really want the different error message
> for some reason).

Yep, also I noted other issue: I get the result from method in
acpi_evaluate_object below (buf), but no result is returned and don't need =
it,
so I removed it too.

>=20
> > +	fncx_params[0].integer.value =3D state ? 0x86 : 0x87;
> > +	buf.length =3D sizeof(obj);
> > +	buf.pointer =3D &obj;
> > +	status =3D acpi_evaluate_object(handle, NULL, &fncx_arg_list, &buf);
> > +	if (ACPI_FAILURE(status)) {
> > +		pr_err("Unable to switch FNCX notifications\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int topstar_getkeycode(struct input_dev *dev, int scancode, int=
 *keycode)
> > +{
> > +	struct tps_key_entry *key =3D tps_get_key_by_scancode(scancode);
> > +
> > +	if (key) {
> > +		*keycode =3D key->keycode;
> > +		return 0;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int topstar_setkeycode(struct input_dev *dev, int scancode, int=
 keycode)
> > +{
> > +	struct tps_key_entry *key;
> > +	int old_keycode;
> > +
> > +	if (keycode < 0 || keycode > KEY_MAX)
> > +		return -EINVAL;
> > +
> > +	key =3D tps_get_key_by_scancode(scancode);
> > +	if (key) {
> > +		old_keycode =3D key->keycode;
> > +		key->keycode =3D keycode;
> > +		set_bit(keycode, dev->keybit);
> > +		if (!tps_get_key_by_keycode(old_keycode))
> > +			clear_bit(old_keycode, dev->keybit);
> > +		return 0;
> > +	}
>=20
> Nit (even more than the rest :-)): you could use:
>=20
> 	if (!key)
> 		return -EINVAL;
>=20
> 	... normal case code ...
> 	return 0;
>=20
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int acpi_topstar_init_hkey(struct topstar_hkey *hkey)
> > +{
> > +	struct tps_key_entry *key;
> > +
> > +	hkey->inputdev =3D input_allocate_device();
> > +	if (!hkey->inputdev) {
> > +		pr_err("Unable to allocate input device\n");
> > +		return -ENODEV;
> > +	}
> > +	hkey->inputdev->name =3D "Topstar Laptop extra buttons";
> > +	hkey->inputdev->phys =3D "topstar/input0";
> > +	hkey->inputdev->id.bustype =3D BUS_HOST;
> > +	hkey->inputdev->getkeycode =3D topstar_getkeycode;
> > +	hkey->inputdev->setkeycode =3D topstar_setkeycode;
> > +	for (key =3D topstar_keymap; key->code; key++) {
> > +		set_bit(EV_KEY, hkey->inputdev->evbit);
> > +		set_bit(key->keycode, hkey->inputdev->keybit);
> > +	}
> > +	if (input_register_device(hkey->inputdev)) {
> > +		pr_err("Unable to register input device\n");
> > +		input_free_device(hkey->inputdev);
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static bool found_tps_dev;
> > +
> > +static int acpi_topstar_add(struct acpi_device *device)
> > +{
> > +	struct topstar_hkey *tps_hkey;
> > +
> > +	if (!device)
> > +		return -EINVAL;
>=20
> Unnecessary NULL check.
>=20
> > +	tps_hkey =3D kzalloc(sizeof(struct topstar_hkey), GFP_KERNEL);
> > +	if (!tps_hkey)
> > +		return -ENOMEM;
> > +
> > +	sprintf(acpi_device_name(device), "%s", ACPI_TOPSTAR_DEVICE_NAME);
> > +	sprintf(acpi_device_class(device), "%s", ACPI_TOPSTAR_CLASS);
>=20
> Hmm, too bad we can't avoid overflowing the fixed-size buffers you're
> filling here (not your problem -- every other user also has the same
> problem).  Most other users use strcpy() rather than sprintf(), though,
> and that'd be slightly simpler here as well.
>=20
> > +	if (acpi_topstar_fncx_switch(device, true))
> > +		goto add_err;
> > +
> > +	device->driver_data =3D tps_hkey;
> > +
> > +	if (acpi_topstar_init_hkey(tps_hkey))
> > +		goto add_err;
> > +
> > +	found_tps_dev =3D true;
> > +	return 0;
> > +
> > +add_err:
> > +	kfree(tps_hkey);
> > +	device->driver_data =3D NULL;
>=20
> Not necessary to clear this out, especially since you could move
> the assignment down after you know you're going to return success.
>=20
> > +	return -ENODEV;
> > +}
> > +
> > +static int acpi_topstar_remove(struct acpi_device *device, int type)
> > +{
> > +	struct topstar_hkey *tps_hkey =3D acpi_driver_data(device);
> > +
> > +	if (!device || !tps_hkey)
> > +		return -EINVAL;
>=20
> Unnecessary NULL checks.
>=20
> > +	acpi_topstar_fncx_switch(device, false);
> > +
> > +	input_unregister_device(tps_hkey->inputdev);
> > +	kfree(tps_hkey);
> > +	device->driver_data =3D NULL;
> > +
> > +	return 0;
> > +}
> > +
> > +static struct acpi_driver acpi_topstar_driver =3D {
> > +	.name =3D ACPI_TOPSTAR_DRIVER_NAME,
> > +	.class =3D ACPI_TOPSTAR_CLASS,
> > +	.ids =3D topstar_device_ids,
> > +	.ops =3D {
> > +		.add =3D acpi_topstar_add,
> > +		.remove =3D acpi_topstar_remove,
> > +		.notify =3D acpi_topstar_notify,
> > +	},
> > +};
> > +
> > +static int __init topstar_laptop_init(void)
> > +{
> > +	int ret;
> > +
> > +	if (acpi_disabled)
> > +		return -ENODEV;
>=20
> We shouldn't need this check.  acpi_bus_register_driver() fails if
> acpi_disabled.
>=20
> > +	ret =3D acpi_bus_register_driver(&acpi_topstar_driver);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (!found_tps_dev) {
>=20
> Why do we need this check to see if we found a device?  This box
> nicely supplies a device with a _HID, so we should get a udev
> event requesting a driver for TPSACPI01, and that is what should
> cause this driver to be loaded.

It's needed because someone can modprobe the module manually in a machine t=
hat
doesn't have TPSACPI01, and acpi_bus_register_driver doesn't fail in this c=
ase,
so the additional check (I want ENODEV to be returned).

Except from this, all other issues you pointed out I fixed now, thanks for =
the
review, just add your reviewed-by if you wish in below updated patch (also I
attach just the diff from previous topstar-laptop.c, to see changes easier):

=46rom 18b722bab6fda5647b03a2b3e63da49786db20d2 Mon Sep 17 00:00:00 2001
=46rom: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Date: Sat, 12 Sep 2009 01:36:54 -0300
Subject: [PATCH v5] topstar-laptop: add new driver for hotkeys support on T=
opstar N01

This adds Topstar Laptop Extras ACPI driver. It enables hotkeys
functionality with Topstar N01 netbook. Besides hotkeys there are
other functions exposed by its ACPI firmware, but for now only
hotkeys reporting on Topstar N01 is supported. Topstar is a chinese
manufacturer, its website can be currently reached at
http://www.topstardigital.cn/

Reviewed-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
=2D--
 MAINTAINERS                           |    5 +
 drivers/platform/x86/Kconfig          |    9 +
 drivers/platform/x86/Makefile         |    1 +
 drivers/platform/x86/topstar-laptop.c |  274 +++++++++++++++++++++++++++++=
++++
 4 files changed, 289 insertions(+), 0 deletions(-)
 create mode 100644 drivers/platform/x86/topstar-laptop.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8dca9d8..d75a7a7 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4968,6 +4968,11 @@ T:	quilt http://svn.sourceforge.jp/svnroot/tomoyo/tr=
unk/2.2.x/tomoyo-lsm/patches
 S:	Maintained
 F:	security/tomoyo/
=20
+TOPSTAR LAPTOP EXTRAS DRIVER
+M:	Herton Ronaldo Krzesinski <herton@mandriva.com.br>
+S:	Maintained
+F:	drivers/platform/x86/topstar-laptop.c
+
 TOSHIBA ACPI EXTRAS DRIVER
 S:	Orphan
 F:	drivers/platform/x86/toshiba_acpi.c
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
index 0000000..e74fbe9
=2D-- /dev/null
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -0,0 +1,274 @@
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
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/input.h>
+
+#define ACPI_TOPSTAR_CLASS "topstar"
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
+	struct topstar_hkey *hkey =3D acpi_driver_data(device);
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
+	union acpi_object fncx_params[1] =3D {
+		{ .type =3D ACPI_TYPE_INTEGER }
+	};
+	struct acpi_object_list fncx_arg_list =3D { 1, &fncx_params[0] };
+
+	fncx_params[0].integer.value =3D state ? 0x86 : 0x87;
+	status =3D acpi_evaluate_object(device->handle, "FNCX", &fncx_arg_list, N=
ULL);
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
+	if (!key)
+		return -EINVAL;
+
+	*keycode =3D key->keycode;
+	return 0;
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
+
+	if (!key)
+		return -EINVAL;
+
+	old_keycode =3D key->keycode;
+	key->keycode =3D keycode;
+	set_bit(keycode, dev->keybit);
+	if (!tps_get_key_by_keycode(old_keycode))
+		clear_bit(old_keycode, dev->keybit);
+	return 0;
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
+static bool found_tps_dev;
+
+static int acpi_topstar_add(struct acpi_device *device)
+{
+	struct topstar_hkey *tps_hkey;
+
+	tps_hkey =3D kzalloc(sizeof(struct topstar_hkey), GFP_KERNEL);
+	if (!tps_hkey)
+		return -ENOMEM;
+
+	strcpy(acpi_device_name(device), "Topstar TPSACPI");
+	strcpy(acpi_device_class(device), ACPI_TOPSTAR_CLASS);
+
+	if (acpi_topstar_fncx_switch(device, true))
+		goto add_err;
+
+	if (acpi_topstar_init_hkey(tps_hkey))
+		goto add_err;
+
+	device->driver_data =3D tps_hkey;
+	found_tps_dev =3D true;
+	return 0;
+
+add_err:
+	kfree(tps_hkey);
+	return -ENODEV;
+}
+
+static int acpi_topstar_remove(struct acpi_device *device, int type)
+{
+	struct topstar_hkey *tps_hkey =3D acpi_driver_data(device);
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
+static const struct acpi_device_id topstar_device_ids[] =3D {
+	{ "TPSACPI01", 0 },
+	{ "", 0 },
+};
+MODULE_DEVICE_TABLE(acpi, topstar_device_ids);
+
+static struct acpi_driver acpi_topstar_driver =3D {
+	.name =3D "Topstar laptop ACPI driver",
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
+	ret =3D acpi_bus_register_driver(&acpi_topstar_driver);
+	if (ret < 0)
+		return ret;
+
+	if (!found_tps_dev) {
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
> > +		acpi_bus_unregister_driver(&acpi_topstar_driver);
> > +		return -ENODEV;
> > +	}
> > +
> > +	printk(KERN_INFO "Topstar Laptop ACPI extras driver loaded\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static void __exit topstar_laptop_exit(void)
> > +{
> > +	acpi_bus_unregister_driver(&acpi_topstar_driver);
> > +}
> > +
> > +module_init(topstar_laptop_init);
> > +module_exit(topstar_laptop_exit);
> > +
> > +MODULE_AUTHOR("Herton Ronaldo Krzesinski");
> > +MODULE_DESCRIPTION("Topstar Laptop ACPI Extras driver");
> > +MODULE_LICENSE("GPL");
>=20
>=20
>=20

=2D-=20
[]'s
Herton

--Boundary-00=_RnyqKBOsZVtTwdJ
Content-Type: text/x-patch;
  charset="UTF-8";
  name="review3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="review3.patch"

diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index 795d788..e74fbe9 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -19,17 +19,8 @@
 #include <linux/acpi.h>
 #include <linux/input.h>
 
-#define ACPI_TOPSTAR_HID "TPSACPI01"
-#define ACPI_TOPSTAR_DEVICE_NAME "Topstar TPSACPI01"
-#define ACPI_TOPSTAR_DRIVER_NAME "Topstar laptop ACPI driver"
 #define ACPI_TOPSTAR_CLASS "topstar"
 
-static const struct acpi_device_id topstar_device_ids[] = {
-	{ ACPI_TOPSTAR_HID, 0 },
-	{ "", 0 },
-};
-MODULE_DEVICE_TABLE(acpi, topstar_device_ids);
-
 struct topstar_hkey {
 	struct input_dev *inputdev;
 };
@@ -82,7 +73,7 @@ static void acpi_topstar_notify(struct acpi_device *device, u32 event)
 	struct tps_key_entry *key;
 	static bool dup_evnt[2];
 	bool *dup;
-	struct topstar_hkey *hkey = device->driver_data;
+	struct topstar_hkey *hkey = acpi_driver_data(device);
 
 	/* 0x83 and 0x84 key events comes duplicated... */
 	if (event == 0x83 || event == 0x84) {
@@ -120,23 +111,13 @@ static void acpi_topstar_notify(struct acpi_device *device, u32 event)
 static int acpi_topstar_fncx_switch(struct acpi_device *device, bool state)
 {
 	acpi_status status;
-	acpi_handle handle = NULL;
 	union acpi_object fncx_params[1] = {
 		{ .type = ACPI_TYPE_INTEGER }
 	};
 	struct acpi_object_list fncx_arg_list = { 1, &fncx_params[0] };
-	struct acpi_buffer buf;
-	union acpi_object obj;
 
-	status = acpi_get_handle(device->handle, "FNCX", &handle);
-	if (ACPI_FAILURE(status)) {
-		pr_err("FNCX method not found\n");
-		return -ENODEV;
-	}
 	fncx_params[0].integer.value = state ? 0x86 : 0x87;
-	buf.length = sizeof(obj);
-	buf.pointer = &obj;
-	status = acpi_evaluate_object(handle, NULL, &fncx_arg_list, &buf);
+	status = acpi_evaluate_object(device->handle, "FNCX", &fncx_arg_list, NULL);
 	if (ACPI_FAILURE(status)) {
 		pr_err("Unable to switch FNCX notifications\n");
 		return -ENODEV;
@@ -149,12 +130,11 @@ static int topstar_getkeycode(struct input_dev *dev, int scancode, int *keycode)
 {
 	struct tps_key_entry *key = tps_get_key_by_scancode(scancode);
 
-	if (key) {
-		*keycode = key->keycode;
-		return 0;
-	}
+	if (!key)
+		return -EINVAL;
 
-	return -EINVAL;
+	*keycode = key->keycode;
+	return 0;
 }
 
 static int topstar_setkeycode(struct input_dev *dev, int scancode, int keycode)
@@ -166,16 +146,16 @@ static int topstar_setkeycode(struct input_dev *dev, int scancode, int keycode)
 		return -EINVAL;
 
 	key = tps_get_key_by_scancode(scancode);
-	if (key) {
-		old_keycode = key->keycode;
-		key->keycode = keycode;
-		set_bit(keycode, dev->keybit);
-		if (!tps_get_key_by_keycode(old_keycode))
-			clear_bit(old_keycode, dev->keybit);
-		return 0;
-	}
 
-	return -EINVAL;
+	if (!key)
+		return -EINVAL;
+
+	old_keycode = key->keycode;
+	key->keycode = keycode;
+	set_bit(keycode, dev->keybit);
+	if (!tps_get_key_by_keycode(old_keycode))
+		clear_bit(old_keycode, dev->keybit);
+	return 0;
 }
 
 static int acpi_topstar_init_hkey(struct topstar_hkey *hkey)
@@ -211,30 +191,25 @@ static int acpi_topstar_add(struct acpi_device *device)
 {
 	struct topstar_hkey *tps_hkey;
 
-	if (!device)
-		return -EINVAL;
-
 	tps_hkey = kzalloc(sizeof(struct topstar_hkey), GFP_KERNEL);
 	if (!tps_hkey)
 		return -ENOMEM;
 
-	sprintf(acpi_device_name(device), "%s", ACPI_TOPSTAR_DEVICE_NAME);
-	sprintf(acpi_device_class(device), "%s", ACPI_TOPSTAR_CLASS);
+	strcpy(acpi_device_name(device), "Topstar TPSACPI");
+	strcpy(acpi_device_class(device), ACPI_TOPSTAR_CLASS);
 
 	if (acpi_topstar_fncx_switch(device, true))
 		goto add_err;
 
-	device->driver_data = tps_hkey;
-
 	if (acpi_topstar_init_hkey(tps_hkey))
 		goto add_err;
 
+	device->driver_data = tps_hkey;
 	found_tps_dev = true;
 	return 0;
 
 add_err:
 	kfree(tps_hkey);
-	device->driver_data = NULL;
 	return -ENODEV;
 }
 
@@ -242,9 +217,6 @@ static int acpi_topstar_remove(struct acpi_device *device, int type)
 {
 	struct topstar_hkey *tps_hkey = acpi_driver_data(device);
 
-	if (!device || !tps_hkey)
-		return -EINVAL;
-
 	acpi_topstar_fncx_switch(device, false);
 
 	input_unregister_device(tps_hkey->inputdev);
@@ -254,8 +226,14 @@ static int acpi_topstar_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
+static const struct acpi_device_id topstar_device_ids[] = {
+	{ "TPSACPI01", 0 },
+	{ "", 0 },
+};
+MODULE_DEVICE_TABLE(acpi, topstar_device_ids);
+
 static struct acpi_driver acpi_topstar_driver = {
-	.name = ACPI_TOPSTAR_DRIVER_NAME,
+	.name = "Topstar laptop ACPI driver",
 	.class = ACPI_TOPSTAR_CLASS,
 	.ids = topstar_device_ids,
 	.ops = {
@@ -269,9 +247,6 @@ static int __init topstar_laptop_init(void)
 {
 	int ret;
 
-	if (acpi_disabled)
-		return -ENODEV;
-
 	ret = acpi_bus_register_driver(&acpi_topstar_driver);
 	if (ret < 0)
 		return ret;

--Boundary-00=_RnyqKBOsZVtTwdJ--
