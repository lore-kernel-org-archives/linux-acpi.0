From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 4/4] acpi/dock: use NULL for pointer
Date: Wed, 28 Mar 2007 23:32:26 -0400
Message-ID: <200703282332.26875.lenb@kernel.org>
References: <200703270538.l2R5cnU9007940@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55371 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965931AbXC2Ddu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Mar 2007 23:33:50 -0400
In-Reply-To: <200703270538.l2R5cnU9007940@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, randy.dunlap@oracle.com

Applied.

thanks,
-Len

On Tuesday 27 March 2007 01:38, akpm@linux-foundation.org wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Use NULL instead of 0 for pointers:
> drivers/acpi/dock.c:677:75: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/dock.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff -puN drivers/acpi/dock.c~acpi-dock-use-null-for-pointer drivers/acpi/dock.c
> --- a/drivers/acpi/dock.c~acpi-dock-use-null-for-pointer
> +++ a/drivers/acpi/dock.c
> @@ -29,6 +29,7 @@
>  #include <linux/notifier.h>
>  #include <linux/platform_device.h>
>  #include <linux/jiffies.h>
> +#include <linux/stddef.h>
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
>  
> @@ -674,7 +675,7 @@ static ssize_t show_dock_uid(struct devi
>  			     struct device_attribute *attr, char *buf)
>  {
>  	unsigned long lbuf;
> -	acpi_status status = acpi_evaluate_integer(dock_station->handle, "_UID", 0, &lbuf);
> +	acpi_status status = acpi_evaluate_integer(dock_station->handle, "_UID", NULL, &lbuf);
>  	if(ACPI_FAILURE(status)) {
>  	    return 0;
>  	}
> _
> 
