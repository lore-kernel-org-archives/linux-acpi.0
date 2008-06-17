From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH -next] acpi: fix printk format warning
Date: Tue, 17 Jun 2008 12:59:13 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806171258410.7277@localhost.localdomain>
References: <20080617094341.d144a5f8.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:42399 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766AbYFQRNA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jun 2008 13:13:00 -0400
In-reply-to: <20080617094341.d144a5f8.randy.dunlap@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@ORACLE.COM>
Cc: linux-acpi@vger.kernel.org, Yi Yang <yi.y.yang@intel.com>, linux-next@vger.kernel.org


applied,
thanks,
-Len


On Tue, 17 Jun 2008, Randy Dunlap wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix printk format warning:
> 
> linux-next-20080617/drivers/acpi/processor_throttling.c:1258: warning: format '%d' expects type 'int', but argument 4 has type 'size_t'
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  drivers/acpi/processor_throttling.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20080617.orig/drivers/acpi/processor_throttling.c
> +++ linux-next-20080617/drivers/acpi/processor_throttling.c
> @@ -1255,7 +1255,7 @@ static ssize_t acpi_processor_write_thro
>  	if (state_val >= pr->throttling.state_count)
>  		return -EINVAL;
>  
> -	snprintf(tmpbuf, 5, "%d", state_val);
> +	snprintf(tmpbuf, 5, "%zu", state_val);
>  
>  	if (strcmp(tmpbuf, charp) != 0)
>  		return -EINVAL;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
