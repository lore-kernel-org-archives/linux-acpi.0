From: nokos@gmx.net
Subject: Re: [PATCH 5/9] fujitsu-laptop: fingers off backlight if video.ko
	is serving this functionality
Date: Tue, 15 Jul 2008 11:38:20 +0200
Message-ID: <1216114700.1940.12.camel@earth.gruber.myown>
References: <1215700265-24908-1-git-send-email-trenn@suse.de>
	 <1215700265-24908-2-git-send-email-trenn@suse.de>
	 <1215700265-24908-3-git-send-email-trenn@suse.de>
	 <1215700265-24908-4-git-send-email-trenn@suse.de>
	 <1215700265-24908-5-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:57889 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754524AbYGOJia (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Jul 2008 05:38:30 -0400
In-Reply-To: <1215700265-24908-5-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: jwoithe@physics.adelaide.edu.au, linux-acpi@vger.kernel.org

Hi there,

on the S6410 this prevents brightness control from working correctly. 
the ACPI BIOS provides non-functional _BCM/_BQC so the video.ko is
registering backlight functions but does not work. Unfortunately not
loading video.ko isn't a solution since with
bc45b1d39a925b56796bebf8a397a0491489d85c the brightness keys are only
reported through video.ko.



Am Donnerstag, den 10.07.2008, 16:31 +0200 schrieb trenn@suse.de: 
> From: Thomas Renninger <trenn@suse.de>
> 
> ---
>  drivers/misc/fujitsu-laptop.c |   26 ++++++++++++++------------
>  1 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/misc/fujitsu-laptop.c b/drivers/misc/fujitsu-laptop.c
> index 3601224..7306776 100644
> --- a/drivers/misc/fujitsu-laptop.c
> +++ b/drivers/misc/fujitsu-laptop.c
> @@ -963,16 +963,16 @@ static int __init fujitsu_init(void)
>  
>  	/* Register backlight stuff */
>  
> -	fujitsu->bl_device =
> -	    backlight_device_register("fujitsu-laptop", NULL, NULL,
> -				      &fujitsubl_ops);
> -	if (IS_ERR(fujitsu->bl_device))
> -		return PTR_ERR(fujitsu->bl_device);
> -
> -	max_brightness = fujitsu->max_brightness;
> -
> -	fujitsu->bl_device->props.max_brightness = max_brightness - 1;
> -	fujitsu->bl_device->props.brightness = fujitsu->brightness_level;
> +	if (!acpi_video_backlight_support()) {
> +		fujitsu->bl_device =
> +			backlight_device_register("fujitsu-laptop", NULL, NULL,
> +						  &fujitsubl_ops);
> +		if (IS_ERR(fujitsu->bl_device))
> +			return PTR_ERR(fujitsu->bl_device);
> +		max_brightness = fujitsu->max_brightness;
> +		fujitsu->bl_device->props.max_brightness = max_brightness - 1;
> +		fujitsu->bl_device->props.brightness = fujitsu->brightness_level;
> +	}
>  
>  	ret = platform_driver_register(&fujitsupf_driver);
>  	if (ret)
> @@ -1008,7 +1008,8 @@ fail_hotkey:
>  
>  fail_backlight:
>  
> -	backlight_device_unregister(fujitsu->bl_device);
> +	if (fujitsu->bl_device)
> +		backlight_device_unregister(fujitsu->bl_device);
>  
>  fail_platform_device2:
>  
> @@ -1035,7 +1036,8 @@ static void __exit fujitsu_cleanup(void)
>  			   &fujitsupf_attribute_group);
>  	platform_device_unregister(fujitsu->pf_device);
>  	platform_driver_unregister(&fujitsupf_driver);
> -	backlight_device_unregister(fujitsu->bl_device);
> +	if (fujitsu->bl_device)
> +		backlight_device_unregister(fujitsu->bl_device);
>  
>  	acpi_bus_unregister_driver(&acpi_fujitsu_driver);
>  

