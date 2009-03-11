From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC PATCH 1/5] ACPI video: check the return value of acpi_video_device_lcd_get_level_current
Date: Wed, 11 Mar 2009 13:56:00 +0100
Message-ID: <200903111356.01710.trenn@suse.de>
References: <1236672205.2820.119.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:52103 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905AbZCKM4F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Mar 2009 08:56:05 -0400
In-Reply-To: <1236672205.2820.119.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Tuesday 10 March 2009 09:03:25 Zhang Rui wrote:
> Subject: check the return value of 
acpi_video_device_lcd_get_level_current
> From: Zhang Rui <rui.zhang@intel.com>
> 
> check the return value of acpi_video_device_lcd_get_level_current
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/video.c |   69 
++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 47 insertions(+), 22 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/video.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/video.c
> +++ linux-2.6/drivers/acpi/video.c
> @@ -294,7 +294,7 @@ static int acpi_video_device_lcd_get_lev
>  			unsigned long long *level);
>  static int acpi_video_get_next_level(struct acpi_video_device *device,
>  				     u32 level_current, u32 event);
> -static void acpi_video_switch_brightness(struct acpi_video_device 
*device,
> +static int acpi_video_switch_brightness(struct acpi_video_device 
*device,
>  					 int event);
>  static int acpi_video_device_get_state(struct acpi_video_device *device,
>  			    unsigned long long *state);
> @@ -308,7 +308,9 @@ static int acpi_video_get_brightness(str
>  	int i;
>  	struct acpi_video_device *vd =
>  		(struct acpi_video_device *)bl_get_data(bd);
> -	acpi_video_device_lcd_get_level_current(vd, &cur_level);
> +
> +	if (acpi_video_device_lcd_get_level_current(vd, &cur_level))
> +		return -EINVAL;
>  	for (i = 2; i < vd->brightness->count; i++) {
>  		if (vd->brightness->levels[i] == cur_level)
>  			/* The first two entries are special - see page 575
> @@ -373,7 +375,8 @@ static int video_get_cur_state(struct th
>  	unsigned long long level;
>  	int state;
>  
> -	acpi_video_device_lcd_get_level_current(video, &level);
> +	if (acpi_video_device_lcd_get_level_current(video, &level))
> +		return -EINVAL;
>  	for (state = 2; state < video->brightness->count; state++)
>  		if (level == video->brightness->levels[state])
>  			return sprintf(buf, "%d\n",
> @@ -502,11 +505,29 @@ static int
>  acpi_video_device_lcd_get_level_current(struct acpi_video_device 
*device,
>  					unsigned long long *level)
>  {
> -	if (device->cap._BQC)
> -		return acpi_evaluate_integer(device->dev->handle, "_BQC", NULL,
> -					     level);
> +	acpi_status status = AE_OK;
> +
> +	if (device->cap._BQC) {
> +		status = acpi_evaluate_integer(device->dev->handle, "_BQC",
> +						NULL, level);
> +		if (ACPI_SUCCESS(status)) {
> +			device->brightness->curr = *level;
> +			return 0;
> +		} else {
> +			/* Fixme:
> +			 * should we return an error or ignore this failure?
> +			 * dev->brightness->curr is a cached value which stores
> +			 * the correct current backlight level in most cases.
> +			 * ACPI video backlight still works w/ buggy _BQC.
> +			 * http://bugzilla.kernel.org/show_bug.cgi?id=12233
> +			 */
I wonder what should go wrong there at all.
We should add a warning (using printk(.. FW_BUG...)) if we do ACPI video 
brightness switching without _BQC. This should be supported, but is a 
firmware bug and likely fails.
(BTW, I recently saw a BIOS with _BCQ function. They said they are going to 
fix it, but it may be more widespread, e.g. this also is often the case 
(missing _BQC) on Samsung). I found it by luck disassembling and 
recompiling the DSDT, a runtime warning would be nice (if it does not 
already exist).
Anyway, if we have _BQC (cap._BQC), evaluation should not fail?
Ok, double checking is always a good idea...

> +			ACPI_WARNING((AE_INFO, "Evaluating _BQC failed"));
> +			device->cap._BQC = 0;
> +		}
> +	}
> +
>  	*level = device->brightness->curr;
> -	return AE_OK;
> +	return 0;
>  }
>  
>  static int
> @@ -773,18 +794,8 @@ static void acpi_video_device_find_cap(s
>  		device->backlight = backlight_device_register(name,
>  			NULL, device, &acpi_backlight_ops);
>  		device->backlight->props.max_brightness = device->brightness->count-3;
> -		/*
> -		 * If there exists the _BQC object, the _BQC object will be
> -		 * called to get the current backlight brightness. Otherwise
> -		 * the brightness will be set to the maximum.
> -		 */
> -		if (device->cap._BQC)
> -			device->backlight->props.brightness =
> -				acpi_video_get_brightness(device->backlight);
> -		else
> -			device->backlight->props.brightness =
> -				device->backlight->props.max_brightness;
> -		backlight_update_status(device->backlight);
> +		device->backlight->props.brightness =
> +			acpi_video_get_brightness(device->backlight);
I could imagine this introduces a regression on machines without _BQC.
IIRC the value which brightness is currently active must be initialized if 
there is no _BQC function and that seems to happen here.

     Thomas
