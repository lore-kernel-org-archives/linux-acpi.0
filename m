From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH 06/11] fujitsu-laptop: fingers off backlight if video.ko is serving this functionality
Date: Fri, 18 Jul 2008 09:34:33 +0930 (CST)
Message-ID: <200807180004.m6I04XmI032105@turbo.physics.adelaide.edu.au>
References: <1216205553-8486-7-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:52443 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753566AbYGRAFd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jul 2008 20:05:33 -0400
In-Reply-To: <1216205553-8486-7-git-send-email-trenn@suse.de> from "Thomas Renninger" at Jul 16, 2008 12:52:28 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: ak@linux.intel.com, mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it, Thomas Renninger <trenn@suse.de>

Hi Thomas

I managed to test this series of patches overnight.  I applied them to
2.6.26 but in the context I don't *think* that matters a great deal.  I
didn't go down the IDG route since there's no clear indication of what
patches are needed for this.

The practical upshot is that on the S7020 a kernel with just these patches
applied can still control the backlight via the backlight interface provided
by the platform driver.  video.ko still cannot control the backlight but I
wasn't expecting it to for reasons outlined previously.  At least on the
S7020 acpi_video_backlight_support() seems to (correctly) return false,
allowing the fujitsu-laptop module to pick up the backlight control as it's
always done.

I realise that the latest revision of this patch series included some logic
updates in acpi_video_backlight_support() so I would be interested to see
whether the S6410 now works.  I suspect it won't but it's worth a try.

Regards
  jonathan

> Signed-off-by: Thomas Renninger <trenn@suse.de>
> Signed-off-by: Thomas Renninger <trenn@stravinsky.suse.de>
> ---
>  drivers/misc/fujitsu-laptop.c |   26 ++++++++++++++------------
>  1 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/misc/fujitsu-laptop.c b/drivers/misc/fujitsu-laptop.c
> index 3601224..4f873cb 100644
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
> -- 
> 1.5.4.5
