From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI video: print out a warning message when duplicate
 video bus devices under the same VGA controller are detected
Date: Thu, 26 Nov 2009 09:05:33 +0800
Message-ID: <1259197533.10510.76.camel@rzhang1-desktop>
References: <1259140608.10510.62.camel@rzhang1-desktop>
	 <alpine.LFD.2.00.0911251638220.3950@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60169 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759855AbZKZBGq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Nov 2009 20:06:46 -0500
In-Reply-To: <alpine.LFD.2.00.0911251638220.3950@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2009-11-26 at 05:39 +0800, Len Brown wrote:
> On Wed, 25 Nov 2009, Zhang Rui wrote:
> 
> > 
> > Some buggy BIOS exports multiple ACPI video bus devices for the same
> > VGA controller, and multiple backlight control methods as well.
> > This may mess up the ACPI video backlight control.
> > http://bugzilla.kernel.org/show_bug.cgi?id=13577
> > 
> > We should at least send out a warning message in this case.
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/video.c |   24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > Index: linux-2.6/drivers/acpi/video.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/video.c
> > +++ linux-2.6/drivers/acpi/video.c
> > @@ -2233,12 +2233,36 @@ static int acpi_video_resume(struct acpi
> >  	return AE_OK;
> >  }
> >  
> > +static acpi_status
> > +acpi_video_bus_match(acpi_handle handle, u32 level, void *context,
> > +			void **return_value)
> > +{
> > +	struct acpi_device *device = context;
> > +	struct acpi_device *sibling;
> > +	int result;
> > +
> > +	if (handle == device->handle)
> > +		return AE_CTRL_TERMINATE;
> > +
> > +	result = acpi_bus_get_device(handle, &sibling);
> > +	if (result)
> > +		return AE_OK;
> > +
> > +	if (!strcmp(acpi_device_name(sibling), ACPI_VIDEO_BUS_NAME))
> > +		printk(KERN_WARNING FW_BUG "Duplicate ACPI video bus "
> > +				"devices for the same VGA controller\n");
> 
> what is somebody supposed to _do_ when they see this message?
> 
I think this warning message gives us clues when debugging backlight
issues.
Say we see a bug report that brightness switching doesn't work and find
out that there is such a warning message in the dmesg output, then we
can see which video bus device under this VGA controller actually works.

If this bug is not rare, then we can set up a dmi list to choose the
working video bus device for these laptops.

thanks,
rui

