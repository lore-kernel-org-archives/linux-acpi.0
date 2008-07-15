From: nokos@gmx.net
Subject: Re: [PATCH 5/9] fujitsu-laptop: fingers off backlight if video.ko
	is serving this functionality
Date: Tue, 15 Jul 2008 17:21:25 +0200
Message-ID: <1216135285.5033.19.camel@earth.gruber.myown>
References: <1215700265-24908-1-git-send-email-trenn@suse.de>
	 <1215700265-24908-5-git-send-email-trenn@suse.de>
	 <1216114700.1940.12.camel@earth.gruber.myown>
	 <200807151446.31799.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:53676 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753544AbYGOPVc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Jul 2008 11:21:32 -0400
In-Reply-To: <200807151446.31799.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: jwoithe@physics.adelaide.edu.au, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

Am Dienstag, den 15.07.2008, 14:46 +0200 schrieb Thomas Renninger:
> On Tuesday 15 July 2008 11:38:20 nokos@gmx.net wrote:
> > Hi there,
> >
> > on the S6410 this prevents brightness control from working correctly.
> > the ACPI BIOS provides non-functional _BCM/_BQC so the video.ko is
> > registering backlight functions but does not work. Unfortunately not
> > loading video.ko isn't a solution since with
> > bc45b1d39a925b56796bebf8a397a0491489d85c the brightness keys are only
> > reported through video.ko.
> Is this an Intel graphics card?
> Then you should also try Matthew's/Hong's IGD extensions.

where can I find those?

> It is likely that everything works out with video.ko then.
> If not, with a patch I sent recently you should switch off Windows osi strings 
> with:
> acpi_osi=windows_false   (preferred)
> or (already works)
> acpi_osi="!Windows 2006"

disabling windows_osi disables backlight through video.ko and everything
works fine with fujitsu_laptop (also brightness-buttons since ACPI then
generates events on the fujitsu device) but some other ACPI stuff is
disabled too (extended battery status etc...)

> If it still does not work, then there is a driver missing which was  a 
> proprietary one on XP and which has not been fully re-engeeniered for Linux.
> 
> Using ACPI video events and pass them to the Fujitsu driver to change 
> backlight (is this how it works? Is this done through userspace?), mixes up 
> everything.

without acpi_osi="!Windows 2006" the buttons just produce ACPI video
events (recieved by video.ko) and hal does the adjustment through
fujitsu_laptop.ko
with acpi_osi="!Windows 2006" ACPI does the adjustment itself and no
direct event is generated (fujitsu_laptop gets an "something changed,
find out what" event)

> Either you have video.ko or fujitsu_acpi.ko or you are in trouble of double 
> touching the HW.

The Problem is that video.ko only touches an otherwise unused ACPI
register but does not change the brightness... (you can just store a
number between 0 and 7 there)
Perhaps there is a way to disable the dysfunctional backlight stuff in 
video.ko but retain the ACPI video event handling?!

Peter

>          Thomas
> 
> > Am Donnerstag, den 10.07.2008, 16:31 +0200 schrieb trenn@suse.de:
> > > From: Thomas Renninger <trenn@suse.de>
> > >
> > > ---
> > >  drivers/misc/fujitsu-laptop.c |   26 ++++++++++++++------------
> > >  1 files changed, 14 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/misc/fujitsu-laptop.c
> > > b/drivers/misc/fujitsu-laptop.c index 3601224..7306776 100644
> > > --- a/drivers/misc/fujitsu-laptop.c
> > > +++ b/drivers/misc/fujitsu-laptop.c
> > > @@ -963,16 +963,16 @@ static int __init fujitsu_init(void)
> > >
> > >  	/* Register backlight stuff */
> > >
> > > -	fujitsu->bl_device =
> > > -	    backlight_device_register("fujitsu-laptop", NULL, NULL,
> > > -				      &fujitsubl_ops);
> > > -	if (IS_ERR(fujitsu->bl_device))
> > > -		return PTR_ERR(fujitsu->bl_device);
> > > -
> > > -	max_brightness = fujitsu->max_brightness;
> > > -
> > > -	fujitsu->bl_device->props.max_brightness = max_brightness - 1;
> > > -	fujitsu->bl_device->props.brightness = fujitsu->brightness_level;
> > > +	if (!acpi_video_backlight_support()) {
> > > +		fujitsu->bl_device =
> > > +			backlight_device_register("fujitsu-laptop", NULL, NULL,
> > > +						  &fujitsubl_ops);
> > > +		if (IS_ERR(fujitsu->bl_device))
> > > +			return PTR_ERR(fujitsu->bl_device);
> > > +		max_brightness = fujitsu->max_brightness;
> > > +		fujitsu->bl_device->props.max_brightness = max_brightness - 1;
> > > +		fujitsu->bl_device->props.brightness = fujitsu->brightness_level;
> > > +	}
> > >
> > >  	ret = platform_driver_register(&fujitsupf_driver);
> > >  	if (ret)
> > > @@ -1008,7 +1008,8 @@ fail_hotkey:
> > >
> > >  fail_backlight:
> > >
> > > -	backlight_device_unregister(fujitsu->bl_device);
> > > +	if (fujitsu->bl_device)
> > > +		backlight_device_unregister(fujitsu->bl_device);
> > >
> > >  fail_platform_device2:
> > >
> > > @@ -1035,7 +1036,8 @@ static void __exit fujitsu_cleanup(void)
> > >  			   &fujitsupf_attribute_group);
> > >  	platform_device_unregister(fujitsu->pf_device);
> > >  	platform_driver_unregister(&fujitsupf_driver);
> > > -	backlight_device_unregister(fujitsu->bl_device);
> > > +	if (fujitsu->bl_device)
> > > +		backlight_device_unregister(fujitsu->bl_device);
> > >
> > >  	acpi_bus_unregister_driver(&acpi_fujitsu_driver);
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

