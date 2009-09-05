From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH] topstar_acpi: add new driver for hotkeys support on
	Topstar N01
Date: Sat, 5 Sep 2009 13:55:37 +0100
Message-ID: <9b2b86520909050555nf15a9f3if964caa5b86278ec@mail.gmail.com>
References: <200909050229.55665.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:49738 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbZIEMzm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Sep 2009 08:55:42 -0400
Received: by bwz19 with SMTP id 19so762951bwz.37
        for <linux-acpi@vger.kernel.org>; Sat, 05 Sep 2009 05:55:44 -0700 (PDT)
In-Reply-To: <200909050229.55665.herton@mandriva.com.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Cc: linux-acpi@vger.kernel.org

On 9/5/09, Herton Ronaldo Krzesinski <herton@mandriva.com.br> wrote:
> This adds Topstar Laptop Extras ACPI driver. It enables hotkeys
> functionality with Topstar N01 netbook. Besides hotkeys there are
> other functions exposed by its ACPI firmware, but for now only
> hotkeys reporting on Topstar N01 is supported. Topstar is a chinese
> manufacturer, its website can be currently reached at
> http://www.topstardigital.cn/
>
> Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> ---
>  drivers/platform/x86/Kconfig        |    8 +
>  drivers/platform/x86/Makefile       |    1 +
>  drivers/platform/x86/topstar_acpi.c |  301
> +++++++++++++++++++++++++++++++++++
>  3 files changed, 310 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/platform/x86/topstar_acpi.c
>
> I'm attaching here too the gzipped acpidump of Topstar N01, which I based to
> do
> the driver.
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 77c6097..3ba2caa 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -396,6 +396,14 @@ config ACPI_ASUS
>  	  NOTE: This driver is deprecated and will probably be removed soon,
>  	  use asus-laptop instead.
>
> +config ACPI_TOPSTAR
> +	tristate "Topstar Laptop Extras"
> +	depends on ACPI

Judging by other drivers it needs to depend on INPUT as well.

> +	---help---
> +	  This driver adds support for hotkeys found on topstar laptops.
> +
> +	  If you have a Topstar laptop, say Y or M here.
> +
>  config ACPI_TOSHIBA
>  	tristate "Toshiba Laptop Extras"
>  	depends on ACPI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 641b8bf..a32e8dd 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -19,4 +19,5 @@ obj-$(CONFIG_PANASONIC_LAPTOP)	+= panasonic-laptop.o
>  obj-$(CONFIG_INTEL_MENLOW)	+= intel_menlow.o
>  obj-$(CONFIG_ACPI_WMI)		+= wmi.o
>  obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
> +obj-$(CONFIG_ACPI_TOPSTAR)	+= topstar_acpi.o
>  obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
> diff --git a/drivers/platform/x86/topstar_acpi.c
> b/drivers/platform/x86/topstar_acpi.c
> new file mode 100644
> index 0000000..e852de2
> --- /dev/null
> +++ b/drivers/platform/x86/topstar_acpi.c
> @@ -0,0 +1,301 @@
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
> +#include <linux/mod_devicetable.h>

I think this should be linux/module.h.

> +#include <acpi/acpi_bus.h>
> +#include <acpi/acpi_drivers.h>

> +#include <acpi/actypes.h>
> +#include <acpi/acpixf.h>

Are you sure these two are needed?  No other platform driver uses them.

> +#include <linux/input.h>
> +
> +#define ACPI_TOPSTAR_HID "TPSACPI01"
> +#define ACPI_TOPSTAR_DEVICE_NAME "Topstar TPSACPI01"
> +#define ACPI_TOPSTAR_DRIVER_NAME "Topstar laptop ACPI driver"
> +#define ACPI_TOPSTAR_CLASS "topstar"
> +
> +#define TOPSTAR_ACPI_NAME "topstar_acpi"

> +#define TOPSTAR_ACPI_ERR KERN_ERR TOPSTAR_ACPI_NAME ": "
> +#define TOPSTAR_ACPI_INFO KERN_INFO TOPSTAR_ACPI_NAME ": "

I believe the modern way to do this is

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

and use pr_err() / pr_info().  See eeepc-laptop.c for an example.

> +
> +static const struct acpi_device_id topstar_device_ids[] = {
> +	{ ACPI_TOPSTAR_HID, 0 },
> +	{ "", 0 },
> +};
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

Hmm.  I heard some EeePCs also have a similar key, although the
current driver doesn't map it at all.  Perhaps it is time to add such
a keycode.

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
> +static void acpi_topstar_notify(acpi_handle handle, u32 event, void *data)
> +{
> +	struct tps_key_entry *key;
> +	static bool dup_evnt[2];
> +	bool *dup;
> +	struct topstar_hkey *hkey = data;
> +
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
> +	printk(TOPSTAR_ACPI_INFO "unknown event = 0x%02x\n", event);
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
> +		printk(TOPSTAR_ACPI_ERR "FNCX method not found\n");
> +		return -ENODEV;
> +	}
> +	fncx_params[0].integer.value = state ? 0x86 : 0x87;
> +	buf.length = sizeof(obj);
> +	buf.pointer = &obj;
> +	status = acpi_evaluate_object(handle, NULL, &fncx_arg_list, &buf);
> +	if (ACPI_FAILURE(status)) {
> +		printk(TOPSTAR_ACPI_ERR
> +		       "Unable to switch FNCX notifications\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int topstar_getkeycode(struct input_dev *dev, int scancode, int
> *keycode)
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
> +static int topstar_setkeycode(struct input_dev *dev, int scancode, int
> keycode)
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
> +		printk(TOPSTAR_ACPI_ERR "Unable to allocate input device\n");
> +		return -ENODEV;
> +	}
> +	hkey->inputdev->name = "Topstar Laptop extra buttons";
> +	hkey->inputdev->phys = "topstar/input0";
> +	hkey->inputdev->id.bustype = BUS_HOST;
> +	hkey->inputdev->getkeycode = topstar_getkeycode;
> +	hkey->inputdev->setkeycode = topstar_setkeycode;
>
> +	for (key = topstar_keymap; key->code; key++) {
> +		set_bit(EV_KEY, hkey->inputdev->evbit);
> +		set_bit(key->keycode, hkey->inputdev->keybit);
> +	}
> +	if (input_register_device(hkey->inputdev)) {
> +		printk(TOPSTAR_ACPI_ERR "Unable to register input device\n");
> +		input_free_device(hkey->inputdev);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int acpi_topstar_add(struct acpi_device *device)
> +{
> +	acpi_status status;
> +	struct topstar_hkey *tps_hkey;
> +
> +	if (!device)
> +		return -EINVAL;
> +
> +	tps_hkey = kzalloc(sizeof(struct topstar_hkey), GFP_KERNEL);
> +	if (!tps_hkey)
> +		return -ENOMEM;
> +
> +	sprintf(acpi_device_name(device), "%s", ACPI_TOPSTAR_DEVICE_NAME);
> +	sprintf(acpi_device_class(device), "%s", ACPI_TOPSTAR_CLASS);
> +
> +	if (acpi_topstar_fncx_switch(device, true))
> +		goto add_err;
> +
> +	device->driver_data = tps_hkey;
> +
> +	if (acpi_topstar_init_hkey(tps_hkey))
> +		goto add_err;
> +
> +	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
> +					     acpi_topstar_notify, tps_hkey);
> +	if (ACPI_FAILURE(status))
> +		goto add_err;

Can't you set .notify instead?

If you stick with this, you need to remember to unregister the input
device if we fail at this point.

> +	return 0;
> +
> +add_err:
> +	kfree(tps_hkey);
> +	device->driver_data = NULL;
> +	return -ENODEV;
> +}
> +
> +static int acpi_topstar_remove(struct acpi_device *device, int type)
> +{
> +	struct topstar_hkey *tps_hkey = acpi_driver_data(device);
> +
> +	if (!device || !tps_hkey)
> +		return -EINVAL;
> +
> +	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
> +				   acpi_topstar_notify);
> +
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
> +	},
> +};
> +
> +static int __init acpi_topstar_init(void)
> +{
> +	if (acpi_disabled)
> +		return -ENODEV;
> +
> +	if (acpi_bus_register_driver(&acpi_topstar_driver) < 0)
> +		return -ENODEV;

Please do

ret = acpi_bus_register_driver(&acpi_topstar_driver)
if (ret < 0)
    return ret;

ENODEV is kinda misleading here, it might have failed due to ENOMEM or
something.

Note that acpi_bus_register_driver() will succeed even if there are no
relevant devices.  If you want "modprobe topstar_acpi" to return
ENODEV on other hardware, you need to explicitly set a flag in
acpi_topstar_add() and test it after registering the driver.

> +
> +	printk(KERN_INFO "Topstar Laptop ACPI extras driver loaded\n");
> +
> +	return 0;
> +}
> +
> +static void __exit acpi_topstar_exit(void)
> +{
> +	acpi_bus_unregister_driver(&acpi_topstar_driver);
> +
> +	printk(KERN_INFO "Topstar Laptop ACPI extras driver unloaded\n");
> +}
> +
> +module_init(acpi_topstar_init);
> +module_exit(acpi_topstar_exit);
> +
> +MODULE_AUTHOR("Herton Ronaldo Krzesinski");
> +MODULE_DESCRIPTION("Topstar Laptop ACPI Extras driver");
> +MODULE_LICENSE("GPL");
> --
> 1.6.4.2
>
>
