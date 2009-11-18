From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [patch 04/12] cmpc_acpi: add support for Classmate PC ACPI
	devices
Date: Wed, 18 Nov 2009 09:07:22 +0000
Message-ID: <9b2b86520911180107r54fc14a2of2ccb19b25698523@mail.gmail.com>
References: <200911172227.nAHMRUgH023139@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:37324 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbZKRJHS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Nov 2009 04:07:18 -0500
Received: by fxm21 with SMTP id 21so908032fxm.21
        for <linux-acpi@vger.kernel.org>; Wed, 18 Nov 2009 01:07:23 -0800 (PST)
In-Reply-To: <200911172227.nAHMRUgH023139@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, cascardo@holoscopio.com

On 11/17/09, akpm@linux-foundation.org <akpm@linux-foundation.org> wrote:
> From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
>
> This add supports for devices like keyboard, backlight, tablet and
> accelerometer.
>
> This work is supported by International Syst S/A.
>
> [randy.dunlap@oracle.com: cmpc_acpi: depends on ACPI]
> [akpm@linux-foundation.org: readability tweaks]
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  MAINTAINERS                      |    6
>  drivers/platform/x86/Kconfig     |   12
>  drivers/platform/x86/Makefile    |    1
>  drivers/platform/x86/cmpc_acpi.c |  543 +++++++++++++++++++++++++++++
>  4 files changed, 562 insertions(+)
>
> diff -puN MAINTAINERS~cmpc_acpi-add-support-for-classmate-pc-acpi-devices
> MAINTAINERS
> --- a/MAINTAINERS~cmpc_acpi-add-support-for-classmate-pc-acpi-devices
> +++ a/MAINTAINERS
> @@ -1427,6 +1427,12 @@ L:	linux-scsi@vger.kernel.org
>  S:	Supported
>  F:	drivers/scsi/fnic/
>
> +CMPC ACPI DRIVER
> +M:	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> +M:	Daniel Oliveira Nascimento <don@syst.com.br>
> +S:	Supported
> +F:	drivers/platform/x86/cmpc_acpi.c
> +
>  CODA FILE SYSTEM
>  M:	Jan Harkes <jaharkes@cs.cmu.edu>
>  M:	coda@cs.cmu.edu
> diff -puN
> drivers/platform/x86/Kconfig~cmpc_acpi-add-support-for-classmate-pc-acpi-devices
> drivers/platform/x86/Kconfig
> ---
> a/drivers/platform/x86/Kconfig~cmpc_acpi-add-support-for-classmate-pc-acpi-devices
> +++ a/drivers/platform/x86/Kconfig
> @@ -435,4 +435,16 @@ config ACPI_TOSHIBA
>
>  	  If you have a legacy free Toshiba laptop (such as the Libretto L1
>  	  series), say Y.
> +
> +config ACPI_CMPC
> +	tristate "CMPC Laptop Extras"
> +	depends on X86 && ACPI
> +	select INPUT
> +	select BACKLIGHT_CLASS_DEVICE
> +	default n
> +	help
> +	  Support for Intel Classmate PC ACPI devices, including some
> +	  keys as input device, backlight device, tablet and accelerometer
> +	  devices.
> +
>  endif # X86_PLATFORM_DEVICES
> diff -puN
> drivers/platform/x86/Makefile~cmpc_acpi-add-support-for-classmate-pc-acpi-devices
> drivers/platform/x86/Makefile
> ---
> a/drivers/platform/x86/Makefile~cmpc_acpi-add-support-for-classmate-pc-acpi-devices
> +++ a/drivers/platform/x86/Makefile
> @@ -21,3 +21,4 @@ obj-$(CONFIG_ACPI_WMI)		+= wmi.o
>  obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
>  obj-$(CONFIG_TOPSTAR_LAPTOP)	+= topstar-laptop.o
>  obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
> +obj-$(CONFIG_ACPI_CMPC)		+= cmpc_acpi.o
> diff -puN /dev/null drivers/platform/x86/cmpc_acpi.c
> --- /dev/null
> +++ a/drivers/platform/x86/cmpc_acpi.c
> @@ -0,0 +1,543 @@
> +/*
> + *  Copyright (C) 2009  Thadeu Lima de Souza Cascardo
> <cascardo@holoscopio.com>
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
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/workqueue.h>
> +#include <acpi/acpi_drivers.h>
> +#include <linux/backlight.h>
> +#include <linux/input.h>
> +
> +MODULE_LICENSE("GPL");
> +
> +
> +/*
> + * Generic input device code.
> + */
> +
> +typedef void (*input_device_init)(struct input_dev *dev);
> +
> +static int cmpc_add_acpi_notify_device(struct acpi_device *acpi, char
> *name,
> +				       acpi_notify_handler handler,
> +				       input_device_init idev_init)
> +{
> +	struct input_dev *inputdev;
> +	acpi_status status;
> +	int error;
> +
> +	inputdev = input_allocate_device();
> +	if (!inputdev) {
> +		error = -ENOMEM;
> +		goto out;
> +	}
> +	inputdev->name = name;
> +	inputdev->dev.parent = &acpi->dev;
> +	idev_init(inputdev);
> +	error = input_register_device(inputdev);
> +	if (error)
> +		goto err_reg;
> +	dev_set_drvdata(&acpi->dev, inputdev);
> +	status = acpi_install_notify_handler(acpi->handle, ACPI_DEVICE_NOTIFY,
> +					     handler, inputdev);
> +	if (ACPI_FAILURE(status)) {
> +		error = -ENODEV;
> +		goto err_acpi;
> +	}
> +	return 0;
> +err_acpi:
> +	input_unregister_device(inputdev);
> +err_reg:
> +	input_free_device(inputdev);
> +out:
> +	return error;
> +}
> +
> +static int cmpc_remove_acpi_notify_device(struct acpi_device *acpi,
> +					  acpi_notify_handler handler)
> +{
> +	struct input_dev *inputdev;
> +	acpi_status status;
> +
> +	status = acpi_remove_notify_handler(acpi->handle, ACPI_DEVICE_NOTIFY,
> +					    handler);
> +	inputdev = dev_get_drvdata(&acpi->dev);
> +	input_unregister_device(inputdev);
> +	input_free_device(inputdev);
> +	return 0;
> +}

This version still needs some fixes.  For example, input_free_device()
should not be called after input_unregister_device().

The other main problem was that the state of the "tablet mode" switch
is not set on initialisation (and the same for resume from suspend).

At the very least, I don't think this version should be merged without
putting it under CONFIG_EXPERIMENTAL.  For more details and less
serious nits see
<http://thread.gmane.org/gmane.linux.acpi.devel/42017/focus=42025>.

Thanks
Alan
