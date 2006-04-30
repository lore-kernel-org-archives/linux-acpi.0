From: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] [RFC] make PC Speaker driver work on x86-64
Date: Sun, 30 Apr 2006 10:46:22 +0200
Message-ID: <200604301046.22369.ak@suse.de>
References: <200604291830.k3TIUA23009336@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:15766 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751064AbWD3Iuq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Apr 2006 04:50:46 -0400
In-Reply-To: <200604291830.k3TIUA23009336@harpo.it.uu.se>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: discuss@x86-64.org
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Saturday 29 April 2006 20:30, Mikael Pettersson wrote:
> I have a pair of Athlon64 machines that dual-boot 32-bit and
> 64-bit kernels. One annoying difference between the kernels
> is that the PC Speaker driver (CONFIG_INPUT_PCSPKR=y) only
> works in the 32-bit kernels. 

Ah, I would consider this more a feature than a bug but ok :)

> In the 64-bit kernels it remains 
> inactive and doesn't even generate any boot-time initialisation
> or error messages.
> 
> Today I debugged that issue, and found that the PC Speaker
> driver's ->probe() routine doesn't even get called in the
> 64-bit kernels. The reason for that is that the arch code
> apparently has to explictly add a "pcspkr" platform device
> in order for the driver core to call the ->probe() routine.
> arch/i386/kernel/setup.c unconditionally adds a "pcspkr"
> device, but the x86_64 kernel has no code at all related to
> the PC Speaker.
> 
> The patch below copies the relevant code from i386 to x86_64,
> which makes the PC Speaker work for me on x86_64.

Ok thanks. Applied.

> Is there a better way to do this? ACPI?

Maybe. ACPI folks, any opinion? 

-Andi (known to rip out the speaker cables in new machines) 

> 
> /Mikael
> 
> diff -rupN linux-2.6.17-rc3/arch/x86_64/kernel/setup.c linux-2.6.17-rc3.x86_64-pcspkr/arch/x86_64/kernel/setup.c
> --- linux-2.6.17-rc3/arch/x86_64/kernel/setup.c	2006-04-28 20:54:10.000000000 +0200
> +++ linux-2.6.17-rc3.x86_64-pcspkr/arch/x86_64/kernel/setup.c	2006-04-29 18:42:08.000000000 +0200
> @@ -1426,3 +1426,22 @@ struct seq_operations cpuinfo_op = {
>  	.show =	show_cpuinfo,
>  };
>  
> +#ifdef CONFIG_INPUT_PCSPKR
> +#include <linux/platform_device.h>
> +static __init int add_pcspkr(void)
> +{
> +	struct platform_device *pd;
> +	int ret;
> +
> +	pd = platform_device_alloc("pcspkr", -1);
> +	if (!pd)
> +		return -ENOMEM;
> +
> +	ret = platform_device_add(pd);
> +	if (ret)
> +		platform_device_put(pd);
> +
> +	return ret;
> +}
> +device_initcall(add_pcspkr);
> +#endif
> 
