From: Christian Birchinger <joker@netswarm.net>
Subject: Re: [PATCH] Current brightness level got not set correctly in
	video module, fix it.
Date: Tue, 16 Oct 2007 19:48:40 +0200
Message-ID: <20071016174840.GA17671@netswarm.net>
References: <1192549319.9847.623.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netswarm.net ([212.55.200.138]:53558 "EHLO netswarm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934784AbXJPSAj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Oct 2007 14:00:39 -0400
Content-Disposition: inline
In-Reply-To: <1192549319.9847.623.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: inux-acpi <linux-acpi@vger.kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>

On Tue, Oct 16, 2007 at 05:41:58PM +0200, Thomas Renninger wrote:
> Len, this should be a rather safe and obvious one. Can you apply it,
> pls.
> 
> Without this one, one should get NULL pointer when cap.BQC is not set as
> device->brightness should not be allocated then.
> 
> Christian: This should fix up the wrong initial 0 entry for the current
> brightness you saw.
> 
> Patch is against Len's git test tree and compile tested only.
> 
> Thanks,
> 
>    Thomas
> 
> ------------
> 
> Current brightness level got not set correctly in video module, fix it.
> 
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> ---
>  drivers/acpi/video.c |   14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> Index: lenb/drivers/acpi/video.c
> ===================================================================
> --- lenb.orig/drivers/acpi/video.c
> +++ lenb/drivers/acpi/video.c
> @@ -428,11 +428,15 @@ static int
>  acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
>  					unsigned long *level)
>  {
> -	if (device->cap._BQC)
> -		return acpi_evaluate_integer(device->dev->handle, "_BQC", NULL,
> -					     level);
> -	*level = device->brightness->curr;
> -	return AE_OK;
> +	acpi_status status = AE_OK;
> +
> +	if (device->cap._BQC){
> +		status = acpi_evaluate_integer(device->dev->handle, "_BQC",
> +					       NULL, level);
> +		if (ACPI_SUCCESS(status) && device->brightness)
> +			device->brightness->curr = *level;
> +	}
> +	return status;
>  }
>  
>  static int
> 

Looks fine here so far. Status is not 0 anymore on init and gets
updated when the brightness level changes.

I've put the function manualy into the 2.6.23.1 video.c because
the function was to different compared to the latest git.

Christian
