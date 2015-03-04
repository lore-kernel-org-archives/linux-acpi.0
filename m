From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v9 07/21] ACPI / sleep: Introduce arm64 specific acpi_sleep.c
Date: Wed, 04 Mar 2015 23:38 +0100
Message-ID: <2076446.VFvTauDDiK@vostro.rjw.lan>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org> <1424853601-6675-8-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64779 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752172AbbCDWOY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2015 17:14:24 -0500
In-Reply-To: <1424853601-6675-8-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>

On Wednesday, February 25, 2015 04:39:47 PM Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> ACPI 5.1 does not currently support S states for ARM64 hardware but
> ACPI code will call acpi_target_system_state() for device power
> management, so introduce acpi_sleep.c to allow other drivers to function
> until S states are defined.
> 
> Since it is arm64 specific stub holder, so let acpi_sleep.c to ARM64
> specific.
> 
> TODO: merge this with drivers/acpi/sleep.c once we fix the specification.
> 
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/kernel/Makefile     |  2 +-
>  arch/arm64/kernel/acpi_sleep.c | 28 ++++++++++++++++++++++++++++
>  drivers/acpi/Makefile          |  2 ++
>  3 files changed, 31 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kernel/acpi_sleep.c
> 
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 218eb7e..4435943 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -34,7 +34,7 @@ arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
>  arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
>  arm64-obj-$(CONFIG_PCI)			+= pci.o
>  arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
> -arm64-obj-$(CONFIG_ACPI)		+= acpi.o
> +arm64-obj-$(CONFIG_ACPI)		+= acpi.o acpi_sleep.o
>  
>  obj-y					+= $(arm64-obj-y) vdso/
>  obj-m					+= $(arm64-obj-m)
> diff --git a/arch/arm64/kernel/acpi_sleep.c b/arch/arm64/kernel/acpi_sleep.c
> new file mode 100644
> index 0000000..54578ef
> --- /dev/null
> +++ b/arch/arm64/kernel/acpi_sleep.c
> @@ -0,0 +1,28 @@
> +/*
> + *  ARM64 Specific Sleep Functionality
> + *
> + *  Copyright (C) 2013-2014, Linaro Ltd.
> + *      Author: Graeme Gregory <graeme.gregory@linaro.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + */
> +
> +#include <linux/acpi.h>
> +
> +/*
> + * Currently the ACPI 5.1 standard does not define S states in a
> + * manner which is usable for ARM64. These two stubs are sufficient
> + * that system initialises and device PM works.
> + */
> +u32 acpi_target_system_state(void)
> +{
> +	return ACPI_STATE_S0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_target_system_state);
> +
> +int __init acpi_sleep_init(void)
> +{
> +	return -ENOSYS;
> +}
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 623b117..c32edf5 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -23,7 +23,9 @@ acpi-y				+= nvs.o
>  
>  # Power management related files
>  acpi-y				+= wakeup.o
> +ifneq (,$(findstring $(ARCH),x86 ia64))

This is super-ugly.  Isn't there a better way to do that?

>  acpi-y				+= sleep.o
> +endif
>  acpi-y				+= device_pm.o
>  acpi-$(CONFIG_ACPI_SLEEP)	+= proc.o
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
