From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2 1/2] ACPI: Add CMOS RTC Operation Region handler support
Date: Wed, 12 Jun 2013 00:28:55 +0200
Message-ID: <3857719.P57XvbL8ou@vostro.rjw.lan>
References: <1370399271-6340-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1370399271-6340-1-git-send-email-tianyu.lan@intel.com>
Sender: stable-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, "3.9+" <stable@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, June 05, 2013 10:27:50 AM Lan Tianyu wrote:
> On HP Folio 13-2000, the BIOS defines a CMOS RTC Operation Region and
> the EC's _REG methord accesses that region.  Thus an appropriate
> address space handler must be registered for that region before the
> EC driver is loaded.
> 
> Introduce a mechanism for adding CMOS RTC address space handlers.
> Register an ACPI scan handler for CMOS RTC devices such that, when
> a device of that kind is detected during an ACPI namespace scan, a
> common CMOS RTC operation region address space handler will be
> installed for it.
> 
> [rjw: Changelog]
> References: https://bugzilla.kernel.org/show_bug.cgi?id=54621
> Reported-and-tested-by: Stefan Nagy <public@stefan-nagy.at>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> Cc: 3.9+ <stable@vger.kernel.org>

Both patches queued up for 3.11.

Thanks,
Rafael


> ---
> Change since v1:
> 	Make CMOS RTC operation region handler X86 specific and remove
> little endian conversion.
> 
>  drivers/acpi/Makefile        |    1 +
>  drivers/acpi/acpi_cmos_rtc.c |   92 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/internal.h      |    7 ++++
>  drivers/acpi/scan.c          |    1 +
>  4 files changed, 101 insertions(+)
>  create mode 100644 drivers/acpi/acpi_cmos_rtc.c
> 
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index d07771b..81dbeb8 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -44,6 +44,7 @@ acpi-y				+= acpi_platform.o
>  acpi-y				+= power.o
>  acpi-y				+= event.o
>  acpi-y				+= sysfs.o
> +acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
>  acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
>  acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
>  acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
> diff --git a/drivers/acpi/acpi_cmos_rtc.c b/drivers/acpi/acpi_cmos_rtc.c
> new file mode 100644
> index 0000000..84190ed
> --- /dev/null
> +++ b/drivers/acpi/acpi_cmos_rtc.c
> @@ -0,0 +1,92 @@
> +/*
> + * ACPI support for CMOS RTC Address Space access
> + *
> + * Copyright (C) 2013, Intel Corporation
> + * Authors: Lan Tianyu <tianyu.lan@intel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <asm-generic/rtc.h>
> +
> +#include "internal.h"
> +
> +#define PREFIX "ACPI: "
> +
> +ACPI_MODULE_NAME("cmos rtc");
> +
> +static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
> +	{ "PNP0B00" },
> +	{ "PNP0B01" },
> +	{ "PNP0B02" },
> +	{}
> +};
> +
> +static acpi_status
> +acpi_cmos_rtc_space_handler(u32 function, acpi_physical_address address,
> +		      u32 bits, u64 *value64,
> +		      void *handler_context, void *region_context)
> +{
> +	int i;
> +	u8 *value = (u8 *)&value64;
> +
> +	if (address > 0xff || !value64)
> +		return AE_BAD_PARAMETER;
> +
> +	if (function != ACPI_WRITE && function != ACPI_READ)
> +		return AE_BAD_PARAMETER;
> +
> +	spin_lock_irq(&rtc_lock);
> +
> +	for (i = 0; i < DIV_ROUND_UP(bits, 8); ++i, ++address, ++value)
> +		if (function == ACPI_READ)
> +			*value = CMOS_READ(address);
> +		else
> +			CMOS_WRITE(*value, address);
> +
> +	spin_unlock_irq(&rtc_lock);
> +
> +	return AE_OK;
> +}
> +
> +static int acpi_install_cmos_rtc_space_handler(struct acpi_device *adev,
> +		const struct acpi_device_id *id)
> +{
> +	acpi_status status;
> +
> +	status = acpi_install_address_space_handler(adev->handle,
> +			ACPI_ADR_SPACE_CMOS,
> +			&acpi_cmos_rtc_space_handler,
> +			NULL, NULL);
> +	if (ACPI_FAILURE(status)) {
> +		pr_err(PREFIX "Error installing CMOS-RTC region handler\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static void acpi_remove_cmos_rtc_space_handler(struct acpi_device *adev)
> +{
> +	if (ACPI_FAILURE(acpi_remove_address_space_handler(adev->handle,
> +			ACPI_ADR_SPACE_CMOS, &acpi_cmos_rtc_space_handler)))
> +		pr_err(PREFIX "Error removing CMOS-RTC region handler\n");
> +}
> +
> +static struct acpi_scan_handler cmos_rtc_handler = {
> +	.ids = acpi_cmos_rtc_ids,
> +	.attach = acpi_install_cmos_rtc_space_handler,
> +	.detach = acpi_remove_cmos_rtc_space_handler,
> +};
> +
> +void __init acpi_cmos_rtc_init(void)
> +{
> +	acpi_scan_add_handler(&cmos_rtc_handler);
> +}
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 18a9d22..c82785f 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -36,6 +36,13 @@ void acpi_pci_root_hp_init(void);
>  void acpi_processor_init(void);
>  void acpi_platform_init(void);
>  int acpi_sysfs_init(void);
> +
> +#ifdef CONFIG_X86
> +void acpi_cmos_rtc_init(void);
> +#else
> +static inline void acpi_cmos_rtc_init(void) {}
> +#endif
> +
>  #ifdef CONFIG_ACPI_CONTAINER
>  void acpi_container_init(void);
>  #else
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index a67f614..642e045 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2159,6 +2159,7 @@ int __init acpi_scan_init(void)
>  	acpi_processor_init();
>  	acpi_platform_init();
>  	acpi_lpss_init();
> +	acpi_cmos_rtc_init();
>  	acpi_container_init();
>  	acpi_memory_hotplug_init();
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
