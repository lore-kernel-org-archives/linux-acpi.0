From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Ignore ACPI video devices that aren't present in hardware
Date: Thu, 24 Jan 2008 17:21:17 -0500
Message-ID: <200801241721.17436.lenb@kernel.org>
References: <1197032113.28990.155.camel@queen.suse.de> <20080117031154.GA26703@srcf.ucam.org> <20080117033936.GB26703@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50937 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752580AbYAXWWM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Jan 2008 17:22:12 -0500
In-Reply-To: <20080117033936.GB26703@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, "Li, Shaohua" <shaohua.li@intel.com>

On Wednesday 16 January 2008 22:39, Matthew Garrett wrote:
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

_ADR returns a bus-specific format.
In the case of a video device, section B.6.1 says that
_ADR returns a 32-bit device ID, and that
it is the same number as returned in the _DOD list.
That is the only constraint.
So I don't think you can use the numerical value returned
to have any particular meaning at all.
In particular, comparing it to magic number 0x10000 makes no sense.

-Len

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
> 
