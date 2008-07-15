From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH 5/9] fujitsu-laptop: fingers off backlight if video.ko
Date: Wed, 16 Jul 2008 09:25:22 +0930 (CST)
Message-ID: <200807152355.m6FNtMO7026981@turbo.physics.adelaide.edu.au>
References: <1216135285.5033.19.camel@earth.gruber.myown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:43479 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753134AbYGOXze (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Jul 2008 19:55:34 -0400
In-Reply-To: <1216135285.5033.19.camel@earth.gruber.myown> from "nokos@gmx.net" at Jul 15, 2008 05:21:25 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nokos@gmx.net
Cc: Thomas Renninger <trenn@suse.de>, jwoithe@physics.adelaide.edu.au, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

> > It is likely that everything works out with video.ko then.
> > If not, with a patch I sent recently you should switch off Windows osi strings 
> > with:
> > acpi_osi=windows_false   (preferred)
> > or (already works)
> > acpi_osi="!Windows 2006"
> 
> disabling windows_osi disables backlight through video.ko and everything
> works fine with fujitsu_laptop (also brightness-buttons since ACPI then
> generates events on the fujitsu device) but some other ACPI stuff is
> disabled too (extended battery status etc...)

As per my previous email, the fact that this works is probably because in
this instance acpi_video_backlight_support() returns false and allows
fujitsu-laptop to set up its backlight control functions.

> > If it still does not work, then there is a driver missing which was  a 
> > proprietary one on XP and which has not been fully re-engeeniered for Linux.
> > 
> > Using ACPI video events and pass them to the Fujitsu driver to change 
> > backlight (is this how it works? Is this done through userspace?), mixes up 
> > everything.
> 
> without acpi_osi="!Windows 2006" the buttons just produce ACPI video
> events (recieved by video.ko) and hal does the adjustment through
> fujitsu_laptop.ko

I guess video.ko receives them because they are ACPI video events.  However,
as previously determined it doesn't do anything useful with them.  I'm a
little surprised that the physical brightness adjustment comes from hal
though.  On my S7020 the brightness changes brought about by the brightness
buttons are seemingly done in hardware - the buttons have an effect even
when fujitsu-laptop isn't loaded.  The brightness control functions in
fujitsu-laptop were added primarily to allow *software* control of the
brightness - something which definitely doesn't work without fujitsu-laptop.
The generation of ACPI video brightness keypress events was added to
fujitsu-laptop so userspace could keep track of changes instigated by the
hardware buttons.

> The Problem is that video.ko only touches an otherwise unused ACPI
> register but does not change the brightness... (you can just store a
> number between 0 and 7 there)

Yes, which is why I'm fairly sure there's no risk of double-touching the
hardware.  video.ko and fujitsu-laptop.ko are driving different hardware.

> Perhaps there is a way to disable the dysfunctional backlight stuff in 
> video.ko but retain the ACPI video event handling?!

The problem with doing this is that it's only the platform-specific drivers
which have the knowledge as to whether this is necessary or not.  video.ko
would therefore have to query each loaded platform-specific module which
seems messy to me.  If video.ko was loaded before the relevant
platform-specific module it gets even messier.  I guess we could add a
video.ko function like acpi_video_backlight_disable() which platform modules
could call if they choose to handle the backlight.  However, this seems
suboptimal to since it means video.ko sets up a backlight interface only to
have to tear it down again soon after.  I guess it's no worse than setting
up a backlight interface which never gets used though.

The fundamental problem as I see at this point it is that the new
acpi_video_backlight_support() function returns true on Fujitsu S-series
laptops because the ACPI environment looks "right" from video.ko's point of
view.  However, it's clear that the desired registers/methods - although
present - are completely non-functional in these laptops so in reality
video.ko cannot handle the backlight in this case.  Unless video.ko
hooks into the Fujitsu-specific registers (which defeats the modularity of
hardware-specific modules) this won't change.

To date I haven't had a chance to look at the whole IGD thing so I have no
idea what effect (if any) those patches are likely to have on this hardware. 
I will try to get to that in the next few days.  Maybe the IGD extensions
will allow video.ko to correctly drive the backlight on these laptops but
until this has been determined the best way forward is probably to omit the
acpi_video_backlight_support() tests from fujitsu-laptop (in effect this
means drop this part of the patch series since that's all it does).  This is
on the basis that acpi_video_backlight_support() doesn't currently take this
Fujitsu hardware into account when it formulates its return value, and
therefore its return value doesn't currently make sense on this platform.

Regards
  jonathan

> From: Thomas Renninger <trenn@suse.de>
>
> ---
>  drivers/misc/fujitsu-laptop.c |   26 ++++++++++++++------------
>  1 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/misc/fujitsu-laptop.c
> b/drivers/misc/fujitsu-laptop.c index 3601224..7306776 100644
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
