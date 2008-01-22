From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] Rationalise ACPI backlight implementation
Date: Tue, 22 Jan 2008 16:33:29 +0800
Message-ID: <1200990809.7424.31.camel@acpi-sony.sh.intel.com>
References: <20071226020325.GA21099@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16120 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755003AbYAVI2I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Jan 2008 03:28:08 -0500
In-Reply-To: <20071226020325.GA21099@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com

On Wed, 2007-12-26 at 02:03 +0000, Matthew Garrett wrote:
> The sysfs backlight class provides no mechanism for querying the 
> acceptable brightness for a backlight. The ACPI spec states that values 
> are only valid if they are reported as available by the firmware. Since 
> we can't provide that information to userspace, instead collapse the 
> range to the number of actual values that can be set.
> 
There is another patch which round the bd->props.brightness to the
nearest but larger acceptable brightness level.
Please refer to http://bugzilla.kernel.org/show_bug.cgi?id=9277

I have no obvious objection on either of these two proposals.
But one thing to mention is that
both of these two patches is written on the assumption that the
brightness levels listed in _BCL method are in ascending order, while
this is not stated in the ACPI spec.
Is this a problem?

Thanks,
Rui

> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> ---
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 521645e..12b2adb 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -296,18 +296,26 @@ static int acpi_video_device_set_state(struct acpi_video_device *device, int sta
>  static int acpi_video_get_brightness(struct backlight_device *bd)
>  {
>  	unsigned long cur_level;
> +	int i;
>  	struct acpi_video_device *vd =
>  		(struct acpi_video_device *)bl_get_data(bd);
>  	acpi_video_device_lcd_get_level_current(vd, &cur_level);
> -	return (int) cur_level;
> +	for (i=2; i<vd->brightness->count; i++) {
> +		if (vd->brightness->levels[i] == cur_level)
> +			/* The first two entries are special - see page 575
> +			   of the ACPI spec 3.0 */
> +			return i-2;
> +	}
> +	return 0;
>  }
>  
>  static int acpi_video_set_brightness(struct backlight_device *bd)
>  {
> -	int request_level = bd->props.brightness;
> +	int request_level = bd->props.brightness+2;
>  	struct acpi_video_device *vd =
>  		(struct acpi_video_device *)bl_get_data(bd);
> -	acpi_video_device_lcd_set_level(vd, request_level);
> +	acpi_video_device_lcd_set_level(vd, 
> +					vd->brightness->levels[request_level]);
>  	return 0;
>  }
>  
> @@ -656,7 +664,6 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
>  	kfree(obj);
>  
>  	if (device->cap._BCL && device->cap._BCM && device->cap._BQC && max_level > 0){
> -		unsigned long tmp;
>  		static int count = 0;
>  		char *name;
>  		name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
> @@ -664,11 +671,10 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
>  			return;
>  
>  		sprintf(name, "acpi_video%d", count++);
> -		acpi_video_device_lcd_get_level_current(device, &tmp);
>  		device->backlight = backlight_device_register(name,
>  			NULL, device, &acpi_backlight_ops);
> -		device->backlight->props.max_brightness = max_level;
> -		device->backlight->props.brightness = (int)tmp;
> +		device->backlight->props.max_brightness = device->brightness->count-3;
> +		device->backlight->props.brightness = acpi_video_get_brightness(device->backlight);
>  		backlight_update_status(device->backlight);
>  
>  		kfree(name);
> 

