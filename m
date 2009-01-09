From: Len Brown <lenb@kernel.org>
Subject: Re: [RESEND PATCH 2/2] ACPI: update props.brightness whenever the ACPI
 video backlight is changed
Date: Fri, 09 Jan 2009 01:39:41 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901090139090.4091@localhost.localdomain>
References: <1231396342.20746.81.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:40866 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbZAIGjs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 01:39:48 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD600GTYYFXXRG5@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 00:38:22 -0600 (CST)
In-reply-to: <1231396342.20746.81.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, rpurdie@rpsys.net, Matthew Garrett <mjg59@srcf.ucam.org>

this one was already applied on 12/30

it was titled video: always update the brightness when poking "brightness"
--
Len Brown, Intel Open Source Technology Center

On Thu, 8 Jan 2009, Zhang Rui wrote:

> Always update the props.brightness
> whenever the ACPI video backlight is changed.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/video.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> Index: linux-2.6/drivers/acpi/video.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/video.c
> +++ linux-2.6/drivers/acpi/video.c
> @@ -481,6 +481,7 @@ acpi_video_device_lcd_set_level(struct a
>  	int status = AE_OK;
>  	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
>  	struct acpi_object_list args = { 1, &arg0 };
> +	int state;
>  
>  
>  	arg0.integer.value = level;
> @@ -489,6 +490,10 @@ acpi_video_device_lcd_set_level(struct a
>  		status = acpi_evaluate_object(device->dev->handle, "_BCM",
>  					      &args, NULL);
>  	device->brightness->curr = level;
> +	for (state = 2; state < device->brightness->count; state++)
> +		if (level == device->brightness->levels[state])
> +			device->backlight->props.brightness = state - 2;
> +
>  	return status;
>  }
>  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
