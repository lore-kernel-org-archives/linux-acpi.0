From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI video: Be more liberal in validating _BQC behaviour
Date: Fri, 19 Feb 2010 01:40:47 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002190140230.24628@localhost.localdomain>
References: <1266357230-10602-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:34478 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab0BSGkt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2010 01:40:49 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KY200E1VT80MAW1@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 19 Feb 2010 00:40:49 -0600 (CST)
In-reply-to: <1266357230-10602-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, rui.zhang@intel.com

Matthew,

Is there a life failure someplace (eg. bugzilla) that works after this 
patch?

thanks,
Len Brown, Intel Open Source Technology Center

On Tue, 16 Feb 2010, Matthew Garrett wrote:

> Right now, if _BQC returns a value we don't understand we immediately
> invalidate it. Change this behaviour so we only invalidate it if it
> continues to give an invalid answer after we've already set a brightness.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/acpi/video.c |   28 +++++++++++++++++-----------
>  1 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index b765790..ea314a2 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -327,7 +327,7 @@ static int acpi_video_device_lcd_set_level(struct acpi_video_device *device,
>  			int level);
>  static int acpi_video_device_lcd_get_level_current(
>  			struct acpi_video_device *device,
> -			unsigned long long *level);
> +			unsigned long long *level, int init);
>  static int acpi_video_get_next_level(struct acpi_video_device *device,
>  				     u32 level_current, u32 event);
>  static int acpi_video_switch_brightness(struct acpi_video_device *device,
> @@ -345,7 +345,7 @@ static int acpi_video_get_brightness(struct backlight_device *bd)
>  	struct acpi_video_device *vd =
>  		(struct acpi_video_device *)bl_get_data(bd);
>  
> -	if (acpi_video_device_lcd_get_level_current(vd, &cur_level))
> +	if (acpi_video_device_lcd_get_level_current(vd, &cur_level, 0))
>  		return -EINVAL;
>  	for (i = 2; i < vd->brightness->count; i++) {
>  		if (vd->brightness->levels[i] == cur_level)
> @@ -414,7 +414,7 @@ static int video_get_cur_state(struct thermal_cooling_device *cooling_dev, unsig
>  	unsigned long long level;
>  	int offset;
>  
> -	if (acpi_video_device_lcd_get_level_current(video, &level))
> +	if (acpi_video_device_lcd_get_level_current(video, &level, 0))
>  		return -EINVAL;
>  	for (offset = 2; offset < video->brightness->count; offset++)
>  		if (level == video->brightness->levels[offset]) {
> @@ -609,7 +609,7 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  
>  static int
>  acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
> -					unsigned long long *level)
> +					unsigned long long *level, int init)
>  {
>  	acpi_status status = AE_OK;
>  	int i;
> @@ -633,10 +633,16 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
>  					device->brightness->curr = *level;
>  					return 0;
>  			}
> -			/* BQC returned an invalid level. Stop using it.  */
> -			ACPI_WARNING((AE_INFO, "%s returned an invalid level",
> -						buf));
> -			device->cap._BQC = device->cap._BCQ = 0;
> +			if (!init) {
> +				/*
> +				 * BQC returned an invalid level.
> +				 * Stop using it.
> +				 */
> +				ACPI_WARNING((AE_INFO,
> +					      "%s returned an invalid level",
> +					      buf));
> +				device->cap._BQC = device->cap._BCQ = 0;
> +			}
>  		} else {
>  			/* Fixme:
>  			 * should we return an error or ignore this failure?
> @@ -892,7 +898,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
>  	if (!device->cap._BQC)
>  		goto set_level;
>  
> -	result = acpi_video_device_lcd_get_level_current(device, &level_old);
> +	result = acpi_video_device_lcd_get_level_current(device, &level_old, 1);
>  	if (result)
>  		goto out_free_levels;
>  
> @@ -903,7 +909,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
>  	if (result)
>  		goto out_free_levels;
>  
> -	result = acpi_video_device_lcd_get_level_current(device, &level);
> +	result = acpi_video_device_lcd_get_level_current(device, &level, 0);
>  	if (result)
>  		goto out_free_levels;
>  
> @@ -1996,7 +2002,7 @@ acpi_video_switch_brightness(struct acpi_video_device *device, int event)
>  		goto out;
>  
>  	result = acpi_video_device_lcd_get_level_current(device,
> -							 &level_current);
> +							 &level_current, 0);
>  	if (result)
>  		goto out;
>  
> -- 
> 1.6.6.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
