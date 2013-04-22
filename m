From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH] ACPI: add a dummy ACPI RTC driver to handle BIOS AML's
  accesses  to registers delcared in CMOS OperationRegion v2.
Date: Mon, 22 Apr 2013 17:28:19 +0800
Message-ID: <517502B3.2040405@canonical.com>
References: <1359338202-4942-1-git-send-email-alex.hung@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:39741 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909Ab3DVJ2a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Apr 2013 05:28:30 -0400
In-Reply-To: <1359338202-4942-1-git-send-email-alex.hung@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>, lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, robert.moore@intel.com, lv.zheng@intel.com

Hi,

I haven't seen any feedback for this patch, and it has not been in 
3.9-rc8 yet so I assumed this patch is not accepted.

I spent some time to implement the space handler in 
acpi_rtc_space_handler, which I will re-submit shortly. It should be a 
better solution than just skipping the CMOS accesses.

Cheers,
Alex Hung

On 01/28/2013 09:56 AM, Alex Hung wrote:
> This is to fix acpica returns an error and terminate when BIOS ASL
> tries to access ACPI's RTC CMOS registers as the below example:
>
> Device (RTC)
> {
> 	Name (_HID, EisaId ("PNP0B00"))
> 	...
> 	OperationRegion (CMS0, SystemCMOS, Zero, 0x40)
> 	Field (CMS0, ByteAcc, NoLock, Preserve)
> 	{
> 		RTSE,   8,
> 			Offset (0x02),
> 		RTMN,   8,
> 			Offset (0x04),
> 		RTHR,   8,
> 			Offset (0x06),
> 		RTDY,   8,
> 		RTDE,   8
> 	}
> }
>
> Method (_Q33, 0, NotSerialized)
> {
> 	Store (^^RTC.RTMN, Local0)
> 	FromBCD (Local0, Local0)
> 	Store (^^RTC.RTHR, Local1)
> 	FromBCD (Local1, Local1)
> 	Store (^^RTC.RTDY, Local2)
> 	Store (^^RTC.RTSE, Local3)
> 	...
> }
>
> Signed-off-by: Alex Hung <alex.hung@canonical.com>
> ---
>   drivers/acpi/Kconfig    |    9 +++
>   drivers/acpi/Makefile   |    1 +
>   drivers/acpi/acpi_rtc.c |  149 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 159 insertions(+)
>   create mode 100644 drivers/acpi/acpi_rtc.c
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 38c5078..fb90397 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -181,6 +181,15 @@ config ACPI_DOCK
>   	  This driver supports ACPI-controlled docking stations and removable
>   	  drive bays such as the IBM Ultrabay and the Dell Module Bay.
>
> +config ACPI_RTC
> +	tristate "RTC"
> +	default m
> +	help
> +	  This driver supports an ACPI RTC device. It enables BIOS to read and
> +	  to write ACPI RTC registers declared in an OperationRegion with
> +	  RegionSpace as SYSTEMCMOS. This is required if BIOS needs to access
> +	  RTC registers during run-time such as a number of HP laptops.
> +
>   config ACPI_I2C
>   	def_tristate I2C
>   	depends on I2C
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 2a4502b..383c62b 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -71,6 +71,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
>   obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
>   obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>   obj-$(CONFIG_ACPI_I2C)		+= acpi_i2c.o
> +obj-$(CONFIG_ACPI_RTC)          += acpi_rtc.o
>
>   # processor has its own "processor." module_param namespace
>   processor-y			:= processor_driver.o processor_throttling.o
> diff --git a/drivers/acpi/acpi_rtc.c b/drivers/acpi/acpi_rtc.c
> new file mode 100644
> index 0000000..8d6b76b
> --- /dev/null
> +++ b/drivers/acpi/acpi_rtc.c
> @@ -0,0 +1,149 @@
> +/*
> + *  acpi_rtc - ACPI RTC Driver
> + *
> + *  Copyright (C) 2013 Alex Hung <alex.hung@canonical.com>
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or (at
> + *  your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/acpi.h>
> +
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("acpi*:PNP0B00:*");
> +MODULE_ALIAS("acpi*:PNP0B01:*");
> +MODULE_ALIAS("acpi*:PNP0B02:*");
> +
> +static const struct acpi_device_id rtc_device_ids[] = {
> +	{"PNP0B00", 0},
> +	{"PNP0B01", 0},
> +	{"PNP0B02", 0},
> +	{"", 0},
> +};
> +
> +static acpi_status acpi_acpi_handle_locate_callback(acpi_handle handle,
> +			u32 level, void *context, void **return_value)
> +{
> +	struct acpi_device *dev = context;
> +
> +	dev->handle = handle;
> +	*(acpi_handle *)return_value = handle;
> +
> +	return AE_CTRL_TERMINATE;
> +}
> +
> +static acpi_status
> +acpi_rtc_space_handler(u32 function, acpi_physical_address address,
> +		      u32 bits, u64 *value64,
> +		      void *handler_context, void *region_context)
> +{
> +	pr_warn("Accessing CMOS offset 0x%02llx is skipped.\n", address);
> +
> +	return AE_OK;
> +}
> +
> +static int rtc_install_handlers(struct acpi_device *rtc_dev)
> +{
> +	acpi_status status;
> +	status = acpi_install_address_space_handler(rtc_dev->handle,
> +						    ACPI_ADR_SPACE_CMOS,
> +						    &acpi_rtc_space_handler,
> +						    NULL, rtc_dev);
> +	if (ACPI_FAILURE(status)) {
> +		pr_info("Fail to install ACPI RTC handler\n");
> +		return AE_ERROR;
> +	}
> +
> +	return 0;
> +}
> +
> +static int acpi_rtc_add(struct acpi_device *device)
> +{
> +	int ret;
> +	int i;
> +	acpi_status status;
> +	acpi_handle rtc_dev = NULL;
> +
> +	for (i = 0; i < sizeof(rtc_device_ids) /
> +			sizeof(struct acpi_device_id) - 1; i++) {
> +		status = acpi_get_devices(rtc_device_ids[i].id,
> +				  acpi_acpi_handle_locate_callback,
> +				  &rtc_dev, &rtc_dev);
> +		if (ACPI_SUCCESS(status) && rtc_dev)
> +				break;
> +	}
> +
> +	if (!ACPI_SUCCESS(status) || !rtc_dev)
> +		return AE_NOT_FOUND;
> +
> +	ret = rtc_install_handlers((struct acpi_device *) &rtc_dev);
> +
> +	return ret;
> +}
> +
> +static int acpi_rtc_remove(struct acpi_device *device, int type)
> +{
> +	acpi_status status;
> +	status = acpi_remove_address_space_handler(device->handle,
> +						   ACPI_ADR_SPACE_CMOS,
> +						   &acpi_rtc_space_handler);
> +	if (!ACPI_SUCCESS(status))
> +		return AE_ERROR;
> +
> +	return AE_OK;
> +}
> +
> +static struct acpi_driver acpi_rtc_driver = {
> +	.name = "rtc",
> +	.class = "ACPI_RTC_CLASS",
> +	.ids = rtc_device_ids,
> +	.ops = {
> +		.add = acpi_rtc_add,
> +		.remove = acpi_rtc_remove,
> +		},
> +};
> +
> +static int __init rtc_init(void)
> +{
> +	int err;
> +
> +	pr_info("Initializing ACPI RTC module\n");
> +	err = acpi_bus_register_driver(&acpi_rtc_driver);
> +	if (err) {
> +		pr_err("Unable to register acpi driver.\n");
> +		goto error_acpi_register;
> +	}
> +
> +	return 0;
> +
> +error_acpi_register:
> +
> +	return err;
> +}
> +
> +static void __exit rtc_exit(void)
> +{
> +	pr_info("Exiting ACPI RTC module\n");
> +	acpi_bus_unregister_driver(&acpi_rtc_driver);
> +}
> +
> +module_init(rtc_init);
> +module_exit(rtc_exit);
>

