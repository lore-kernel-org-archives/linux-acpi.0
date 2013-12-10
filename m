From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [RFC part2 PATCH 2/9] ARM64 / ACPI: Prefill cpu possible/present maps and map logical cpu id to APIC id
Date: Tue, 10 Dec 2013 12:53:28 +0000
Message-ID: <20131210125328.923F2C40A27@trevor.secretlab.ca>
References: <1385999094-3152-1-git-send-email-hanjun.guo@linaro.org> < 1385999094-3152-3-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:53796 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab3LJMxe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Dec 2013 07:53:34 -0500
Received: by mail-wg0-f45.google.com with SMTP id y10so4904203wgg.12
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2013 04:53:32 -0800 (PST)
In-Reply-To: <1385999094-3152-3-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linaro-kernel@lists.linaro.org, linux-acpi@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linaro-acpi@lists.linaro.org, Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, Hanjun Guo <hanjun.guo@linaro.org>

On Mon,  2 Dec 2013 23:44:47 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> When boot the kernel with MADT, the cpu possible and present maps should be
> prefilled for cpu topology and acpi based cpu hot-plug.
> 
> The logic cpu id maps to APIC id (GIC id) is also implemented, it is needed
> for acpi processor drivers.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
[...]
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index a0c2ca6..1428024 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -420,7 +420,9 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  		if (err)
>  			continue;
>  
> +#ifndef CONFIG_ACPI
>  		set_cpu_present(cpu, true);
> +#endif
>  		max_cpus--;
>  	}
>  }

This looks wrong. Will this break non-ACPI booting when CONFIG_ACPI is
enabled? The decision on whether or not to run code must be made at
runtime.

g.
