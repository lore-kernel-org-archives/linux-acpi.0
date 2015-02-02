From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v8 05/21] ACPI / sleep: Introduce sleep_arm.c
Date: Mon, 02 Feb 2015 23:18:24 +0100
Message-ID: <1685897.h4vAPfoguo@vostro.rjw.lan>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org> <1422881149-8177-6-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64848 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932136AbbBBVzb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Feb 2015 16:55:31 -0500
In-Reply-To: <1422881149-8177-6-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, Mark Langsdorf <mlangsdo@redhat.com>, wangyij

On Monday, February 02, 2015 08:45:33 PM Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> ACPI 5.1 does not currently support S states for ARM64 hardware but
> ACPI code will call acpi_target_system_state() for device power
> managment, so introduce sleep_arm.c to allow other drivers to function
> until S states are defined.
> 
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/Makefile    |  4 ++++
>  drivers/acpi/sleep_arm.c | 28 ++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>  create mode 100644 drivers/acpi/sleep_arm.c
> 
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index f74317c..bcec54e 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -23,7 +23,11 @@ acpi-y				+= nvs.o
>  
>  # Power management related files
>  acpi-y				+= wakeup.o
> +ifeq ($(ARCH), arm64)
> +acpi-y				+= sleep_arm.o
> +else # X86, IA64
>  acpi-y				+= sleep.o
> +endif
>  acpi-y				+= device_pm.o
>  acpi-$(CONFIG_ACPI_SLEEP)	+= proc.o
>  
> diff --git a/drivers/acpi/sleep_arm.c b/drivers/acpi/sleep_arm.c
> new file mode 100644
> index 0000000..54578ef
> --- /dev/null
> +++ b/drivers/acpi/sleep_arm.c
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
> 

Why does this need to be in drivers/acpi/ ?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
