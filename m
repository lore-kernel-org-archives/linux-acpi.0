From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add Panasonic Laptop ACPI extras driver
Date: Tue, 22 Jul 2008 15:03:25 -0400
Message-ID: <20080722144348.ZZRA012@mailhub.coreip.homeip.net>
References: <20080722005301.GF8744@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:54027 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbYGVTD3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jul 2008 15:03:29 -0400
Received: by py-out-1112.google.com with SMTP id p76so1462270pyb.10
        for <linux-acpi@vger.kernel.org>; Tue, 22 Jul 2008 12:03:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080722005301.GF8744@prithivi.gnumonks.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-acpi@vger.kernel.org

Hi Harald,

On Mon, Jul 21, 2008 at 08:53:01PM -0400, Harald Welte wrote:
> [PATCH] Add Panasonic Laptop ACPI extras driver
> 

Since I don't usually read ACPI list I did not have a chance to reply
earlier, could you please CC linux-input and/or myself when working
with drivers that implement input devices?

> +
> +#define KEYMAP_SIZE		11
> +static const int initial_keymap[KEYMAP_SIZE] = {
> +	/*  0 */ -1,

Normally KEY_RESERVED is used for invalid entries.

> +	/*  1 */ KEY_BRIGHTNESSDOWN,
> +	/*  2 */ KEY_BRIGHTNESSUP,
> +	/*  3 */ KEY_DISPLAYTOGGLE,
> +	/*  4 */ KEY_MUTE,
> +	/*  5 */ KEY_VOLUMEDOWN,
> +	/*  6 */ KEY_VOLUMEUP,
> +	/*  7 */ KEY_SLEEP,
> +	/*  8 */ KEY_PROG1, /* Change CPU boost */
> +	/*  9 */ KEY_BATTERY,
> +	/* 10 */ KEY_SUSPEND,
> +};
> +

> +
> +static int acpi_pcc_init_input(struct pcc_acpi *pcc)
> +{
> +	int rc;
> +
> +	ACPI_FUNCTION_TRACE("acpi_pcc_init_input");
> +
> +	pcc->input_dev = input_allocate_device();
> +	if (!pcc->input_dev) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> +				  "Couldn't allocate input device for hotkey"));
> +		return -ENOMEM;
> +	}
> +
> +	pcc->input_dev->evbit[0] = BIT(EV_KEY);
> +
> +	set_bit(KEY_BRIGHTNESSDOWN, pcc->input_dev->keybit);
> +	set_bit(KEY_BRIGHTNESSUP, pcc->input_dev->keybit);
> +	set_bit(KEY_MUTE, pcc->input_dev->keybit);
> +	set_bit(KEY_VOLUMEDOWN, pcc->input_dev->keybit);
> +	set_bit(KEY_VOLUMEUP, pcc->input_dev->keybit);
> +	set_bit(KEY_SLEEP, pcc->input_dev->keybit);
> +	set_bit(KEY_BATTERY, pcc->input_dev->keybit);
> +	set_bit(KEY_SUSPEND, pcc->input_dev->keybit);
> +	set_bit(KEY_DISPLAYTOGGLE, pcc->input_dev->keybit);
> +	set_bit(KEY_PROG1, pcc->input_dev->keybit);

I like doing:

	for (i = 0; i < sizeof(pcc->keymap); i++)
		__set_bit(pcc->keymap[i], input_dev->keybit);
	__clear_bit(KEY_RESERVED, input_dev->keybit);

after copying the keymap, as this helps maintaining the keymap in just
one place.

> +
> +	pcc->input_dev->name = ACPI_PCC_DRIVER_NAME;
> +	pcc->input_dev->phys = ACPI_PCC_INPUT_PHYS;
> +	pcc->input_dev->id.bustype = 0x1a; /* XXX FIXME: BUS_I8042? */

I think BUS_HOST is most appropriate here.

> +	pcc->input_dev->id.vendor = 0x0001;
> +	pcc->input_dev->id.product = 0x0001;
> +	pcc->input_dev->id.version = 0x0100;
> +	pcc->input_dev->getkeycode = pcc_getkeycode;
> +	pcc->input_dev->setkeycode = pcc_setkeycode;
> +
> +	/* load initial keymap */
> +	memcpy(pcc->keymap, initial_keymap, sizeof(pcc->keymap));
> +
> +	input_set_drvdata(pcc->input_dev, pcc);
> +
> +	rc = input_register_device(pcc->input_dev);
> +	if (rc < 0)
> +		input_free_device(pcc->input_dev);
> +
> +	return rc;
> +}

> +
> +static int acpi_pcc_hotkey_add(struct acpi_device *device)
> +{
> +	acpi_status status;
> +	struct pcc_acpi *pcc;
> +	int num_sifr, result;
> +
> +	ACPI_FUNCTION_TRACE("acpi_pcc_hotkey_add");
> +
> +	if (!device)
> +		return -EINVAL;
> +
> +	num_sifr = acpi_pcc_get_sqty(device);
> +
> +	if (num_sifr > 255) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "num_sifr too large"));
> +		return -ENODEV;
> +	}
> +
> +	pcc = kmalloc(sizeof(struct pcc_acpi), GFP_KERNEL);

kzalloc?

> +	if (!pcc) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> +				  "Couldn't allocate mem for pcc"));
> +		return -ENOMEM;
> +	}
> +	memset(pcc, 0, sizeof(struct pcc_acpi));
> +
> +	pcc->sinf = kmalloc(sizeof(u32) * (num_sifr + 1), GFP_KERNEL);

kcalloc?

> +	if (!pcc->sinf) {
> +		result = -ENOMEM;
> +		goto out_hotkey;
> +	}
> +
> +	pcc->device = device;
> +	pcc->handle = device->handle;
> +	pcc->num_sifr = num_sifr;
> +	acpi_driver_data(device) = pcc;
> +	strcpy(acpi_device_name(device), ACPI_PCC_DEVICE_NAME);
> +	strcpy(acpi_device_class(device), ACPI_PCC_CLASS);
> +
> +	result = acpi_pcc_init_input(pcc);
> +	if (result) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> +				  "Error installing keyinput handler\n"));
> +		goto out_sinf;
> +	}
> +
> +	/* initialize hotkey input device */
> +	status = acpi_install_notify_handler(pcc->handle, ACPI_DEVICE_NOTIFY,
> +					     acpi_pcc_hotkey_notify, pcc);
> +
> +	if (ACPI_FAILURE(status)) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> +				  "Error installing notify handler\n"));
> +		result = -ENODEV;
> +		goto out_input;
> +	}
> +
> +	/* initialize backlight */
> +	pcc->backlight = backlight_device_register("panasonic", NULL, pcc,
> +						   &pcc_backlight_ops);
> +	if (IS_ERR(pcc->backlight))
> +		goto out_notify;
> +
> +	if (!acpi_pcc_retrieve_biosdata(pcc, pcc->sinf)) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> +				 "Couldn't retrieve BIOS data\n"));
> +		goto out_backlight;
> +	}
> +
> +	/* read the initial brightness setting from the hardware */
> +	pcc->backlight->props.max_brightness =
> +					pcc->sinf[SINF_AC_MAX_BRIGHT];
> +	pcc->backlight->props.brightness = pcc->sinf[SINF_AC_CUR_BRIGHT];
> +
> +	/* read the initial sticky key mode from the hardware */
> +	pcc->sticky_mode = pcc->sinf[SINF_STICKY_KEY];
> +
> +	/* add sysfs attributes */
> +	result = sysfs_create_group(&device->dev.kobj, &pcc_attr_group);
> +	if (result)
> +		goto out_backlight;
> +
> +	return 0;
> +
> +out_backlight:
> +	backlight_device_unregister(pcc->backlight);
> +out_notify:
> +	acpi_remove_notify_handler(pcc->handle, ACPI_DEVICE_NOTIFY,
> +				   acpi_pcc_hotkey_notify);
> +out_input:
> +	input_unregister_device(pcc->input_dev);
> +	kfree(input_get_drvdata(pcc->input_dev));
> +	input_free_device(pcc->input_dev);

This will bomb. You are not allowed to call input_free_device after
input_unregister_device - input_dev is refcounted and will be freed
after the last reference is dropped. Plus acpi_pcc_init_input frees
input device itself if input_register_device_fails. Also drvdata of
input_dev is set to point to 'pcc' which is being freed again below.
So I think you just need to call input_unregister_device() here.

> +out_sinf:
> +	kfree(pcc->sinf);
> +out_hotkey:
> +	kfree(pcc);
> +
> +	return result;
> +}
> +
> +static int acpi_pcc_hotkey_remove(struct acpi_device *device, int type)
> +{
> +	struct pcc_acpi *pcc = acpi_driver_data(device);
> +
> +	ACPI_FUNCTION_TRACE("acpi_pcc_hotkey_remove");
> +
> +	if (!device || !pcc)
> +		return -EINVAL;
> +
> +	sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
> +
> +	backlight_device_unregister(pcc->backlight);
> +
> +	acpi_remove_notify_handler(pcc->handle, ACPI_DEVICE_NOTIFY,
> +				   acpi_pcc_hotkey_notify);
> +
> +	input_unregister_device(pcc->input_dev);
> +	kfree(input_get_drvdata(pcc->input_dev));
> +	input_free_device(pcc->input_dev);
> +

Same as above, simply input_unregister_device(pcc->input_dev); should
suffice.

> +	kfree(pcc->sinf);
> +	kfree(pcc);
> +
> +	return 0;
> +}

Thanks!

-- 
Dmitry
