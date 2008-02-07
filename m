From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Ignore ACPI video devices that aren't present in hardware
Date: Thu, 7 Feb 2008 02:03:46 -0500
Message-ID: <200802070203.46783.lenb@kernel.org>
References: <1197032113.28990.155.camel@queen.suse.de> <20080203000354.GA26623@srcf.ucam.org> <20080207014406.GA19333@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36000 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457AbYBGHFN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Feb 2008 02:05:13 -0500
In-Reply-To: <20080207014406.GA19333@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, "Li, Shaohua" <shaohua.li@intel.com>

thanks for the update, matthew.

applied,
-len

On Wednesday 06 February 2008 20:44, Matthew Garrett wrote:
> Vendors often ship machines with a choice of integrated or discrete
> graphics, and use the same DSDT for both. As a result, the ACPI video
> module will locate devices that may not exist on this specific platform.
> Attempt to determine whether the device exists or not, and abort the\
> device creation if it doesn't
> 
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
> ---
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 09a85eb..11c8335 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -735,11 +735,40 @@ static void acpi_video_bus_find_cap(struct acpi_video_bus *video)
>  static int acpi_video_bus_check(struct acpi_video_bus *video)
>  {
>  	acpi_status status = -ENOENT;
> -
> +	long device_id;
> +	struct device *dev;
> +	struct acpi_device *device;
>  
>  	if (!video)
>  		return -EINVAL;
>  
> +	device = video->device;
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
>  	/* Since there is no HID, CID and so on for VGA driver, we have
>  	 * to check well known required nodes.
>  	 */
> 
