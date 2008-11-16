From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 02/10] Check for ACPI backlight support otherwise use vendor ACPI drivers
Date: Sun, 16 Nov 2008 16:07:31 -0600
Message-ID: <200811161607.32429.trenn@suse.de>
References: <1217605083-31003-1-git-send-email-trenn@suse.de> <1217605083-31003-3-git-send-email-trenn@suse.de> <200811141527.43427.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59180 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753392AbYKPWHs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Nov 2008 17:07:48 -0500
In-Reply-To: <200811141527.43427.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

On Friday 14 November 2008 04:27:42 pm Bjorn Helgaas wrote:
> On Friday 01 August 2008 09:37:55 am Thomas Renninger wrote:
> > @@ -1013,7 +983,7 @@ static void acpi_device_set_id(struct acpi_device
> > *device, will get autoloaded and the device might still match
> >  		   against another driver.
> >  		*/
> > -		if (ACPI_SUCCESS(acpi_video_bus_match(device)))
> > +		if (acpi_is_video_device(device))
> >  			cid_add = ACPI_VIDEO_HID;
> >  		else if (ACPI_SUCCESS(acpi_bay_match(device)))
> >  			cid_add = ACPI_BAY_HID;
>
> It doesn't seem right to me to make this core behavior depend
> on a config option.  With this approach, the ACPI device tree may
> or may not contain an ACPI_VIDEO_HID device, depending on whether
> CONFIG_ACPI_VIDEO is set, and that seems capricious.
>
> What is the benefit of moving this code out of scan.c?  It's not
> a very big function, and I think the consistency is worth the extra
> code.
This was done because the function is re-used later to detect which kind of
video functionalities the video device provides.
I somehow agree, but I don't see much of a disadvantage having this separated. 
You do not have the video device marked as such if CONFIG_ACPI_VIDEO is not 
compiled in, but it shouldn't hurt?

The two corresponding functions:
acpi_backlight_cap_match
acpi_is_video_device

might also go back to video.c again and get exported there. I can do that if 
you think it's worth it.

    Thomas
>
> > +#if defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE)
> > +
> > +extern long acpi_video_get_capabilities(acpi_handle
> > graphics_dev_handle); +extern long acpi_is_video_device(struct
> > acpi_device *device);
> > +extern int acpi_video_backlight_support(void);
> > +extern int acpi_video_display_switch_support(void);
> > +
> > +#else
> > +
> > +static inline long acpi_video_get_capabilities(acpi_handle
> > graphics_dev_handle) +{
> > +	return 0;
> > +}
> > +
> > +static inline long acpi_is_video_device(struct acpi_device *device)
> > +{
> > +	return 0;
> > +}


