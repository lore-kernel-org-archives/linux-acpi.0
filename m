From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Reduce ACPI resource conflict message to KERN_INFO,
 printf cleanup
Date: Sun, 04 Apr 2010 21:13:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004042107470.4155@localhost.localdomain>
References: <1269284889-3968-1-git-send-email-chase.douglas@ubuntu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:58867 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188Ab0DEBNV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Apr 2010 21:13:21 -0400
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L0D009Y5Q1SS421@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 04 Apr 2010 20:13:09 -0500 (CDT)
In-reply-to: <1269284889-3968-1-git-send-email-chase.douglas@ubuntu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chase Douglas <chase.douglas@ubuntu.com>
Cc: linux-acpi@vger.kernel.org



thanks,
Len Brown, Intel Open Source Technology Center

On Mon, 22 Mar 2010, Chase Douglas wrote:

> From: Chase Douglas <chase.douglas@canonical.com>
> 
> By default, ACPI resource conflict messages are logged at level
> KERN_ERR. This is a rather high level for a message that is more a
> warning than an indication of a real kernel error. Also, KERN_ERR level
> messages can appear over some boot splash screens, and this message is
> not serious enough to warrant such treatment. Thus, the log level has
> been reduced to KERN_INFO.
> 
> Also, cleanup message to use %pR resource printing format.
> 
> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> ---
>  drivers/acpi/osl.c |   14 ++++----------
>  1 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 02e8464..33a01cb 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -1151,16 +1151,10 @@ int acpi_check_resource_conflict(const struct resource *res)
>  
>  	if (clash) {
>  		if (acpi_enforce_resources != ENFORCE_RESOURCES_NO) {
> -			printk("%sACPI: %s resource %s [0x%llx-0x%llx]"
> -			       " conflicts with ACPI region %s"
> -			       " [0x%llx-0x%llx]\n",
> -			       acpi_enforce_resources == ENFORCE_RESOURCES_LAX
> -			       ? KERN_WARNING : KERN_ERR,
> -			       ioport ? "I/O" : "Memory", res->name,
> -			       (long long) res->start, (long long) res->end,
> -			       res_list_elem->name,
> -			       (long long) res_list_elem->start,
> -			       (long long) res_list_elem->end);

I think KERN_WARNING would be more appropriate here, as
this is a condition that may cause a devide driver to refuse to load...

I agree with skipping the check of acpi_enforce_resources here.

> +			printk(KERN_INFO "ACPI: resource %s %pR"
> +			       " conflicts with ACPI region %s %pR\n",
> +			       res->name, res, res_list_elem->name,
> +			       res_list_elem);
>  			if (acpi_enforce_resources == ENFORCE_RESOURCES_LAX)
>  				printk(KERN_NOTICE "ACPI: This conflict may"
>  				       " cause random problems and system"
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
