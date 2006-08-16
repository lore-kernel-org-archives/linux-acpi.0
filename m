From: Len Brown <len.brown@intel.com>
Subject: Re: [patch 05/14] acpi: handle firmware_register init errors
Date: Tue, 15 Aug 2006 23:26:41 -0400
Message-ID: <200608152326.42299.len.brown@intel.com>
References: <200608150537.k7F5bOTW011542@shell0.pdx.osdl.net>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46754 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750884AbWHPDY5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Aug 2006 23:24:57 -0400
In-Reply-To: <200608150537.k7F5bOTW011542@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, rdunlap@xenotime.net, greg@kroah.com

Applied.

Looking forward to removing this call to firmware_register() completely soon.

thanks,
-Len


On Tuesday 15 August 2006 01:37, akpm@osdl.org wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Check and handle init errors.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> Cc: Greg KH <greg@kroah.com>
> Cc: "Brown, Len" <len.brown@intel.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/acpi/bus.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff -puN drivers/acpi/bus.c~acpi-handle-firmware_register-init-errors drivers/acpi/bus.c
> --- a/drivers/acpi/bus.c~acpi-handle-firmware_register-init-errors
> +++ a/drivers/acpi/bus.c
> @@ -25,6 +25,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/ioport.h>
> +#include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/sched.h>
>  #include <linux/pm.h>
> @@ -738,7 +739,10 @@ static int __init acpi_init(void)
>  		return -ENODEV;
>  	}
>  
> -	firmware_register(&acpi_subsys);
> +	result = firmware_register(&acpi_subsys);
> +	if (result < 0)
> +		printk(KERN_WARNING "%s: firmware_register error: %d\n",
> +			__FUNCTION__, result);
>  
>  	result = acpi_bus_init();
>  
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
