From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 8/9] acpi: check a return value correctly in acpi_power_get_context()
Date: Tue, 29 Apr 2008 04:14:18 -0400
Message-ID: <200804290414.19227.lenb@kernel.org>
References: <200804182027.m3IKRTq7013561@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55896 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755835AbYD2IPJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Apr 2008 04:15:09 -0400
In-Reply-To: <200804182027.m3IKRTq7013561@imap1.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, lizf@cn.fujitsu.com, yakui.zhao@intel.com

applied.

thanks,
-len

On Friday 18 April 2008, akpm@linux-foundation.org wrote:
> From: Li Zefan <lizf@cn.fujitsu.com>
> 
> We should check *resource != NULL rather than resource != NULL, which will be
> always true.
> 
> Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>
> Acked-by: Zhao Yakui <yakui.zhao@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/power.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/acpi/power.c~acpi-check-a-return-value-correctly-in-acpi_power_get_context drivers/acpi/power.c
> --- a/drivers/acpi/power.c~acpi-check-a-return-value-correctly-in-acpi_power_get_context
> +++ a/drivers/acpi/power.c
> @@ -121,7 +121,7 @@ acpi_power_get_context(acpi_handle handl
>  	}
>  
>  	*resource = acpi_driver_data(device);
> -	if (!resource)
> +	if (!*resource)
>  		return -ENODEV;
>  
>  	return 0;
> _
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


