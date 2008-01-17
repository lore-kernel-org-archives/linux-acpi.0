From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Ignore ACPI video devices that aren't present in
	hardware
Date: Thu, 17 Jan 2008 11:57:11 +0100
Message-ID: <1200567431.23376.459.camel@queen.suse.de>
References: <1197032113.28990.155.camel@queen.suse.de>
	 <20071207225025.GA2055@srcf.ucam.org>
	 <1197290906.28990.329.camel@queen.suse.de>
	 <20080117031154.GA26703@srcf.ucam.org>
	 <20080117033936.GB26703@srcf.ucam.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:45552 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbYAQK5P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jan 2008 05:57:15 -0500
In-Reply-To: <20080117033936.GB26703@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>, "Li, Shaohua" <shaohua.li@intel.com>

On Thu, 2008-01-17 at 03:39 +0000, Matthew Garrett wrote:
> Vendors often ship machines with a choice of integrated or discrete 
> graphics, and use the same DSDT for both. As a result, the ACPI video 
> module will locate devices that may not exist on this specific platform. 
> Attempt to determine whether the device exists or not, and abort the 
> device creation if it doesn't.
> 
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> ---
> 
> I'm still not convinced that this can be done reliably, especially if 
> anyone ever produces ACPI devices that aren't PCI-based. On the other 
> hand, I believe that this will work correctly (ie, discard devices for 
> integrated hardware if discrete hardware is present, and vice-versa) in 
> all existing cases. The most irritating feature is that there's no good 
> way to determine if an _ADR method refers to a PCI device or not - 0x00 
> could mean the PCI host bridge or the first video device hanging off an 
> AGP bridge. So far all the implementations I've seen use low numbers for 
> devices that aren't directly on the root PCI bus, so I've just assumed 
> that they'll always be less than 0x10000. If someone puts a graphics 
> core in their host bridge, this will break. But that would seem a mad 
> thing to do, so I'm going to pretend it's impossible.
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 12b2adb..1906eff 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -1266,8 +1266,37 @@ acpi_video_bus_write_DOS(struct file *file,
>  
>  static int acpi_video_bus_add_fs(struct acpi_device *device)
>  {
> +	long device_id;
> +	int status;
>  	struct proc_dir_entry *entry = NULL;
>  	struct acpi_video_bus *video;
> +	struct device *dev;
> +	
> +	status =
> +	    acpi_evaluate_integer(device->handle, "_ADR", NULL, &device_id);
> +
> +	if (!ACPI_SUCCESS(status))
> +		return -ENODEV;
> +
> +	/* We need to attempt to determine whether the _ADR refers to a
> +	   PCI device or not. There's no terribly good way to do this,
> +	   so the best we can hope for is to assume that there'll never
> +	   be a video device in the host bridge */
> +	if (device_id >= 0x10000) {
> +		/* It looks like a PCI device. Does it exist? */
> +		dev = acpi_get_physical_device(device->handle);
> +	} else {
> +		/* It doesn't look like a PCI device. Does its parent
> +		   exist? */
> +		acpi_handle phandle;
> +		if (acpi_get_parent(device->handle, &phandle))
> +			return -ENODEV;
> +		dev = acpi_get_physical_device(phandle);
> +	}
> +	if (!dev)
> +		return -ENODEV;
> +	put_device(dev);
> +
>  
> 
>  	video = acpi_driver_data(device);

First, thanks for looking at this.

Does it make sense to add this as a separate function, searching for a
physical PCI device for an ACPI device may pop up more often in the
future? This is a kind of _STA (present or not) function for PCI ACPI
devices then.

I also wonder why you added this to acpi_video_bus_add_fs and not
acpi_video_bus_add, but it's functionally the same.

This has been tested on a Dell 610 only then?
This sounds like an older machine, I wonder whether the video driver is
useful on this one at all and whether Windows had to check whether the
devices are present also...

What does the video device provide in functionality on this older Dell?
Vista requires the ACPI graphics devices for some functionalities. The
video device has not been used much (this is at least correct for SUSE,
AFAIK also for all other distributions, the video driver was in a rather
bad shape all the time?). I have no problem to blacklist the driver for
BIOSes older than VISTA capables ones.
We won't loose any functionality, but may prevent some problems when we
do not release the video driver on older machines.

I don't know exactly how these ACPI BIOSes are made up, but it looks
like there are components added by each HW vendor adding some HW to the
board. So you might have some graphics devices in the old BIOSes, but
the real functionality might have been implemented in an Asus, Sony,
IBM, whatever vendor specific ACPI device or a native driver.
Now for VISTA the vendor has to test that these ACPI graphics devices
are really functional (this might not have been the case before) as they
will get used by the OS.
I would not take the Dell 610 as a reference system here.

Please tell me if you have tested more machines, I try to give it a test
on a Toshiba, Lenovo and whatever I find with a Vista capable BIOS (IMO
this should be the most important criterion for finding the devices, I
doubt older Windows Versions made much use of ACPI graphics devices) as
soon as I find some time...

Thanks,

   Thomas

