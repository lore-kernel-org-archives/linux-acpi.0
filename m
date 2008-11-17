From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 02/10] Check for ACPI backlight support otherwise use vendor ACPI drivers
Date: Mon, 17 Nov 2008 12:51:42 -0700
Message-ID: <200811171251.43103.bjorn.helgaas@hp.com>
References: <1217605083-31003-1-git-send-email-trenn@suse.de> <200811141527.43427.bjorn.helgaas@hp.com> <200811161607.32429.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:39820 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbYKQTwV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Nov 2008 14:52:21 -0500
In-Reply-To: <200811161607.32429.trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

On Sunday 16 November 2008 03:07:31 pm Thomas Renninger wrote:
> On Friday 14 November 2008 04:27:42 pm Bjorn Helgaas wrote:
> > On Friday 01 August 2008 09:37:55 am Thomas Renninger wrote:
> > > @@ -1013,7 +983,7 @@ static void acpi_device_set_id(struct acpi_device
> > > *device, will get autoloaded and the device might still match
> > >  		   against another driver.
> > >  		*/
> > > -		if (ACPI_SUCCESS(acpi_video_bus_match(device)))
> > > +		if (acpi_is_video_device(device))
> > >  			cid_add = ACPI_VIDEO_HID;
> > >  		else if (ACPI_SUCCESS(acpi_bay_match(device)))
> > >  			cid_add = ACPI_BAY_HID;
> >
> > It doesn't seem right to me to make this core behavior depend
> > on a config option.  With this approach, the ACPI device tree may
> > or may not contain an ACPI_VIDEO_HID device, depending on whether
> > CONFIG_ACPI_VIDEO is set, and that seems capricious.
> >
> > What is the benefit of moving this code out of scan.c?  It's not
> > a very big function, and I think the consistency is worth the extra
> > code.
> This was done because the function is re-used later to detect which kind of
> video functionalities the video device provides.
> I somehow agree, but I don't see much of a disadvantage having this separated. 
> You do not have the video device marked as such if CONFIG_ACPI_VIDEO is not 
> compiled in, but it shouldn't hurt?

My personal opinion is that the device tree should be the same,
regardless of which drivers were selected at build-time.  It should
be possible to build a kernel with CONFIG_ACPI_VIDEO=n, then decide
later that you want to load a video driver.  Plus, it took me about
half an hour to figure out why the Makefile looks weird:

	obj-$(CONFIG_ACPI_VIDEO)        += video.o
	ifdef CONFIG_ACPI_VIDEO
	obj-y                           += video_detect.o
	endif

(I first thought video_detect.o could just be moved up to the
first line along with video.o.)

> The two corresponding functions:
> acpi_backlight_cap_match
> acpi_is_video_device
> 
> might also go back to video.c again and get exported there. I can do that if 
> you think it's worth it.

As long as we use the "self-defined HID" strategy for binding drivers,
I think those HIDs should be considered part of the core, and they
should be set whenever CONFIG_ACPI=y.  I don't think they should
depend on which drivers were selected at build-time.  In some ways,
it might be nicer if a driver could supply its own "match" function,
and then all the video-related special cases could be in the video
driver.

Bjorn


