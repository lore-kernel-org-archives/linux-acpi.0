From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] sony-laptop: newline-terminate the printk for backlight
 change failure
Date: Thu, 16 Oct 2008 15:32:25 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810161532170.3026@localhost.localdomain>
References: <1224184535-30764-1-git-send-email-ajax@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:48874 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883AbYJPTcz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Oct 2008 15:32:55 -0400
In-reply-to: <1224184535-30764-1-git-send-email-ajax@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adam Jackson <ajax@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

applied.

thanks,
-len

On Thu, 16 Oct 2008, Adam Jackson wrote:

> ---
>  drivers/misc/sony-laptop.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
> index 60775be..5a97d3a 100644
> --- a/drivers/misc/sony-laptop.c
> +++ b/drivers/misc/sony-laptop.c
> @@ -970,7 +970,7 @@ static int sony_nc_resume(struct acpi_device *device)
>  	/* set the last requested brightness level */
>  	if (sony_backlight_device &&
>  			!sony_backlight_update_status(sony_backlight_device))
> -		printk(KERN_WARNING DRV_PFX "unable to restore brightness level");
> +		printk(KERN_WARNING DRV_PFX "unable to restore brightness level\n");
>  
>  	/* re-initialize models with specific requirements */
>  	dmi_check_system(sony_nc_ids);
> -- 
> 1.6.0.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
