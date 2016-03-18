From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RESEND PATCH v4 2/5] ACPI: add GTDT table parse driver into ACPI
 driver
Date: Fri, 18 Mar 2016 15:45:13 +0100
Message-ID: <56EC1479.7060902@linaro.org>
References: <1458288053-29031-1-git-send-email-fu.wei@linaro.org>
 <1458288053-29031-3-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35881 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbcCROpS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Mar 2016 10:45:18 -0400
Received: by mail-wm0-f51.google.com with SMTP id l124so33955632wmf.1
        for <linux-acpi@vger.kernel.org>; Fri, 18 Mar 2016 07:45:17 -0700 (PDT)
In-Reply-To: <1458288053-29031-3-git-send-email-fu.wei@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, marc.zyngier@arm.com, hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org, timur@codeaurora.org, graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de, wim@iguana.be, catalin.marinas@arm.com, will.deacon@arm.com, Suravee.Suthikulpanit@amd.com, leo.duran@amd.com

On 03/18/2016 09:00 AM, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This driver adds support for parsing all kinds of timer in GTDT:
> (1)arch timer: provide a kernel API to parse all the PPIs and
> always-on info in GTDT and export them by arch_timer_data struct.
>
> (2)memory-mapped timer: provide several kernel APIs to parse
> GT Block Structure in GTDT, export those info by return value
> and arch_timer_mem_data struct.
>
> (3)SBSA Generic Watchdog: parse all info in SBSA Generic Watchdog
> Structure in GTDT, and creating a platform device with that
> information. This allows the operating system to obtain device
> data from the resource of platform device.
> The platform device named "sbsa-gwdt" can be used by the ARM SBSA
> Generic Watchdog driver.
>
> By this driver, we can simplify all the relevant drivers, and
> separate all the ACPI GTDT knowledge from them.
>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>   drivers/acpi/Kconfig                 |   9 +
>   drivers/acpi/Makefile                |   1 +
>   drivers/acpi/gtdt.c                  | 376 ++++++++++++++++++++++++=
+++++++++++
>   include/clocksource/arm_arch_timer.h |  13 ++
>   include/linux/acpi.h                 |  17 ++
>   5 files changed, 416 insertions(+)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 82b96ee..abf33d3 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -521,4 +521,13 @@ config XPOWER_PMIC_OPREGION
>
>   endif
>
> +config ACPI_GTDT
> +	bool "ACPI GTDT Support"
> +	depends on ARM64
> +	help
> +	  GTDT (Generic Timer Description Table) provides information
> +	  for per-processor timers and Platform (memory-mapped) timers
> +	  for ARM platforms. Select this option to provide information
> +	  needed for the timers init.

Why not ARM64's Kconfig select ACPI_GTDT ?

This config option assumes an user will manually select this option=20
which I believe it makes sense to have always on when ARM64=3Dy. So why=
=20
not create a silent option and select it directly from the ARM64=20
platform Kconfig ?


>   endif	# ACPI
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index edeb2d1..f7ea779 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -98,5 +98,6 @@ obj-$(CONFIG_ACPI_EXTLOG)	+=3D acpi_extlog.o
>   obj-$(CONFIG_PMIC_OPREGION)	+=3D pmic/intel_pmic.o
>   obj-$(CONFIG_CRC_PMIC_OPREGION) +=3D pmic/intel_pmic_crc.o
>   obj-$(CONFIG_XPOWER_PMIC_OPREGION) +=3D pmic/intel_pmic_xpower.o
> +obj-$(CONFIG_ACPI_GTDT)		+=3D gtdt.o

acpi_gtdt.o ?

>   video-objs			+=3D acpi_video.o video_detect.o
> diff --git a/drivers/acpi/gtdt.c b/drivers/acpi/gtdt.c
> new file mode 100644
> index 0000000..d1b851c
> --- /dev/null
> +++ b/drivers/acpi/gtdt.c
> @@ -0,0 +1,376 @@
> +/*
> + * ARM Specific GTDT table Support
> + *
> + * Copyright (C) 2015, Linaro Ltd.
> + * Author: Fu Wei <fu.wei@linaro.org>
> + *         Hanjun Guo <hanjun.guo@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <clocksource/arm_arch_timer.h>
> +
> +#undef pr_fmt

Why #undef ?

> +#define pr_fmt(fmt) "GTDT: " fmt
> +
> +static u32 platform_timer_count __initdata;
> +static int gtdt_timers_existence __initdata;
> +
> +/*
> + * Get some basic info from GTDT table, and init the global variable=
s above
> + * for all timers initialization of Generic Timer.
> + * This function does some validation on GTDT table, and will be run=
 only once.
> + */
> +static void __init *platform_timer_info_init(struct acpi_table_heade=
r *table)
> +{
> +	void *gtdt_end, *platform_timer_struct, *platform_timer;
> +	struct acpi_gtdt_header *header;
> +	struct acpi_table_gtdt *gtdt;
> +	u32 i;
> +
> +	gtdt =3D container_of(table, struct acpi_table_gtdt, header);
> +	if (!gtdt) {
> +		pr_err("table pointer error.\n");
> +		return NULL;
> +	}
> +	gtdt_end =3D (void *)table + table->length;
> +	gtdt_timers_existence |=3D ARCH_CP15_TIMER;
> +
> +	if (table->revision < 2) {
> +		pr_info("Revision:%d doesn't support Platform Timers.\n",
> +			table->revision);
> +		return NULL;
> +	}
> +
> +	platform_timer_count =3D gtdt->platform_timer_count;
> +	if (!platform_timer_count) {
> +		pr_info("No Platform Timer structures.\n");
> +		return NULL;
> +	}
> +
> +	platform_timer_struct =3D (void *)gtdt + gtdt->platform_timer_offse=
t;
> +	if (platform_timer_struct < (void *)table +
> +				    sizeof(struct acpi_table_gtdt)) {
> +		pr_err(FW_BUG "Platform Timer pointer error.\n");
> +		return NULL;
> +	}
> +
> +	platform_timer =3D platform_timer_struct;
> +	for (i =3D 0; i < platform_timer_count; i++) {
> +		if (platform_timer > gtdt_end) {
> +			pr_err(FW_BUG "subtable pointer overflows.\n");
> +			platform_timer_count =3D i;
> +			break;
> +		}
> +		header =3D (struct acpi_gtdt_header *)platform_timer;
> +		if (header->type =3D=3D ACPI_GTDT_TYPE_TIMER_BLOCK)
> +			gtdt_timers_existence |=3D ARCH_MEM_TIMER;
> +		else if (header->type =3D=3D ACPI_GTDT_TYPE_WATCHDOG)
> +			gtdt_timers_existence |=3D ARCH_WD_TIMER;
> +		platform_timer +=3D header->length;
> +	}
> +
> +	return platform_timer_struct;
> +}
> +
> +static int __init map_generic_timer_interrupt(u32 interrupt, u32 fla=
gs)
> +{
> +	int trigger, polarity;
> +
> +	if (!interrupt)
> +		return 0;
> +
> +	trigger =3D (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIV=
E
> +			: ACPI_LEVEL_SENSITIVE;
> +
> +	polarity =3D (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_L=
OW
> +			: ACPI_ACTIVE_HIGH;
> +
> +	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
> +}
> +
> +/*
> + * Get the necessary info of arch_timer from GTDT table.
> + */
> +int __init gtdt_arch_timer_data_init(struct acpi_table_header *table=
,
> +				     struct arch_timer_data *data)
> +{
> +	struct acpi_table_gtdt *gtdt;
> +
> +	if (acpi_disabled || !data)
> +		return -EINVAL;
> +
> +	if (!table) {
> +		if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_GTDT, 0, &table)))
> +			return -EINVAL;
> +	}
> +
> +	if (!gtdt_timers_existence)
> +		platform_timer_info_init(table);

Same comment than the one below in the gtdt_gt_block function. There is=
=20
something wrong in the init sequence.

> +	gtdt =3D container_of(table, struct acpi_table_gtdt, header);
> +
> +	data->phys_secure_ppi =3D
> +		map_generic_timer_interrupt(gtdt->secure_el1_interrupt,
> +					    gtdt->secure_el1_flags);
> +
> +	data->phys_nonsecure_ppi =3D
> +		map_generic_timer_interrupt(gtdt->non_secure_el1_interrupt,
> +					    gtdt->non_secure_el1_flags);
> +
> +	data->virt_ppi =3D
> +		map_generic_timer_interrupt(gtdt->virtual_timer_interrupt,
> +					    gtdt->virtual_timer_flags);
> +
> +	data->hyp_ppi =3D
> +		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
> +					    gtdt->non_secure_el2_flags);
> +
> +	data->c3stop =3D !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON=
);
> +
> +	return 0;
> +}
> +
> +bool __init gtdt_timer_is_available(int type)
> +{
> +	return gtdt_timers_existence | type;
> +}
> +
> +/*
> + * Helper function for getting the pointer of platform_timer_struct.
> + */
> +static void __init *get_platform_timer_struct(struct acpi_table_head=
er *table)
> +{
> +	struct acpi_table_gtdt *gtdt;
> +
> +	if (!table) {
> +		pr_err("table pointer error.\n");
> +		return NULL;
> +	}

IMO, this check is not necessary as the caller should have checked it=20
before calling this function.

> +	gtdt =3D container_of(table, struct acpi_table_gtdt, header);
> +
> +	return (void *)gtdt + gtdt->platform_timer_offset;
> +}
> +
> + /*
> + * Get the pointer of GT Block Structure in GTDT table
> + */
> +void __init *gtdt_gt_block(struct acpi_table_header *table, int inde=
x)
> +{
> +	struct acpi_gtdt_header *header;
> +	void *platform_timer;
> +	int i, j;
> +
> +	if (!gtdt_timers_existence)
> +		platform_timer =3D platform_timer_info_init(table);
> +	else
> +		platform_timer =3D get_platform_timer_struct(table);

This portion of code suggests there is a lost of control of the init=20
sequence or will give the opportunity of the caller to do it so.

I would suggest to be more strict:

if (!gtdt_timers_existence)
	return NULL;

and let the user of this function to ensure gtdt_gt_block is called=20
after the gtdt tables are initialized.

> +	if (!gtdt_timer_is_available(ARCH_MEM_TIMER))
> +		return NULL;
> +
> +	for (i =3D 0, j =3D 0; i < platform_timer_count; i++) {
> +		header =3D (struct acpi_gtdt_header *)platform_timer;
> +		if (header->type =3D=3D ACPI_GTDT_TYPE_TIMER_BLOCK && j++ =3D=3D i=
ndex)
> +			return platform_timer;
> +		platform_timer +=3D header->length;
> +	}
> +
> +	return NULL;
> +}
> +
> +/*
> + * Get the timer_count(the number of timer frame) of a GT Block in G=
TDT table
> + */
> +u32 __init gtdt_gt_timer_count(struct acpi_gtdt_timer_block *gt_bloc=
k)
> +{
> +	if (!gt_block) {
> +		pr_err("invalid GT Block baseaddr.\n");
> +		return 0;
> +	}

In the patch 5/5, !gt_block is already checked.

> +	return gt_block->timer_count;
> +}
> +
> +/*
> + * Get the physical address of GT Block in GTDT table
> + */
> +void __init *gtdt_gt_cntctlbase(struct acpi_gtdt_timer_block *gt_blo=
ck)
> +{
> +	if (!gt_block) {
> +		pr_err("invalid GT Block baseaddr.\n");
> +		return NULL;
> +	}

Same comment here.

arch_timer_mem_best_frame in patch 5/5 checks !gt_block then calls=20
arch_timer_mem_cnttidr which in turn calls gtdt_gt_cntctlbase

> +	return (void *)gt_block->block_address;
> +}
> +
> +/*
> + * Helper function for getting the pointer of a timer frame in GT bl=
ock.
> + */
> +static void __init *gtdt_gt_timer_frame(struct acpi_gtdt_timer_block=
 *gt_block,
> +					int index)
> +{
> +	void *timer_frame;
> +
> +	if (!(gt_block && gt_block->timer_count))
> +		return NULL;

Pointless check.

Ok, I am giving up the review at this point.

Don't introduce a family of helpers to access gtdt structure internal. =
I=20
think it would much more nice if you create a structure for the timer,=20
pass it to the acpi subsystem and let it fill it.

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
