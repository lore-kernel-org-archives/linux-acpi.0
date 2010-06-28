From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] acpi/processor: fix for !CONFIG_CPU_IDLE
Date: Mon, 28 Jun 2010 14:42:02 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006281440430.16755@localhost.localdomain>
References: <4C238A8902000078000080B1@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50490 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab0F1SmJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Jun 2010 14:42:09 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L4Q003TNMM3I8G2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 28 Jun 2010 13:42:05 -0500 (CDT)
In-reply-to: <4C238A8902000078000080B1@vpn.id2.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-acpi@vger.kernel.org

On Thu, 24 Jun 2010, Jan Beulich wrote:

> The conditional modified (to have an 'else' portion) in commit
> 2671717265ae6e720a9ba5f13fbec3a718983b65 degenerates to an
> unconditional NULL dereference when CONFIG_CPU_IDLE is off, as
> cpuidle_register_driver() returns non-zero in this case, and
> cpu_idle_get_driver() returns NULL. The simplest solution is to make
> the whole construct depend on CONFIG_CPU_IDLE bein defined.
> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>

As CONFIG_ACPI selects CONFIG_CPU_IDLE,
how were you able to provoke this issue?

thanks,
-Len Brown, Intel Open Source Technology Center

> ---
>  drivers/acpi/processor_driver.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- linux-2.6.35-rc3/drivers/acpi/processor_driver.c
> +++ 2.6.35-rc3-acpi-no-cpuidle/drivers/acpi/processor_driver.c
> @@ -922,6 +922,7 @@ static int __init acpi_processor_init(vo
>  		return -ENOMEM;
>  #endif
>  
> +#ifdef CONFIG_CPU_IDLE
>  	if (!cpuidle_register_driver(&acpi_idle_driver)) {
>  		printk(KERN_DEBUG "ACPI: %s registered with cpuidle\n",
>  			acpi_idle_driver.name);
> @@ -929,6 +930,7 @@ static int __init acpi_processor_init(vo
>  		printk(KERN_DEBUG "ACPI: acpi_idle yielding to %s",
>  			cpuidle_get_driver()->name);
>  	}
> +#endif
>  
>  	result = acpi_bus_register_driver(&acpi_processor_driver);
>  	if (result < 0)
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
