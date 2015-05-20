From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 03/11] irqchip / GIC: Add GIC version support in ACPI
 MADT
Date: Wed, 20 May 2015 22:02:12 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1505202157190.4225@nanos>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org> <1431953961-22706-4-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34829 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023AbbETUCJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 May 2015 16:02:09 -0400
In-Reply-To: <1431953961-22706-4-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiang Liu <jiang.liu@linux.intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Grant Likely <grant.likely@linaro.org>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On Mon, 18 May 2015, Hanjun Guo wrote:
> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> index 65d6b93..855ead9 100644
> --- a/drivers/acpi/irq.c
> +++ b/drivers/acpi/irq.c
> @@ -32,6 +32,9 @@ void __init acpi_irqchip_init(void)
>  	if (acpi_disabled)
>  		return;
>  
> +	if (acpi_gic_version_init())
> +		return;

This looks just wrong. acpi_irqchip_init() is a generic ACPI function
and now you stick a GIC specific callback into it?

What calls acpi_irqchip_init?

Thanks,

	tglx
