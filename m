From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v4] topstar-laptop: add new driver for hotkeys support on Topstar N01
Date: Thu, 10 Sep 2009 17:02:53 -0600
Message-ID: <200909101702.54249.bjorn.helgaas@hp.com>
References: <200909092102.22152.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:22813 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbZIJXCx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Sep 2009 19:02:53 -0400
In-Reply-To: <200909092102.22152.herton@mandriva.com.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Alan Jenkins <sourcejedi.lkml@googlemail.com>, Corentin Chary <corentin.chary@gmail.com>

On Wednesday 09 September 2009 06:02:22 pm Herton Ronaldo Krzesinski wrote:
> This adds Topstar Laptop Extras ACPI driver. It enables hotkeys
> functionality with Topstar N01 netbook. Besides hotkeys there are
> other functions exposed by its ACPI firmware, but for now only
> hotkeys reporting on Topstar N01 is supported. Topstar is a chinese
> manufacturer, its website can be currently reached at
> http://www.topstardigital.cn/
> 
> Reviewed-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> ---
>  MAINTAINERS                           |    5 +
>  drivers/platform/x86/Kconfig          |    9 +
>  drivers/platform/x86/Makefile         |    1 +
>  drivers/platform/x86/topstar-laptop.c |  299 +++++++++++++++++++++++++++++++++
>  4 files changed, 314 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/platform/x86/topstar-laptop.c
> 
> v3 addresses last comments on the patch previously posted and adds missing
> MODULE_DEVICE_TABLE entry
> v4 adds myself to MAINTAINERS
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8dca9d8..d75a7a7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4968,6 +4968,11 @@ T:	quilt http://svn.sourceforge.jp/svnroot/tomoyo/trunk/2.2.x/tomoyo-lsm/patches
>  S:	Maintained
>  F:	security/tomoyo/
>  
> +TOPSTAR LAPTOP EXTRAS DRIVER
> +M:	Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> +S:	Maintained
> +F:	drivers/platform/x86/topstar-laptop.c
> +
>  TOSHIBA ACPI EXTRAS DRIVER
>  S:	Orphan
>  F:	drivers/platform/x86/toshiba_acpi.c
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 77c6097..4831562 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -396,6 +396,15 @@ config ACPI_ASUS
>  	  NOTE: This driver is deprecated and will probably be removed soon,
>  	  use asus-laptop instead.
>  
> +config TOPSTAR_LAPTOP
> +	tristate "Topstar Laptop Extras"
> +	depends on ACPI
> +	depends on INPUT
> +	---help---
> +	  This driver adds support for hotkeys found on Topstar laptops.
> +
> +	  If you have a Topstar laptop, say Y or M here.
> +
>  config ACPI_TOSHIBA
>  	tristate "Toshiba Laptop Extras"
>  	depends on ACPI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 641b8bf..d1c1621 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -19,4 +19,5 @@ obj-$(CONFIG_PANASONIC_LAPTOP)	+= panasonic-laptop.o
>  obj-$(CONFIG_INTEL_MENLOW)	+= intel_menlow.o
>  obj-$(CONFIG_ACPI_WMI)		+= wmi.o
>  obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
> +obj-$(CONFIG_TOPSTAR_LAPTOP)	+= topstar-laptop.o
>  obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
> diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
> new file mode 100644
> index 0000000..795d788
> --- /dev/null
> +++ b/drivers/platform/x86/topstar-laptop.c
> @@ -0,0 +1,299 @@
> +/*
> + * ACPI driver for Topstar notebooks (hotkeys support only)
> + *
> + * Copyright (c) 2009 Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> + *
> + * Implementation inspired by existing x86 platform drivers, in special
> + * asus/eepc/fujitsu-laptop, thanks to their authors
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/acpi.h>
> +#include <linux/input.h>
> +
> +#define ACPI_TOPSTAR_HID "TPSACPI01"
> +#define ACPI_TOPSTAR_DEVICE_NAME "Topstar TPSACPI01"
> +#define ACPI_TOPSTAR_DRIVER_NAME "Topstar laptop ACPI driver"
> +#define ACPI_TOPSTAR_CLASS "topstar"
> +
> +static const struct acpi_device_id topstar_device_ids[] = {
> +	{ ACPI_TOPSTAR_HID, 0 },
> +	{ "", 0 },
> +};
> +MODULE_DEVICE_TABLE(acpi, topstar_device_ids);

Some of these #defines are only used once, and I don't think it adds
anything to wrap the constant with a name.  Personally, I think it
makes more sense to put the device_id table next to the acpi_driver
struct that references it.

> +
> +struct topstar_hkey {
> +	struct input_dev *inputdev;
> +};
> +
> +struct tps_key_entry {
> +	u8 code;
> +	u16 keycode;
> +};
> +
> +static struct tps_key_entry topstar_keymap[] = {
> +	{ 0x80, KEY_BRIGHTNESSUP },
> +	{ 0x81, KEY_BRIGHTNESSDOWN },
> +	{ 0x83, KEY_VOLUMEUP },
> +	{ 0x84, KEY_VOLUMEDOWN },
> +	{ 0x85, KEY_MUTE },
> +	{ 0x86, KEY_SWITCHVIDEOMODE },
> +	{ 0x87, KEY_F13 }, /* touchpad enable/disable key */
> +	{ 0x88, KEY_WLAN },
> +	{ 0x8a, KEY_WWW },
> +	{ 0x8b, KEY_MAIL },
> +	{ 0x8c, KEY_MEDIA },
> +	{ 0x96, KEY_F14 }, /* G key? */
> +	{ }
> +};
> +
> +static struct tps_key_entry *tps_get_key_by_scancode(int code)
> +{
> +	struct tps_key_entry *key;
> +
> +	for (key = topstar_keymap; key->code; key++)
> +		if (code == key->code)
> +			return key;
> +
> +	return NULL;
> +}
> +
> +static struct tps_key_entry *tps_get_key_by_keycode(int code)
> +{
> +	struct tps_key_entry *key;
> +
> +	for (key = topstar_keymap; key->code; key++)
> +		if (code == key->keycode)
> +			return key;
> +
> +	return NULL;
> +}
> +
> +static void acpi_topstar_notify(struct acpi_device *device, u32 event)
> +{
> +	struct tps_key_entry *key;
> +	static bool dup_evnt[2];
> +	bool *dup;
> +	struct topstar_hkey *hkey = device->driver_data;

I don't know whether acpi_driver_data() really adds any value,
but you do use it in acpi_topstar_remove(), so it'd be good to
at least use it consistently.

> +	/* 0x83 and 0x84 key events comes duplicated... */
> +	if (event == 0x83 || event == 0x84) {
> +		dup = &dup_evnt[event - 0x83];
> +		if (*dup) {
> +			*dup = false;
> +			return;
> +		}
> +		*dup = true;
> +	}
> +
> +	/*
> +	 * 'G key' generate two event codes, convert to only
> +	 * one event/key code for now (3G switch?)
> +	 */
> +	if (event == 0x97)
> +		event = 0x96;
> +
> +	key = tps_get_key_by_scancode(event);
> +	if (key) {
> +		input_report_key(hkey->inputdev, key->keycode, 1);
> +		input_sync(hkey->inputdev);
> +		input_report_key(hkey->inputdev, key->keycode, 0);
> +		input_sync(hkey->inputdev);
> +		return;
> +	}
> +
> +	/* Known non hotkey events don't handled or that we don't care yet */
> +	if (event == 0x8e || event == 0x8f || event == 0x90)
> +		return;
> +
> +	pr_info("unknown event = 0x%02x\n", event);
> +}
> +
> +static int acpi_topstar_fncx_switch(struct acpi_device *device, bool state)
> +{
> +	acpi_status status;
> +	acpi_handle handle = NULL;
> +	union acpi_object fncx_params[1] = {
> +		{ .type = ACPI_TYPE_INTEGER }
> +	};
> +	struct acpi_object_list fncx_arg_list = { 1, &fncx_params[0] };
> +	struct acpi_buffer buf;
> +	union acpi_object obj;
> +
> +	status = acpi_get_handle(device->handle, "FNCX", &handle);
> +	if (ACPI_FAILURE(status)) {
> +		pr_err("FNCX method not found\n");
> +		return -ENODEV;
> +	}

There's no need to check whether FNCX exists before trying to
evaluate it (unless you really want the different error message
for some reason).

> +	fncx_params[0].integer.value = state ? 0x86 : 0x87;
> +	buf.length = sizeof(obj);
> +	buf.pointer = &obj;
> +	status = acpi_evaluate_object(handle, NULL, &fncx_arg_list, &buf);
> +	if (ACPI_FAILURE(status)) {
> +		pr_err("Unable to switch FNCX notifications\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int topstar_getkeycode(struct input_dev *dev, int scancode, int *keycode)
> +{
> +	struct tps_key_entry *key = tps_get_key_by_scancode(scancode);
> +
> +	if (key) {
> +		*keycode = key->keycode;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int topstar_setkeycode(struct input_dev *dev, int scancode, int keycode)
> +{
> +	struct tps_key_entry *key;
> +	int old_keycode;
> +
> +	if (keycode < 0 || keycode > KEY_MAX)
> +		return -EINVAL;
> +
> +	key = tps_get_key_by_scancode(scancode);
> +	if (key) {
> +		old_keycode = key->keycode;
> +		key->keycode = keycode;
> +		set_bit(keycode, dev->keybit);
> +		if (!tps_get_key_by_keycode(old_keycode))
> +			clear_bit(old_keycode, dev->keybit);
> +		return 0;
> +	}

Nit (even more than the rest :-)): you could use:

	if (!key)
		return -EINVAL;

	... normal case code ...
	return 0;

> +
> +	return -EINVAL;
> +}
> +
> +static int acpi_topstar_init_hkey(struct topstar_hkey *hkey)
> +{
> +	struct tps_key_entry *key;
> +
> +	hkey->inputdev = input_allocate_device();
> +	if (!hkey->inputdev) {
> +		pr_err("Unable to allocate input device\n");
> +		return -ENODEV;
> +	}
> +	hkey->inputdev->name = "Topstar Laptop extra buttons";
> +	hkey->inputdev->phys = "topstar/input0";
> +	hkey->inputdev->id.bustype = BUS_HOST;
> +	hkey->inputdev->getkeycode = topstar_getkeycode;
> +	hkey->inputdev->setkeycode = topstar_setkeycode;
> +	for (key = topstar_keymap; key->code; key++) {
> +		set_bit(EV_KEY, hkey->inputdev->evbit);
> +		set_bit(key->keycode, hkey->inputdev->keybit);
> +	}
> +	if (input_register_device(hkey->inputdev)) {
> +		pr_err("Unable to register input device\n");
> +		input_free_device(hkey->inputdev);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool found_tps_dev;
> +
> +static int acpi_topstar_add(struct acpi_device *device)
> +{
> +	struct topstar_hkey *tps_hkey;
> +
> +	if (!device)
> +		return -EINVAL;

Unnecessary NULL check.

> +	tps_hkey = kzalloc(sizeof(struct topstar_hkey), GFP_KERNEL);
> +	if (!tps_hkey)
> +		return -ENOMEM;
> +
> +	sprintf(acpi_device_name(device), "%s", ACPI_TOPSTAR_DEVICE_NAME);
> +	sprintf(acpi_device_class(device), "%s", ACPI_TOPSTAR_CLASS);

Hmm, too bad we can't avoid overflowing the fixed-size buffers you're
filling here (not your problem -- every other user also has the same
problem).  Most other users use strcpy() rather than sprintf(), though,
and that'd be slightly simpler here as well.

> +	if (acpi_topstar_fncx_switch(device, true))
> +		goto add_err;
> +
> +	device->driver_data = tps_hkey;
> +
> +	if (acpi_topstar_init_hkey(tps_hkey))
> +		goto add_err;
> +
> +	found_tps_dev = true;
> +	return 0;
> +
> +add_err:
> +	kfree(tps_hkey);
> +	device->driver_data = NULL;

Not necessary to clear this out, especially since you could move
the assignment down after you know you're going to return success.

> +	return -ENODEV;
> +}
> +
> +static int acpi_topstar_remove(struct acpi_device *device, int type)
> +{
> +	struct topstar_hkey *tps_hkey = acpi_driver_data(device);
> +
> +	if (!device || !tps_hkey)
> +		return -EINVAL;

Unnecessary NULL checks.

> +	acpi_topstar_fncx_switch(device, false);
> +
> +	input_unregister_device(tps_hkey->inputdev);
> +	kfree(tps_hkey);
> +	device->driver_data = NULL;
> +
> +	return 0;
> +}
> +
> +static struct acpi_driver acpi_topstar_driver = {
> +	.name = ACPI_TOPSTAR_DRIVER_NAME,
> +	.class = ACPI_TOPSTAR_CLASS,
> +	.ids = topstar_device_ids,
> +	.ops = {
> +		.add = acpi_topstar_add,
> +		.remove = acpi_topstar_remove,
> +		.notify = acpi_topstar_notify,
> +	},
> +};
> +
> +static int __init topstar_laptop_init(void)
> +{
> +	int ret;
> +
> +	if (acpi_disabled)
> +		return -ENODEV;

We shouldn't need this check.  acpi_bus_register_driver() fails if
acpi_disabled.

> +	ret = acpi_bus_register_driver(&acpi_topstar_driver);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!found_tps_dev) {

Why do we need this check to see if we found a device?  This box
nicely supplies a device with a _HID, so we should get a udev
event requesting a driver for TPSACPI01, and that is what should
cause this driver to be loaded.

> +		acpi_bus_unregister_driver(&acpi_topstar_driver);
> +		return -ENODEV;
> +	}
> +
> +	printk(KERN_INFO "Topstar Laptop ACPI extras driver loaded\n");
> +
> +	return 0;
> +}
> +
> +static void __exit topstar_laptop_exit(void)
> +{
> +	acpi_bus_unregister_driver(&acpi_topstar_driver);
> +}
> +
> +module_init(topstar_laptop_init);
> +module_exit(topstar_laptop_exit);
> +
> +MODULE_AUTHOR("Herton Ronaldo Krzesinski");
> +MODULE_DESCRIPTION("Topstar Laptop ACPI Extras driver");
> +MODULE_LICENSE("GPL");


