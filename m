From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH] dell-wireless: new driver for dell wireless button for
 Windows 8
Date: Mon, 10 Nov 2014 22:12:42 -0800
Message-ID: <20141111061242.GD56947@vmdeb7>
References: <1415685685-16953-1-git-send-email-alex.hung@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37795 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaKKGMr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2014 01:12:47 -0500
Content-Disposition: inline
In-Reply-To: <1415685685-16953-1-git-send-email-alex.hung@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Rafael Wysocki <rjw@rjwysocki.net>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>
Cc: platform-driver-x86@vger.kernel.org

On Tue, Nov 11, 2014 at 02:01:25PM +0800, Alex Hung wrote:

Please provide a proper git commit message.

Which devices present this button. There appears to be a button and a slider
version? Is it necessary to add completely new driver for this one button in
addition to the other dell-* drivers already here.

Matthew?

As this is ACPI enumerated, does it belong in drivers/platform and not in
drivers/acpi?

Rafael?

Thanks,

Darren

> Signed-off-by: Alex Hung <alex.hung@canonical.com>
> ---
>  drivers/platform/x86/Kconfig         |   12 +++
>  drivers/platform/x86/Makefile        |    1 +
>  drivers/platform/x86/dell-wireless.c |  159 ++++++++++++++++++++++++++++++++++
>  3 files changed, 172 insertions(+)
>  create mode 100644 drivers/platform/x86/dell-wireless.c
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 172f26c..919df0b 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -228,6 +228,18 @@ config HP_WIRELESS
>  	 To compile this driver as a module, choose M here: the module will
>  	 be called hp-wireless.
>  
> +config DELL_WIRELESS
> +	tristate "DELL wireless button"

> +	depends on ACPI
> +	depends on INPUT
> +	help
> +	 This driver provides supports for new DELL wireless button for Windows
> +         8. On such systems the driver should load automatically (via ACPI
> +         alias).
> +
> +	 To compile this driver as a module, choose M here: the module will
> +	 be called dell-wireless.
> +
>  config HP_WMI
>  	tristate "HP WMI extras"
>  	depends on ACPI_WMI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index c4ca428..09b382b 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_DELL_LAPTOP)	+= dell-laptop.o
>  obj-$(CONFIG_DELL_WMI)		+= dell-wmi.o
>  obj-$(CONFIG_DELL_WMI_AIO)	+= dell-wmi-aio.o
>  obj-$(CONFIG_DELL_SMO8800)	+= dell-smo8800.o
> +obj-$(CONFIG_DELL_WIRELESS)	+= dell-wireless.o
>  obj-$(CONFIG_ACER_WMI)		+= acer-wmi.o
>  obj-$(CONFIG_ACERHDF)		+= acerhdf.o
>  obj-$(CONFIG_HP_ACCEL)		+= hp_accel.o
> diff --git a/drivers/platform/x86/dell-wireless.c b/drivers/platform/x86/dell-wireless.c
> new file mode 100644
> index 0000000..c1545fb
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wireless.c
> @@ -0,0 +1,159 @@
> +/*
> + *  dell-wireless button for Windows 8
> + *
> + *  Copyright (C) 2014 Alex Hung
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/platform_device.h>
> +#include <linux/acpi.h>
> +#include <acpi/acpi_bus.h>
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Alex Hung");
> +MODULE_ALIAS("acpi*:DELLABCE:*");
> +
> +#define DELL_TOGGLE_SWITCH	0
> +#define DELL_SLIDER_SWITCH	1
> +
> +static int switch_type;
> +
> +static struct input_dev *dellwl_input_dev;
> +
> +static const struct acpi_device_id dellwl_ids[] = {
> +	{"DELLABCE", 0},
> +	{"", 0},
> +};
> +
> +static int dell_wireless_input_setup(void)
> +{
> +	int err;
> +
> +	dellwl_input_dev = input_allocate_device();
> +	if (!dellwl_input_dev)
> +		return -ENOMEM;
> +
> +	dellwl_input_dev->name = "DELL Wireless hotkeys";
> +	dellwl_input_dev->phys = "dellabce/input0";
> +	dellwl_input_dev->id.bustype = BUS_HOST;
> +	dellwl_input_dev->evbit[0] = BIT(EV_KEY);
> +	set_bit(KEY_RFKILL, dellwl_input_dev->keybit);
> +
> +	err = input_register_device(dellwl_input_dev);
> +	if (err)
> +		goto err_free_dev;
> +
> +	return 0;
> +
> +err_free_dev:
> +	input_free_device(dellwl_input_dev);
> +	return err;
> +}
> +
> +static void dell_wireless_input_destroy(void)
> +{
> +	input_unregister_device(dellwl_input_dev);
> +}
> +
> +static void dellwl_notify(struct acpi_device *acpi_dev, u32 event)
> +{
> +	if (event != 0x80) {
> +		pr_info("Received unknown event (0x%x)\n", event);
> +		return;
> +	}
> +
> +	if (switch_type != DELL_TOGGLE_SWITCH)
> +		return;
> +
> +	input_report_key(dellwl_input_dev, KEY_RFKILL, 1);
> +	input_sync(dellwl_input_dev);
> +	input_report_key(dellwl_input_dev, KEY_RFKILL, 0);
> +	input_sync(dellwl_input_dev);
> +}
> +
> +static int dellwl_add(struct acpi_device *device)
> +{
> +	acpi_status status;
> +	unsigned long long output;
> +	int err = 0;
> +
> +	status = acpi_evaluate_integer(device->handle, "CRBT", NULL, &output);
> +	if (!ACPI_SUCCESS(status))
> +		return -EINVAL;
> +
> +	switch (output) {
> +	case 0:
> +	case 1:
> +		switch_type = DELL_TOGGLE_SWITCH;
> +		err = dell_wireless_input_setup();
> +		break;
> +	case 2:
> +	case 3:
> +		/* hard block is handled by module drivers */
> +		switch_type = DELL_SLIDER_SWITCH;
> +		break;
> +	default:
> +		err = -EINVAL;
> +	}
> +
> +	return err;
> +}
> +
> +static int dellwl_remove(struct acpi_device *device)
> +{
> +	if (switch_type == DELL_TOGGLE_SWITCH)
> +		dell_wireless_input_destroy();
> +
> +	return 0;
> +}
> +
> +static struct acpi_driver dellwl_driver = {
> +	.name	= "dell-wireless",
> +	.owner	= THIS_MODULE,
> +	.ids	= dellwl_ids,
> +	.ops	= {
> +		.add	= dellwl_add,
> +		.remove	= dellwl_remove,
> +		.notify	= dellwl_notify,
> +	},
> +};
> +
> +static int __init dellwl_init(void)
> +{
> +	int err;
> +
> +	pr_info("Initializing DELLABCE module\n");
> +	err = acpi_bus_register_driver(&dellwl_driver);
> +	if (err) {
> +		pr_err("Unable to register DELL wireless control driver.\n");
> +		goto error_acpi_register;
> +	}
> +
> +	return 0;
> +
> +error_acpi_register:
> +	return err;
> +}
> +
> +static void __exit dellwl_exit(void)
> +{
> +	pr_info("Exiting DELLABCE module\n");
> +	acpi_bus_unregister_driver(&dellwl_driver);
> +}
> +
> +module_init(dellwl_init);
> +module_exit(dellwl_exit);
> -- 
> 1.7.9.5
> 
> 

-- 
Darren Hart
Intel Open Source Technology Center
