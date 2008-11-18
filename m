From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 02/10] Check for ACPI backlight support otherwise use vendor ACPI drivers
Date: Tue, 18 Nov 2008 03:31:54 +0100
Message-ID: <200811180331.55114.trenn@suse.de>
References: <1217605083-31003-1-git-send-email-trenn@suse.de> <200811161607.32429.trenn@suse.de> <200811171251.43103.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56122 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232AbYKRCcA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Nov 2008 21:32:00 -0500
In-Reply-To: <200811171251.43103.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

On Monday 17 November 2008 08:51:42 pm Bjorn Helgaas wrote:
> On Sunday 16 November 2008 03:07:31 pm Thomas Renninger wrote:
> > On Friday 14 November 2008 04:27:42 pm Bjorn Helgaas wrote:
> > > On Friday 01 August 2008 09:37:55 am Thomas Renninger wrote:
> > > > @@ -1013,7 +983,7 @@ static void acpi_device_set_id(struct
> > > > acpi_device *device, will get autoloaded and the device might still
> > > > match against another driver.
> > > >  		*/
> > > > -		if (ACPI_SUCCESS(acpi_video_bus_match(device)))
> > > > +		if (acpi_is_video_device(device))
> > > >  			cid_add = ACPI_VIDEO_HID;
> > > >  		else if (ACPI_SUCCESS(acpi_bay_match(device)))
> > > >  			cid_add = ACPI_BAY_HID;
> > >
> > > It doesn't seem right to me to make this core behavior depend
> > > on a config option.  With this approach, the ACPI device tree may
> > > or may not contain an ACPI_VIDEO_HID device, depending on whether
> > > CONFIG_ACPI_VIDEO is set, and that seems capricious.
> > >
> > > What is the benefit of moving this code out of scan.c?  It's not
> > > a very big function, and I think the consistency is worth the extra
> > > code.
> >
> > This was done because the function is re-used later to detect which kind
> > of video functionalities the video device provides.
> > I somehow agree, but I don't see much of a disadvantage having this
> > separated. You do not have the video device marked as such if
> > CONFIG_ACPI_VIDEO is not compiled in, but it shouldn't hurt?
>
> My personal opinion is that the device tree should be the same,
> regardless of which drivers were selected at build-time.  It should
> be possible to build a kernel with CONFIG_ACPI_VIDEO=n, then decide
> later that you want to load a video driver.  Plus, it took me about
> half an hour to figure out why the Makefile looks weird:
>
> 	obj-$(CONFIG_ACPI_VIDEO)        += video.o
> 	ifdef CONFIG_ACPI_VIDEO
> 	obj-y                           += video_detect.o
> 	endif
>
> (I first thought video_detect.o could just be moved up to the
> first line along with video.o.)
>
> > The two corresponding functions:
> > acpi_backlight_cap_match
> > acpi_is_video_device
> >
> > might also go back to video.c again and get exported there. I can do that
> > if you think it's worth it.
>
> As long as we use the "self-defined HID" strategy for binding drivers,
> I think those HIDs should be considered part of the core, and they
> should be set whenever CONFIG_ACPI=y.  I don't think they should
> depend on which drivers were selected at build-time.  In some ways,
> it might be nicer if a driver could supply its own "match" function,
> and then all the video-related special cases could be in the video
> driver.

The video and other drivers cannot provide their own match function or
autoloading of the driver would not work.
Either you compile it into the core and the detection/matching will always 
take place or you do it as it is currently done and the matching for video 
devices will only be done if ACPI_VIDEO is compiled in.

      Thomas
