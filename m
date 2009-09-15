From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: [PATCH v6] topstar-laptop: add new driver for hotkeys support on Topstar N01
Date: Tue, 15 Sep 2009 00:14:02 -0300
Message-ID: <200909150014.02908.herton@mandriva.com.br>
References: <200909142111.22037.herton@mandriva.com.br> <1252982124.30298.1.camel@dc7800.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:33010 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758042AbZIODOF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2009 23:14:05 -0400
In-Reply-To: <1252982124.30298.1.camel@dc7800.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Alan Jenkins <sourcejedi.lkml@googlemail.com>, Corentin Chary <corentin.chary@gmail.com>

Em Seg 14 Set 2009, =E0s 23:35:24, Bjorn Helgaas escreveu:
> On Mon, 2009-09-14 at 21:11 -0300, Herton Ronaldo Krzesinski wrote:
> > This adds Topstar Laptop Extras ACPI driver. It enables hotkeys
> > functionality with Topstar N01 netbook. Besides hotkeys there are
> > other functions exposed by its ACPI firmware, but for now only
> > hotkeys reporting on Topstar N01 is supported. Topstar is a chinese
> > manufacturer, its website can be currently reached at
> > http://www.topstardigital.cn/
> >=20
> > Reviewed-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> > Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
>=20
> I can't test this, of course, but from an ACPI driver point of view,
> it looks good to me, so if you think it's worth anything, you can add=
:
>=20
> Reviewed-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Sure, should I repost with your reviewed-by, or this can this be added =
while
merging patch v6 I posted?

>=20
>=20
> > ---
> >  MAINTAINERS                           |    5 +
> >  drivers/platform/x86/Kconfig          |    9 +
> >  drivers/platform/x86/Makefile         |    1 +
> >  drivers/platform/x86/topstar-laptop.c |  265 +++++++++++++++++++++=
++++++++++++
> >  4 files changed, 280 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/platform/x86/topstar-laptop.c
> >=20
> > v5 - review fixes
> > v6 - more review fixes: remove additional check when manually modpr=
obing module,
> > remove uneeded driver_data =3D NULL from acpi_topstar_remove
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8dca9d8..d75a7a7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4968,6 +4968,11 @@ T:	quilt http://svn.sourceforge.jp/svnroot/t=
omoyo/trunk/2.2.x/tomoyo-lsm/patches
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
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kc=
onfig
> > index 77c6097..4831562 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -396,6 +396,15 @@ config ACPI_ASUS
> >  	  NOTE: This driver is deprecated and will probably be removed so=
on,
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
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/M=
akefile
> > index 641b8bf..d1c1621 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -19,4 +19,5 @@ obj-$(CONFIG_PANASONIC_LAPTOP)	+=3D panasonic-lap=
top.o
> >  obj-$(CONFIG_INTEL_MENLOW)	+=3D intel_menlow.o
> >  obj-$(CONFIG_ACPI_WMI)		+=3D wmi.o
> >  obj-$(CONFIG_ACPI_ASUS)		+=3D asus_acpi.o
> > +obj-$(CONFIG_TOPSTAR_LAPTOP)	+=3D topstar-laptop.o
> >  obj-$(CONFIG_ACPI_TOSHIBA)	+=3D toshiba_acpi.o
> > diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platfo=
rm/x86/topstar-laptop.c
> > new file mode 100644
> > index 0000000..02f3d4e
> > --- /dev/null
> > +++ b/drivers/platform/x86/topstar-laptop.c
> > @@ -0,0 +1,265 @@
> > +/*
> > + * ACPI driver for Topstar notebooks (hotkeys support only)
> > + *
> > + * Copyright (c) 2009 Herton Ronaldo Krzesinski <herton@mandriva.c=
om.br>
> > + *
> > + * Implementation inspired by existing x86 platform drivers, in sp=
ecial
> > + * asus/eepc/fujitsu-laptop, thanks to their authors
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License version 2 =
as
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
> > +#define ACPI_TOPSTAR_CLASS "topstar"
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
> > +static void acpi_topstar_notify(struct acpi_device *device, u32 ev=
ent)
> > +{
> > +	struct tps_key_entry *key;
> > +	static bool dup_evnt[2];
> > +	bool *dup;
> > +	struct topstar_hkey *hkey =3D acpi_driver_data(device);
> > +
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
> > +	/* Known non hotkey events don't handled or that we don't care ye=
t */
> > +	if (event =3D=3D 0x8e || event =3D=3D 0x8f || event =3D=3D 0x90)
> > +		return;
> > +
> > +	pr_info("unknown event =3D 0x%02x\n", event);
> > +}
> > +
> > +static int acpi_topstar_fncx_switch(struct acpi_device *device, bo=
ol state)
> > +{
> > +	acpi_status status;
> > +	union acpi_object fncx_params[1] =3D {
> > +		{ .type =3D ACPI_TYPE_INTEGER }
> > +	};
> > +	struct acpi_object_list fncx_arg_list =3D { 1, &fncx_params[0] };
> > +
> > +	fncx_params[0].integer.value =3D state ? 0x86 : 0x87;
> > +	status =3D acpi_evaluate_object(device->handle, "FNCX", &fncx_arg=
_list, NULL);
> > +	if (ACPI_FAILURE(status)) {
> > +		pr_err("Unable to switch FNCX notifications\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int topstar_getkeycode(struct input_dev *dev, int scancode,=
 int *keycode)
> > +{
> > +	struct tps_key_entry *key =3D tps_get_key_by_scancode(scancode);
> > +
> > +	if (!key)
> > +		return -EINVAL;
> > +
> > +	*keycode =3D key->keycode;
> > +	return 0;
> > +}
> > +
> > +static int topstar_setkeycode(struct input_dev *dev, int scancode,=
 int keycode)
> > +{
> > +	struct tps_key_entry *key;
> > +	int old_keycode;
> > +
> > +	if (keycode < 0 || keycode > KEY_MAX)
> > +		return -EINVAL;
> > +
> > +	key =3D tps_get_key_by_scancode(scancode);
> > +
> > +	if (!key)
> > +		return -EINVAL;
> > +
> > +	old_keycode =3D key->keycode;
> > +	key->keycode =3D keycode;
> > +	set_bit(keycode, dev->keybit);
> > +	if (!tps_get_key_by_keycode(old_keycode))
> > +		clear_bit(old_keycode, dev->keybit);
> > +	return 0;
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
> > +static int acpi_topstar_add(struct acpi_device *device)
> > +{
> > +	struct topstar_hkey *tps_hkey;
> > +
> > +	tps_hkey =3D kzalloc(sizeof(struct topstar_hkey), GFP_KERNEL);
> > +	if (!tps_hkey)
> > +		return -ENOMEM;
> > +
> > +	strcpy(acpi_device_name(device), "Topstar TPSACPI");
> > +	strcpy(acpi_device_class(device), ACPI_TOPSTAR_CLASS);
> > +
> > +	if (acpi_topstar_fncx_switch(device, true))
> > +		goto add_err;
> > +
> > +	if (acpi_topstar_init_hkey(tps_hkey))
> > +		goto add_err;
> > +
> > +	device->driver_data =3D tps_hkey;
> > +	return 0;
> > +
> > +add_err:
> > +	kfree(tps_hkey);
> > +	return -ENODEV;
> > +}
> > +
> > +static int acpi_topstar_remove(struct acpi_device *device, int typ=
e)
> > +{
> > +	struct topstar_hkey *tps_hkey =3D acpi_driver_data(device);
> > +
> > +	acpi_topstar_fncx_switch(device, false);
> > +
> > +	input_unregister_device(tps_hkey->inputdev);
> > +	kfree(tps_hkey);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct acpi_device_id topstar_device_ids[] =3D {
> > +	{ "TPSACPI01", 0 },
> > +	{ "", 0 },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, topstar_device_ids);
> > +
> > +static struct acpi_driver acpi_topstar_driver =3D {
> > +	.name =3D "Topstar laptop ACPI driver",
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
> > +	ret =3D acpi_bus_register_driver(&acpi_topstar_driver);
> > +	if (ret < 0)
> > +		return ret;
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
[]'s
Herton
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
